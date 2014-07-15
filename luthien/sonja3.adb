------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                        L U T H I E N . S O N J A 3                       --
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

-- implementation of chapter 3 of the Sonja Macfarlane Thesis
-- this body holds the generally used math routines.

with Ada.Numerics.Generic_Elementary_Functions;
--with Ada.Numerics.Generic_Real_Arrays;

package body Sonja3 is
   
  Package Num renames Ada.Numerics;
  package Math is new Ada.Numerics.Generic_Elementary_Functions 
    (Float_Type => Long_Float);
  --package Vm is new Ada.Numerics.Generic_Real_Arrays (Real => Long_Float);
  
   Lm : Lin_Move_Record_Type := (Sinv_Flag => False, others => 0.0);
   
   
   procedure Math_In (Invec : Sonja3_In_Type)
   is
      Dx : M_Type := Invec.P1.X - Invec.P2.X;
      Dy : M_Type := Invec.P1.Y - Invec.P2.Y;
      Dz : M_Type := Invec.P1.Z - Invec.P2.Z;
      Da : M_Type := Invec.P1.A - Invec.P2.A;
      Db : M_Type := Invec.P1.B - Invec.P2.B;
      Dc : M_Type := Invec.P1.C - Invec.P2.C;
   begin
      Lm.Jmax := Invec.Jmax;
      Lm.Amax := Invec.Amax;
      Lm.Smax := Invec.Smax;
      if Invec.S2 > Invec.S1 then
	 Lm.S1 := Invec.S1;
	 Lm.S2 := Invec.S2;
	 Lm.Sinv_Flag := False;
      else
	 Lm.S1 := Invec.S2;
	 Lm.S2 := Invec.S1;
	 Lm.Sinv_Flag := True;
      end if;
      Lm.D := Math.Sqrt (Dx ** 2 + Dy ** 2 + Dz ** 2 + Da ** 2 + Db ** 2 + Dc ** 2);
      Lm.Delta_Tmax := (Num.Pi * Lm.Amax) / (2.0 * Lm.Jmax); --(3.4)
      Lm.Dmin := Lm.Amax * Lm.Delta_Tmax ** 2 + 2.0 * Lm.S1 * Lm.Delta_Tmax; -- (3.20)
      Lm.Dv := Lm.Dmin; -- I hope this is right???
      Lm.Delta_Smin := Lm.Delta_Tmax * Lm.Amax; -- (3.22)
   exception
      when others => null;
   end Math_In;
   
   
   procedure Math312_314 
   is
      Tmp : Long_Float;
   begin
      Tmp := (Lm.Amax * Lm.Delta_Tmax) / 2.0;
      Lm.Sa := Lm.S1 + Tmp; -- (3.12)
      Lm.Sb := Lm.S2 - Tmp; -- (3.13)
      Lm.D1 := Lm.Amax * Lm.Delta_Tmax ** 2 * 
	(1.0 / 4.0 - 1.0 / Num.Pi ** 2) + Lm.S1 * Lm.Delta_Tmax; -- (3.14)
   exception
      when others => null;
   end Math312_314;
   
   
   procedure Math315_316 
   is
   begin
      Lm.D2 := (Lm.Sb ** 2 - Lm.Sa ** 2) / 2.0 * Lm.Amax; -- (3.15)
      Lm.D3 := Lm.Amax * Lm.Delta_Tmax ** 2 * 
	(1.0 / 4.0 + 1.0 / Num.Pi ** 2) + Lm.Sb * Lm.Delta_Tmax; -- (3.16)
   exception
      when others => null;
   end Math315_316;
   
   
   procedure Math317_318 
   is
   begin
      Lm.Sb := - Lm.Amax * Lm.Delta_Tmax + 
	Math.Sqrt ((Lm.Amax * Lm.Delta_Tmax) ** 2 - 2.0 * Lm.Amax * 
		     ((Lm.Amax * Lm.Delta_Tmax ** 2) / 2.0 + 
			Lm.S1 * Lm.Delta_Tmax - Lm.Sa ** 2 / (2.0 * Lm.Amax) - 
			Lm.D)); -- (3.17)
      Lm.S2 := Lm.Sb + (Lm.Amax * Lm.Delta_Tmax) / 2.0; -- (3.18)
   exception
      when others => null;
   end Math317_318;
   
   
   procedure Math324_325 
   is
      L, U, V : Long_Float;
      function "**" (Left, Right : Long_Float) return Long_Float Renames  Math."**";
   begin
      if Lm.S1 < Long_Float'Model_Epsilon then
	 Lm.Delta_T := ((Num.Pi * Lm.D) / (2.0 * Lm.Jmax)) ** (1.0 / 3.0); -- (C.17)
      else
	 U := - (Num.Pi * Lm.D) / (4.0 * Lm.Jmax); -- (C.8)
	 V := - (Num.Pi * Lm.S1) / (3.0 * Lm.Jmax); -- (C.9)
	 L := (abs (U) + Math.Sqrt (U ** 2 - V ** 3)) ** (1.0 / 3.0); -- (C.15)
	 Lm.Delta_T := L + V / L; -- (C.16)
      end if;
      Lm.Apeak := (2.0 * Lm.Jmax * Lm.Delta_T) / Num.Pi; -- (3.25)
   exception
      when others => null;
   end Math324_325;
   
   
   procedure Math326_325 
   is
   begin
      Lm.Delta_T := Math.Sqrt ((Num.Pi * (Lm.S2 - Lm.S1)) / (2.0 * Lm.Jmax)); -- (3.26)
      Lm.Apeak := (2.0 * Lm.Jmax * Lm.Delta_T) / Num.Pi; -- (3.25)
   exception
      when others => null;
   end Math326_325;
   
   
   procedure Math_Yy 
   is
   begin
      Lm.Slimit := Lm.Amax * Lm.Delta_Tmax + Lm.S2; -- (3.29)
      Lm.Db := (Lm.Slimit + Lm.S2) * Lm.Delta_Tmax; -- (3.32)
      Math312_314;
      Math315_316;
      Lm.Da := Lm.D1 + Lm.D2 + Lm.D3; -- (3.31)
      Lm.Dlimit := Lm.Da + Lm.Db; -- (3.30)
      --Lm.Delta_Smin := Lm.Delta_Tmax * Lm.Amax; --(3.21) 
   exception
      when others => null;
   end Math_Yy;
   
   
   procedure Math_Bii_A1 
   is
      Tmp_S1 : Mpsec_Type := Lm.S1;
      Tmp_S2 : Mpsec_Type := Lm.S2;
   begin
      Lm.S2 := Lm.Smax; 
      Math312_314;
      Lm.Sax := Lm.Sa;
      Math315_316;
      Lm.D1x := Lm.D1;
      Lm.Dx := Lm.D1 + Lm.D2 + Lm.D3;
      Lm.S1 := Tmp_S2;
      Math312_314;
      Lm.Saz := Lm.Sa;
      Math315_316;
      Lm.D1z := Lm.D1;
      Lm.Dz := Lm.D1 + Lm.D2 + Lm.D3;
      Lm.S1 := Tmp_S1;
      Lm.S2 := Tmp_S2;
   exception
      when others => null;
   end Math_Bii_A1;
   
   
   procedure Math_Bii_A2 
   is
   begin
      Lm.Speak := - (Lm.Amax * Lm.Delta_Tmax) / 2.0 + 
	Math.Sqrt (Lm.Amax * Lm.D + (Lm.Ax ** 2 + Lm.Az ** 2) / 2.0 - 
		     (Lm.Amax * Lm.Delta_Tmax) * (Lm.S1 + Lm.S2)); -- (D.1)
      Lm.Sbz := Lm.Speak - (Lm.Amax * Lm.Delta_Tmax) / 2.0; -- (D.2)
      Lm.Sbx := Lm.Sbz; -- (D.2)
      Lm.D2x := (Lm.Sbx ** 2 - Lm.Sax ** 2) / (2.0 * Lm.Amax); -- (D.3)
      Lm.D3x := Lm.Amax * Lm.Delta_Tmax ** 2 * 
	(1.0 / 4.0 + 1.0 / Num.Pi ** 2) + Lm.Sbx * Lm.Delta_Tmax; -- (D.4)
      Lm.Dx := Lm.D1x + Lm.D2x + Lm.D3x;
      Lm.D2z := (Lm.Sbz ** 2 - Lm.Saz ** 2) / (2.0 * Lm.Amax); -- (D.5)
      Lm.D3z := Lm.Amax * Lm.Delta_Tmax ** 2 * 
	(1.0 / 4.0 + 1.0 / Num.Pi ** 2) + Lm.Sbz * Lm.Delta_Tmax; -- (D.6)
      Lm.Dx := Lm.D1 + Lm.D2 + Lm.D3;
   exception
      when others => null;
   end Math_Bii_A2;
   
   
   procedure Math_Bii_B 
   is
     Drampup : Mpsec_Type := 0.0; 
   begin
      if Lm.S2 - Lm.S1 > Lm.Delta_Smin then
	 Math312_314;
	 Math315_316;
	 Drampup := Lm.D1 + Lm.D2 + Lm.D3;
      else
	 Math326_325; -- gives dT and Apeak
	 Lm.Sbx := Lm.S2 - (Lm.Apeak * Lm.Delta_T) / 2.0; -- (D.2)
	 Lm.D1x := Lm.Apeak * Lm.Delta_T ** 2 * 
	(1.0 / 4.0 - 1.0 / Num.Pi ** 2) + Lm.S1 * Lm.Delta_T; -- (3.14)
	 Lm.D3x := Lm.Apeak * Lm.Delta_T ** 2 * 
	   (1.0 / 4.0 + 1.0 / Num.Pi ** 2) + Lm.Sbx * Lm.Delta_T; -- (D.4)
	 Drampup := Lm.D1x + Lm.D3x;
      end if;
      if Drampup > Lm.D then
	 raise Exception;
      else
	 
      end if;
   exception
      when others => null;
   end Math_Bii_B;
   
   
   
end Sonja3;
