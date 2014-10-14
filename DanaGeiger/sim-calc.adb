with Ada.Calendar;
with Ada.Numerics;

package body Sim.Calc is
   package Cal renames Ada.Calendar;
   Pi : Long_Float := Ada.Numerics.Pi;
   
   
   task body Simulate --motor
      is
      use type Cal.Time;
      Jm, Jl, 
	Kdw, Kt, 
	Tf, Tl, 
	Tg      : Long_Float := 0.0;
      Iin       : Long_Float := 0.0;
      Wacc, W   : Long_Float; -- hoekversnelling en hoeksnelheid
      Pos       : Long_Float := 0.0;  -- radians
      N         : Integer    := 0;  -- lines per rev
      Running, 
      Done      : Boolean    := False;
      Period    : Duration   := 0.000_300; -- secs
      --Period    : Duration   := 1.0;
      Next_Time : Cal.Time   := Cal.Clock + period;
   begin
      while not Done loop
	 select
	    when not Running =>
	       accept Start (Jmi, Jli, Kti, Kdwi, Tfi, Tli : Long_Float; 
			     Ni : integer) do
		  Jm := Jmi;
		  Jl := Jli;
		  Kt := Kti;
		  Kdw := Kdwi;
		  Tf := Tfi;
		  Tl := Tli;
		  N := Ni;
		  W := 0.0;
		  Wacc := 0.0;
		  Pos := 0.0;
		  Running := True;
		  Next_Time := Cal.Clock + Period;
	       end Start;
	       
	 or
	    when Running =>
	       accept Stop do
		  W := 0.0;
		  Pos := 0.0;
		  Running := False;
		  Done := True;
	       end Stop;
	 or
	    when Running =>
	       accept Get_Pos (Encpos : in out Long_Integer) do
		  Encpos := Long_Integer (Pos * Long_Float (N)/ 2.0 / Pi);
	       end Get_Pos;
	 or
	    when Running =>
	       accept Set_Current (Inow : in Long_Float) do
		  Iin := Inow;
	       end Set_Current;
	 or
	    delay until (Next_Time);
	    if Running then
	       --updaate motor outputs
	       Tg := Iin * Kt;
	       Wacc := (Tg - Tf - Tl - Kdw * w) / (Jm + Jl); -- 
	       Pos := Pos + W * Long_Float (Period) + 
		 0.5 * Wacc * Long_Float (Period) ** 2;
	       W := W + Wacc * Long_Float (Period);
	    end if;
	    Next_Time := Cal.Clock + Period;
	 end select;
	 
	 --Done_Time := Cal.Clock;
	 --Tio.Put_Line ("Scan Time : " & Duration'Image (Done_Time - This_Time));
      end loop;
   end Simulate;
   
 end Sim.Calc;  
