with Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

package body Pll.Calc is
   package Tio renames Ada.Text_IO;
   package Num is new Ada.Numerics.Generic_Elementary_Functions (Long_Float);
   ----------------------
   -- output variables --
   ----------------------
   A1,
   Km,
   Eta,
   Lrpm,
   Wj,
   Wy,
   Wm,
   Krho,
   Ki,
   G1,
   K      : Long_Float := 0.0;
   
   
   -------------
   -- utility --
   -------------
   Pi : Long_Float := Ada.Numerics.Pi;
   
   procedure Calc_Wj (Wj : in out Long_Float; Kd, J : in Long_Float)
   is
   begin
      Wj := ((Kd * 3.0) / (100.0 * Pi)) / J;
      Tio.Put_Line ("wj   = " & Long_Float'Image (Wj));
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
      --  E := Eta0;
      --  Now := Num.Arctan (2.0 * E / (1.0 - E ** 2), 1.0, 360.0) - 
      --  	2.0 * Num.Arctan (1.0 / E, 1.0, 360.0) -
      --  	Num.Arctan (Wc / Wj, 1.0, 360.0) - Pm + 180.0;
      --Tio.Put_Line ("Now0 = " & Long_Float'Image (Now));
      --  E := Eta1;
      --  Now := Num.Arctan (2.0 * E / (1.0 - E ** 2), 1.0, 360.0) - 
      --  	2.0 * Num.Arctan (1.0 / E, 1.0, 360.0) -
      --  	Num.Arctan (Wc / Wj, 1.0, 360.0) - Pm + 180.0;
      --Tio.Put_Line ("Now1 = " & Long_Float'Image (Now));
      C_Eta (Eta0, Eta1);
      Tio.Put_Line ("eta  = " & Long_Float'Image (Eta));
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
      Tio.Put_Line ("lrpm = " & Long_Float'Image (Lrpm));
   end Calc_Lrpm;
   
   
   procedure Calc_K (K      : in out Long_Float;
		     Wc, wj : in Long_Float)
   is
   begin
      K := Num.Sqrt ((Wc / Wj) ** 2 + 1.0);
      Tio.Put_Line ("k    = " & Long_Float'Image (K));
   end Calc_K;
   
   
   procedure Calcit (J, Kd, Kt, Pm, Vcc, Hrpm, Wc : Long_Float; N : Positive) 
   is
   begin
      Calc_Wj (Wj, Kd, J);
      Calc_Eta (Eta, Wc, Wj, Pm);
      Calc_Wy_Wm (Wy, Wm, Wc, Eta);
      Calc_Km (Km, Vcc, Hrpm, N);
      Calc_Lrpm (Lrpm, Wc, N);
      Calc_K (K, Wc, Wj);
      
      null;
   end Calcit;
   
   
end Pll.Calc;
