------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                         P O S T . P A R S E R                            --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                     Copyright (C) 2014, Jan de Kruyf                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.                                               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
--              Post is maintained by J de Kruijf Engineers                 --
--                  (email: jan.de.kruyf@hotmail.com)                       --
--                                                                          --
------------------------------------------------------------------------------
--
--  The pst.parser parses the token stream and calls the apropriate 
--   routines in the Post.Machine package
--


with Ada.Characters.Handling;
with Ada.Unchecked_Conversion;


with Text_Io; 
with System.Storage_Elements;
with POSIX.IO;
with POSIX.Files;
with POSIX.File_Status;
with POSIX.Permissions;
with POSIX.Process_Identification;
with POSIX.Memory_Mapping;
with GNATCOLL.Traces;
with Post.Scanner;

package body Post.Parser is
   package Pio renames POSIX.IO;
   package Pf  renames POSIX.Files;
   package Pfs renames POSIX.File_Status;
   package Pps renames POSIX.Permissions;
   package Ppi renames POSIX.Process_Identification;
   package Tio renames Text_Io; 
   package Ach renames Ada.Characters.Handling;
   package As  renames Ada.Streams;  
   package Ps  renames Post.Scanner;
   package Gct    renames GNATCOLL.Traces;
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");
   
   
   File_Text    : Stream_Element_Array_Access := null;
   Multax_On    : Boolean := False;
   
   
   procedure Error_Message (Message : String)
   is
   begin
      Gct.Trace (Stream1, Message);
   end Error_Message;
   
   
   -----------------------------------------------------------------------
   -- read a file with POSIX 
   -- Mapping the whole file into the address space of your process 
   -- and then overlaying the file with a String object. 
   ------------------------------------------------------------------------

   function Open (Name : String)
		 return Stream_Element_Array_Access
   is
      Text_File    : POSIX.IO.File_Descriptor;
      Text_Size    : System.Storage_Elements.Storage_Offset;
      Text_Address : System.Address;

   begin
      Text_File := POSIX.IO.Open 
	(Name => POSIX.To_POSIX_String (Str => Name),
	 Mode => POSIX.IO.Read_Only);
      Text_Size    := System.Storage_Elements.Storage_Offset 
	(POSIX.IO.File_Size (Text_File));
      Text_Address := POSIX.Memory_Mapping.Map_Memory 
	(Length     => Text_Size,
	 Protection => POSIX.Memory_Mapping.Allow_Read,
	 Mapping    => POSIX.Memory_Mapping.Map_Shared,
	 File       => Text_File,
	 Offset     => 0);
      declare
	 Text : As.Stream_Element_Array 
	   (1 .. As.Stream_Element_Offset (Text_Size));
	 for Text'Address use Text_Address;
      begin
	 File_Text := new As.Stream_Element_Array 
	   (1 .. As.Stream_Element_Offset (Text_Size));
	 File_Text.all := Text;
      end;
      POSIX.Memory_Mapping.Unmap_Memory 
	(First  => Text_Address,
	 Length => Text_Size);
      POSIX.IO.Close (File => Text_File);
      return File_Text;
   exception
      when POSIX.POSIX_Error  =>
	 Error_Message ("POSIX Error on Open: " & 
			  POSIX.Image (POSIX.Get_Error_Code));
	 return null;
      when others             =>
	 Error_Message ("Open: an error occured");
	 return null;
   end Open;    
   
   
   -----------------------------------------------
   -- open for write:
   -- tries to open a new file, if the file exists
   -- the old file will be renamed to a backup file.
   -- 
   -- file descriptor of 0 is returned on error.
   --
   ------------------------------------------------
   function Wopen (Name : String)
		  return Pio.File_Descriptor
   is
      Pname    : Posix.POSIX_String := POSIX.To_POSIX_String (Str => Name);
      Status   : Pfs.Status;
      Response : String (1 .. 3);
      
      Function Try_Open (Name : Posix.POSIX_String) return Pio.File_Descriptor
      is
      begin
	 return Pio.Open_Or_Create 
	   (Name        => Pname,
	    Mode        => Pio.Write_Only,
	    Permissions => Pps.Permission_Set'
	      (Pps.Owner_Write | Pps.Group_Read => True, 
	       others => False),
	    Options     => Pio.append);------>
      exception
	 when POSIX.POSIX_Error =>
	    Error_Message ("File cannot be opened.");
	    return 0;------>
      end Try_Open;
      
      use type Ppi.User_ID;
      use type Posix.POSIX_String;
   begin
      Status := Pfs.Get_File_Status (Pathname => Pname);
      if (Pfs.Owner_Of (Status) =  Ppi.Get_Real_User_ID) then -- is my file
	 if Pfs.Is_Regular_File (Status) then
	    Tio.Put("File exists, do you want to overwrite? (Yes or No)  ");
	    Tio.Get(Response);
	    if Ach.To_Upper (Response (1)) = 'Y' then
	       begin
		  Pf.Rename (Old_Pathname => Pname, 
			     New_Pathname => Pname & "~");
	       exception
		  when POSIX.POSIX_Error =>
		     Error_Message ("Existing file cannot be renamed.");
		     return 0;------>
	       end;
	       return Try_Open (PName);---------------------->
	    else
	       Error_Message ("Aborting . . . ");
	       return 0;---------------------->
	    end if;
	 else
	    Error_Message ("File exists but is not a regular file.");
	    return 0;---------------------->
	 end if;
      else -- is not my file
	 Error_Message ("File exists but cannot be opened.");
	 return 0;---------------------->
      end if;
   exception  -- file probably does not exist yet
      when POSIX.POSIX_Error =>  -- try to open new file
	 return Try_Open (PName);---------------------->
   end Wopen;
   
   
   procedure WClose (Fd : POSIX.IO.File_Descriptor)
   is
   begin
      Pio.Close (Fd);
   end Wclose;
   
   -----------------------------
   -- parsing the source file --
   -----------------------------
   
   ---------------
   -- 3rd level --
   ---------------
   function Parse_Debug (Stt : String) return Boolean
   is
      Sp      : String (1 .. Stt'Length);
      Err     : Boolean := False;
   begin
      Sp := Ach.To_Upper (Stt);
      if Sp = "SLON" or Sp = "SLOFF" then
	 M_Print_Debug (Sp);
      else
	 M_Print_Error 
	   ("misspelled 'INSERT DEBUG' argument. I read " & Sp);
	 Err := True;
      end if;
      return Err;
   end Parse_Debug;
   
   
   function Parse_Insert_Fedrat_Units (Stt : String) return Boolean
   is
      Sp      : String (1 .. Stt'Length);
      Err     : Boolean := False;
   begin
      Sp := Ach.To_Upper (Stt);
      if Sp = "MMPM" or Sp = "IPM" then
	 M_Print_Fedrat_Units (Sp);
	 Gct.Trace (Debug_Str, "#### fedrat units are " & Sp);
      else
	 M_Print_Error 
	   ("misspelled 'INSERT FEDRAT' argument. I read " & Sp);
	 Err := True;
      end if;
      return Err;
   end Parse_Insert_Fedrat_Units;
   
   
   function Parse_Insert_Fadein (Stt : String) return Boolean
   is
      Sp      : String (1 .. Stt'Length);
      Spi     : Integer range 0 .. Stt'Length := 0;
      Time    : Float   := 0.0;
      Stti    : Integer := Stt'First - 1;
      Err,
      Dp      : Boolean := False;
   begin
      for i in 1 .. Stt'Length loop --Extract 
	 if Stt(I) = ' ' then
	    null; --skip
	 elsif (Stt(I) in '0' .. '9') then
	    Spi := Spi + 1;
	    Sp (Spi) := Stt(I);
	 elsif (Stt(I) = '.') then -- decimal point
	    if Dp then exit; end if; -- 2nd dec point
	    Spi := Spi + 1;
	    Sp (Spi) := Stt(I);
	    Dp := True;
	 else
	    exit;
	 end if;
      end loop;
      Time := Float'Value (Sp (Sp'First .. Spi));
      if not (Time in 0.0 .. 5.0) then
	 M_Print_Error 
	   ("Fade In Time out of range");
	 Err := True;
	 goto Uit;
      end if;
      M_Print_Fadein_Time (Time);
      Gct.Trace (Debug_Str, "#### Fade In = " & Float'Image (Time) & " sec");
  <<Uit>>
      return Err;     
   end Parse_Insert_Fadein;
   
   
   function Parse_Insert_Beam (Stt : String) return Boolean
   is
      Sp      : String (1 .. Stt'Length);
      Spi     : Integer range 0 .. Stt'Length := 0;
      Percent : Integer := 0;
      Stti    : Integer := Stt'First - 1;
      Err     : Boolean := False;
   begin
      for i in 1 .. Stt'Length loop --Extract integer part
	 if Stt(I) = ' ' then
	    null; --skip
	 elsif Stt(I) in '0' .. '9' then
	    Spi := Spi + 1;
	    Sp (Spi) := Stt(I);
	 else
	    exit;
	 end if;
      end loop;
      Percent := Integer'Value (Sp (Sp'First .. Spi));
      if not (Percent in 1 .. 100) then
	 M_Print_Error 
	   ("Beam current out of range");
	 Err := True;
	 goto Uit;
      end if;
      M_Print_Beam_Current (Percent);
      Gct.Trace (Debug_Str, "#### Beam = " & Integer'Image (Percent) & " %");
  <<Uit>>
      return Err;
   end Parse_Insert_Beam;
   
   
   ---------------
   -- 2nd level --
   ---------------
   
   function Parse_Multax return Boolean
   is
      use type As.Stream_Element_Offset;
      I   : Long_Long_Integer := 0;
      S   : Ps.Onoff_type;
      Err : Boolean           := False;
   begin
      loop
	 Err := Ps.Scan_Long_Long_Integer (I);
	 exit when Err;
	 case I is
	    when 0 => 
	       S         := Ps.Off;
	       Multax_On := False;
	    when 1 => 
	       S         := Ps.On;
	       Multax_On := True;
	    when others => 
	       M_Print_error 
		 ("internal error, multax, not on / off type");
	       Err := True;
	 end case;
	 exit when Err;
	 M_Print_Multax ("MULTAX " & Ps.Onoff_Type'Image (S));
	 exit;
      end loop;
      return Err;
   end Parse_Multax;
   
   
   Function Parse_Spindle (Nextr : As.Stream_Element_Offset) return Boolean
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Long_Long_Integer,
	 Target => Ps.Mkwi_Type);
      pragma Warnings (On);
      use type As.Stream_Element_Offset;
      I   : Long_Long_Integer := 0;
      F   : Long_Float        := 0.0;
      M   : Ps.Mkwi_Type;
      Su  : String (1 .. 5)   := "     ";
      Got_Value,
      Err : Boolean           := False;
   begin
      loop
	 while Ps.Next_Token < Nextr loop
	    Err := Ps.Scan_Long_Long_Integer (I);
	    exit when Err; 
	    if I <= Ps.Mkwi_Type'Pos (Ps.Mkwi_Type'Last) then
	       M := Convert (I);
	       case M is
		  when Ps.On =>
		     Su := Ps.Mkwi_Type'Image (M) & "   ";
		  when Ps.Off =>
		     Su := Ps.Mkwi_Type'Image (M) & "  ";
		  when Ps.Clw =>
		     Su := Ps.Mkwi_Type'Image (M) & "  ";
		  when Ps.Cclw =>
		     Su := Ps.Mkwi_Type'Image (M) & " ";
		  when others => 
		     M_Print_Error ("spindle option " & Ps.Mkwi_Type'Image (M) & 
				      " cannot be used at present");
		     Err := True;
		     exit;
	       end case;
	    else
	       Ps.Next_Token := Ps.Next_Token - 8; -- Push It back
	       Err := Ps.Scan_Double (F);
	       exit when Err; 
	       if F < 0.0 then 
		  F := 0.0;
		  M_Print_Error ("no negative numbers allowed in SPINDL statement");
	       end if;
	       Got_Value := True;
	    end if;
	 end loop;
	 exit when Err;
	 if Got_Value then
	    M_Print_Spindle ("SPINDL " & Su & Long_Float'image (F));
	 else
	    M_Print_Spindle ("SPINDL " & Su & "NaN");
	 end if;
	 exit;
      end loop;
      return Err;
   end Parse_Spindle;
   
   
   function Parse_Feedrate (Nextr : As.Stream_Element_Offset) return Boolean
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Long_Long_Integer,
	 Target => Ps.Mkwi_Type);
      pragma Warnings (On);
      use type As.Stream_Element_Offset;
      I   : Long_Long_Integer := 0;
      F   : Long_Float        := 0.0;
      M   : Ps.Mkwi_Type;
      Su  : String (1 .. 3)   := "F  ";
      Err : Boolean           := False;
   begin
      loop
	 while Ps.Next_Token < Nextr loop
	    Err := Ps.Scan_Long_Long_Integer (I);
	    exit when Err; 
	    if I <= Ps.Mkwi_Type'Pos (Ps.Mkwi_Type'Last) then
	       M := Convert (I);
	       case M is
		  when Ps.Ipm =>
		     Su := Ps.Mkwi_Type'Image (M);
		  when Ps.Ipr =>
		     M_Print_Error ("feedrate option " & Ps.Mkwi_Type'Image (M) & 
				      " cannot be used at present");
		     Err := True;
		     exit;
		  when others => 
		     M_Print_Error ("feedrate option " & Ps.Mkwi_Type'Image (M) & 
				      " cannot be used at present");
		     Err := True;
		     exit;
	       end case;
	    else
	       Ps.Next_Token := Ps.Next_Token - 8; -- Push It back
	       Err := Ps.Scan_Double (F);
	       exit when Err; 
	    end if;
	 end loop;
	 exit when Err;
	 if F /= 0.0 then
	    M_Print_Fedrat_Units (Su & Long_Float'Image (F));
	 else
	    M_Print_Fedrat_Units (Su);
	 end if;
	 exit;
      end loop;
      return Err;
   end Parse_Feedrate;
   
   
   function Parse_Insert return Boolean
   is
      S, St, Stt : String (1 .. 88);
      Err, 
      Done,
      Found_Name : Boolean := False;
      I          : Integer := S'Last;
      J          : Integer := S'First;
      Sti, 
      Stti       : Integer := S'First - 1;
   begin
      Err := Ps.Scan_Info (S);
      if not Err then
	 while not Done loop -- strip trailing spaces
	    if S (I) = ' ' then
	       I := I  - 1;
	    else
	       Done := True;
	    end if;
	 end loop;
	 while (S (J) /= '=' and  J <= I) loop -- extract parameter
	    if S(J) /= ' ' then
	       Sti := Sti + 1;
	       St (Sti) := S (J);
	    end if;
	    J := J + 1;
	 end loop; -- found parameter name
	 J := J + 1;
	 while J <= I loop
	    if S(J) /= ' ' then
	       Stti := Stti + 1;
	       Stt (Stti) := S (J);
	    end if;
	    J := J + 1;
	 end loop; -- found setting
	 for E in Ps.Kwi_Ins_Type'Range loop
	    declare 
	       use type Ps.Kwi_Ins_Type;
	       Sp : String := Ach.To_Upper (St (St'First .. Sti));
	    begin
	       if Sp = Ps.Kwi_Ins_Type'Image (E) then
		  Found_Name := True;
		  case E is
		     when Ps.Beam =>
			Err := Parse_Insert_Beam (Stt (1 .. Stti));
			exit;
		     when Ps.Fadein =>
			Err := Parse_Insert_Fadein (Stt (1 .. Stti));
			exit;
		     when Ps.Fedrat =>
			Err := Parse_Insert_Fedrat_Units (Stt (1 .. Stti));
			exit;
		     when Ps.Debug =>
			Err := Parse_Debug (Stt (1 .. Stti));
			exit;
		     when others => 
			M_Print_error 
			  ("internal error, Parse_Insert in de post parser has not been updated");
			Err := True;
			goto Uit;
		  end case;
	       end if; 
	    end;
	 end loop;
	 if not Found_Name then
	    M_Print_Error ("misspelled 'INSERT' argument. I read " & S);
	    Err := True;
	 end if;
      end if;
  <<Uit>>
      return Err;
   end Parse_Insert;
   
   
   function Parse_Info return Boolean
   is
      S, 
      S1   : String (1 .. 88);
      Err  : Boolean := False;
      I    : Integer := S'Last;
      K    : Integer := S1'First;
      Done : Boolean := False;
   begin
      Err := Ps.Scan_Info (S);
      if not Err then
	 while not Done loop -- strip trailing spaces
	    if S (I) = ' ' then
	       I := I  - 1;
	    else
	       Done := True;
	    end if;
	 end loop;
	 for J in S'First .. I loop -- strip every 7th and 8th char, they are spaces
	    if not ((J mod 8 = 7) or (J mod 8 = 0)) then
	       S1(K) := S(J);
	       K := K + 1;
	    end if;
	 end loop;
	 M_Print_Comment (S1 (S1'First .. (K - 1)));
      end if;
      return Err;
   end Parse_Info;
   
   
   function Parse_Machine return Boolean
   is
      S, 
      S1   : String (1 .. 8);
      Done,
      Err  : Boolean := False;
      I    : Integer := S'Last;
      K    : Integer := S1'First - 1;
   begin
      Err := Ps.Scan_String8 (S);
      if not Err then
	 while not Done loop -- strip trailing spaces
	    if S (I) = ' ' then
	       I := I  - 1;
	    else
	       Done := True;
	    end if;
	 end loop;
	 for J in S'First .. I loop
	    if S (J) /= ' ' then
	       K := K + 1;
	       S1 (K) := S (J);
	    end if;
	 end loop;
	 M_Print_Machine (S1 (S1'First .. (K)));
      end if;
      return Err;
   end Parse_Machine;
   
   
   function Parse_Origin return Boolean
   is
      X   : Long_Float        := 0.0;
      Y   : Long_Float        := 0.0;
      Z   : Long_Float        := 0.0;
      
      Err : Boolean           := False;
   begin
      loop
	 Err := Ps.Scan_Double (X);
	 exit when Err;
	 Err := Ps.Scan_Double (Y);
	 exit when Err;
	 Err := Ps.Scan_Double (Z);
	 exit;
      end loop;
      if Err then
	 M_Print_Error ("cutter location file fault: badly formed float value");
      else
	 M_Print_Origin ("ORIGIN " & Long_Float'Image (X) & " " &
			   Long_Float'Image (Y) & " " &
			   Long_Float'Image (Z)& " ");
      end if;
      return Err;
   end Parse_Origin;
   
   
   function Parse_From (Nextr : As.Stream_Element_Offset) return Boolean
   is
      use type Ada.Streams.Stream_Element_Offset;
      X     : Long_Float        := 0.0;
      Y     : Long_Float        := 0.0;
      Z     : Long_Float        := 0.0;
      I     : Long_Float        := 0.0;
      J     : Long_Float        := 0.0;
      K     : Long_Float        := 0.0;
      Blank : Long_Long_Integer := 0;
      S : String (1 .. 8)       := "        ";
      Err   : Boolean           := False;
   begin
      loop
	 loop
	    Err := Ps.Scan_String8 (S);
	    exit when Err;
	    Err := Ps.Scan_Long_Long_Integer (Blank);
	    exit;
	 end loop;
	 if Err then 
	    M_Print_Error ("badly formed header in 'From' statement");
	    exit;
	 end if;
	 loop
	    Err := Ps.Scan_Double (X);
	    exit when Err;
	    Err := Ps.Scan_Double (Y);
	    exit when Err;
	    Err := Ps.Scan_Double (Z);
	    exit when Err;
	    if Multax_On then
	       Err := Ps.Scan_Double (I);
	       exit when Err;
	       Err := Ps.Scan_Double (J);
	       exit when Err;
	       Err := Ps.Scan_Double (K);
	       exit when Err;
	       M_Print_Pos 
		 ("FROM " & S & " " &
		    Long_Float'Image (X) & " " & Long_Float'Image (Y) & " " & 
		    Long_Float'Image (Z) & " " & Long_Float'Image (I) & " " & 
		    Long_Float'Image (J) & " " & Long_Float'Image (K));
	    else
	       M_Print_Pos 
		 ("FROM " & S & " " & Long_Float'Image (X) & " " & 
		    Long_Float'Image (Y) & " " & Long_Float'Image (Z));
	    end if;
	    exit;
	 end loop;
	 if Err then 
	    M_Print_Error 
	      ("Badly formed positional value in 'From' statement");
	 end if;
	 exit;
      end loop;
      return Err;
   end Parse_From;
   
   
   function Parse_Gto (Nextr : As.Stream_Element_Offset) return Boolean
   is
      use type Ada.Streams.Stream_Element_Offset;
      X     : Long_Float        := 0.0;
      Y     : Long_Float        := 0.0;
      Z     : Long_Float        := 0.0;
      I     : Long_Float        := 0.0;
      J     : Long_Float        := 0.0;
      K     : Long_Float        := 0.0;
      Blank : Long_Long_Integer := 0;
      S : String (1 .. 8)       := "        ";
      First_Set_Done,
      Err   : Boolean           := False;
   begin
      loop 
	 loop
	    Err := Ps.Scan_String8 (S);
	    exit when Err;
	    Err := Ps.Scan_Long_Long_Integer (Blank);
	    exit;
	 end loop;
	 if Err then 
	    M_Print_Error ("badly formed header in 'From' statement");
	    exit;
	 end if;
	 while Ps.Next_Token < Nextr loop
	    Err := Ps.Scan_Double (X);
	    exit when Err;
	    Err := Ps.Scan_Double (Y);
	    exit when Err;
	    Err := Ps.Scan_Double (Z);
	    exit when Err;
	    if Multax_On then
	       Err := Ps.Scan_Double (I);
	       exit when Err;
	       Err := Ps.Scan_Double (J);
	       exit when Err;
	       Err := Ps.Scan_Double (K);
	       exit when Err;
	       M_Print_Pos 
		 ("GOTO " & S & " " &
		    Long_Float'Image (X) & " " & Long_Float'Image (Y) & " " & 
		    Long_Float'Image (Z) & " " & Long_Float'Image (I) & " " & 
		    Long_Float'Image (J) & " " & Long_Float'Image (K));
	    else
	       M_Print_Pos 
		 ("GOTO " & S & " " & Long_Float'Image (X) & " " & 
		    Long_Float'Image (Y) & " " & Long_Float'Image (Z));
	    end if;
	    if not First_Set_Done then
	       S (S'First) := Character'Val (0); -- flag not to print it anymore
	    end if;
	 end loop;
	 if Err then 
	    M_Print_Error 
	      ("Badly formed positional value in 'Goto' statement");
	 end if;
	 exit;
      end loop;
      
      return Err;
   end Parse_Gto;
   
   
   
   
   ---------------
   -- 1st level --
   ---------------
   
   function Parse_Special_Feature return Boolean
   is
      V   : Ps.Special_Feature_Type := Ps.Tlaxis;
      Err : Boolean     := False;
   begin
      loop
	 Err := Ps.Scan_Special_Feature_Index (V);
	 if Err then
	    M_Print_Error 
	      ("internal fault : Special_Feature_Type not in the table");
	    exit;
	 else
	    Gct.Trace (Debug_Str, "#   Parse_Special_Feature " & 
			 Ps.Special_Feature_Type'Image (V));
	    case V is
	       when Ps.Multax => Err := Parse_Multax;
	       when others => 
		  M_Print_error 
		    ("internal error, option " & 
		       Ps.Special_Feature_Type'Image (V) & 
		       " is not handled at the moment");
		  Err := True;
		  exit;
	    end case;
	 end if;
	 exit;
      end loop;
      return Err;
   end Parse_Special_Feature;
   
   
   -- allowance should be made for extended cutter record --
   function Parse_Cut_Tol return Boolean
   is
      Su  : String (1 .. 7);
      V   : Ps.Cut_Tol_Type := Ps.Nix;
      D   : Long_Float      := 0.0;
      Err : Boolean         := False;
   begin
      loop
	 Err := Ps.Scan_Cut_Tol_Index (V);
	 if Err then
	    M_Print_Error ("internal fault : Cut_Tol_Type not in the table");
	    exit;
	 else
	    Gct.Trace (Debug_Str, "#   Cut_Tol_Type " & 
			 Ps.Cut_Tol_Type'Image (V));
	    case V is
	       when Ps.Toler  => 
		  Err := Ps.Scan_Double (D);
		  Su := Ps.Cut_Tol_Type'Image (V) & "  ";
	       when Ps.Intol  => 
		  Err := Ps.Scan_Double (D);
		  Su := Ps.Cut_Tol_Type'Image (V) & "  ";
	       when Ps.Outtol => 
		  Err := Ps.Scan_Double (D);
		  Su := Ps.Cut_Tol_Type'Image (V) & " ";
	       when Ps.Cutter => 
		  Err := Ps.Scan_Double (D);
		  Su := Ps.Cut_Tol_Type'Image (V) & " ";
	       when others    => 
		  M_Print_Error ("option " & Ps.Cut_Tol_Type'Image (V) & 
				   " cannot be used at present");
		  exit;
	    end case;
	    if Err then
	       M_Print_Error 
		 ("cutter location file fault: badly formed float value");
	       exit;
	    end if;
	    M_Print_Cut_Tol (Su & Long_Float'Image (D));
	 end if;
	 exit;
      end loop;
      return Err;
   end Parse_Cut_Tol;
   
   
   function Parse_Kwi_Rec (Nextr : As.Stream_Element_Offset) return Boolean
   is
      V   : Ps.Kwi_Type := Ps.Endk;
      Err : Boolean     := False;
   begin
      Err := Ps.Scan_Kwi_Index (V);
      if Err then
	 M_Print_Error ("internal fault : Kwi_Type not in the table");
      else
	 Gct.Trace (Debug_Str, "#   Kwi_Type " & 
		      Ps.Kwi_Type'Image (V));
	 case V is
	    when Ps.PARTNO => Err := Parse_Info;
	    when Ps.PPRINT => Err := Parse_Info;
	    when Ps.INSERT => Err := Parse_Insert;
	    when Ps.FEDRAT => Err := Parse_Feedrate (Nextr);
	    when Ps.SPINDL => Err := Parse_Spindle (Nextr);
	    when Ps.MACHIN => Err := Parse_Machine;
	    when Ps.ORIGIN => Err := Parse_Origin;
	    when Ps.Istop  => M_Print_Istop ("");
	    WHEN Others => Null;
	 end case;
      end if;
      return Err;
   end Parse_Kwi_Rec;
   
   
   function Parse_Move_Rec (Nextr : As.Stream_Element_Offset) return Boolean
   is
      V   : Ps.Move_Rec_Type := Ps.Nix0;
      Err : Boolean          := False;
   begin
      Err := Ps.Scan_Mov_Rec_Index (V);
      if Err then
	 M_Print_Error ("internal fault : Move_Rec_Type not in the table");
      else
	 Gct.Trace (Debug_Str, "#    Ps.Move_Rec_Type " & 
		      Ps.Move_Rec_Type'Image (V));
	 case V is
	    when Ps.From => Err := Parse_From (Nextr);
	    when Ps.Gto  => Err := Parse_Gto (Nextr);
	    when others  => 
	       M_Print_Error ("movement option " & Ps.Move_Rec_Type'Image (V) & 
				" cannot be used at present");
	       Err := True;
	 end case;
      end if;
      return Err;
   end Parse_Move_Rec;
   
   
   
   function Parse_Source_Lnno return Boolean 
   is
      V    : Long_Long_Integer range 1 .. Long_Long_Integer'Last := 1; 
      Err  : Boolean := False;
   begin
      Err := Ps.Scan_Source_Line_Number (V);
      if Err then 
	 M_Print_Error 
	   ("cutter location file fault: Inconsistent source line number");
      else
	 M_Print_Apt_Block (V);
      end if;
      return Err;
   end Parse_Source_Lnno;
   
   
   ---------------
   -- top level --
   ---------------
   
   function Parse (Text : Stream_Element_Array_Access) return Result
   is
      Done, Err  : Boolean         := False;
      Header     : Ps.Header_Type;
      use type As.Stream_Element_Offset;
      Next_Token_Number : As.Stream_Element_Offset := 1;
   begin
      Multax_On := False;
      Ps.Text := Text;
      Ps.Next_Token := Ps.Text'First;
      while not Done loop
	 Ps.Next_Token := Next_Token_Number; -- until we can use this for fault trapping
	 Err := Ps.Scan_Header (Header, Done);
	 if Err then 
	    M_Print_Error 
	      ("cutter location file fault: Inconsistent header");
	    exit;
	 elsif not Done then
	    Gct.Trace (Debug_Str, "Cl.Tap Block " & 
			 Positive'Image (Header.Rec_No));
	    Gct.Trace (Debug_Str, "#    record length: " & 
			 Positive'Image (Header.Rec_Len));
	    Gct.Trace (Debug_Str, "#    record type: " & 
			 Ps.Rec_Type'Image (Header.Rec_T));
	    Next_Token_Number := Next_Token_Number + 
	      As.Stream_Element_Offset (16 + Header.Rec_Len * 8);
	    case Header.Rec_T is
	       when Ps.Source_Lnno         => 
		  Err := Parse_Source_Lnno;
	       when Ps.Kwi_Rec             => 
		  Err := Parse_Kwi_Rec (Next_Token_Number);
	       when Ps.Move_Rec            =>
		  Err := Parse_Move_Rec (Next_Token_Number);
	       when Ps.Cut_Tol_Rec         =>
		  Err := Parse_Cut_Tol;
	       when Ps.Special_Feature_Rec => 
		  Err := Parse_Special_Feature;
	       when Ps.Fini                =>
		  M_Print_Fini ("");
	       when others => null;
	    end case;
	    exit when Err;
	 end if;
      end loop;
      if Err then return Failure;
      else return Success;
      end if;
   end Parse;
   
end Post.Parser;
