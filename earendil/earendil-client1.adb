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
   
   Mp_P, Mf_P : Ens.E_Obj_Msg_Access_Type;
   
   procedure Send_Parset_Msg (Str : String)
   is
      Reply : Integer := Earendil.Handle (Em => Mp_P, S => Str);
    begin
      
      null;
   end Send_Parset_Msg;
   
   ------------------------
   type E_Reply_Msg_Type is new Erd.E_Obj_Msg_Type with 
      record
	S     : O_String.O_String (1 .. 64);
      end record;

   Overriding function Handle (em    : access E_Reply_Msg_Type;
			       Id    : Erd.Op_Type;
			       Name  : String;
			       Class : Erd.Attr_Class;
			       I     : Integer;
			       X     : Long_Float;
			       C     : Character;
			       B     : Boolean;
			       S     : String
			      ) return Integer;
   

   function Handle (em    : access E_Reply_Msg_Type; 
		    Id    : Erd.Op_Type;
		    Name  : String;
		    Class : Erd.Attr_Class;
		    I     : Integer;
		    X     : Long_Float;
		    C     : Character;
		    B     : Boolean;
		    S     : String
		   ) return Integer 
   is
   begin
      null;
      return 0;
   end Handle;
   
   E_Reply_Msg : aliased E_Reply_Msg_Type;
   
   
   
begin
   Mp_P := Ens.Find ("E_Parset_Msg");
   Mf_P := Ens.Find ("E_File_Msg");
   Earendil.Name_Server.Register 
     ("E_Reply_Msg", E_Reply_Msg'Access);
end Earendil.Client1;
