------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                  L U T H I E N . S O N J A . S O N J A 4                 --
--                                                                          --
--                                  B o d y                                 --
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
--

with Ada.Numerics.Generic_Elementary_Functions;

package body Luthien.Sonja.Sonja4 is
   
   package Dbcp is new Dll.Bcp (Nof_Axes);
   package Num  renames Ada.Numerics;
   package Math is new Ada.Numerics.Generic_Elementary_Functions 
     (Float_Type => Long_Float);
   
   Tighthyper    : Long_Float          := 0.0;
   Rho           : constant Long_Float := 0.8;
   Ptmpa, Ptmpb,
   P1a, P1b      : Real_Vector_Type;
   
   
   function Test_Bend (Inp : Sonja4_In_Type) return Mpsec_Type
   is
      function "**" (Left, Right : Long_Float) return Long_Float 
        Renames  Math."**";
      function Norm (Right : Mv.Real_Vector) return Long_Float 
        Renames  Mv."abs";
      Theta,
      Cos_Theta        : Long_Float := 0.0;
      Ptmp             : Real_Vector_Type;
      Ptmp_N,
      Coord_Max        : Long_Float := 0.0;
      S_Blend_Max_Acc,
      S_Blend_Max_Jerk : Mpsec_Type;
   begin
      
      Ptmp := Inp.P1 - Inp.P0;
      Ptmp_N := Norm (Mv.Real_Vector (Ptmp));
      for I in Ptmp'Range loop
	 if Ptmp (I) > Coord_Max then 
	    Coord_Max := Ptmp (I);
	 end if;
      end loop;
      Tighthyper := (Inp.Tightness / Coord_Max) * Ptmp_N;
      P1a := Inp.P1 - (Ptmp / Ptmp_N * Tighthyper); -- (4.12)
      Ptmp := Inp.P2 - Inp.P1;
      P1b := Inp.P1 + (Ptmp / Norm (Mv.Real_Vector (Ptmp))) * Tighthyper; -- (4.13)
      Ptmpa := (Inp.P1 - P1a);
      Ptmpb := (P1b - Inp.P1);
      Cos_Theta := Ptmpa * Ptmpb / tighthyper ** 2; -- (4.21)
      Theta := Math.Arccos (Cos_Theta);
      --A_Blend_Max := Inp.S1 ** 2 / (Rho * tighthyper) * 
	--Math.Sqrt ((1.0 + Cos_Theta) / 2.0);
      S_Blend_Max_Acc := Math.Sqrt ((Rho * Inp.Amax * Tighthyper) / 
				      Math.Sqrt ((1.0 + Cos_Theta) / 2.0)); --(4.22)
      --J_Blend_Max := 
	--(15.0 * Inp.S1 ** 3 * Mv."abs" (Mv.Real_Vector (Ptmpb - Ptmpa))) / 
	--(4.0 * tighthyper ** 3);
      S_Blend_Max_Jerk := 
	((2.0 * Inp.Jmax * Tighthyper ** 2) / (15.0 * Math.Cos (Theta / 2.0))) **
	(1.0 / 3.0); -- (4.24)
      if S_Blend_Max_Jerk < S_Blend_Max_Acc then -- (4.25)
	 return S_Blend_Max_Jerk;
      else
	 return S_Blend_Max_Acc;
      end if;
   exception
      when others => null; return 0.0;
   end Test_Bend;
   
   
   procedure Calc_Blend (Anchor : in out Dll.Dllist_Access_Type; 
			 Inp    : Sonja4_In_Type) 
   is
      function Norm (Right : Mv.Real_Vector) return Long_Float Renames  Mv."abs";
      Bcp      : Dbcp.Bcp_Access_Type := new Dbcp.Bcp_Type;
      V1a, V1b : Real_Vector_Type; 
   begin
      Bcp.Tau := Tighthyper / Inp.S1;
      V1a := Inp.S1 * (Ptmpa / Norm (Mv.Real_Vector (Ptmpa))); -- (4.16)
      V1b := Inp.S1 * (Ptmpb / Norm (Mv.Real_Vector (Ptmpb))); -- (4.17)
      Bcp.B1 := Dbcp.Real_Vector_Type (P1a); -- (4.14)
      Bcp.B2 := Dbcp.Real_Vector_Type (P1b - 2.0 * Bcp.Tau * V1b);
      Bcp.M1 := Dbcp.Real_Vector_Type (2.0 * Bcp.Tau * V1a); -- (4.15)
      Bcp.M2 := Dbcp.Real_Vector_Type (2.0 * Bcp.Tau * V1b);
      Dll.Pars_Q.Insert_Pv_Before (This => Bcp, Next => Anchor);
   exception
      when others => null;
   end Calc_Blend;
   
end Luthien.Sonja.Sonja4;
