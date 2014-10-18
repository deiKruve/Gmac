with Ada.Calendar;
with Ada.Numerics;

package body Sim.Calc is
   package Cal renames Ada.Calendar;
   Pi : Long_Float := Ada.Numerics.Pi;
   
   
   ---------------------
   -- motor Simulator --
   ---------------------
   task body Simulate 
      is
      use type Cal.Time;
      Jm, Jl, 
	Kdw, Kt, 
	Tf, Tl, 
	Tg      : Long_Float := 0.0;
      Iin       : Long_Float := 0.0;
      Wacc, W   : Long_Float; -- hoekversnelling en hoeksnelheid
      Pos       : Long_Float := 0.0;  -- motor position in radians
      N         : Long_Integer    := 0;  -- encoder lines per rev
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
		  Jm        := Jmi;
		  Jl        := Jli;
		  Kt        := Kti;
		  Kdw       := Kdwi;
		  Tf        := Tfi;
		  Tl        := Tli;
		  N         := Long_Integer (Ni);
		  W         := 0.0;
		  Wacc      := 0.0;
		  Pos       := 0.0;
		  Running   := True;
		  Next_Time := Cal.Clock + Period;
	       end Start;
	 or
	    when Running =>
	       accept Stop do
		  W       := 0.0;
		  Pos     := 0.0;
		  Running := False;
		  Done    := True;
	       end Stop;
	 or
	    when Running =>
	       -- in reality this is read from some u/d counter so this is correct
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
	       Tg   := Iin * Kt;
	       Wacc := (Tg - Tf - Tl - Kdw * w) / (Jm + Jl); -- 
	       Pos  := Pos + W * Long_Float (Period) + 
		 0.5 * Wacc * Long_Float (Period) ** 2;
	       W    := W + Wacc * Long_Float (Period);
	    end if;
	    Next_Time := Cal.Clock + Period;
	 end select;
	 
	 --Done_Time := Cal.Clock;
	 --Tio.Put_Line ("Scan Time : " & Duration'Image (Done_Time - This_Time));
	 if Done then exit; end if;
      end loop;
   end Simulate;
   
   
   ---------------------
   -- Drive simulator --
   ---------------------
   type Unsigned32 is mod 2 ** 32;
   
   -- global variables -- 
   Epl_Period          : Duration   := 0.001;   -- written during phase 1 I presume
   Request_Init        : Boolean    := False;
   
   T_Period,
   T_Half_Period       : Duration   := 0.0;
   T_Vcc,        
   T_Max_Current,
   T_Hrpm,       
   T_Kp,         
   T_Kpit,       
   T_Phi_Kp,     
   T_Phi_Kpit          : Long_Float := 0.0;
   T_N                 : Positive   := 1;
   Request_Update_Pars : Boolean    := False;
   
   Request_Sync_Time   : Boolean    := False;
   
   T_Phi_Soll,
   T_Phi_Ist,
   T_Phi_Delta         : Long_Float := 0.0;
   Request_Update_Phi  : Boolean    := False;
   
   
   -- init request, must happen in pre-op 1 --
   -- NMT_CycleLen_U32 is in usec
   procedure Set_Init_Pars (NMT_CycleLen_U32 : Unsigned32; Vperiod : Duration)
   is
   begin
      Epl_Period    := Duration (NMT_CycleLen_U32) / 1000_000.0; -- in seconds
      T_Period      := Vperiod;
      T_Half_Period := Vperiod / 2.0;
      Request_Init  := True;
   end Set_Init_Pars;
   
   
   -- temp store for new parameters --
   procedure Set_New_Pars (VPeriod : Duration;
			       Vvcc, Vhrpm, Va1, Vkrho, Vki, Vg1 : Long_Float;
			       Vn : Positive)
   is
   begin
      T_Period      := Vperiod;
      T_Vcc         := Vvcc;
      T_Max_Current := Vmax_Current;
      T_Hrpm        := Vhrpm;
      T_Kp          := Vkp * vA1;
      T_Kpit        := Kp + Vki * Long_Float (T_Period) * vA1;
      T_Phi_Kp      := Vkp_Phi * Va1;
      T_Phi_Kpit    := T_Phi_Kp + VKi_Phi * Long_Float (T_Period) * vA1;
      T_N           := Vn;
      Request_Update_Pars := True;
   end Set_New_Pars;
   
   
   -- temp store the destination for the end of the next epl_period
   -- the drive will update at the next sync with the delta.
   -- this delta will be used to advance the dest every scan until 
   -- a valid new pair of destination and sync pulse have been given.
   procedure Set_New_Dest (Position : Long_Float)
   is
   begin
      T_Phi_Soll         := Position;
      Request_Update_Phi := True;
   end Set_New_Dest;
   
   
   -- returns Position at the last sync pulse
   procedure Get_Position (Position : in out Long_Float)
   is
   begin
      Position := T_Phi_Ist;
   end Get_Position;
   

   task body Drive_Sim 
      is
      use type Cal.Time;
      N          : Positive   := 1;
      Vcc, Hrpm, 
	--A1, Krho, 
	--Ki, G1   : Long_Float := 0.0;
	Kp, Kpit,
	Phi_Kp, Phi_Kpit : Long_Float := 0.0;
      Enabled,
      Done       : Boolean    := False;
      Period     : Duration   := 0.001_000; -- secs
					   --Period    : Duration   := 1.0;
      Next_Time  : Cal.Time   := Cal.Clock + period;
      
      -- running vars --
      Phi_Ist,    -- does this need a start position?! ---------------------
      Phi_Soll,
      Phi_Delta,
      Tmp,
      Phi_Error,
      Phi_Error_Last,
      Omega_Error,
      Omega_Error_Last,
      Max_Current,
      Co                : Long_Float := 0.0;
      
      -- syncing vars
      Sync_Time,
      Next_Time_Last : Cal.Time;
      Sigma_Diff_T,
      Diff_T,
      Up_Lim,
      Lo_Lim,
      Up_Lim_Base,
      Lo_Lim_Base    : Duration := 0.000_000_100; 
   begin
      while not Done loop
	 select
	    when not Enabled =>
	       accept Start 
		 (VPeriod                           : Duration;
		  Vvcc, vMax_Current, Vhrpm, 
		    Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float;
		  Vn                                : Positive)
	      do
		 Period      := Vperiod;
		 Vcc         := Vvcc;
		 Max_Current := Vmax_Current;
		 Hrpm        := Vhrpm;
		 Kp          := Vkp * vA1;
		 Kpit        := Kp + Vki * Long_Float (Period) * vA1;
		 Phi_Kp      := Vkp_Phi * Va1;
		 Phi_Kpit    := Phi_Kp + VKi_Phi * Long_Float (Period) * vA1;
		 N           := Vn;
		 
		 Phi_Ist        := 0.0;
		 Phi_Soll       := 0.0;
		 Phi_Delta      := 0.0;
		 Phi_Error      := 0.0;
		 Phi_Error_Last := 0.0;
		 Enabled        := True;
	      end Start;
	 or
	    when Enabled =>
	      accept Stop do
		 Done := True;
	      end Stop;
	 or 
	    accept Sync_Pulse do
	       Sync_Time := Cal.Clock;
	       Simulate.Get_Pos (Long_Integer (T_Phi_Ist)); -- get motor position
	       Request_Sync_Time := True;
	       if Request_Update_Phi then
		  Tmp := (T_Phi_Soll - Phi_Soll) * T_Period / Epl_period;
		  if abs (Tmp) > abs (Phi_Delta) / 2.0 then
		     Phi_Delta := Tmp; -- we have a valid new position
		  end if; -- else we did not get, carry on with the old delta.
		  Request_Update_Phi := False;
	       end if; -- Request_Update_Phi
	       if Request_Update_Pars then
		  Period      := T_Period;
		  Vcc         := T_Vcc;
		  Max_Current := T_Max_Current;
		  Hrpm        := T_Hrpm;
		  Kp          := T_Kp;
		  Kpit        := T_Kpit;
		  Phi_Kp      := T_Phi_Kp;
		  Phi_Kpit    := T_Phi_Kpit;
		  N           := T_N;
		  Request_Update_Pars := False;
	       end if; -- Request_Update_Pars
	       if Request_Init then
		  Next_Time    := Cal.Clock + T_Half_Period;
		  Next_Time_Last := Next_Time - T_Period;
		  Enabled      := False;
		  Period       := T_Period;
		  Request_Init := False;
	       end if;
	    end Sync_Pulse;
	 or
	    delay until (Next_Time);
	    if Enabled then
	       Simulate.Get_Pos (Long_Integer (Phi_Ist)); -- get motor position
	       Phi_Error   := Phi_Soll - Phi_Ist;     -- posistion error
	       Omega_Error := Phi_Error - Phi_Error_Last; -- speed error
	       
	       -- this implements 2 PI controllers
	       --  Omega for speed
	       --  and Phi for position.
	       Co := Co + Omega_Error * Kpit - Omega_Error_Last * Kp + 
		 Phi_Error * Phi_Kpit - Phi_Error_Last * Phi_Kp;
	       
	       Omega_Error_Last := Omega_Error;
	       Phi_Error_Last := Phi_Error;
	       Phi_Soll := Phi_Soll + Phi_Delta; -- move the destination fwd
	       
	       if Co > +Max_Current    then Co := Max_Current;
	       elsif Co < -Max_Current then Co := -Max_Current;
	       end if; -- anti windup;

	       Simulate.Set_Current (Co);
	    else 
	       Simulate.Set_Current (0.0);
	    end if; -- enabled
		 -- sync the sample clock to the EPL cycle
	    if Request_Sync_Time then
	       Sigma_Diff_T := Sigma_Diff_T + (Sync_Time - Next_Time_Last) + 
		 (Next_Time - Sync_Time);
	       Diff_T := Sigma_Diff_T / 100.0;
	       if Diff_T > Up_Lim then 
		  Period := Period - 0.000_000_010;
		  Up_Lim := Up_Lim + 0.000_000_002;
	       elsif Diff_T < Up_Lim_Base then
		  Up_Lim := Up_Lim_Base;
	       elsif Diff_T < Lo_Lim then
		  Period := Period + 0.000_000_010;
		  Lo_Lim := Lo_Lim - 0.000_000_002;
	       elsif Diff_T > Lo_Lim_Base then
		  Lo_Lim := Lo_Lim_Base;
	       end if;
	       Request_Sync_Time := False;
	    end if; -- Request_Sync_Time

	    Next_Time_Last := Next_Time;
	    Next_Time := Next_Time + Period;
	    --delay until (Next_Time);
	 end select;
	 if Done then exit; end if;
      end loop;
   end Drive_Sim;
   
   task body Cnc_Sim is
   begin
      null;
   end Cnc_Sim;
   
 end Sim.Calc;  
