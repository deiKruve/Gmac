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
	 T : Table_P_Type := Obj.C_Table.Next;
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
		  M.X := T.Key;
		  M.Res := 0;
	       else 
		  Ber.Report_Error 
		    ("get param: " & Name & "Key not found.");
		  M.Res := 3; -- key not found;
	       end if;
	       
	       
	    end if;
	 end if;
      end Handle_Attr_M;

   begin
      
   end Handle;

end Beren.Amend;
