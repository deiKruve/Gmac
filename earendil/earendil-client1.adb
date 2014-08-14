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
with Earendil.Err;

with O_String;

package body Earendil.Client1 is
   
   package Eer renames Earendil.Err;
   package Erd renames Earendil;
   package Ens renames Earendil.Name_Server;
   
   -- remote connector object pointers.
   Mp_P, Mf_P, Me_P : Ens.E_Obj_Msg_Access_Type;
   
   
   ------------------------------------------
   -- message types this module can handle --
   ------------------------------------------
   
   -- to receive connect request from the despatcher
   type E_Client1_Connect_Msg_Type is new Erd.E_Obj_Msg_Type with null record;
   Overriding 
   function Handle (em    : access E_Client1_Connect_Msg_Type;
		    Id    : Erd.Op_Type;
		    Name  : String;
		    Class : Erd.Attr_Class;
		    I     : Integer;
		    X     : Long_Float;
		    C     : Character;
		    B     : Boolean;
		    S     : String
		   ) return Integer;
     
   
    -- to receive replies from despatcher
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
   
   
      
   -----------------------------------------
   -- the local message connector objects --
   -----------------------------------------
   E_Reply_Msg    : aliased E_Reply_Msg_Type;
   Client1_Socket : aliased E_Client1_Connect_Msg_Type;
   

   
   ----------------------
   -- message handlers --
   ----------------------
   
   -- handle a connection request
   function Handle (em    : access E_Client1_Connect_Msg_Type;
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
      Earendil.Name_Server.Remove (E_Reply_Msg'Access);
      Earendil.Name_Server.Register 
	("E_Reply_Msg", E_Reply_Msg'Access);
      Mp_P := Ens.Find ("E_Parset_Msg");
      Mf_P := Ens.Find ("E_File_Msg");
      return 0;
   exception
      when others => return -1;
   end Handle;
   
   
   -- handle a reply from the despatcher, its asynchronous
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
      String_Displayer (S);
      return 0;
   end Handle;
   
    
   --------------------
   -- send a message --
   --------------------
   
   -- send a parameter set message to despatcher
   procedure Send_Parset_Msg (Str : String)
   is
      Reply : Integer := Earendil.Handle (Em => Mp_P, S => Str);
    begin
      if Reply /= 0 then
	 Eer.Report_Error ("Client1.Send_ParSet_Msg : Error " & 
			     Integer'Image (Reply));
      end if;
    end Send_Parset_Msg;
    
    -- send a load or store message
    procedure Send_File_Msg (Str : String; Id : Erd.Op_Type)
    is
       Reply : Integer := Earendil.Handle (Em => Mf_P, Id => Id, S => Str);
    begin
      if Reply /= 0 then
	 Eer.Report_Error ("Client1.Send_File_Msg : Error " & 
			     Integer'Image (Reply));
      end if;
    end Send_File_Msg;
    
    
    -- send an enumeration message
    procedure Send_Enum_Msg
    is
       Reply : Integer := Earendil.Handle (Em => Me_P);
    begin
       if Reply /= 0 then
	 Eer.Report_Error ("Client1.Send_Enum_Msg : Error " & 
			     Integer'Image (Reply));
       end if;
    end Send_Enum_Msg;
    
   
begin
   -- register the local message object connectors.
   Earendil.Name_Server.Register
     ("Client1_Socket", Client1_Socket'Access);
   Earendil.Name_Server.Register 
     ("E_Reply_Msg", E_Reply_Msg'Access);
   
   -- find the remote connectors.
   Mp_P := Ens.Find ("E_Parset_Msg");
   Mf_P := Ens.Find ("E_File_Msg");
   Me_P := Ens.Find ("E_Enum_Msg");
end Earendil.Client1;
