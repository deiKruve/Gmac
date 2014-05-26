------------------------------------------------------------------------------
--                                                                          --
--                             GMAC COMPONENTS                              --
--                                                                          --
--                          T E X T S C A N N E R                           --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--         Copyright (C) 2001-2012, Free Software Foundation, Inc.          --
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
--                  Gmac is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

--  Scanner for the Gmac setup file

with System.Storage_Elements;

with GNATCOLL.Traces;
with Generic_Scanner;
with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;
with Ada.Exceptions;
with Ada.Text_IO;
with Ada.Streams;

with POSIX.IO;
with POSIX.Files;
with POSIX.File_Status;
with POSIX.Permissions;
with POSIX.Process_Identification;
with POSIX.Memory_Mapping;


package body Gmactextscan is

   package Asu renames Ada.Strings.Unbounded;
   package Acl renames Ada.Characters.Latin_1;
   package As  renames Ada.Streams;  
   
   package Gct renames GNATCOLL.Traces;

   package Pio renames POSIX.IO;
   package Pf  renames POSIX.Files;
   package Pfs renames POSIX.File_Status;
   package Pps renames POSIX.Permissions;
   package Ppi renames POSIX.Process_Identification;
   
   Stream1 : constant Gct.Trace_Handle := Gct.Create ("GMACTEXTSCAN");
   Stream2 : constant Gct.Trace_Handle := Gct.Create ("GMACTEXTSCAN.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("GMACTEXTSCAN.DEBUG");

   
   
   
   subtype Stream_Element_Array is Ada.Streams.Stream_Element_Array;
   type Stream_Element_Array_Access is access all Stream_Element_Array;
   
   File_Text : Stream_Element_Array_Access := null;

   function "+" (X : String) return Asu.Unbounded_String
     renames Asu.To_Unbounded_String;

   package Scan is new Generic_Scanner (Token_Type);
      
   Tokens : constant Scan.Token_Regexp_Array :=
     (ID          => Scan.ID_Regexp (Additional_ID_Chars => "."),
      Number      => Scan.Number_Regexp,
      Float       => Scan.Float_Regexp,
      T_String    => Scan.String_Regexp ('"'),
      Comma       => +",",
      Exclamation => +"!",
      --Colon       => +":",
      --Semicolon   => +";",
      Equal       => +"=",
      Open_Brace  => +"{",
      Close_Brace => +"}",
      EOF         => +"");
   
  
   --Expected       : Extended_Token_Type;
   --Expected_Value : Unbounded_String;
   --Token          : Token_Type;
   
   
   procedure Error_Message (Message : String)
   is
   begin
      Gct.Trace (Stream1, Message);
   end Error_Message;
   -- pragma Inline_Always (Error_Message);
   
   
   
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
   
   
   ---------------------------------------------------------
   -- the global scanner for gmac.text.                   --
   -- it stays in existence as long as the program exists --
   ---------------------------------------------------------
   Scanner : Scan.Scanner_Type :=
     Scan.New_Scanner
     (Input         => Scan.Stream_Element_Array_Access (Open (Setup_File)),
      Regexps       => Tokens,
      Xtra_White_Space => "*:;",
      Comment_Delim => Scan.Comment_Like (Scan.Shell_Like),
      Scan          => False);
   
   
   -- local helpers --
   
   procedure Skip_Group (Scanner : Scan.Scanner_Type)
   is
      Open_Braces : Natural := 1;
      Token       : Token_Type;      
   begin
      loop
	 Token := Scanner.Next_Token;
	 if Token = Open_Brace then Open_Braces := Open_Braces + 1;
	 elsif Token = Close_Brace then Open_Braces := Open_Braces -1;
	 end if;
	 exit when Open_Braces = 0 or Scanner.At_EOF;
      end loop;
   exception
      when E : Scan.Unrecognized_Token  | 
	Scan.Unmatched_Token | Scan.Unexpected_EOF =>
	 Gct.Trace (Stream2, E);
	 Error_Message ("'gmac.text': Token Error");
	 Error_Message ("Error near the end of '" & 
			  Extended_Token_Type'Image (Scanner.Current_Token) & 
			  " " & Scanner.String_Value & "'");
   end Skip_Group;
   
   
   -- find a parameter in the setup file --
   function Find_Parameter (Param : String) return Extended_Token_Type
   is
      Done   : Boolean := True;
      Eos    : Boolean := False;
      J, K, 
      Iparam : Positive := Param'First;
      
      Token  : Extended_Token_Type;
   begin
      null;
      Scanner.Restart_Scanner (Scan => True);
      while j < Param'Last and not Scanner.At_Eof and Done loop
	 while Param (J) /= '.' and J < Param'Last loop
	    J := J + 1;
	 end loop;
	 if Param (J) = '.' then J := J -1; end if;
	 Done := False; Eos := False;
	 loop
	    Gct.Trace (Debug_Str, Scanner.String_Value);
	    if Scanner.Current_Token = ID then
	       Scanner.Next;
	       if not Scanner.At_Eof then
		  if Scanner.Current_Token = Equal then
		     if Scanner.Last_String_Value = Param (K .. J) then -- found
			K := J + 2; -- ready for the next name part
			J := K;     --    if any
			Scanner.Next;
			if not Scanner.At_Eof and 
			  Scanner.Current_Token = Open_Brace then
			   Scanner.Next;
			end if;
			Token := Scanner.Current_Token;
			Done := True;
		     else
			Scanner.Next;
			if not Scanner.At_Eof and 
			  Scanner.Current_Token = Open_Brace then
			   Skip_Group (Scanner);
			end if;
			if not Scanner.At_Eof then Scanner.Next;
			else Eos := True;
			end if;
		     end if;
		  else Eos := True;
		  end if;
	       else Eos := True;
	       end if;
	    elsif Scanner.Current_Token = Open_Brace then -- unnamed entry
	       Skip_Group (Scanner);
	       if not Scanner.At_Eof then Scanner.Next;
	       else Eos := True;
	       end if;
	    else Eos := True;
	    end if;
	    
	    exit when Done or Eos;
	 end loop;
      end loop;
      if not Done or Scanner.String_Value'Length = 0 then
	 Token := Error;
	 Error_Message ("Error near the end of '" & Param (Param'First .. J) & "'");
      end if;
      return Token;
   exception
      when E : Scan.Unrecognized_Token | 
	Scan.Unmatched_Token | Scan.Unexpected_EOF =>
	 Gct.Trace (Stream2, E);
	 Error_Message ("'gmac.text': Token Error");
	 Error_Message ("Error near the end of '" & Param (Param'First .. J) & "'");
	 Token := Error;
	 return Token;
   end Find_Parameter;
   
   
   -- ask for the next token --
   function Next_Token return Extended_Token_Type
   is
      Token : Extended_Token_Type;
   begin
      if not Scanner.At_Eof then
	 Token := Scanner.Next_Token;
      else 
	 Token := Error;
      end if;
      return Token;
   end Next_Token;
   
   
   -- string value of the last scanned token. --
   function String_Value return String
   is
   begin
      return Scanner.String_Value;
   end String_Value;
   
   
begin
   null;
   Gct.Parse_Config_File;   --  parses default ./.gnatdebug
   --User.Proc;

end Gmactextscan;
