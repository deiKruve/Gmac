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
   
   --type Op_Type is (Enum, Get, Set, Setpar, Load, Store);
   --type Attr_Class is (Inval, Str, Int, Real, Char, Bool);
   
   type E_Parset_Msg_Type is new Erd.E_Obj_Msg_Type with 
      record
	 --S     : O_String.O_String (1 .. 64);
	 null;
      end record;
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
   
   --type File_Op_Type is (Load, Store);
   
   type E_File_Msg_Type is new Erd.E_Obj_Msg_Type with 
      record
	 --Id   : File_Op_Type;
	 --Name : O_String.O_String (1 .. 64);
	 null;
      end record;
   
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
      M : Bob.File_Msg;
   begin
      if Id = Erd.Load then M.Id := Bob.Load;
      elsif Id = Erd.Store then M.Id := Bob.Store;
      end if;
      M.Ostr := null;----------------------------------------------------ps
      Bob.Broadcast (M);
      return M.Res;
   end Handle;
      
   E_File_Msg   : aliased E_File_Msg_Type;
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
   Earendil.Name_Server.Register
     ("E_File_Msg", E_File_Msg'Access);

end Beren.Despatch;
