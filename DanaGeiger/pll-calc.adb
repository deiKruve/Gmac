
-- to run:
-- ./plldes -j 0.522 -kd 4.7 -kt 27.0 -pm 45.0 -n 5000 -vcc 15.0 -hrpm 3000.0 -wc 1000.0


with Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

package body Pll.Calc is
   package Tio renames Ada.Text_IO;
   package Num is new Ada.Numerics.Generic_Elementary_Functions (Long_Float);
   ----------------------
   -- output variables --
   ----------------------
   A1,                         -- r26
     Km,                         -- r28
     Eta,                        -- r30
     Etah,
     Lrpm,                       -- r32
     Lrpmh,
     Wj,                         -- r34
     Wjh,
     Wch,
     Wy,                         -- r36
     Wm,                         -- r38
     D,                       -- r03
     Dh,
     Krho,
     Krhoh,
     Ki,
     Kih,
     G1,
     G1h,
     K,
     Kh       : Long_Float := 0.0; -- r46v
   
   
   ----------------------
   -- omega seed array --
   ----------------------
   --Omega : array (Positive range <>) of Long_Float := (10.0, 14.0, 20.0, 28.0, 40.0, 55.0, 750.0);
   Omega : array (Positive range <>) of Long_Float := 
     (1.00, 1.25, 1.60, 2.00, 2.50, 3.20, 4.00, 5.00, 6.30, 8.00);
   
   -------------
   -- utility --
   -------------
   Pi : Long_Float := Ada.Numerics.Pi;
   
   procedure Calc_Wj (Wj : in out Long_Float; Kd, J : in Long_Float)
   is
   begin
      Wj := ((Kd * 3.0) / (100.0 * Pi)) / J;
      --Tio.Put_Line ("wj   = " & Long_Float'Image (Wj));
   end Calc_Wj;
   
   
   procedure Calc_Eta (Eta : in out Long_Float; Wc, Wj, Pm : in Long_Float)
   is
      Eta0 : Long_Float := 1.1;
      Eta1 : Long_Float := 20.0;
      --E, now : Long_Float;
      
      procedure C_Eta (Lo, Hi : Long_Float)
      is
	 Ans,
	 E_Now : Long_Float;
      begin
	 E_Now := (Lo + Hi) / 2.0;
	 Ans := Num.Arctan (2.0 * E_now / (1.0 - E_now ** 2), 1.0, 360.0) - 
	   2.0 * Num.Arctan (1.0 / E_now, 1.0, 360.0) -
	   Num.Arctan (Wc / Wj, 1.0, 360.0) - Pm + 180.0;
	 --Tio.Put_Line ("ans = " & Long_Float'Image (ans));
	 if abs (Ans) < 5.0 * Long_Float'Epsilon then
	    Eta := E_Now;
	    return;
	 elsif Ans < 0.0 then
	    C_Eta (E_Now, Hi);
	 else 
	    C_Eta (Lo, E_Now);
	 end if;
      end C_Eta;
      
   begin
      C_Eta (Eta0, Eta1);
      --Tio.Put_Line ("eta  = " & Long_Float'Image (Eta));
   end Calc_Eta;
   
   
   procedure Calc_Wy_Wm (Wy, Wm : in out Long_Float; Wc, Eta : in Long_Float)
   is
   begin
      Wy := Wc / Eta;
      Wm := Eta * Wc;
      Tio.Put_Line ("wy   = " & Long_Float'Image (Wy));
      Tio.Put_Line ("wm   = " & Long_Float'Image (Wm));
   end Calc_Wy_Wm;
   
   
   procedure Calc_Km (km : in out Long_Float; 
		      Vcc, hrpm : in Long_Float; N : in positive)
   is
   begin
      Km := 30.0 * Vcc / (Pi * Hrpm * Long_Float (N));
      Tio.Put_Line ("km   = " & Long_Float'Image (Km));
   end Calc_Km;
   
   
   procedure Calc_Lrpm (Lrpm : in out Long_Float;
			Wc : in Long_Float; N : in positive)
   is
   begin
      Lrpm := 300.0 * Wc / (Pi * Long_Float (N));
      --Tio.Put_Line ("lrpm = " & Long_Float'Image (Lrpm));
   end Calc_Lrpm;
   
   
   procedure Calc_K (K      : in out Long_Float;
		     Wc, wj : in Long_Float)
   is
   begin
      K := Num.Sqrt ((Wc / Wj) ** 2 + 1.0);
      --Tio.Put_Line ("k    = " & Long_Float'Image (K));
   end Calc_K;
   
   
   function Ask_A1 (A1 : in out Long_Float) return Boolean
   is
   begin
      loop
	 Tio.Put ("Enter value for A1, or 'Enter' to exit >> ");
	 declare 
	    S : String := Tio.Get_Line;
	 begin
	    if S = "" then return False; end if;	       
	    A1 := Long_Float'Value (S);
	    exit;
	 exception
	    when others => Tio.Put_Line ("float value, or 'Enter' expected.");
	 end;
      end loop;
      return True;
   end Ask_A1;
   
   
   procedure Calc_D (d : in out Long_Float; 
		     k, kd, a1, Kt : in Long_Float; N : in Positive) 
   is  
   begin
      D := K * Kd * (3.0 / (Pi * 100.0)) / (A1 * Kt * Long_Float (N));
   end Calc_D;
   
   
   procedure Calc_Krho (krho   : in out Long_Float;
			Wc, Eta, d : in Long_Float)
   is
   begin
      Krho := (Wc / Eta) ** 2 * D;
      --Tio.Put_Line ("krho = " & Long_Float'Image (Krho));
   end Calc_Krho;
   
   
   procedure Calc_Ki (ki   : in out Long_Float;
		      Wc, Eta, D, Krho : in Long_Float)
   is
   begin
      Ki := 2.0 * Wc / Eta * D - Krho / Wc * (Eta - 1.0 / Eta);
      --Tio.Put_Line ("ki    = " & Long_Float'Image (Ki));
   end Calc_Ki;
   
   procedure Calc_G1 (g1   : in out Long_Float;
		      D, Ki, Eta, Wc, Krho, Km : in Long_Float)
   is
   begin
      G1 := (D - Ki / (Eta * Wc) - Krho / Wc ** 2) / Km;
      --Tio.Put_Line ("g1    = " & Long_Float'Image (G1));
   end Calc_G1;
   
   procedure Calc_Plot (Two : Boolean := false)
   is
      Tmp90,
      W,
      Angle0,
      Angle,                       -- phase angle at omega
      Angle2,
      Magn,                        -- vector magnitude for Nyquist in r05
      Magn2,
      Magn_Db,                     -- open loop magn, decibelized
      Magn2_Db,
      Cl_Resp,                     -- closed-loop response at omega;
      Cl_Resp2,
      Cl_Resp_Db,
      Cl_Resp2_Db : Long_Float := 0.0; -- closed-loop response at omega, decibelized;
   begin
      -- print column headings
      Tio.Put_Line ("#  rad/sec               angle'                  magnitude              magnitude db           closed-loop db response");
      
      while Cl_Resp_Db > -7.0 loop
	 for J in Omega'First .. Omega'Last loop
	    W := Omega (J);

	    -- calculate magnitude
	    Magn := (K * Num.Sqrt ((2.0 * W * Wy) ** 2 + (Wy ** 2 - W ** 2) ** 2)) / 
	      (W ** 2 * ((W / Wm) ** 2 + 1.0) * Num.Sqrt ((W / Wj) ** 2 + 1.0));
	    Magn_Db := Num.Log (Magn, 10.0) * 20.0;
	    if Two then
	       Magn2 := 
		 (Kh * Num.Sqrt ((2.0 * W * Wy) ** 2 + (Wy ** 2 - W ** 2) ** 2)) / 
		 (W ** 2 * ((W / Wm) ** 2 + 1.0) * Num.Sqrt ((W / Wjh) ** 2 + 1.0));
	       Magn2_Db := Num.Log (Magn2, 10.0) * 20.0;
	    end if;
	    
	    -- calculate angle
	    Tmp90 := Wy ** 2 - W ** 2;
	    if abs (Tmp90) < 5.0 * Long_Float'Epsilon then
	       Angle0 := 90.0;
	    else
	       Angle0 := Num.Arctan ((2.0 * W * Wy) / Tmp90 , 1.0, 360.0);
	       if Angle0 < 0.0 then
		  Angle0 := 180.0 + Angle0;
	       end if;
	    end if;
	    Angle := Angle0 - 180.0 - 2.0 * Num.Arctan (W / Wm, 1.0, 360.0) - 
	      Num.Arctan (W / Wj, 1.0, 360.0);
	    if Two then
	       Angle2 := Angle0 - 180.0 - 2.0 * Num.Arctan (W / Wm, 1.0, 360.0) - 
		 Num.Arctan (W / Wjh, 1.0, 360.0);
	    end if;
	    
	    -- calculate closed loop response
	    Cl_Resp := Magn / 
	      (Num.Sqrt (Magn ** 2 + 2.0 * Magn * Num.Cos (Angle, 360.0) + 1.0));
	    if Two then
	       Cl_Resp2 := Magn2 / 
		 (Num.Sqrt (Magn2 ** 2 + 2.0 * Magn2 * Num.Cos (Angle2, 360.0) + 1.0));
	    end if;
	    
	    -- make decibels
	    Cl_Resp_Db := Num.Log (Cl_Resp, 10.0) * 20.0;
	    if Two then
	       Cl_Resp2_Db := Num.Log (Cl_Resp2, 10.0) * 20.0;
	    end if;
	    
	    -- print neat columns
	    Tio.Put ("  " & Long_Float'Image (W) & "  " &       -- 1
		       Long_Float'Image (Angle) & "  " &        -- 2
		       Long_Float'Image (Magn) & "  " &         -- 3
		       Long_Float'Image (Magn_Db) & "  " &      -- 4
		       Long_Float'Image (Cl_Resp_Db) & "  " &   -- 5
		       Long_Float'Image (Cl_Resp));             -- 6
	    
	    if Two then
	       Tio.Put_Line ("  " & Long_Float'Image (Angle2) & "  " &   -- 7
			       Long_Float'Image (Magn2) & "  " &         -- 8
			       Long_Float'Image (Magn2_Db) & "  " &      -- 9
			       Long_Float'Image (Cl_Resp2_Db));           -- 10
	    else
	       Tio.Put_Line ("");
	    end if;
	    
	    null;
	 end loop;
	 for J in Omega'First .. Omega'Last loop
	    Omega (J) := Omega (J) * 10.0;
	 end loop;
      end loop;
   end Calc_Plot;
   
   procedure Calc_Write_Maxima (Two : Boolean := false)
   is
   begin
      Tio.Put_Line ("# command lines for Maxima: ");
      Tio.Put_Line ("");
      Tio.Put_Line ("# load (coma);");
      Tio.Put_Line ("");
      Tio.Put_Line ("Gs:" & Long_Float'Image (K) & "*((s^2+2*s*" & Long_Float'Image (Wy) & "+" & Long_Float'Image (Wy) & "^2) / (s^2*(s*1/" & Long_Float'Image (Wm) & "+1)*(s*1/" & Long_Float'Image (Wm) & "+1)*(s*1/" & Long_Float'Image (Wj) & "+1)));");
      Tio.Put_Line ("");
      Tio.Put_Line ("Fs: Gs / (1+Gs);");
      Tio.Put_Line ("");
      Tio.Put_Line ("step_response (Fs);");
      Tio.Put_Line ("");
      
      if Two then
	 Tio.Put_Line ("Gs2:" & Long_Float'Image (Kh) & "*((s^2+2*s*" & Long_Float'Image (Wy) & "+" & Long_Float'Image (Wy) & "^2) / (s^2*(s*1/" & Long_Float'Image (Wm) & "+1)*(s*1/" & Long_Float'Image (Wm) & "+1)*(s*1/" & Long_Float'Image (Wjh) & "+1)));");
	 Tio.Put_Line ("");
	 Tio.Put_Line ("Fs2: Gs2 / (1+Gs2);");
	 Tio.Put_Line ("");
	 Tio.Put_Line ("step_response (Fs2);");
	 Tio.Put_Line ("");
      end if;
      
   end Calc_Write_Maxima;
   
   
   procedure Calcit (J, Kd, Kt, Pm, Vcc, Hrpm, Wc : Long_Float; N : Positive) 
   is
   begin
      Calc_Wj (Wj, Kd, J);
      Tio.Put_Line ("wj   = " & Long_Float'Image (Wj));
      Calc_Eta (Eta, Wc, Wj, Pm);
      Tio.Put_Line ("eta  = " & Long_Float'Image (Eta));
      Calc_Wy_Wm (Wy, Wm, Wc, Eta);
      Calc_Km (Km, Vcc, Hrpm, N);
      Calc_Lrpm (Lrpm, Wc, N);
      Tio.Put_Line ("lrpm = " & Long_Float'Image (Lrpm));
      Calc_K (K, Wc, Wj);
      Tio.Put_Line ("k    = " & Long_Float'Image (K));
      loop
	 exit when Ask_A1 (A1) = False;
	 Calc_D (D, K, Kd, A1, Kt, N);
	 Calc_Krho (Krho, Wc, Eta, D);
	 Tio.Put_Line ("krho = " & Long_Float'Image (Krho));
	 Calc_Ki (Ki, Wc, Eta, D, Krho);
	 Tio.Put_Line ("ki   = " & Long_Float'Image (Ki));
	 Calc_G1 (G1, D, Ki, Eta, Wc, Krho, Km);
	 Tio.Put_Line ("g1   = " & Long_Float'Image (G1));
      end loop;
      Calc_Plot (False);
      Calc_Write_Maxima (False);
      null;
   end Calcit;
   
   
   procedure Calc_Hl (J, jh, Kd, Kt, Pm, Vcc, Hrpm, Wc : Long_Float; N : Positive)
   is
   begin
      Calc_Wj (Wj, Kd, J);
      Tio.Put_Line ("wjl   = " & Long_Float'Image (Wj));
      Calc_Wj (Wjh, Kd, Jh);
      Tio.Put_Line ("wjh  = " & Long_Float'Image (Wjh));
      Wch := Wc *  Wjh / Wj;
      Tio.Put_Line ("wch  = " & Long_Float'Image (Wch));
      if Wj > Wch then 
	 Tio.Put_Line ("No design possible,  Wj > Wch. ");
	 return;
      elsif Wj > Wch / 3.0 then
	 Wy := Wj;
      else
	 Wy := Wch / 3.0;
      end if;
      Tio.Put_Line ("wy   = " & Long_Float'Image (Wy));
      Wm := 3.0 * Wc;
      Tio.Put_Line ("wm   = " & Long_Float'Image (Wm));
      Calc_Eta (Eta, Wc, Wj, Pm);
      Tio.Put_Line ("etal  = " & Long_Float'Image (Eta));
      Calc_Eta (Etah, Wch, Wjh, Pm);
      Tio.Put_Line ("etah  = " & Long_Float'Image (Etah));
      Calc_Km (Km, Vcc, Hrpm, N);
      Calc_Lrpm (Lrpm, Wc, N);
      Tio.Put_Line ("lrpml = " & Long_Float'Image (Lrpm));
      Calc_Lrpm (Lrpmh, Wch, N);
      Tio.Put_Line ("lrpmh = " & Long_Float'Image (Lrpmh));
      Calc_K (K, Wc, Wj);
      Tio.Put_Line ("kl    = " & Long_Float'Image (K));
      Calc_K (Kh, Wch, Wjh);
      Tio.Put_Line ("kh    = " & Long_Float'Image (Kh));
      loop
	 exit when Ask_A1 (A1) = False;
	 Calc_D (D, K, Kd, A1, Kt, N);
	 Calc_D (Dh, Kh, Kd, A1, Kt, N);
	 Calc_Krho (Krho, Wc, Eta, D);
	 Tio.Put_Line ("krhol = " & Long_Float'Image (Krho));
	 Calc_Krho (Krhoh, Wch, Etah, Dh);
	 Tio.Put_Line ("krhoh = " & Long_Float'Image (Krhoh));
	 Calc_Ki (Ki, Wc, Eta, D, Krho);
	 Tio.Put_Line ("kil   = " & Long_Float'Image (Ki));
	 Calc_Ki (Kih, Wch, Etah, Dh, Krhoh);
	 Tio.Put_Line ("kih   = " & Long_Float'Image (Kih));
	 Calc_G1 (G1, D, Ki, Eta, Wc, Krho, Km);
	 Tio.Put_Line ("g1l   = " & Long_Float'Image (G1));
	 Calc_G1 (G1h, Dh, Kih, Etah, Wch, Krhoh, Km);
	 Tio.Put_Line ("g1h   = " & Long_Float'Image (G1h));
      end loop;
      Calc_Plot (True);
      Calc_Write_Maxima (True);
   end Calc_Hl;
   
end Pll.Calc;
