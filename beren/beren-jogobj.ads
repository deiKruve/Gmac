------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                          B E R E N . J O G O B J                         --
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
--                 Beren is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- extra data definition for Beren.Jog

with Earendil.Objects;
with O_String;
package Beren.Jogobj is
   
   
   type Attr_Class is (Enum, Real_Pair, Inval, Str, Int, Real, Char, Bool);
   
   -- extra jog attr.
   type Pulse_Mode_Enumeration_Type is (Off, Hundredth, Tenth, Unit, Ten);
   
   -- jog attibutes message
   type Attr_Msg is new Earendil.Objects.Obj_Msg with
     record
	Id    : Earendil.Objects.Op_Type;
	Enum  : access procedure (Name :String; M : Attr_Msg);
	Name  : Earendil.Objects.Attr_Name;
	--Res   : Integer;
	Class : Attr_Class;
	E     : Pulse_Mode_Enumeration_Type;
	I     : Integer;
	X,
	X1    : Long_Float;
	C     : Character;
	B     : Boolean;
	S     : O_String.O_String (1 .. 64);
     end record;

   type Attr_Msg_P is access all Attr_Msg;

end Beren.Jogobj;
