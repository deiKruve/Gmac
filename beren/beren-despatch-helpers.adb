------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                B E R E N . D E S P A T C H . H E L P E R S               --
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
with O_String;
with Beren.Jogobj;

package body Beren.Despatch.Helpers is
   package Bjo renames Beren.Jogobj;
   package Obs renames O_String;
   
   procedure Enumerate_Attr (Name : String; M : Beren.Jogobj.Attr_Msg)
   is
      use type Bjo.Attr_Class;
   begin
      case M.Class is
	 when Bjo.Str  =>  Send_Reply_Msg (Obs.To_String (M.S));
	 when Bjo.Int  => 
	    declare
	       Rstr  : String := Integer'Image (M.I);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Real => 
	    declare 
	       Rstr : String := Long_Float'Image (M.X);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Char => Send_Reply_Msg (M.C);
	 when Bjo.Bool => 
	    declare
	       Rstr  : String := Boolean'Image (M.B);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Enum => 
	    declare
	       Rstr  : String := Bjo.Pulse_Mode_Enumeration_Type'Image (M.E);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when others   => null;
      end case;
   end Enumerate_Attr;
   
begin
   Enumerate := Enumerate_Attr'Access;   
end Beren.Despatch.Helpers;
