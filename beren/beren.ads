------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                                 B E R E N                                --
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
with Ada.Numerics.Generic_Real_Arrays;

package Beren is
   private
   ---------------------------
   -- for sonja and friends --
   ---------------------------
   subtype Sec_Type is Long_Float;
   subtype M_Type is Long_Float; -- this is disingenious, 
				 --rads are now also called meters.
   subtype Rad_Type is Long_Float;
   subtype Mpsec_Type is Long_Float;  -- speed type
   subtype Mpsec2_Type is Long_Float; -- acc type
   subtype Mpsec3_Type is Long_Float; -- jerk type
   
   package Mv is new Ada.Numerics.Generic_Real_Arrays 
     (Real => Long_Float);
   
   --  type Pos_Vector_Type is
   --     record
   --  	 X,
   --  	 Y,
   --  	 Z  : M_Type;
   --  	 A,
   --  	 B,
   --  	 C  : M_Type;
   --     end record;
   type Real_Vector_Type is new Mv.Real_Vector (1 .. 6);
   
   
end Beren;
