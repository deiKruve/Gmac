------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                       L U T H I E N . D L L . Q C P                      --
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

-- dll of all QCP controlpoints for the low level parser

with Ada.Numerics.Generic_Real_Arrays;
  
generic
   Nof_Axes : Positive := 1;
   
package Luthien.Dll.Qcp is
   
   package Mv is new Ada.Numerics.Generic_Real_Arrays 
     (Real => Long_Float);
   type Real_Vector_Type is new Mv.Real_Vector (1 .. Nof_Axes);
   
   --  subtype Sec_Type is Long_Float;
   --  subtype M_Type is Long_Float; -- this is disingenious, 
   --  				 --rads are now also called meters.
   --  subtype Rad_Type is Long_Float;
   --  subtype Mpsec_Type is Long_Float;  -- speed type
   --  subtype Mpsec2_Type is Long_Float; -- acc type
   --  subtype Mpsec3_Type is Long_Float; -- jerk type
   
   
   type Qcp_Type is tagged;
   type Qcp_Access_Type is access all Qcp_Type;
   type Qcp_Type is new Cp_Type with
      record
	 Tqi : Sec_Type; -- time
	 Pqi : M_Type; -- position (D)
	 Vqi : Mpsec_Type; -- velocity (s)
	 Aqi : Mpsec2_Type; -- acceleration (s)
	 P1,
	 Dinc : Real_Vector_Type;
      end record;
   
   procedure Get_Item (N   : access Dllist_Type; 
		       Q_P : in out Qcp_Access_Type);
   
end Luthien.Dll.Qcp;
