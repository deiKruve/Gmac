------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                             B E R E N . J O G                            --
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
-- Template for a jog module
--
with O_String;

package body Beren.Jog is
   package Obs renames O_String;
   package Bob renames Beren.Objects;

   -----------------------
   -- Message interface --
   -----------------------
   --  message handler  --
   procedure Handle (Obj : in out Beren.Objects.Object; 
		     M   : in out Beren.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Jog_Object_Type; 
			       M : in out Bob.Attr_Msg) 
	with Inline
      is
	 use type Bob.Op_Type;
	 use type Bob.Attr_Class;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.Name, "Jog_Rate") then
	    M.Class := Bob.Real;
	    M.X := Jog_Object_Type (Obj).Jog_Rate;
	    M.Res := 0;
	 elsif M.Id = Bob.Set 
	   and then Obs.Eq (M.Name, "Jog_Rate") 
	   and then M.Class = Bob.Real 
	 then
	    Jog_Object_Type (Obj).Jog_Rate := M.X;
	    M.Res := 0;
	 elsif M.Id = Bob.Enum then
	    M.Name := Obs.To_O_String (32, "Jog_Rate");
	    M.Class := Bob.Real;
	    M.X := Jogger.all.Jog_Rate;
	    M.Enum (Name, M);
	 end if;
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Jog_Object_Type; 
			       M : in out Bob.File_Msg)
	with Inline
      is
	 use type Bob.File_Op_Type;
      begin
	 if M.Id = Bob.Store then
	    String'Write (M.Ostr, "{" & Name & " = {");
	    if Xis = Linear then 
	       declare 
		  Ustr : String := " m/min}";
	       begin
		  String'Write (M.Ostr, "Jog_Rate = {" & 
				  Mpsec_Type'Image (Obj.Jog_Rate * 60.0) &
				  Ustr);
	       end;
	    elsif Xis = Rotary then
	       declare 
		  Ustr : String := " deg/min}";
	       begin
		  String'Write (M.Ostr, "Jog_Rate = {" & 
				  Mpsec_Type'Image (Obj.Jog_Rate * 60.0) &
				  Ustr);
	       end;
	    end if;
	     String'Write (M.Ostr, "}}" & ASCII.LF);
	 end if;
      end Handle_File_M;
      ------------------
   begin
      if Obj.all in Jog_Object_Type then
	 if M in Bob.Attr_Msg then
	    Handle_Attr_M (Jog_Object_Type (Obj.all), Bob.Attr_Msg (M));
	 elsif M in Bob.File_Msg then
	    Handle_File_M (Jog_Object_Type (Obj.all), Bob.File_Msg (M));
	 end if;
      end if;
   end Handle;
   
   
			   
begin
   Bob.Init_Obj (Bob.Object (Jogger), Name);
   Jogger.Handle := Handle'Access;
end Beren.Jog;
