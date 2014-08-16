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
-- the server

with Earendil.Name_Server;
with Earendil.Objects;
with Beren.Jogobj;
with Beren.Err;
with O_String;

package body Beren.Despatch is
   package Tio   renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
 
   package Erd renames Earendil;
   package Ens renames Earendil.Name_Server;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Ber renames Beren.Err;
   package Obs renames O_String;
   
   -- reply object pointer.
   Mr_P : Ens.E_Obj_Msg_Access_Type;
   
   
   ------------------------------------------
   -- message types this module can handle --
   ------------------------------------------
   
   -- to receive connect request from the client
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
     
   
   -- to receive a parameter-set message from the client
   type E_Parset_Msg_Type is new Erd.E_Obj_Msg_Type with null record;
   overriding
   function Handle (eM    : access E_Parset_Msg_Type;
		    Id    : Erd.Op_Type;
		    Name  : String;
		    Class : Erd.Attr_Class;
		    I     : Integer;
		    X     : Long_Float;
		    C     : Character;
		    B     : Boolean;
		    S     : String
		   ) return Integer;
   
   
   -- to recieve a message to set or get any attributes
   type E_Attr_Msg_Type is new Erd.E_Obj_Msg_Type with null record;
   overriding
   function Handle (eM    : access E_Attr_Msg_Type;
		    Id    : Erd.Op_Type;
		    Name  : String;
		    Class : Erd.Attr_Class;
		    I     : Integer;
		    X     : Long_Float;
		    C     : Character;
		    B     : Boolean;
		    S     : String
		   ) return Integer;
   
   
   -- to enumerate the attributes in the system
   type E_Enum_Msg_Type is new Erd.E_Obj_Msg_Type with null record;
   overriding
   function Handle (eM    : access E_Enum_Msg_Type;
		    Id    : Erd.Op_Type;
		    Name  : String;
		    Class : Erd.Attr_Class;
		    I     : Integer;
		    X     : Long_Float;
		    C     : Character;
		    B     : Boolean;
		    S     : String
		   ) return Integer;
   
   -- to receive a file message from the client 
   type E_File_Msg_Type is new Erd.E_Obj_Msg_Type with null record;
   Overriding
   function Handle (Em    : access E_File_Msg_Type;
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
   E_File_Msg      : aliased E_File_Msg_Type;
   E_Enum_Msg      : aliased E_Enum_Msg_Type;
   E_Attr_Msg      : aliased E_Attr_Msg_Type;
   E_Parset_Msg    : aliased E_Parset_Msg_Type;
   Despatch_Socket : aliased E_Client1_Connect_Msg_Type;
   
   
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
      Earendil.Name_Server.Remove (E_Parset_Msg'Access);
      Earendil.Name_Server.Remove (E_Attr_Msg'Access);
      Earendil.Name_Server.Remove (E_Enum_Msg'Access);
      Earendil.Name_Server.Remove (E_File_Msg'Access);
      Earendil.Name_Server.Register 
	("E_Parset_Msg", E_Parset_Msg'Access);
      Earendil.Name_Server.Register 
	("E_Attr_Msg", E_Attr_Msg'Access);
      Earendil.Name_Server.Register 
	("E_Enum_Msg", E_Enum_Msg'Access);
      Earendil.Name_Server.Register
	("E_File_Msg", E_File_Msg'Access);
      Mr_P := Earendil.Name_Server.Find ("E_Reply_Msg");
      return 0;
   exception
      when others => return -1;
   end Handle;
   
   
   -- handle a parameter set request --
   function Handle (eM    : access E_Parset_Msg_Type;
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
      M : Bjo.Attr_Msg;
   begin
      M.Id := Bob.Setpar;
      M.Class := Bjo.Str;
      M.S := Obs.To_O_String (64, S);
      Bob.Broadcast (Bjo.Attr_Msg (M));
      return M.Res;
   end Handle;
   
   -- handle an attr message
   function Handle (eM    : access E_Attr_Msg_Type;
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
      use type Erd.Op_Type;
      M : Bjo.Attr_Msg;
   begin
      M.Name := Obs.To_O_String (32, Name);
      M.S    := Obs.To_O_String (64, S);
      if Id = Erd.Set then
	 M.Id := Bob.Set;
	 Bob.Broadcast (M);
      elsif Id = Erd.Get then
	 M.Id := Bob.Get;
	 Bob.Broadcast (M);
	 if M.Res = 0 then
	    case M.Class is
	       when Bjo.Enum => Send_Reply_Msg (M.E);
	       when Bjo.Int  => Send_Reply_Msg (M.I);
	       when Bjo.Real => Send_Reply_Msg (M.X);
	       when Bjo.Char => Send_Reply_Msg (M.C);
	       when Bjo.Bool => Send_Reply_Msg (M.B);
	       when Bjo.Str  => Send_Reply_Msg (Obs.To_String (M.S));
	       when others => null;
	    end case; -- m.class
	 end if; -- M.Res = 0
      end if; -- Id = Erd.Set
      return M.Res;
   end Handle;
   
   
   -- handle an enumerate request --
   function Handle (eM    : access E_Enum_Msg_Type;
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
      M : Bjo.Attr_Msg;
   begin
      M.Id := Bob.Enum;
      M.Enum := Enumerate;
      Bob.Broadcast (M);
      return 0;
   end Handle;
   
   
   -- handle a parameter read or write request --
   function Handle (Em    : access E_File_Msg_Type;
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
      use type Erd.Op_Type;
      use type Ada.Text_Io.Text_Streams.Stream_Access;
      M : Bob.File_Msg;
      Fd  : Tio.File_Type; 
      Ostr : Tiots.Stream_Access;
      Istr : Tiots.Stream_Access;
   begin
      if Id = Erd.Load then 
	 M.Id := Bob.Load;
	 Open_In_File (S, fd, Istr);
	 if Istr /= null then
	    M.Ostr := Istr;
	 else return -1;
	 end if;
      elsif Id = Erd.Store then 
	 M.Id := Bob.Store;
	 Open_Out_File (S, fd, Ostr);
	 if Ostr /= null then
	    M.Ostr := Ostr;
	 else return -1;
	 end if;
      end if;
      Bob.Broadcast (M);
      declare
      begin
	 Tio.Close (Fd);
      exception
	 when others => null;
      end;
      return M.Res;
   end Handle;
   
   
   --------------------
   -- send a message --
   --------------------
   
   -- send a reply to the client
   procedure Send_Reply_Msg (Str : String)
   is
      Reply : Integer := Earendil.Handle (Em => Mr_P, Class => Erd.Str, S => Str);
   begin
      if Reply /= 0 then
	 Ber.Report_Error ("Beren.Despatch.Send_Reply_Msg.Str : Error " & 
			     Integer'Image (Reply));
      end if;
   end Send_Reply_Msg;
   
   
   procedure Send_Reply_Msg (I : Integer)
   is
      Reply : Integer := Earendil.Handle (Em => Mr_P, Class => Erd.Int, I => I);
   begin
      if Reply /= 0 then
	 Ber.Report_Error ("Beren.Despatch.Send_Reply_Msg.Str : Error " & 
			     Integer'Image (Reply));
      end if;
   end Send_Reply_Msg;
   
   
   procedure Send_Reply_Msg (X : Long_float)
   is
      Reply : Integer := Earendil.Handle (Em => Mr_P, Class => Erd.Real, X => X);
    begin
      if Reply /= 0 then
	 Ber.Report_Error ("Beren.Despatch.Send_Reply_Msg.Float : Error " & 
			     Integer'Image (Reply));
      end if;
    end Send_Reply_Msg;
    
   
   procedure Send_Reply_Msg (C : Character)
   is
      Reply : Integer := Earendil.Handle (Em => Mr_P, Class => Erd.Char, C => C);
   begin
      if Reply /= 0 then
	 Ber.Report_Error ("Beren.Despatch.Send_Reply_Msg.Char : Error " & 
			     Integer'Image (Reply));
      end if;
   end Send_Reply_Msg;
   
   
   procedure Send_Reply_Msg (B : Boolean)
   is
      Reply : Integer := Earendil.Handle (Em => Mr_P, Class => Erd.Bool, B => B);
   begin
      if Reply /= 0 then
	 Ber.Report_Error ("Beren.Despatch.Send_Reply_Msg.Bool : Error " & 
			     Integer'Image (Reply));
      end if;
   end Send_Reply_Msg;
   
   
   procedure Send_Reply_Msg (E : Bjo.Pulse_Mode_Enumeration_Type)
   is
   begin
      Ber.Report_Error 
      ("Beren.Despatch.Send_Reply_Msg.Pulse_Mode_Enumeration_Type : Error " & 
	 "not implemented yet.");
   end Send_Reply_Msg;

  
begin
   -- register the local message object connectors.
   Earendil.Name_Server.Register
     ("Despatch_Socket", Despatch_Socket'Access);
   Earendil.Name_Server.Register 
     ("E_Parset_Msg", E_Parset_Msg'Access);
   Earendil.Name_Server.Register 
     ("E_Attr_Msg", E_Attr_Msg'Access);
   Earendil.Name_Server.Register 
     ("E_Enum_Msg", E_Enum_Msg'Access);
   Earendil.Name_Server.Register
     ("E_File_Msg", E_File_Msg'Access);

end Beren.Despatch;
