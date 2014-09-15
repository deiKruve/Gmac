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
--ambrogio de agostini
-- Template for a correction module
--
with Ada.Text_Io;-- debug??
with Ada.Streams;
with Ada.Numerics.Generic_Real_Arrays;

with Bezier_Spline;
with Gmactextscan;
with O_String;
with Beren.Err;
with Beren.Jogobj;

package body Beren.Amend is
   package Tio renames Ada.Text_Io; -- debug??
      
   package Bs  renames Bezier_Spline;
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
   
   
   --------------------------------------------------------
   -- the Bezier section                                 --
   -- from the points in C_Table the definitions of the  --
   -- bezier curve spline pieces are found.              --
   -- then the spline is plotted into the B_Table via    --
   -- Point_Write                                        --
   --------------------------------------------------------
   
   B_Table       : Table_P_Type;  -- the spline table anchor
   B_Table_Now : Table_P_Type with atomic;  -- and a pointer
   
   
   -- Point_Write is used by Point_Type'Write in the Bezier package
   -- Stream is preset to Std-Out 
   -- Item has the Bs.Point_Type to be plotted
   procedure Point_Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Bs.Point_Type)
   is
      Tn  : Table_P_Type;
   begin
      -- insert at the end, i.e. before the anchor
      Tn               := new Table_type;
      Tn.Next           := B_Table;
      Tn.Prev           := B_Table.Prev;
      B_Table.Prev.Next := Tn;
      B_Table.Prev      := Tn;
      Tn.Key  := Item.X;
      Tn.Val  := Item.Y;
      if Tn.Prev /= B_Table then -- not for the first one
	 --Y = X.m + n
	 --Y = X((y2-y1)/(x2-x1))+(x2y1-x1y2)/(x2-x1)
	 Tn.Prev.M := (Tn.Val - Tn.Prev.Val) / (Tn.Key - Tn.Prev.Key);
	 Tn.Prev.N := (Tn.Key * Tn.Prev.Val - Tn.Prev.Key * Tn.Val) / 
	   (Tn.Key - Tn.Prev.Key);
      end if;
   end Point_Write;
   
   
   -------------------------------
   -- find Bezier coefficients. --
   -------------------------------
   
   procedure Open_Bezi_Find (T : Table_P_Type)
     -- count the number of points
     -- and transfer them into a knot array
     -- call the bezier routine and store the result
     --
     -- the output is stored in B_Table by the Point_Write routine.
     -- 
   is
      Tn : Table_P_Type := T.Next;
      N  : Integer := 0; -- Number of knots
   begin
      while Tn /= null loop -- count the data points
	 N := N + 1;
	 Tn:= Tn.Next;
      end loop;
      Tn := T.Next; -- back to the beginning
      declare
	 Knots                 : Bs.Point_Array_Type (1 .. N);
	 First_Control_Points  : Bs.Point_Array_Type (1 .. N - 1);
	 Second_Control_Points : Bs.Point_Array_Type (1 .. N - 1);
      begin
	 -- knots.x will have the Z value
	 -- knots Y will have the required focussing voltage level.
	 -- in other words: X will have the read value, and Y the 
	 -- corrected absolute value
	 for I in Knots'First .. Knots'Last loop
	    Knots (I).X := Tn.key;
	    Knots (I).Y := Tn.Val;
	    Tn:= Tn.Next;
	 end loop;
	 Bs.Get_Curve_Control_Points 
	   (Knots, First_Control_Points, Second_Control_Points);
	 B_Table      := new Table_Type; -- set up the global table
	 B_Table.Prev := B_Table;
	 B_Table.Next := B_Table;
	 --B_Table_Now  := B_Table; -- the pointer for storing the plot
	 Bs.Plot_Bez_Spline 
	   (Knots, First_Control_Points, Second_Control_Points, Amender.Dmax);
	 B_Table_Now  := B_Table.next; -- ready for every day use in the scanner
      end;
   end Open_Bezi_Find;
   
     
     ---------------------------------------
   -- find the polynomial coefficients. --
   ---------------------------------------
   
   procedure Poly_Find (T : Table_P_Type)
     -- count the number of points, this gives the order
     -- then select the fitting matrix and result vector to suit
     -- call the solver 
     -- and tranfer the result to the table.
     --
     -- we might want to remember the number of points for the recurring 
     -- rt level calculation.
   is
      Tn : Table_P_Type := T.Next;
      N  : Integer := 0; -- Order of The curve
      package Gra is new Ada.Numerics.Generic_Real_Arrays(Real => Long_Float);
      
      
      procedure Fill_In_A2 (A : in out Gra.Real_Matrix; 
			    V : in out Gra.Real_Vector; 
			    T : in out Table_P_Type) with Inline 
      is
      begin
	 A (1, 1) := 1.0;
	 A (1, 2) := Tn.Key;
	 V (1)    := Tn.Val;
	 Tn := Tn.Next;
	 A (2, 1) := 1.0;
	 A (2, 2) := Tn.Key;
	 V (2)    := Tn.Val;
      end Fill_In_A2;
      
      procedure Fill_In_A3 (A : in out Gra.Real_Matrix; 
			    V : in out Gra.Real_Vector; 
			    T : in out Table_P_Type) with Inline 
      is
	 Tn : Table_P_Type := T;
      begin
	 A (1, 1) := 1.0;
	 A (1, 2) := Tn.Key;
	 A (1, 3) := Tn.Key ** 2;
	 V (1)    := Tn.Val;
	 Tn := Tn.Next;
	 A (2, 1) := 1.0;
	 A (2, 2) := Tn.Key;
	 A (2, 3) := Tn.Key ** 2;
	 V (2)    := Tn.Val;
	 Tn := Tn.Next;
	 A (3, 1) := 1.0;
	 A (3, 2) := Tn.Key;
	 A (3, 3) := Tn.Key ** 2;
	 V (3)    := Tn.Val;
      end Fill_In_A3;
      
      
      procedure Fill_In_A4 (A : in out Gra.Real_Matrix; 
			    V : in out Gra.Real_Vector; 
			    T  : in out Table_P_Type) with Inline 
      is
	 Tn : Table_P_Type := T;
      begin
	 A (1, 1) := 1.0;
	 A (1, 2) := Tn.Key;
	 A (1, 3) := Tn.Key ** 2;
	 A (1, 4) := Tn.Key ** 3;
	 V (1)    := Tn.Val;
	 Tn := Tn.Next;
	 A (2, 1) := 1.0;
	 A (2, 2) := Tn.Key;
	 A (2, 3) := Tn.Key ** 2;
	 A (2, 4) := Tn.Key ** 3;
	 V (2)    := Tn.Val;
	 Tn := Tn.Next;
	 A (3, 1) := 1.0;
	 A (3, 2) := Tn.Key;
	 A (3, 3) := Tn.Key ** 2;
	 A (3, 4) := Tn.Key ** 3;
	 V (3)    := Tn.Val;
	 Tn := Tn.Next;
	 A (4, 1) := 1.0;
	 A (4, 2) := Tn.Key;
	 A (4, 3) := Tn.Key ** 2;
	 A (4, 4) := Tn.Key ** 3;
	 V (4)    := Tn.Val;
      end Fill_In_A4;
      
      procedure Fill_In_A5 (A : in out Gra.Real_Matrix; 
			    V : in out Gra.Real_Vector; 
			    T : in out Table_P_Type) with Inline 
      is
	 Tn : Table_P_Type := T;
      begin
	 A (1, 1) := 1.0;
	 A (1, 2) := Tn.Key;
	 A (1, 3) := Tn.Key ** 2;
	 A (1, 4) := Tn.Key ** 3;
	 A (1, 5) := Tn.Key ** 4;
	 V (1)    := Tn.Val;
	 Tn := Tn.Next;
	 A (2, 1) := 1.0;
	 A (2, 2) := Tn.Key;
	 A (2, 3) := Tn.Key ** 2;
	 A (2, 4) := Tn.Key ** 3;
	 A (2, 5) := Tn.Key ** 4;
	 V (2)    := Tn.Val;
	 Tn := Tn.Next;
	 A (3, 1) := 1.0;
	 A (3, 2) := Tn.Key;
	 A (3, 3) := Tn.Key ** 2;
	 A (3, 4) := Tn.Key ** 3;
	 A (3, 5) := Tn.Key ** 4;
	 V (3)    := Tn.Val;
	 Tn := Tn.Next;
	 A (4, 1) := 1.0;
	 A (4, 2) := Tn.Key;
	 A (4, 3) := Tn.Key ** 2;
	 A (4, 4) := Tn.Key ** 3;
	 A (4, 5) := Tn.Key ** 4;
	 V (4)    := Tn.Val;
	 Tn := Tn.Next;
	 A (5, 1) := 1.0;
	 A (5, 2) := Tn.Key;
	 A (5, 3) := Tn.Key ** 2;
	 A (5, 4) := Tn.Key ** 3;
	 A (5, 5) := Tn.Key ** 4;
	 V (5)    :=  Tn.Val;
      end Fill_In_A5;
      
      procedure Fill_In_A6 (A : in out Gra.Real_Matrix; 
			    V : in out Gra.Real_Vector; 
			    T : in out Table_P_Type) with Inline 
      is
	 Tn : Table_P_Type := T;
      begin
	 A (1, 1) := 1.0;
	 A (1, 2) := Tn.Key;
	 A (1, 3) := Tn.Key ** 2;
	 A (1, 4) := Tn.Key ** 3;
	 A (1, 5) := Tn.Key ** 4;
	 A (1, 6) := Tn.Key ** 5;
	 V (1)    := Tn.Val;
	 Tn := Tn.Next;
	 A (2, 1) := 1.0;
	 A (2, 2) := Tn.Key;
	 A (2, 3) := Tn.Key ** 2;
	 A (2, 4) := Tn.Key ** 3;
	 A (2, 5) := Tn.Key ** 4;
	 A (2, 6) := Tn.Key ** 5;
	 V (2)    := Tn.Val;
	 Tn := Tn.Next;
	 A (3, 1) := 1.0;
	 A (3, 2) := Tn.Key;
	 A (3, 3) := Tn.Key ** 2;
	 A (3, 4) := Tn.Key ** 3;
	 A (3, 5) := Tn.Key ** 4;
	 A (3, 6) := Tn.Key ** 5;
	 V (3)    := Tn.Val;
	 Tn := Tn.Next;
	 A (4, 1) := 1.0;
	 A (4, 2) := Tn.Key;
	 A (4, 3) := Tn.Key ** 2;
	 A (4, 4) := Tn.Key ** 3;
	 A (4, 5) := Tn.Key ** 4;
	 A (4, 6) := Tn.Key ** 5;
	 V (4)    := Tn.Val;
	 Tn := Tn.Next;
	 A (5, 1) := 1.0;	 
	 A (5, 2) := Tn.Key;	 
	 A (5, 3) := Tn.Key ** 2;
	 A (5, 4) := Tn.Key ** 3;
	 A (5, 5) := Tn.Key ** 4;
	 A (5, 6) := Tn.Key ** 5;
	 V (5)    := Tn.Val;
	 Tn := Tn.Next;
	 A (6, 1) := 1.0;	 
	 A (6, 2) := Tn.Key;	 
	 A (6, 3) := Tn.Key ** 2;
	 A (6, 4) := Tn.Key ** 3;
	 A (6, 5) := Tn.Key ** 4;
	 A (6, 6) := Tn.Key ** 5;
	 V (6)    := Tn.Val;
      end Fill_In_A6;

   begin
      while Tn/= null loop -- count the data points
	 N := N + 1;
	 Tn:= Tn.Next;
      end loop;
      Tn := T.Next; -- back to the beginning
      declare 
	 A  : Gra.Real_Matrix (1 .. N, 1 .. N);
	 V  : Gra.Real_Vector (1 .. N);
	 Vr : Gra.Real_Vector (1 .. N);
      begin
	 case N is
	    --when 1 => N1;
	    when 2 => Fill_In_A2 (A, V, Tn);
	    when 3 => Fill_In_A3 (A, V, Tn);
	    when 4 => Fill_In_A4 (A, V, Tn);
	    when 5 => Fill_In_A5 (A, V, Tn);
	    when 6 => Fill_In_A6 (A, V, Tn);
	    when others => Ber.Report_Error 
	       (Name & 
		" Polynomial parameter calculation: too few or too many data points.");
	 end case;
	 --Vr := Solv.Linear_Equations (A, V);
	 Vr := Gra.Solve (A, V);
	 Tn := T.Next; -- back to the beginning
	 for I in Vr'First .. Vr'Last loop
	    Tn.B := Vr (I);
	    Tn := Tn.Next;
	 end loop;
      end;
      null;
   end Poly_Find;


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
	 use type Bjo.Enumeration_Type;
	 use type Bjo.Curve_Enumeration_Type;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then  
	    if Obs.Eq (M.Name, "Relative") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Relative;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Bdirectional") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Bdirectional;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Curve") then
	       M.Class := Bjo.Enum;
	       M.E := Bjo.Curve_Enumeration_Type'Pos (Obj.Curve);
	       M.E1 := Bjo.Curve;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Enable") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Enable;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Dmax") then
	      M.Class := Bjo.Real;
	      M.X     := Obj.Dmax;
	      M.Res   := 0;
	    elsif Obs.Eq (M.Name, "B_Table") then
	       declare
		  T : Table_P_Type := B_Table.next;
	       begin
		  while T.Next /= null loop
		     M.Class := Bjo.Real_Pair;
		     M.X     := T.Key;
		     M.X1    := T.Val;
		     M.Enum  (Name, M);
		     T       := T.Next;
		  end loop;
		  M.Res   := 0;
	       end;
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
	       for I in 0 .. M.I loop
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
	    if Obs.Eq (M.Name, "Relative") and then M.Class = Bjo.Bool then
	       Obj.Relative := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Bdirectional") and then M.Class = Bjo.Bool then
	       Obj.Bdirectional := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Curve") and then 
	      M.Class = Bjo.Enum and then
	      M.E1 = Bjo.Curve then
	       Obj.Curve := Bjo.Curve_Enumeration_Type'Val (M.E);
	       if Obj.Curve = Bjo.Poly then -- find the polynomial parameters
		  Poly_Find (Obj.C_Table);
		  M.Res := 0;
	       elsif Obj.Curve = Bjo.Bezier then -- find the bezier spline curve
		  Open_Bezi_Find (Obj.C_Table);
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
		    (abs (M.X - T.Next.Key) > Long_Float'Epsilon and
		       M.X > T.Next.Key) loop
		     T := T.Next;
		  end loop;
		  if T.next = null then -- insert at the end.
		     Tn      := new Table_type;
		     Tn.Next := T.Next;
		     Tn.Prev := T;
		     T.Next  := Tn;
		     Tn.Key  := M.X;
		     Tn.Val  := 0.0;
		     Tn.B    := 0.0;
		  elsif abs (M.X - T.Next.Key) <= Long_Float'Epsilon then
		     -- this is the key record, correct the value
		     Tn := T.next;
		  else -- insert before this record
		     Tn          := new Table_type;
		     Tn.Prev     := T;
		     Tn.Next     := T.Next;
		     T.Next.Prev := Tn;
		     T.Next      := Tn;
		     Tn.Key      := M.X;
		     Tn.Val      := 0.0;
		     Tn.B        := 0.0;
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
	    --   <Name> ".Curve = " ["Off", "Linear", "Bezier" or "Poly"]
	    --   <Name> ".C_Table "["U "|"D "] <key> " = " <value>
	    --   <Name> ".Dmax" =  <floatValue> ["mm" | "inch"]
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
		     elsif String (M.S) (J + 1 .. K) = "Curve" then
			-- Set "Curve"
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'O' | 'B' | 'P' | 'L' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "Off" | "off" | "Linear" | 
			  "Bezier" | "bezier" | "Poly" | "poly" then
			   Amender.Curve := 
			     Bjo.Curve_Enumeration_Type'Value (String (M.S) (K .. J - 1));
			   if Amender.Curve = Bjo.Poly then
			      Poly_Find (Amender.C_Table);
			   elsif Amender.Curve = Bjo.Bezier then
			      Open_Bezi_Find (Amender.C_Table);
			   end if;
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Curve -> expected 'Off', 'Linear', 'Bezier' or 'Poly'.");
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
			   while T.next /= Obj.C_Table and then 
			     (abs (Tmp_Key - T.Next.Key) > Long_Float'Epsilon and
				Tmp_Key > T.Next.Key) loop
			      T := T.Next;
			   end loop;
			   if T.next = Obj.C_Table then -- insert at the end.
			      Tn      := new Table_type;
			      Tn.Next := T.Next;
			      Tn.Prev := T;
			      T.Next  := Tn;
			      Obj.C_Table.Prev := Tn;
			      Tn.Key  := Tmp_Key;
			      Tn.Val  := 0.0;
			      Tn.B    := 0.0;
			   elsif 
			     abs (Tmp_key - T.Next.Key) <= Long_Float'Epsilon then
			      -- this is the key record, correct the value");
			      Tn := T.Next;
			   else 
			      -- insert before this.next record");
			      -- so after T
			      Tn          := new Table_type;
			      Tn.Prev     := T;
			      Tn.Next     := T.next;
			      T.Next.Prev := Tn;
			      T.Next      := Tn;
			      Tn.Key      := Tmp_Key;
			      Tn.Val      := 0.0;
			      Tn.B        := 0.0;
			   end if;
			   If Up then
			      Tn.Val := Tmp_Val;
			   elsif Down then
			      Tn.B   := Tmp_Val;
			   end if;
			   M.Res   := 0;
			end; -- c_table block
		     elsif String (M.S) (J + 1 .. K) = "Dmax" then
			-- set Dmax
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Tmp_Val := Long_Float'Value (String (M.S) (K .. J - 1));
			while M.S (J) = ' ' loop
			   J := J + 1;
			end loop;
			if Xis = Linear and then 
			  String (M.S) (J .. J + 1) = "mm" then
			   Amender.Dmax := Tmp_Val;
			   M.Res := 0; -- success
			elsif Xis = Rotary and then 
			  String (M.S) (J .. J + 2) = "deg" then
			   Amender.Dmax := To_Radians (Tmp_Val);
			   M.Res := 0; -- success
			else
			   Ber.Report_Error 
			     ("set param: " & Name & ".Dmax -> wrong units.");
			   M.Res := 2; -- units wrong
			end if;
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
	    
	    M.Name  := Obs.To_O_String (32, "Curve");
	    M.Class := Bjo.Enum;
	    M.E := Bjo.Curve_Enumeration_Type'Pos (Amender.all.Curve);
	    M.E1    := Bjo.Curve;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Enable");
	    M.Class := Bjo.Bool;
	    M.B := Amender.all.Enable;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Dmax");
	    M.Class := Bjo.Real;
	    M.X     := Amender.all.Dmax;
	    M.Enum  (Name, M);
	    
	    declare 
	       T   : Table_P_Type := Amender.C_Table.Next;
	    begin
	       while T /= Amender.C_Table loop
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
	    M.X     := Out_Cpos;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Out_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Rpos;
	    M.Enum  (Name, M);
	    
	 end if; -- M.Id = ..
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Amend_Object_Type; 
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
	       String'Write (M.Ostr, "          Bdirectional = {" &
			       Boolean'Image (Obj.Bdirectional) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "          Curve = {" &
			       Bjo.Curve_Enumeration_Type'Image (Obj.Curve) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "          Enable = {" &
			       Boolean'Image (Obj.Enable) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "          C_Table = {" & ASCII.LF);
	       declare                                      
		  T   : Table_P_Type := Amender.C_Table.Next;
	       begin
		  while T /= Amender.C_Table loop
		     String'Write (M.Ostr, "                     {"& 
				     Long_Float'Image (T.Key) & " " &
				     Long_Float'Image (T.Val) & " " &
				     Long_Float'Image (T.B)   & "}" &
				     ASCII.LF);
		     T := T.Next;
		  end loop;
	       end;
	       String'Write (M.Ostr, "                    }" & ASCII.LF);
	       String'Write (M.Ostr, "         }" & ASCII.LF);
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
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Curve");
	       --Tio.Put_Line ("debugger" & Gts.String_Value);
	       case Token is
		  when Gts.T_String =>
		     Amender.Curve := Bjo.Curve_Enumeration_Type'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Curve -> expected 'Off', 'Linear', 'Bezier' or 'Poly'.");
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
		    while T /= Amender.C_Table loop
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
   -- these 2 are used when                 --
   -- Out_Cpos is a function of In_Cpos.    --
   -- the function is determined by the curve  --
   -------------------------------------------
   procedure Down_Scan
   is
   begin
      while In_Cpos.all < B_Table_Now.Key loop
	 B_Table_Now := B_Table_Now.Prev;
	 exit when B_Table_Now = B_Table.Next; -- lowest segment
      end loop;
      while In_Cpos.all > B_Table_Now.Next.Key loop
	 B_Table_Now := B_Table_Now.Next;
	 exit when B_Table_Now = B_Table.Prev.Prev; -- highest segment
      end loop;
      Out_Cpos := In_Cpos.all * B_Table_Now.M + B_Table_Now.N;
   end Down_Scan;
   
   
   procedure Up_Scan
   is
   begin
      -- we hope there is little difference with the commanded pos.
      Out_Rpos := (In_Rpos.all - B_Table_Now.N) / B_Table_Now.M;
   end Up_Scan;
   
   
   -----------------------------------------------------
   -- these are used in the case of a relative offset --
   -- which is a function of the 'In_Corrector input' --
   -----------------------------------------------------
   procedure Down_Scan_C 
   is
   begin
      while In_Cpos.all < B_Table_Now.Key loop
	 B_Table_Now := B_Table_Now.Prev;
	 exit when B_Table_Now = B_Table.Next; -- lowest segment
      end loop;
      while In_Cpos.all > B_Table_Now.Next.Key loop
	 B_Table_Now := B_Table_Now.Next;
	 exit when B_Table_Now = B_Table.Prev.Prev; -- highest segment
      end loop;
      Out_Cpos := In_Cpos.all * B_Table_Now.M + B_Table_Now.N;
   end Down_Scan_C;
   
   
   procedure Up_Scan_C 
   is
   begin
      -- we hope there is little difference with the commanded pos.
      Out_Rpos := (In_Rpos.all - B_Table_Now.N) / B_Table_Now.M;
   end Up_Scan_C;
   
   
   -- input defaults
   In_Corrector_Xf : aliased M_Type := In_Corrector_Init;
   In_Cpos_Xf      : aliased M_Type := In_Cpos_Init;
   In_Rpos_Xf      : aliased M_Type := In_Rpos_Init;
   
   
begin
   Bob.Init_Obj (Bob.Object (Amender), Name);
   Amender.Handle       := Handle'Access;
   Amender.Relative     := False;
   Amender.Bdirectional := False;
   Amender.Curve        := Bjo.Linear;
   Amender.Enable       := False;
   Amender.C_Table      := new Table_Type;
   Amender.C_Table.Prev := Amender.C_Table;
   Amender.C_Table.Next := Amender.C_Table;
   Amender.Dmax         := 20.0; 
   -- connect inputs to the defaults
   In_Corrector := In_Corrector_Xf'Access;
   In_Cpos      := In_Cpos_Xf'Access;
   In_Rpos      := In_Rpos_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   if Use_In_Corrector then 
      Bth.Insert_Down_Scan (Dsc);
      Bth.Insert_Up_Scan (Usc);
   else
      Bth.Insert_Down_Scan (Ds);
      Bth.Insert_Up_Scan (Us);
   end if;
end Beren.Amend;
