------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                         B E R E N . O B J E C T S                        --
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
--
with Ada.Text_IO.Text_Streams;
with O_String;

package Beren.Objects is
   pragma Elaborate_Body;
   
   
     -----------------------------------------------------
   -----------------------------------------------------
   --type Object;
   
   subtype Obj_Name  is O_String.O_String (1 .. 32);
   
   subtype Attr_Name is O_String.O_String (1 .. 32);
   
   subtype T_Stamp is Integer;
   -- message timestamp type
   
   type Obj_Msg;
   
   type Object_Desc;
   
   type Object is access all Object_Desc'Class;
   type Object_Desc is tagged
      record
	 Used    : Natural;
	 Name    : Obj_name;
	 Stamp   : T_stamp;
	 Dlink,
	 Slink,
	 Next    : Object;
	 --Lib     : Library;
	 Ref     : Integer;
	 Handle  : access procedure 
	   (Obj  : in out Object; M : in out Obj_Msg'Class);
      end record;
   -- root of all object types
   
   --procedure Initialize (Obj : in Object) with inline;
   -- reference counting
   
   --procedure Adjust (Obj : in Object) with inline;
   -- reference counting
   
   --procedure Finalize (Obj : in out Object) with inline;
   -- reference counting
   -- must be overridden in any object extentions to take care of
   -- pointers that might exist in the extention.
   
   New_Obj : Object; 
   -- this is where any newly generated object may be picked up
    ------------------------------------------------------------------------
   ------------------------------------------------------------------------
   -- Messages
   ------------------------------------------------------------------------
   ------------------------------------------------------------------------
   
   Stamper : T_Stamp;
   -- for timestamping messages.
   -- initialized to integer'first
   
   ------------------------------------------------------------------------
   -- Obj_Msg
   ------------------------------------------------------------------------

   type Obj_Msg is abstract tagged record
      Stamp  : T_stamp;
      Res    : Integer;
      Dlink  : Object;
   end record;
   
   
   
   type Op_Type is (Enum, Get, Set);
   -- for Attr_Msg and Link_Msg

   ------------------------------------------------------------------------
   -- Attr_Msg
   ------------------------------------------------------------------------

   type Attr_Class is (Inval, Str, Int, Real, Char, Bool); 
   
   type Attr_Msg is new Obj_Msg with
     record
	Id    : Op_Type;
	Enum  : access procedure (Name :String; M : Attr_Msg);
	Name  : Attr_Name;
	--Res   : Integer;
	Class : Attr_Class;
	I     : Integer;
	X     : Long_Float;
	C     : Character;
	B     : Boolean;
	S     : O_String.O_String (1 .. 64);
     end record;
   
   ------------------------------------------------------------------------
   -- Link_Msg
   ------------------------------------------------------------------------

   type Link_Msg is new Obj_Msg with
     record
	Id    : Op_Type;
	Enum  : access procedure (Name :String);
	Name  : Obj_Name;
	--Res   : Integer;
	Obj   : Object;
     end record;
   
   ------------------------------------------------------------------------
   -- Copy_Msg
   ------------------------------------------------------------------------

   type Copy_Op_Type is (Shallow, Deep);
   
   type Copy_Msg is new Obj_Msg with
      record
	 Id    : Copy_Op_Type;
	 Obj   : Object;  -- result
      end record;
   
   ------------------------------------------------------------------------
   -- Find_Msg
   ------------------------------------------------------------------------

   type Find_Msg is new Obj_Msg with
      record
	 Name  : Obj_Name;
	 Obj   : Object;  -- result
      end record;
   
   ------------------------------------------------------------------------
   -- File_Msg
   ------------------------------------------------------------------------
   type File_Op_Type is (Load, Store);
   
   type File_Msg is new Obj_Msg with
      record
	 Id   : File_Op_Type;
	 --Pos  : Ada.Streams.Stream_Element_Offset;
	 Ostr : Ada.Text_IO.Text_Streams.Stream_Access;
      end record;
   
   ------------------------------------------------------------------------
   -- Time Stamp a message
   ------------------------------------------------------------------------

   procedure Stamp (Obj : in out Obj_Msg'Class);
   
   ------------------------------------------------------------------------
   -- make a new object
   ------------------------------------------------------------------------
   
  -- procedure Init (Obj : in out object);
   procedure Init_Obj (Obj : Object; Name : String);
   
   ------------------------------------------------------------------------
   -- broadcast a Message
   ------------------------------------------------------------------------
    
   procedure Broadcast (M : in out Obj_Msg'Class);
   
   
private
   Obj_Root : Object;

end Beren.Objects;
