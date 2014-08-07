------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                        B E R E N . S C A N N E R                         --
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
-- scanner framework for the beren modules
--

package Beren.Scanner is
   
   type Scan_Entry_Type;
   type Scan_Entry_P_Type is access all Scan_Entry_Type;
   type Scan_Entry_Type is 
      record
	 Prev, Next : Scan_Entry_P_Type;
	 Scan : access procedure;
      end record;
   
   type Scan_Proc_P_Type is access procedure;
   
   procedure Insert_Down_Scan (Ds : Scan_Proc_P_Type);
   
   procedure Insert_Up_Scan (Ds : Scan_Proc_P_Type);
   
   procedure Scan (Q : Scan_Entry_P_Type);
   
   Scan_List : Scan_Entry_P_Type := new Scan_Entry_Type;
   
end Beren.Scanner;
