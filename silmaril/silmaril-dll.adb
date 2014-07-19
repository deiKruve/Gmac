------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                          S I L M A R I L . D L L                         --
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
--                Silmaril is maintained by J de Kruijf Engineers           --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

-- implementation of a protected doubly linked list
--

with Ada.Unchecked_Deallocation;

package body Silmaril.Dll is
   
   type String_Access_Type is access all String;
   
   
   procedure Initialize (Anchor : access Dllist_Type)
   is
   begin
      --Anchor := new Dllist_Type; must be done before calling
      Anchor.Pos   := null; 
      Anchor.Prev  := Dllist_Access_Type (Anchor);
      Anchor.mPrev := Dllist_Access_Type (Anchor);
      Anchor.Next  := Dllist_Access_Type (Anchor);
      Anchor.mNext := Dllist_Access_Type (Anchor);
   end Initialize;
   
   
   protected body Program_Queue_Type is
       
      procedure Unlink_From_Dllist (This : access Dllist_Type)
      is
	 procedure Free_Dllist is
	    new Ada.Unchecked_Deallocation (Dllist_Type, Dllist_Access_type);
	 That : Dllist_Access_Type := Dllist_Access_Type (This);
      begin 
	 --Open := False;
	 This.Prev.Next := This.Next;
	 This.Next.Prev := This.Prev;
	 if This.Mnext /= null and This.Mnext /= This then
	    This.Mprev.Mnext := This.Mnext;
	 end if;
	 if This.Mprev /= null and This.Mprev /= This then
	    This.mNext.mPrev := This.mPrev;
	 end if;
	 Free_Dllist (That);
	 --Open := True;
      end Unlink_From_Dllist;
      
      entry Get_Item (N : access Dllist_Type'Class; 
		      Pos : in out Posvec_Class_Access_Type)
      when Open is
      begin
	 Open := False;
	 Pos := Posvec_Class_Access_Type (N.Pos);
	 -- returns null when N is on the anchor
	 Open := True;
      end Get_Item;
      
      entry Insert_Pv_Before (This : access Posvec_Type'Class;  
			      next : access Dllist_Type)
      when Open is
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Pos   => Posvec_Class_Access_Type (This), 
			    Luth  => null,
			    Prev  => Next.prev, 
			    Next  => Dllist_Access_Type (Next),
			    Mprev => null, Mnext => null);
      begin
	 Open := False;
	 Next.Prev   := P;
	 P.Prev.Next := P;
	 Open := True;
      end Insert_Pv_Before;
      
      entry Insert_Pv_After
	(This : access Posvec_Type'Class;   
	 Prev : access Dllist_Type )
      when Open is
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Pos   => Posvec_Class_Access_Type (This), 
			    Luth  => null,
			    Prev  => Dllist_Access_Type (Prev), 
			    Next  => Prev.Next,
			    Mprev => null, Mnext => null);
      begin
	 Open := False;
	 Prev.Next   := P;
	 P.Next.Prev := P;
	 Open := True;
      end Insert_Pv_After;
      
      entry Unlink_Dllist_Item (This : access Dllist_Type)
      when Open is
      begin
	 Open := False; 
	 Unlink_From_Dllist (This);
	 Open := True;
      end Unlink_Dllist_Item;
      
      
      ------------------------
      -- 3 axis item entrys --
      ------------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec3_Class_Access_Type)
      when Open is
      begin
	 Open := False;
	 Pos := Posvec3_Class_Access_Type (N.Pos);
	 -- returns null when N is on the anchor
	 Open := True;
      end Get_Item;
      
      entry Insert_Pv_Before (This        : access Posvec3_Type'Class;  
			      Next, Mnext : access Dllist_Type)
      when Open is
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Pos  => Posvec_Class_Access_Type (This), 
			    Luth => null,
			    Prev => Next.prev, Next => Dllist_Access_Type (Next),
			    Mprev => Mnext.Mprev, 
			    Mnext => Dllist_Access_Type (Mnext)); 
      begin
	 Open := False;
	 Next.Prev     := P;
	 Mnext.Mprev   := P;
	 P.Prev.Next   := P;
	 P.Mprev.Mnext := P;
	 Open := True;
      end Insert_Pv_Before;
      
      entry Insert_Pv_After (This        : access Posvec3_Type'Class;   
			     Prev, Mprev : access Dllist_Type)
      when Open is
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Pos => Posvec_Class_Access_Type (This), 
			    Luth => null,
			    Prev => Dllist_Access_Type (Prev), Next => Prev.Next,
			    Mprev => Dllist_Access_Type (Mprev), 
			    Mnext => Mprev.mnext);
      begin
	 Open := False;
	 Prev.Next     := P;
	 Mprev.MNext   := P;
	 P.Next.Prev   := P;
	 P.Mnext.Mprev := P;
	 Open := True;
      end Insert_Pv_After;
      
      
      procedure Unlink_This_Pos3_Node (This : access Dllist_Type)
      is
	 procedure Free_Posvec3 is 
	    new Ada.Unchecked_Deallocation (Posvec3_Type, Posvec3_Access_type);
      begin
	 Free_Posvec3 (Posvec3_Access_Type (This.Pos));
	 Unlink_From_Dllist (This);
      end Unlink_This_Pos3_Node;
      
      entry Unlink_Pos3_Node (This : access Dllist_Type)
      when Open is
	 procedure Free_Posvec3 is 
	    new Ada.Unchecked_Deallocation (Posvec3_Type, Posvec3_Access_type);
      begin
	 Open := False;
	 Unlink_This_Pos3_Node (This);
	 Open := True;
      end Unlink_Pos3_Node;
      
      
      ------------------------
      -- 9 axis item entrys --
      ------------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec9_Access_Type)
      when Open is
      begin
	 Open := False;
	 Pos := Posvec9_Access_Type (N.Pos);
	 -- returns null when N is on the anchor
	 Open := True;
      end Get_Item;
      
      
      procedure Unlink_This_Pos9_Node  (This : access Dllist_Type)
      is
	 procedure Free_Posvec9 is 
	    new Ada.Unchecked_Deallocation(Posvec9_Type, Posvec9_Access_type);
      begin
	  Free_Posvec9 (Posvec9_Access_Type (This.Pos));
	  Unlink_From_Dllist (This);
      end Unlink_This_Pos9_Node;
      
      entry Unlink_Pos9_Node  (This : access Dllist_Type)
      when Open is
      begin
	 Open := False;
	 Unlink_This_Pos9_Node (This);
	 Open := True;
      end Unlink_Pos9_Node;
      
      
      --------------------------
      -- command item entries --
      --------------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec_C_Access_Type)
      when Open is
      begin
	 Open := False;
	 Pos := Posvec_C_Access_Type (N.Pos);
	 -- returns null when N is on the anchor
	 Open := True;
      end Get_Item;
      
      
      procedure Unlink_This_Posc_Node  (This : access Dllist_Type)
      is
	 procedure Free_Posc is 
	    new Ada.Unchecked_Deallocation(Posvec_C_Type, Posvec_C_Access_Type);
      begin
	  Free_Posc (Posvec_C_Access_Type (This.Pos));
	  Unlink_From_Dllist (This);
      end Unlink_This_Posc_Node;
      
      entry Unlink_Pos_C_Node  (This : access Dllist_Type)
      when Open is
      begin
	 Open := False;
	 Unlink_This_Posc_Node (This);
	 Open := True;
      end Unlink_Pos_C_Node;
      
      
      -------------------------
      -- string item entries --
      -------------------------
      procedure Unlink_This_Pos_S_Node (This : access Dllist_Type)
      is
	 procedure Free_Posvec_S is 
	    new Ada.Unchecked_Deallocation(Posvec_S_Type, Posvec_S_Access_Type);
	 procedure Free_String is
	    new Ada.Unchecked_Deallocation(String, String_Access_type);
      begin
	 Free_String (String_Access_Type (Posvec_S_Access_Type (This.Pos).Sa));
	  Free_Posvec_S (Posvec_S_Access_Type (This.Pos));
	  Unlink_From_Dllist (This);
      end Unlink_This_Pos_S_Node;
      
      entry Unlink_Pos_S_Node  (This : access Dllist_Type)
      when Open is
      begin
	 Open := False;
	 Unlink_This_Pos_S_Node (This);
	 Open := True;
      end Unlink_Pos_S_Node;
      
      
      -----------------------------------
      -- finalize a doubly linked list --
      -----------------------------------
      entry Finalize (Anchor : access Dllist_Type)
      when Open is
	 This, Next : access Dllist_Type := Anchor.Next;
      begin
	 Open := False;
	 while This /= Anchor loop
	    Next := This.Next;
	    if This.Pos in Posvec_S_Access_Type then 
	       Unlink_This_Pos_S_Node (This);
	    elsif This.Pos in Posvec9_Access_Type then
	       Unlink_This_Pos9_Node (This);
	    elsif This.Pos in Posvec3_Access_Type then
	       Unlink_This_Pos3_Node (This);
	    elsif This.Pos in Posvec_C_Access_Type then
	       Unlink_This_PosC_Node (This);
	    end if;
	    This := Next;
	 end loop;
	 Open := True;
      end Finalize;   
      
   end Program_Queue_Type;
   
   
end Silmaril.Dll;

