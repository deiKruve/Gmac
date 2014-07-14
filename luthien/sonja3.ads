------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                        L U T H I E N . S O N J A 3                       --
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

-- implementation of chapter 3 of the Sonja Macfarlane Thesis

--with Silmaril;
--with Silmaril.Dll;

package Sonja3 is
   
   subtype Sec_Type is Long_Float;
   subtype M_Type is Long_Float; -- this is disingenious, 
				 --rads are now also called meters.
   subtype Rad_Type is Long_Float;
   subtype Mpsec_Type is Long_Float;  -- speed type
   subtype Mpsec2_Type is Long_Float; -- acc type
   subtype Mpsec3_Type is Long_Float; -- jerk type
   
   type Qcp_Type is 
      record
	 Tqi : Sec_Type; -- time
	 Pqi : M_Type; -- position (D)
	 Vqi : Mpsec_Type; -- velocity (s)
	 Aqi : Mpsec2_Type; -- acceleration (s)
      end record;
   type Qcp_Table_Type is array (Positive range <>) of Qcp_Type;
   
   type Pos_Vector_Type is
      record
	 X,
	 Y,
	 Z  : M_Type;
	 A,
	 B,
	 C  : M_Type;
      end record;
   
   type Sonja3_In_Type is
      record
	 P1   : Pos_Vector_Type;  -- start point
	 P2   : Pos_Vector_Type;  -- end position
	 S1   : Mpsec_Type;       -- start speed
	 S2   : Mpsec_Type;       -- end speed
	 Ift1 : Sec_Type;         -- start inverse feed time
	 Ift2 : Sec_Type;         -- end inverse feed time
      end record;
   
private
   
   type Lin_Move_Record_Type is
      record	 
	 D,                   -- Euclidian distance between two points.
	 Dmin,                -- minimum distance required to use the SAP
			      -- algorithm.                
	 Dlimit,              -- minimum distance required to be able to use 
			      -- the SAP when ramping from s1 to speak and
			      -- then from speak to s2.
	 D1,                  -- distance covered during a ramp from zero 
       			      -- acceleration to amax in the SAP algorithm.
	 D1z,                 -- distance covered during a ramp from zero 
	                      -- acceleration to amax in the SAP algorithm for
                              -- the case z.
	 D2,                  -- distance covered during the acceleration 
			      -- cruise at amax in the SAP algorithm.
	 D2z,                 -- distance covered during the acceleration 
			      -- cruise at amax in the SAP algorithm for 
			      -- the case z.
	 D3,                  -- distance covered during a ramp down from amax
			      -- to zero acceleration in the SAP algorithm.
	 D3z,                 -- distance covered during a ramp down from amax
			      -- to zero acceleration in the SAP algorithm
			      -- for the case z.

	 Da,                  -- distance covered during a SAP used to ramp
			      -- from s1 to slimit (=D1a + D2a + D3a).
	 D1a,
	 D2a,
	 D3a,
	 Db,                  -- distance covered during an acceleration pulse
			      -- from s2 to slimit.
	 D1b,
	 D2b,
	 D3b,
	 Dv,                  -- distance required to ramp between the two
			      -- way-point speeds.
	 Dw,                  -- distances required to ramp between two speeds.
	 Dx,
	 Dy,
	 Dz,
	 Delta_D : M_Type;    -- distance remaining after an acceleration pulse 
			      -- (used in the speed-limited case)
	 Jmax : Mpsec3_Type;  -- maximum allowable jerk.
	 S,
	 S1,                  -- speed at start of this traject
	 S2,                  -- speed at the end of this traject
	 Sa,                  -- speed attained at the end of a ramp 
			      -- from zero acceleration to maximum acceleration 
			      -- in the SAP algorithm.
	 Saz,                 -- speed attained at the end of a ramp from 
			      -- zero acceleration to maximum acceleration in
			      -- the SAP algorithm for the case z.
	 Sb,                  -- speed attained at the end of the acceleration 
			      -- cruise in the SAP algorithm.
	 Sbz,                 -- speed attained at the end of the acceleration 
			      -- cruise in the SAP algorithm for the case z.
	 Si,                  -- speed at point i.
	 Slimit,              -- speed reached by an acceleration pulse at amax.
	 Smax,                -- maximum allowable speed along a trajectory 
			      -- segment ( MMAS).
	 Speak : Mpsec_Type;  -- peak speed reached during a trajectory between
			      -- two way-points ( smax).
	 Delta_S,             -- change in speed
	 Delta_Smin,          --   minimum change in speed required to use 
			      -- the SAP algorithm
	 Delta_Srd : Mpsec_Type; -- change in speed required for a ramp from 
			      -- maximum acceleration to zero acceleration in
			      -- the SAP algorithm.
	 Amax,                -- manufacturer maximum allowable acceleration
			      -- (MMAA).
	 Apeak : Mpsec2_Type; -- peak acceleration reached during a point to 
			      -- point motion (<= amax).
	 T,                   -- time.
	 Ts1,                 -- time required to carry out a given straight
			      -- line motion.
	 Delta_T,             -- time required to ramp up to apeak while 
			      -- respecting jmax (  dtmax).
	 Delta_Tmax : Sec_Type; -- time required for a ramp up to amax from 
			      -- zero acceleration while respecting jmax.
      end record;
	 
   procedure Math312_314;
   procedure Math315_316;
   procedure Math317_318;
   procedure Math324_325;
   procedure Math326_325;
   procedure Math_Yy;
   
   --subtype Move_Record_Type is Silmaril.Dll.Posvec9_Type;
   --subtype Move_Record_Access_Type is Silmaril.Dll.Posvec9_Access_Type;
   
end Sonja3;
