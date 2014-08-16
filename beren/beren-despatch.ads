------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                       B E R E N . D E S P A T C H                        --
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
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

with Beren.Jogobj;

package Beren.Despatch is 
   pragma Elaborate_Body;
  
private
   procedure Send_Reply_Msg (Str : String);
   procedure Send_Reply_Msg (I : Integer);
   procedure Send_Reply_Msg (X : Long_float);
   procedure Send_Reply_Msg (C : Character);
   procedure Send_Reply_Msg (B : Boolean);
   procedure Send_Reply_Msg (E : Beren.Jogobj.Pulse_Mode_Enumeration_Type);
   
   Enumerate     : access procedure (Name : String; M : Beren.Jogobj.Attr_Msg);
   Open_Out_File : access procedure 
     (Name : String := ""; 
      Ofd  : in out Ada.Text_IO.File_Type; 
      Ostr : in out Ada.Text_IO.Text_Streams.Stream_Access);
   Open_In_File  : access procedure 
     (Name : String := ""; 
      Ifd  : in out Ada.Text_IO.File_Type; 
      Istr : in out Ada.Text_IO.Text_Streams.Stream_Access);
end Beren.Despatch;
