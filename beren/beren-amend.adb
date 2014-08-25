------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                           B E R E N . A M E N D                          --
--                                                                          --
--                                  B o d y                                 --
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
--                 Beren is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- Template for a correction module
--
with Ada.Text_Io;-- debug??

--with Ada.Numerics;
with Gmactextscan;
with O_String;
with Beren.Err;

package body Beren.Amend is
      package Tio renames Ada.Text_Io; -- debug??
   
   package Gts renames Gmactextscan;
   package Obs renames O_String;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Bth renames Beren.Thread;
   package Ber renames Beren.Err;
   package Math renames Ada.Numerics;
   
   --------------------
   -- Scan variables --
   --------------------
   
   
      
   -------------------------------------
   -- to radian or not to radian . .  --
   -------------------------------------
   function To_Radians (Deg : Long_Float) return Long_Float
   is
   begin
      return (Deg * 2.0 * Math.Pi) / 360.0;
   end To_Radians;
   
   function To_Degrees (Rad : Long_Float) return Long_Float
   is
   begin
      return (Rad * 360.0) / (2.0 * Math.Pi);
   end To_Degrees;
   
   pragma Inline (To_Radians, To_Degrees);
   
   
   ------------------------------------
   -- find the quintic coefficients. --
   ------------------------------------
   
   procedure Quit_Find (T : Table_P_Type)
   is
   begin
      
      null;
   end Quint_Find;


   -----------------------
   -- Message interface --
   -----------------------
   
   --  message handler  --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Amend_Object_Type; 
			       M : in out Bjo.Attr_Msg) 
	with Inline
      is
	 T   : Table_P_Type := Obj.C_Table.Next;
	 --Tn  : Table_P_Type;
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then  
	    if Obs.Eq (M.Name, "Rel") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Rel;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Bdirectional") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Bdirectional;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Qcurve") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Qcurve;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Enable") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Enable;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "C_Table") and then M.Class = Bjo.Real then 
	       -- get the values for the key in M.X
	       while M.X - T.Key > Long_Float'Epsilon and T /= null  loop
		  T := T.Next;
	       end loop;
	       if T /= null then
		  M.Class := Bjo.Real_Pair;
		  M.X := T.Val;
		  M.X1 := T.B;
		  M.Res := 0;
	       else 
		  Ber.Report_Error 
		    ("get param: " & Name & "Key not found.");
		  M.Res := 3; -- key not found;
	       end if;
	    elsif Obs.Eq (M.Name, "C_Table_B") and then M.Class = Bjo.Int then
	       -- gets the B number subscripted by the integer sent.
	       for I in range 0 .. M.X loop
		  exit when T = null;
	       end loop;
	       if T /= null then
		  M.Class := Bjo.Real;
		  M.X := T.B;
		  M.Res := 0;
	       else 
		  Ber.Report_Error 
		    ("get param: " & Name & "B not found.");
		  M.Res := 3; -- key not found;
	       end if;
	    elsif Obs.Eq (M.Name, "In_Corrector") then
	      M.Class := Bjo.Real;
	      M.X     := In_Corrector.all;
	      M.Res := 0;
	   elsif Obs.Eq (M.Name, "In_Cpos") then
	      M.Class := Bjo.Real;
	      M.X     := In_Cpos.all;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Out_Cpos") then
	      M.Class := Bjo.Real;
	      M.X     := Out_Cpos;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "In_Rpos") then
	      M.Class := Bjo.Real;
	      M.X     := In_Rpos.all;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Out_Rpos") then
	      M.Class := Bjo.Real;
	      M.X     := Out_Rpos;
	      M.Res   := 0;
	   else
	      Ber.Report_Error 
		("get param: " & Name & "no such attribute");
	      M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Set and then Obs.Eq (M.S, Name) then
	    if Obs.Eq (M.Name, "Rel") and then M.Class = Bjo.Bool then
	       Obj.Rel := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Bdirectional") and then M.Class = Bjo.Bool then
	       Obj.Bdirectional := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Qcurve") and then M.Class = Bjo.Bool then
	       Obj.Qcurve := M.B;
	       if M.B = True then -- find the quintic parameters
		  Quint_Find (Obj.C_Table);
		  M.Res := 0;
	       else
		  null; -- nothing to be done;
	       end if;
	    elsif Obs.Eq (M.Name, "Enable") and then M.Class = Bjo.Bool then
	       Obj.Enable := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "C_Table") and then M.Class = Bjo.Real_Pair then
	       -- X = key, X1 = value, C = 'U' | 'D' | ''(pos dir, neg dir or no dir)
	       declare 
		  Tn  : Table_P_Type;
	       begin
		  T := Obj.C_Table;
		  while T.next /= null and then -- find key
		    (abs (M.X - T.Key) > Long_Float'Epsilon and
		       M.X > T.Key) loop
		     T := T.Next;
		  end loop;
		  if T.next = null then -- insert at the end.
		     Tn      := new Table_type;
		     Tn.Next := T.Next;
		     Tn.Prev := T;
		     T.Next  := Tn;
		     Tn.Key  := M.X;
		  elsif abs (M.X - T.Key) <= Long_Float'Epsilon then
		     -- this is the key record, correct the value
		     Tn := T;
		  else -- insert before this record
		     Tn      := new Table_type;
		     Tn.Prev := T.Prev;
		     T.Prev  := Tn;
		     Tn.Next := T;
		     Tn.Key  := M.X;
		  end if;
		  If M.C in 'U' | 'u' then --pos direction
		     Tn.Val  := M.X1;
		  elsif M.C in 'D' | 'd' then --neg direction
		     Tn.B := M.X1;
		  else Tn.Val  := M.X1; -- single values
		  end if;
		  M.Res   := 0;
	       end;
	    else
	       M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Setpar then
	    -- dissect the string 
	    --   <Name> ".Enable = " <boolValue>
	    --   <Name> ".Relative = " <boolValue>
	    --   <Name> ".Bdirectional = " <boolValue>
	    --   <Name> ".Qcurve = " <boolValue>
	    --   <Name> ".C_Table "["U "|"D "] <key> " = " <value>
	    if M.Class = Bjo.Str then
	       declare
		  J, K : Integer := 0;
		  Tmp_Val : Long_Float := 0.0;
	       begin
		  for I in M.S'Range loop
		     J := I;
		     exit when M.S (I) = '.';
		     exit when M.S (I) /= Name (I);
		  end loop;
		  if M.S (J) = '.' then -- module name found
		     for I in J + 1 .. M.S'Length loop
			exit when M.S (I) in ' ' | '=';
			K := I;
		     end loop;
		     if String (M.S) (J + 1 .. K) = "Relative" then
			-- set "Relative"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'T' | 'F' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "True" | "true" | 
			  "False" | "false" then
			   Amender.Relative := 
			     Boolean'Value (String (M.S) (K .. J - 1));
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Relative -> expected 'True' or 'False'.");
			   M.Res := 3; -- exception in conversion
			end if; -- true or false
		     elsif String (M.S) (J + 1 .. K) = "Bdirectional" then
			-- set "Bdirectional"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'T' | 'F' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "True" | "true" | 
			  "False" | "false" then
			   Amender.Bdirectional := 
			     Boolean'Value (String (M.S) (K .. J - 1));
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Bdirectional -> expected 'True' or 'False'.");
			   M.Res := 3; -- exception in conversion
			end if; -- true or false
		     elsif String (M.S) (J + 1 .. K) = "Qcurve" then
			-- Set "Qcurve"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'T' | 'F' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "True" | "true" | 
			  "False" | "false" then
			   Amender.Qcurve := 
			     Boolean'Value (String (M.S) (K .. J - 1));
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Qcurve -> expected 'True' or 'False'.");
			   M.Res := 3; -- exception in conversion
			end if; -- true or false
		     elsif String (M.S) (J + 1 .. K) = "Enable" then
			-- set "Enable"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'T' | 'F' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "True" | "true" | 
			  "False" | "false" then
			   Amender.Enable := 
			     Boolean'Value (String (M.S) (K .. J - 1));
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Enable -> expected 'True' or 'False'.");
			   M.Res := 3; -- exception in conversion
			end if; -- true or false
		     elsif String (M.S) (J + 1 .. K) = "C_Table" then
			-- enter a value in "C_Table"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			declare
			   Up, Down : Boolean := False;
			   Tmp_Key,
			   Tmp_Val  : Long_Float := 0.0;
			   Tn       : Table_P_Type;
			begin
			   if M.S (K) = 'U' then
			      Up := True;
			      K := K + 1;
			      while M.S (K) = ' ' loop
				 K := K + 1;
			      end loop;
			   elsif M.S (K) = 'D' then 
			      Down := True;
			      K := K + 1;
			      while M.S (K) = ' ' loop
				 K := K + 1;
			      end loop;
			   else Up := True; -- when no direction indicator given
			   end if;
			   J := K;
			   while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			      J := J + 1;
			   end loop;
			   Tmp_Key := Long_Float'Value (String (M.S) (K .. J - 1));
			   while M.S (J) in ' ' | '=' loop
			      J := J + 1;
			   end loop;
			   K := J;
			   while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			      J := J + 1;
			   end loop;
			   Tmp_Val := Long_Float'Value (String (M.S) (K .. J - 1));
			   T := Obj.C_Table;
			   while T.next /= null and then 
			     (abs (Tmp_Key - T.Key) > Long_Float'Epsilon and
				Tmp_Key > T.Key) loop
			      T := T.Next;
			   end loop;
			   if T.next = null then -- insert at the end.
			      Tn      := new Table_type;
			      Tn.Next := T.Next;
			      Tn.Prev := T;
			      T.Next  := Tn;
			      Tn.Key  := Tmp_Key;
			   elsif abs (Tmp_key - T.Key) <= Long_Float'Epsilon then
			      -- this is the key record, correct the value
			      Tn := T;
			   else -- insert before this record
			      Tn      := new Table_type;
			      Tn.Prev := T.Prev;
			      T.Prev  := Tn;
			      Tn.Next := T;
			      Tn.Key  := Tmp_Key;
			   end if;
			   If Up then
			      Tn.Val  := Tmp_Val;
			   elsif Down then
			      Tn.B := Tmp_Val;
			   end if;
			   M.Res   := 0;
			end; -- c_table block
		     else
			Ber.Report_Error 
			  ("set param: " & Name & "no such attribute");
			M.Res := 1; -- no such attribute
		     end if; -- attr name found
		  else
		     M.Res := -4; -- name not found, this is not an error
		  end if; -- module name found
	       exception
		  when others =>
		     Ber.Report_Error 
		       ("set param: " & Name & 
			  ".some attr -> expected a real value.");
		     M.Res := 3; -- exception in conversion
	       end; -- m.class = string block	
	    end if; -- if m.class = string
	    
	 elsif M.Id = Bob.Enum then
	    M.Name  := Obs.To_O_String (32, "Relative");
	    M.Class := Bjo.Bool;
	    M.B := Amender.all.Relative;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Bdirectional");
	    M.Class := Bjo.Bool;
	    M.B := Amender.all.Bdirectional;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Qcurve");
	    M.Class := Bjo.Bool;
	    M.B := Amender.all.Qcurve;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Enable");
	    M.Class := Bjo.Bool;
	    M.B := Amender.all.Enable;
	    M.Enum  (Name, M);
	    
	    declare 
	       T   : Table_P_Type := Amender.C_Table.Next;
	    begin
	       while T /= null loop
		  M.Name  := 
		    Obs.To_O_String (32, "C_Table " & Long_Float'Image (T.Key));
		  M.Class := Bjo.Real_Pair;
		  M.X     := T.Val;
		  M.X1    := T.B;
		  M.Enum  (Name, M);
		  T := T.Next;
	       end loop;
	    end;
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Corrector");
	    M.Class := Bjo.Real;
	    M.X     := In_Corrector.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Cpos.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Rpos.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Out_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Cpos.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Out_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Rpos.all;
	    M.Enum  (Name, M);
	    
	 end if; -- M.Id = ..
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Jog_Object_Type; 
			       M : in out Bob.File_Msg)
	with Inline
      is
	 Token     : Gts.Extended_Token_Type;
	 
	 use type Bob.File_Op_Type;
	 use type Gts.Extended_Token_Type;
      begin
	 if M.Id = Bob.Store then
	    declare
	    begin
	       String'Write (M.Ostr, "" & Name & " = {");
	       String'Write (M.Ostr, "Relative = {" &
			       Boolean'Image (Obj.Relative) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "Bdirectional = {" &
			       Boolean'Image (Obj.Bdirectional) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "Qcurve = {" &
			       Boolean'Image (Obj.Qcurve) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "Enable = {" &
			       Boolean'Image (Obj.Enable) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "C_Table = {");
	       declare 
		  T   : Table_P_Type := Amender.C_Table.Next;
	       begin
		  while T /= null loop
		     String'Write (M.Ostr, "{"& 
				     Long_Float'Image (Obj.Key) & " " &
				     Long_Float'Image (Obj.Val) & " " &
				     Long_Float'Image (Obj.B)   & "}");
		     T := T.Next;
		  end loop;
	       end;
	       String'Write (M.Ostr, "}" & ASCII.LF);
	       M.Res := -1; -- success with this unit
	    exception
	       when others => M.Res := 4; -- disk full
	    end;
	    
	 elsif M.Id = Bob.Load then
	    loop
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Relative");
	       --Tio.Put_Line ("debugger" & Gts.String_Value);
	       case Token is
		  when Gts.T_String =>
		     Amender.Relative := Boolean'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Relative -> expected 'True' or 'False'.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Bdirectional");
	       --Tio.Put_Line ("debugger" & Gts.String_Value);
	       case Token is
		  when Gts.T_String =>
		     Amender.Bdirectional := Boolean'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Bdirectional -> expected 'True' or 'False'.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Qcurve");
	       --Tio.Put_Line ("debugger" & Gts.String_Value);
	       case Token is
		  when Gts.T_String =>
		     Amender.Qcurve := Boolean'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Qcurve -> expected 'True' or 'False'.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Enable");
	       --Tio.Put_Line ("debugger" & Gts.String_Value);
	       case Token is
		  when Gts.T_String =>
		     Amender.Enable := Boolean'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Enable -> expected 'True' or 'False'.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".C_Table");
		 declare 
		    T   : Table_P_Type := Amender.C_Table.Next;
		    Exptn : exception;
		 begin
		    if Token /= Gts.Open_Brace then raise Exptn; end if;
		    while T /= null loop
		       Token := Gts.Next_Token;
		       if Token = Gts.T_String then
			  T.Key := Long_Float'Value (Gts.String_Value);
		       else raise Exptn; 
		       end if;
		       Token := Gts.Next_Token;
		       if Token = Gts.T_String then
			  T.Val := Long_Float'Value (Gts.String_Value);
		       else raise Exptn; 
		       end if;
		       Token := Gts.Next_Token;
		       if Token = Gts.T_String then
			  T.B := Long_Float'Value (Gts.String_Value);
		       else raise Exptn; 
		       end if;
		       T := T.Next;
		    end loop;
		    Token := Gts.Next_Token;
		    if Token /= Gts.Close_Brace then raise Exptn; end if;
		    M.Res := 0;
		 exception
		    when Exptn => 
		       Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".C_Table -> Key, Value, Value triplets " & 
			  "of real expected.");
		       M.Res := 3; -- exception in conversion
		 end;

	    end loop; -- read pars
	 end if; -- M.Id = 
      end Handle_File_M;
      ------------------
   begin
      if Obj.all in Amend_Object_Type then
	 if M in Bjo.Attr_Msg then
	    Handle_Attr_M (Amend_Object_Type (Obj.all), Bjo.Attr_Msg (M));
	 elsif M in Bob.File_Msg then
	    Handle_File_M (Amend_Object_Type (Obj.all), Bob.File_Msg (M));
	 end if;
      end if;
   end Handle;
   
   
   -------------------------------------------
   -- Scan once per cnc scan period         --
   -- this is executed in a priority thread --
   -------------------------------------------
   procedure Down_Scan
   is
   begin
      null;
   end Down_Scan;
   
   procedure Up_Scan
   is
   begin
      null;
   end Up_Scan;
   
   
   -- input defaults
   In_Corrector_Xf : aliased M_Type := In_Corrector_Init;
   In_Cpos_Xf      : aliased M_Type := In_Cpos_Init;
   In_Rpos_Xf      : aliased M_Type := In_Rpos_Init;
   
   
begin
   Amender.C_Table.Prev := null;
   Amender.C_Table.Next := null;
   
   -- connect inputs to the defaults
   In_Corrector := In_Corrector_Xf'Access;
   In_Cpos      := In_Cpos_Xf'Access;
   In_Rpos      := In_Rpos_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   Bth.Insert_Down_Scan (Ds);
   Bth.Insert_Up_Scan (Us);
   
end Beren.Amend;
