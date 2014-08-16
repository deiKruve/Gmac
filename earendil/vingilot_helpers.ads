------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                       V I N G I L O T . H E L P E R S                    --
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
--                 Earendil is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- This is a first try at a terminal for earendil, the extra routines

with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

package Vingilot_Helpers is
   
   Patrn : Ada.Strings.Unbounded.Unbounded_String;
   
   procedure Str_Display (S : String);
   
   procedure Boolean_Display (B : Boolean);
   
   procedure Character_Display (C : Character);
   
   procedure Real_Display (X : Long_Float);
   
   procedure Integer_Display (I : Integer);
   
   --  procedure Open_Out_File (Name : String := ""; 
   --  			    Ofd  : out Ada.Text_IO.File_Type; 
   --  			    Ostr : out Ada.Text_IO.Text_Streams.Stream_Access);
   
   
   --  procedure Open_In_File (Name : String := ""; 
   --  			  Ofd  : out Ada.Text_IO.File_Type; 
   --  			  Ostr : out Ada.Text_IO.Text_Streams.Stream_Access);
   
end Vingilot_Helpers;
