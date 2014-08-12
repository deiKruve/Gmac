------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                       B E R E N . D E S P A T C H                        --
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

--Tape.driver -- the server
with Earendil.Name_Server;
with Earendil.Objects;
with Beren.Jogobj;
with O_String;

package body Beren.Despatch is
   
   package Erd renames Earendil;
   package Ens renames Earendil.Name_Server;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Obs renames O_String;
   
   
   type E_Parset_Msg_Type is new Erd.E_Obj_Msg_Type with 
      record
	S     : O_String.O_String (1 .. 64);
      end record;
   overriding
   function E_Broadcast (eM : access E_Parset_Msg_Type; Str : String) return String;
   overriding
   function E_Reply (eM : access E_Parset_Msg_Type) return String;
   
   function E_Broadcast (eM : access E_Parset_Msg_Type; Str : String) return String 
   is
      M : Bjo.Attr_Msg;
   begin
      M.Id := Bob.Setpar;
      M.Class := Bjo.Str;
      M.S := Obs.To_O_String (64, Str);
      Bob.Broadcast (Bjo.Attr_Msg (M));
      if M.Res = 0 then
      	 return "Ok";
      else
      	 return "Failure";
      end if;
      --Tio.Put_Line (Integer'Image (M.Res));
   end E_Broadcast;
   
   function E_Reply (eM : access E_Parset_Msg_Type) return String 
   is
   begin
      null; ----not functional
      return "";
   end E_Reply;
      
   
   E_Parset_Msg : aliased E_Parset_Msg_Type;

   --  function Enum_Attr (Str : String) return String
   --  is
   --     M : Bjo.Attr_Msg;
   --  begin
   --     M.Id := Bob.Enum;
   --     --M.Enum := Berentest1.Enumerate_Attr'access;
   --     Bob.Broadcast (M);
   --     return "Ok";
   --  end Enum_Attr;
   
begin
   Earendil.Name_Server.Register 
     ("E_Parset_Msg", E_Parset_Msg'Access);

end Beren.Despatch;
