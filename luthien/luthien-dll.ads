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

with Silmaril.Dll;

package Luthien.Dll is
   
   
   -- base of all Cp records
   type Cp_Type is abstract tagged;
   type Cp_Access_Type is access all Cp_Type'Class;
   type Cp_Type is abstract tagged record
      null;
   end record;
   
   
   type Dllist_Type;
   type Dllist_Access_Type is access all Dllist_Type;
     
   type Dllist_Type is tagged record
      Q_P            : access Cp_Type'Class;
      Silm           : access Silmaril.Dll.Dllist_Access_Type := null;
      Prev, Next     : Dllist_Access_Type       := null;
   end record;
   
   procedure Initialize (Anchor : access Dllist_Type);
   
   protected type Parser_Queue_Type is
      pragma Priority (Parser_Q_Thread_Priority);
      
      entry Finalize(Anchor : access Dllist_Type);
      entry Get_Item (N : access Dllist_Type; 
		      Q_P : out Cp_Access_Type);
      entry Insert_Pv_Before (This : access Cp_Type'Class;  
			      next : access Dllist_Type);
      entry Insert_Pv_After (This : access Cp_Type'Class;   
			     Prev : access Dllist_Type );
      entry Unlink_Dllist_Item (This : access Dllist_Type);
      -- destroy a Dllist-item in the link
   private
      Open : Boolean := True;
   end Parser_Queue_Type;
   
   --Pq_Anchor : Dllist_Access_Type := new Dllist_Type;
   --Pars_Q    : Parser_Queue_Type;
   
end Luthien.Dll;
