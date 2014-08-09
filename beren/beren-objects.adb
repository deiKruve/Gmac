------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                         B E R E N . O B J E C T S                        --
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
--
--with Ada.Text_Io;

package body Beren.Objects is
   --package Tio renames Ada.Text_Io;
   package Obs renames O_String;
   
   subtype Gen_Name is Obs.O_String (1 .. 32);
   
   type Dummy_Desc;
   
   type Dummy is access all Dummy_Desc;
   type Dummy_Desc is new Object_Desc with
      record
	 G_Name : Gen_Name; -- generator proc of the failed object;
	 --Len    : Ada.Streams.Stream_Element_Offset; 
	 -- length of the data block;
	 --Blk    : access Ada.Streams.Stream_Element_Array; 
	 -- has the data on the file
	 
      end record;
   -- object type for unknown object types.
   
    -----------
   -- Stamp --
   -----------

   procedure Stamp (Obj : in out Obj_Msg'Class) is
   begin
      Obj.Stamp := Stamper;
      if Stamper /= Integer'Last then 
	 Stamper := Stamper + 1;
      else
	 Stamper := Integer'First;
      end if;
   end Stamp;
   
   
   ------------------
   -- Handle_Dummy --
   ------------------
   procedure Handle_Dummy (Obj : in out Object; M : in out Obj_Msg'Class)
   is
      ---------
      procedure Handle_Attr_M (Obj : in out Dummy; M : in out Attr_Msg) with Inline
      is
      begin
	 if M.Id = Get and then Obs.Eq (M.Name, "Gen") then
	    Obs.Copy (Source => Obj.G_Name, 
		      Dest   => M.S);
	 end if;
      end Handle_Attr_M;
      ---------
      procedure Handle_Copy_M (Obj : in out Dummy; M : in out Copy_Msg) with Inline
      is
	 Dum : Dummy;
      begin
	 if M.Stamp = Obj.Stamp then
	    M.Obj := Obj.Dlink;
	 else
	    Dum := new Dummy_Desc;
	    --Initialize (Object (Dum));
	    Obj.Stamp := M.Stamp;
	    Obj.Dlink := Object (Dum);
	    Dum.Handle := Obj.Handle;
	    Obs.Copy (Source => Obj.G_Name, 
		      Dest   => Dum.G_Name);
	    --Dum.Len := Obj.Len;
	    --Dum.Blk := Obj.Blk;
	    M.Obj := Object (Dum);
	 end if;
      end Handle_Copy_M;
      -------
      --  procedure Handle_File_M (Obj : in out Dummy; M : in out File_Msg) with Inline
      --  is
      --  	 Len : As.Stream_Element_Offset;
      --  	 use type As.Stream_Element_Offset;
      --  begin
      --  	 if M.Id = Load then
      --  	    Obj.Len := M.Len;
      --  	    Obj.Blk := 
      --  	      new As.Stream_Element_Array (1 .. As.Stream_Element_Offset (Obj.Len));
      --  	    Files.Read (File => M.R.F.all, Item => Obj.Blk.all, Last => Len);
      --  	    if Len /= M.Len then
      --  	       Raise_Error (Message => "Handle_Dummy : Read error.");
      --  	    end if;
      --  	 elsif M.Id = Store then
      --  	    Files.Write (File => M.R.F.all, Item => Obj.Blk.all);
      --  	 end if;
      --  	 Update_Rider_From_Index (R => M.R);
      --  end Handle_File_M;
      --------
   begin
      --if Obj'Tag = Dummy_Desc'Tag then
      if Obj.all in Dummy_Desc then
	 if M in Attr_Msg then
	    Handle_Attr_M (Dummy (Obj), Attr_Msg (M));
	 elsif M in Copy_Msg then
	    Handle_Copy_M (Dummy (Obj), Copy_Msg (M));
	 --  elsif M'Tag = File_Msg'Tag then
	 --     Handle_File_M (Dummy (Obj), File_Msg (M));
	 end if; -- falls through if none of these
      end if; -- falls through if none of these
   end Handle_Dummy;
   
   
   procedure Init_Obj (Obj : Object; Name : String)
   is   
   begin
      Obj.Used     := 0;
      Obj.Name     := Obs.To_O_String (32, Name);
      Obj.Stamp    := 0;
      Obj.Dlink    := null;
      Obj.Slink    := null;
      Obj.Next     := null;
      Obj.Ref      := 0;
      Obj.Handle   := null;
      New_Obj.Next := Object (Obj);
      New_Obj      := Object (Obj);
   end Init_Obj;
   
   
   procedure Broadcast (M : in out Obj_Msg'Class)
   is
      Frame : Object := Obj_Root.next;
   begin
      Frame := Obj_Root.next;
      Stamp (M);
      M.Res := Integer'First;
      --Tio.Put_Line ("broadcast00");
      while Frame /= null and M.Res < 0  loop

	    --Tio.Put_Line ("broadcast");

	 Frame.Handle (Frame, M);
	 Frame := Frame.Next;
      end loop;
   end Broadcast;
   
   
begin
   Stamper := Integer'First;
   
   Obj_Root       := new Object_Desc;
   Obj_Root.Used  := 0;
   Obj_Root.Name  := Obs.To_O_String (32, "root object");
   Obj_Root.Stamp := 0;
   Obj_Root.Dlink := null;
   Obj_Root.Slink := null;
   Obj_Root.Next  := null;
   Obj_Root.Ref   := 0;
   Obj_Root.Handle := null;
   New_Obj := Obj_Root;
   
end Beren.Objects;
