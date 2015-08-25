------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                 L U T H I E N . S O N J A . S O N J A 4                  --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--                     Copyright (C) 2014, Jan de Kruyf                     --
--                 Algorithms copyright (C) Sonja Macfarlane,               --
--                   The University of New Brunswick, 1999                  --
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

-- implementation of chapter 4 of the Sonja Macfarlane Thesis

with Luthien.Dll.Bcp;
with Ada.Numerics.Generic_Real_Arrays;

generic
   Nof_Axes : Positive := 1;
   
package Luthien.Sonja.Sonja4 is
      
   package Mv is new Ada.Numerics.Generic_Real_Arrays (Real => Long_Float);
   type Real_Vector_Type is new Mv.Real_Vector (1 .. Nof_Axes);
   
   package Dll is new Luthien.Dll;

   type Sonja4_In_Type is
      record
	 P0,
	 P1,
	 P2        : Real_Vector_Type;  -- start point, blend point, next point
	 Tightness : M_Type;
	 S1        : Mpsec_Type;       -- requested speed at P1
	 
	 Amax      : Mpsec2_Type;      -- max accel
	 Jmax      : Mpsec3_Type;      -- max jerk
      end record;
   
   function Test_Bend (Inp : Sonja4_In_Type) return Mpsec_Type;
   procedure Calc_Blend (Anchor : in out Dll.Dllist_Access_Type; 
			 Inp : Sonja4_In_Type);
   

end Luthien.Sonja.Sonja4;
