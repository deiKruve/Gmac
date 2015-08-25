------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                       L U T H I E N . D L L . B C P                      --
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

-- dll of all BCP controlpoints for the low level parser
-- b1, b2, m1, m2, tau

with Ada.Numerics.Generic_Real_Arrays;
  
generic
   Nof_Axes : Positive := 1;
   
package Luthien.Dll.Bcp is
   
   package Mv is new Ada.Numerics.Generic_Real_Arrays 
     (Real => Long_Float);
   type Real_Vector_Type is new Mv.Real_Vector (1 .. Nof_Axes);
   
   type Bcp_Type is tagged;
   type Bcp_Access_Type is access all Bcp_Type;
   type Bcp_Type is new Cp_Type with
      record
	 B1,
	 B2  : Real_Vector_Type;
	 M1,
	 M2  : Real_Vector_Type;
	 Tau : Sec_Type;
      end record;
   
   procedure Get_Item (N   : access Dllist_Type;
		       B_P : in out Bcp_Access_Type);
   
end Luthien.Dll.Bcp;
