------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                        B E R E N . S C A N N E R                         --
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
-- scanner thread framework for the beren modules
--

package body Beren.Thread is
   
   
   procedure Insert_Down_Scan (Ds : Scan_Proc_P_Type)
   is
      Scan_Entry : Scan_Entry_P_Type := new Scan_Entry_Type;
   begin
      Scan_Entry.Scan := Ds;
      Scan_List.Next.Prev := Scan_Entry;
      Scan_Entry.Prev := Scan_List;
      Scan_Entry.Next := Scan_List.Next;
      Scan_List.Next := Scan_Entry;
   end Insert_Down_Scan;
   
   procedure Insert_Down_Scan (Scan_List : in out Scan_Entry_P_Type; 
			       Ds        : Scan_Proc_P_Type)
   is
      Scan_Entry : Scan_Entry_P_Type := new Scan_Entry_Type;
   begin
      Scan_Entry.Scan := Ds;
      Scan_List.Next.Prev := Scan_Entry;
      Scan_Entry.Prev := Scan_List;
      Scan_Entry.Next := Scan_List.Next;
      Scan_List.Next := Scan_Entry;
   end Insert_Down_Scan;
   
    
   procedure Insert_Up_Scan (Us : Scan_Proc_P_Type)
   is
      Scan_Entry : Scan_Entry_P_Type := new Scan_Entry_Type;
   begin
      Scan_Entry.Scan := Us;
      Scan_List.Prev.Next := Scan_Entry;
      Scan_Entry.Next := Scan_List;
      Scan_Entry.Prev := Scan_List.Prev;
      Scan_List.Prev := Scan_Entry;
   end Insert_Up_Scan;
      
    
   procedure Insert_Up_Scan (Scan_List : in out Scan_Entry_P_Type; 
			     Us        : Scan_Proc_P_Type)
   is
      Scan_Entry : Scan_Entry_P_Type := new Scan_Entry_Type;
   begin
      Scan_Entry.Scan := Us;
      Scan_List.Prev.Next := Scan_Entry;
      Scan_Entry.Next := Scan_List;
      Scan_Entry.Prev := Scan_List.Prev;
      Scan_List.Prev := Scan_Entry;
   end Insert_Up_Scan;
      
   
   procedure Scan
   is
      Qq : Scan_Entry_P_Type := Scan_List;
   begin
      while Qq.Scan /= null loop
	 Qq.Scan.all;
	 Qq := Qq.Next;
      end loop;
   end Scan;
   
   
   procedure Scan (Q : Scan_Entry_P_Type)
   is
      Qq : Scan_Entry_P_Type := Q;
   begin
      while Qq.Scan /= null loop
	 Qq.Scan.all;
	 Qq := Qq.Next;
      end loop;
   end Scan;
  
begin
   Scan_List.Prev := Scan_List;
   Scan_List.Next := Scan_List;
   Scan_List.Scan := null;
   
end Beren.Thread;
