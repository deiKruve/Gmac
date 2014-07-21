------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                  L U T H I E N . S O N J A 3 . M A I N                   --
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
--
-- this package has the main entry and data preparation

with Luthien.Dll;

package body Luthien.Sonja3.Main is
   
   package Dll renames Luthien.Dll;
   
   type State_Type is (State1,  -- ingang
		       State2,  -- B
		       State3,  -- A
		       State4,  -- Biii
		       State5,  -- Biia
		       State6,  -- Biib
		       State7,  -- Biii-2
		       State8,  -- SAP
		       State9,  -- AP
		       State10, -- sap-2
		       State11, -- AP-2
		       State12, -- AP-3
		       State18); -- theEnd.
   
   --Fsm_State : State_Type := State1;
   
   procedure Fsm (Inp : in  Sonja3_In_Type; Fsm_State : in out State_Type)
   is
      From_Fsm_State : State_Type;
   begin
       loop
	  case Fsm_State is
	     
	     when State1  =>
		Math_In (Inp);
		if abs (Lm.Smax - Lm.S2) < Mpsec_Type'Epsilon then
		   Fsm_State := State3;
		else
		   Fsm_State := State2;
		end if;
		
	     when State2  =>
		if Lm.Dv > Lm.D then
		   Lm.Smax := Lm.S2;
		   Fsm_State := State3;
		else
		   Math_Yy;
		   if Lm.Smax - Lm.S2 > Lm.Delta_Smin then
		      if Lm.D > Lm.Dlimit then
			 Fsm_State := State5;
		      else
			 Fsm_State := State6;
		      end if;
		   else
		      Fsm_State := State4;
		   end if;
		end if;
		
	     when State3  =>
		if abs (Lm.S1 - Lm.S2) < Mpsec_Type'Epsilon then
		   -- we dont know what to do here yet!!!!!!!!!!!!!!!!!!!!
		   null;
		else
		   From_Fsm_State := State3;
		   if Lm.D > Lm.Dmin and ((Lm.S1 - Lm.S2) > Lm.Delta_Smin) then
		      Fsm_State := State8;
		   else
		      Fsm_State := State9;
		   end if;
		end if;
		
	     when State4  =>
		Math_Biii_1;
		if Lm.D > Lm.Dx + Lm.Dy then
		   Fsm_State := State7;
		else
		   Fsm_State := State6;
		end if;
		
	     when State5  =>
		Math_Bii_A1;
		if Lm.D > Lm.Dx + Lm.Dz then
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => False,
			       D1          => Lm.D1x,
			       D2          => Lm.D2x,
			       D3          => Lm.D3x, -- d's from Math_Bii_A1.
			       Delta_D     => Lm.D - Lm.Dz,
			       S1          => Lm.S1,
			       Sa          => Lm.Sax,
			       Sb          => Lm.Sbx,
			       S2          => Lm.Smax,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => True,
			       D1          => Lm.D1z,
			       D2          => Lm.D2z,
			       D3          => Lm.D3z, -- d's from Math_Bii_A1.
			       Delta_D     => Lm.Dz,
			       S1          => Lm.S2,
			       Sa          => Lm.Saz,
			       Sb          => Lm.Sbz,
			       S2          => Lm.Smax,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		else
		   Math_Bii_A2;
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => False,
			       D1          => Lm.D1x,
			       D2          => Lm.D2x,
			       D3          => Lm.D3x, -- d's from Math_Bii_A2.
			       Delta_D     => Lm.Dx,
			       S1          => Lm.S1,
			       Sa          => Lm.Sax,
			       Sb          => Lm.Sbx,
			       S2          => Lm.Speak,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => True,
			       D1          => Lm.D1z,
			       D2          => Lm.D2z,
			       D3          => Lm.D3z, -- d's from Math_Bii_A2.
			       Delta_D     => Lm.Dz,
			       S1          => Lm.S2,
			       Sa          => Lm.Saz,
			       Sb          => Lm.Sbz,
			       S2          => Lm.Speak,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		end if;
		Fsm_State := State18;
		
	     when State6  =>
		Math_Bii_B;
		Fsm_State := State7;
		
	     when State7  =>
		if Lm.D2x < M_Type'Epsilon then -- AP
		   Qcp_Ap_B2 (Anchor       => Dll.Pq_Anchor,
			      Sinv_Flag    => False,
			      Delta_D      => Lm.D - Lm.Dz,
			      S1           => Lm.S1,
			      Apeak        => Lm.Apeak,
			      Delta_T      =>Lm.Delta_T);
		else -- SAP
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => False,
			       D1          => Lm.D1x,
			       D2          => Lm.D2x,
			       D3          => Lm.D3x, -- d's from Math_Bii_B.
			       Delta_D     => Lm.D - Lm.Dz,
			       S1          => Lm.S1,
			       Sa          => Lm.Sax,
			       Sb          => Lm.Sbx,
			       S2          => Lm.Speak,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		end if;
		if Lm.D2x < M_Type'Epsilon then -- AP
		   Qcp_Ap_B2 (Anchor       => Dll.Pq_Anchor,
			      Sinv_Flag    => True,
			      Delta_D      => Lm.Dz,
			      S1           => Lm.S2,
			      Apeak        => Lm.Apeak,
			      Delta_T      =>Lm.Delta_T);
		else -- SAP
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => False,
			       D1          => Lm.D1z,
			       D2          => Lm.D2z,
			       D3          => Lm.D3z, -- d's from Math_Bii_B.
			       Delta_D     => Lm.Dz,
			       S1          => Lm.S2,
			       Sa          => Lm.Sax,
			       Sb          => Lm.Sbx,
			       S2          => Lm.Speak,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		end if;
		Fsm_State := State18;
		
	     when State8  =>
		Math312_314;
		Fsm_State := State10;
		
	     when State9  =>
		if Lm.Delta_S < Lm.Delta_Smin and Lm.D < Lm.Dmin then
		   Math324_325;
		   if Lm.Delta_S < Lm.Delta_T * Lm.Apeak then
		      Fsm_State := State11;
		   else
		      Fsm_State := State12;
		   end if;
		elsif Lm.D < Lm.Dmin then
		   Math324_325;
		   Fsm_State := State12;
		elsif Lm.Delta_S < Lm.Delta_Smin then
		   Fsm_State := State11;
		end if;
		
	     when State10 =>
		Math315_316;
		if Lm.D1 + Lm.D2 + Lm.D3 -Lm.D > 0.0 then
		   Math317_318;
		   Fsm_State := State10; -- watch the endless loop here;
		else
		   Qcp_Sap_B1 (Anchor      => Dll.Pq_Anchor,
			       Sinv_Flag   => False,
			       D1          => Lm.D1,
			       D2          => Lm.D2,
			       D3          => Lm.D3, -- d's from Math_315_316.
			       Delta_D     => Lm.D,
			       S1          => Lm.S1,
			       Sa          => Lm.Sa,
			       Sb          => Lm.Sb,
			       S2          => Lm.S2,
			       Amax        => Lm.Amax,
			       Delta_Tmax  => Lm.Delta_Tmax);
		   Fsm_State := State18;
		end if;
		
	     when State11 =>
		Math326_325;
		Fsm_State := State12;
		
	     when State12 =>
		Qcp_Ap_B2 (Anchor       => Dll.Pq_Anchor,
			   Sinv_Flag    => False,
			   Delta_D      => Lm.D,
			   S1           => Lm.S1,
			   Apeak        => Lm.Apeak,
			   Delta_T      =>Lm.Delta_T);
		Fsm_State := State18;
		
	     when State18 => exit;
	  end case;
      end loop;
      
   end Fsm;
   
   
   procedure Start (Inp : in  Sonja3_In_Type; Outp : out Qcp.Qcp_Type) 
   is
      Fsm_State : State_Type := State1;
   begin
      --Fsm_State := State1;
      Fsm (Inp => Inp, Fsm_State => Fsm_State);
   exception
      when others => null;
   end Start;
   
end Luthien.Sonja3.Main;
