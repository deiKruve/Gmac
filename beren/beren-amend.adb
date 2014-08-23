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
	       -- get the value for the key in M.X ------------------------units??
	       while M.X - T.Key > Long_Float'Epsilon and T /= null  loop
		  T := T.Next;
	       end loop;
	       if T /= null then
		  M.Class := Bjo.Real;
		  M.X := T.Val;
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
	       -- X = key, X1 = value
	       declare 
		  Tn  : Table_P_Type := new Table_type;
	       begin
		  T := Obj.C_Table;
		  while M.X - T.Key > Long_Float'Epsilon and T.next /= null  loop
		     T := T.Next;
		  end loop;
		  if T.next = null then -- insert at the end.
		     Tn.Next := T.Next;
		     Tn.Prev := T;
		     T.Next  := Tn;
		     Tn.Key  := M.X;
		     Tn.Val  := M.X1;
		     M.Res   := 0;
		  elsif abs (M.X - T.Key) =< Long_Float'Epsilon then
		     -- this is the key record, correct the value
		     T.Val   := M.X1;
		     M.Res   := 0;
		  else -- insert before this record
		     Tn.Prev := T.Prev;
		     T.Prev  := Tn;
		     Tn.Next := T;
		     Tn.Key  := M.X;
		     Tn.Val  := M.X1;
		  end if;
	       end;
	    else
	       M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Setpar then
	    -- dissect the string 
	    --   <Name> ".Enable = " <boolValue>
	    --   <Name> ".Rel = " <boolValue>
	    --   <Name> ".Bdirectional = " <boolValue>
	    --   <Name> ".Qcurve = " <boolValue>
	    --
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
			null;
			
		     end if;
			
			
	 end if;
      end Handle_Attr_M;

   begin
      
   end Handle;

begin
   Amender.C_Table.Prev := null;
   Amender.C_Table.Next := null;
   
end Beren.Amend;
