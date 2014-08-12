------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                        E A R E N D I L . C L I E N T 1                   --
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
--             Earendil is maintained by J de Kruijf Engineers              --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--

with Earendil.Name_Server;

with O_String;

package body Earendil.Client1 is
   
   package Erd renames Earendil;
   package Ens renames Earendil.Name_Server;
   
   M1 : Ens.E_Obj_Msg_Access_Type;
   
   procedure Send_Parset_Msg (S : String)
   is
      Reply : String := Earendil.E_Broadcast (M1, S);
   begin
      null;
   end Send_Parset_Msg;
   
   ------------------------
   type E_Reply_Msg_Type is new Erd.E_Obj_Msg_Type with 
      record
	S     : O_String.O_String (1 .. 64);
      end record;
   Overriding function E_Broadcast 
     (eM : access E_Reply_Msg_Type; Str : String) return String;
   Overriding function E_Reply 
     (Rm : access E_Reply_Msg_Type) return String;
   
   function E_Broadcast (eM : access E_Reply_Msg_Type; Str : String) return String 
   is
   begin
      null; ----not functional
      return "";
   end E_Broadcast;
   
   function E_Reply (Rm : access E_Reply_Msg_Type) return String 
   is
   begin
      null;
      return "";
   end E_Reply;
   
   E_Reply_Msg : aliased E_Reply_Msg_Type;
   
   
   
begin
   M1 := Ens.Find ("E_Parset_Msg");
   Earendil.Name_Server.Register 
     ("E_Reply_Msg", E_Reply_Msg'Access);
end Earendil.Client1;
