
package Pll.Calc is
   
   ---------------------------------------
   -- procedure Calcit,                 -- 
   -- used for single moment of inertia --
   ---------------------------------------
   procedure Calcit (J, Kd, Kt, Pm, Vcc, Hrpm, Wc : Long_Float; N : Positive);
   
   ----------------------------------------------------
   -- procedure Calc_Hl,                             --
   -- used where there is a  moment of inertia range --
   -- j has the low end of the range,                --
   -- jh has the high end of the range               --
   ----------------------------------------------------
   procedure Calc_Hl (J, jh, Kd, Kt, Pm, Vcc, Hrpm, Wc : Long_Float; N : Positive);
   
end Pll.Calc;
