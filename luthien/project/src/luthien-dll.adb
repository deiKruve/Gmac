------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                           L U T H I E N . D L L                          --
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
--                Luthien is maintained by J de Kruijf Engineers            --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

-- dll of all controlpoints for the low level parser

-- with Silmaril.Dll;

with Ada.Unchecked_Deallocation;

package body Luthien.Dll is
   
  -- package Sdll renames Silmaril.Dll;
   
   procedure Initialize (Anchor : access Dllist_Type) is
   begin
      null;
      --Anchor := new Dllist_Type; must be done before calling
      Anchor.Q_P  := null;
      --Anchor.Silm := null;
      Anchor.Prev := Dllist_Access_Type (Anchor);
      Anchor.Next := Dllist_Access_Type (Anchor);
   end Initialize;
   
   protected body Parser_Queue_Type is
      
      procedure Unlink_From_Dllist (This : access Dllist_Type)
      is
	 procedure Free_Dllist is
	    new Ada.Unchecked_Deallocation (Dllist_Type, Dllist_Access_type);
	 That : Dllist_Access_Type := Dllist_Access_Type (This);
      begin 
	 This.Prev.Next := This.Next;
	 This.Next.Prev := This.Prev;
	 --This.Silm := null;
	 -- the from-silmaril connection
	 Free_Dllist (That);
      end Unlink_From_Dllist;
      
      
      -----------------------------------
      -- finalize a doubly linked list --
      -----------------------------------
      entry Finalize(Anchor : access Dllist_Type)
      when Open is
	 This, Next : access Dllist_Type := Anchor.Next;
      begin
	 Open := False;
	 while This /= Anchor loop
	    Next := This.Next;
	    --!!!!!!!!!!!!!!!!!!!!!!!!!to be done
	    This := Next;
	 end loop;
	 Open := True;
      end Finalize;


      entry Get_Item (N : access Dllist_Type; 
		      Q_P : out Cp_Access_Type)
      when Open is   
      begin
	 Open := False;
	 Q_P  := Cp_Access_Type (N.Q_P);
	 Open := True;
      end Get_Item;
      
      
      entry Insert_Pv_Before (This : access Cp_Type'Class;  
			      next : access Dllist_Type)
      when Open is   
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Q_P  => Cp_Access_Type (This),
			    --Silm => null,
			    Prev => Next.prev, 
			    Next => Dllist_Access_Type (Next));
      begin
	 Open := False;
	 Next.Prev   := P;
	 P.Prev.Next := P;
	 Open := True;
      end Insert_Pv_Before;
      
      
      entry Insert_Pv_After (This : access Cp_Type'Class;   
			     Prev : access Dllist_Type )
      when Open is
	 P : Dllist_Access_Type := 
	   new Dllist_Type'(Q_P  => Cp_Access_Type (This),
			    --Silm => null,
			    Prev  => Dllist_Access_Type (Prev), 
			    Next  => Prev.Next);
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
      
   end Parser_Queue_Type;
   
   
begin
   Initialize (Pq_Anchor);
end Luthien.Dll;
