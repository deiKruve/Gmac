------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                               E A R E N D I L                            --
--                                                                          --
--                                  S p e c                                 --
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
--                 Earendil is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
--with O_String;
package Earendil is
   pragma Pure(Earendil);
     type E_Obj_Msg_Type is abstract tagged limited private;
     -- Primitive dispatching operations where
     -- E_Obj_Msg_Type is controlling operand
     
     type Op_Type is (Conn, Enum, Get, Set, Setpar, Load, Store);
     type Attr_Class is (Inval, Str, Int, Real, Char, Bool);
     
     function Handle (eM    : access E_Obj_Msg_Type;
		      Id    : Op_Type := Conn;
		      Name  : String := "";
		      Class : Attr_Class := Inval;
		      I     : Integer := 0;
		      X     : Long_Float := 0.0;
		      C     : Character := 'a';
		      B     : Boolean := false;
		      S     : String := ""
		     ) return Integer is abstract;
     
   

private
   type E_Obj_Msg_Type is abstract tagged limited 
      record
	 null;
      end record;
   
end Earendil;
