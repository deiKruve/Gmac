------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                        E A R E N D I L . C L I E N T 1                   --
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
--             Earendil is maintained by J de Kruijf Engineers              --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
with Earendil;

package Earendil.Client1 with Elaborate_Body is
   
   -- send a parameter set message to despatcher
   procedure Send_Parset_Msg (Str : String);
   
   -- send an attribute set or get message to despatcher
   procedure Send_Attr_Msg (Str : String; Id : Earendil.Op_Type);
   
   -- send a load or store message
   procedure Send_File_Msg (Str : String; Id : Earendil.Op_Type);
   
   -- send an enumeration message
   procedure Send_Enum_Msg;
   
   -- send a connect message
   procedure Send_Connect_Msg;
   
   String_Displayer    : access procedure (S : String);
   Boolean_Displayer   : access procedure (B : Boolean);
   Character_Displayer : access procedure (C : Character);
   Real_Displayer      : access procedure (X : Long_Float);
   Integer_Displayer   : access procedure (I : Integer);
end Earendil.Client1;
