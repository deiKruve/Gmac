with Ada.Calendar;
with Ada.Real_Time;
with Ada.Numerics;
with Ada.Text_Io;

package body Sim.Calc is
   package Cal renames Ada.Calendar;
   package Art renames Ada.Real_Time;
   package Tio renames Ada.Text_Io;
   
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
  
   -- global variables -- 
   
   -- errors
   Drive_Limit_Error   : Boolean := False;

   
   Epl_Period          : Duration   := 0.001;   -- written during phase 1 I presume
   T_Period,
   T_Half_Period       : Duration   := 0.0;
   T_Max_Limt          : Duration   := 0.0;
   Request_Init        : Boolean    := False;
   
   T_Vcc,        
   T_Max_Current,
   T_Kp,         
   T_Kpi,       
   T_Phi_Kp,     
   T_Phi_Kpi           : Long_Float := 0.0;
   T_N                 : Positive   := 1;
   Request_Update_Pars : Boolean    := False;
   
   Request_Sync_Time   : Boolean    := False;
   
   Phi_Delta_Scaler,
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
      Phi_Delta_scaler := Long_Float (T_Period) / Long_Float (Epl_Period);
   end Set_Init_Pars;
   
   
   -- temp store for new parameters --
   procedure Set_New_Pars (Vvcc, Vmax_Current, Vmax_limt, 
			     Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float)
   is
   begin
      T_Vcc         := Vvcc;
      T_Max_Current := Vmax_Current;
      T_Max_Limt    := Duration (Vmax_Limt);
      T_Kp          := Vkp * vA1;
      T_Kpi         := T_Kp + Vki * Long_Float (T_Period) * vA1;
      T_Phi_Kp      := Vkp_Phi * Va1;
      T_Phi_Kpi     := T_Phi_Kp + VKi_Phi * Long_Float (T_Period) * vA1;
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
   
   procedure Get_Errors (Drive_Limit : in out Boolean)
   is
   begin
      Drive_Limit := Drive_Limit_Error;
   end Get_Errors;
   

   task body Drive_Sim 
      is
      use type Cal.Time;
      -- hardware bridge enable
      Bridge_Enable     : Boolean := False;
      
      N          : Positive   := 1;
      Vcc, 
	Kp, Kpi,
	Phi_Kp, Phi_Kpi : Long_Float := 0.0;
      Enabled,
      Done       : Boolean    := False;
      Period     : Duration   := 0.001_000; -- secs
      Max_Limt   : Duration   := 0.0;
      Next_Time  : Cal.Time   := Cal.Clock + period;
      
      -- running vars --
      Phi_Ist,    -- does this need a start position?! Yah zero on Start-
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
		 ( Vvcc, vMax_Current, Vmax_limt, 
		    Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float;
		  Vn                                : Positive)
	      do
		 Vcc         := Vvcc;
		 Max_Current := Vmax_Current;
		 
		 T_Max_Limt  := Duration (Vmax_Limt);
		 Max_limt    := T_Max_Limt;
		 Kp          := Vkp * vA1;
		 Kpi         := Kp + Vki * Long_Float (Period) * vA1;
		 Phi_Kp      := Vkp_Phi * Va1;
		 Phi_Kpi     := Phi_Kp + VKi_Phi * Long_Float (Period) * vA1;
		 N           := Vn;
		 
		 Phi_Ist        := 0.0;
		 
		 Phi_Soll       := 0.0;
		 Phi_Delta      := 0.0;
		 Phi_Error      := 0.0;
		 Phi_Error_Last := 0.0;
		 Enabled        := True;
		 Bridge_Enable  := True;
	      end Start;
	 or
	    when Enabled =>
	       accept Stop do
		  Bridge_Enable := False;
		  Done := True;
	       end Stop;
	 or 
	    accept Sync_Pulse do
	       Sync_Time := Cal.Clock;
	       Simulate.Get_Pos (Long_Integer (T_Phi_Ist)); -- get motor position
	       Request_Sync_Time := True;
	       if Request_Update_Phi then
		  Tmp := (T_Phi_Soll - Phi_Soll) * Phi_Delta_Scaler;
		  if abs (Tmp) > abs (Phi_Delta) / 2.0 then
		     Phi_Delta := Tmp; -- we have a valid new position
		  end if; -- else we did not get, carry on with the old delta.
		  Request_Update_Phi := False;
	       end if; -- Request_Update_Phi
	       if Request_Update_Pars then
		  Vcc         := T_Vcc;
		  Max_Current := T_Max_Current;
		  Max_limt    := T_Max_Limt;
		  Kp          := T_Kp;
		  Kpi         := T_Kpi;
		  Phi_Kp      := T_Phi_Kp;
		  Phi_Kpi     := T_Phi_Kpi;
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
	       Omega_Error := Phi_Error - Phi_Error_Last; -- speed error * period
	       
	       -- this implements 2 PI controllers
	       --  Omega for speed
	       --  and Phi for position.
	       Co := Co + Omega_Error * Kpi - Omega_Error_Last * Kp + 
		 Phi_Error * Phi_Kpi - Phi_Error_Last * Phi_Kp;
	       
	       Omega_Error_Last := Omega_Error;
	       Phi_Error_Last   := Phi_Error;
	       Phi_Soll         := Phi_Soll + Phi_Delta; -- move the destination fwd
	       
	       if Co > +Max_Current    then 
		  Co         := Max_Current;
		  Max_Limt   := Max_Limt - Period;
	       elsif Co < -Max_Current then 
		  Co         := -Max_Current;
		  Max_Limt   := Max_Limt - Period;
	       else Max_Limt := T_Max_Limt;
	       end if; -- anti windup;
	       if Max_Limt < 0.0 then
		  Bridge_Enable     := False;
		  Drive_Limit_Error := True;
		  Enabled           := False;
		  Co                := 0.0;
	       end if;
	       -----we also need following error here
	       
	       Simulate.Set_Current (Co);
	    else 
	       Simulate.Set_Current (0.0);
	    end if; -- enabled
		 -- sync the sample clock to the EPL cycle
	    if Request_Sync_Time then
	       Sigma_Diff_T := Sigma_Diff_T + (Next_Time - Sync_Time) - 
		 (Sync_Time - Next_Time_Last);
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
   
   
   -------------------
   -- cnc simulator --
   -------------------
   
   -- global variables --
   Log_Time,                     -- next time to take a log.
   Epl_Sync_Time,                -- when the next sync pulse will happen
   Epl_Req_Time  : Cal.Time;     -- when the next update will happen
   Start_Ready   : Integer := 0; -- crude attempt at pre operational phases
   
   -- motor parameter intermediate storage
   M_Jm,
   M_Jl,
   M_Kt,
   M_Kdw,
   M_Tf,
   M_Tl  : Long_Float := 0.0;
   M_N   : Positive   := 1;
   
   -- drive parameter intermediate storage.
   C_Vcc,         
   C_Max_Current, 
   C_Max_Limt,    
   C_A1,          
   C_Kp_Phi,      
   C_Ki_Phi,      
   C_Kp,          
   C_Ki            : Long_Float := 0.0;             
   C_N            : Positive    := 1;           
   
   -- prepare the motor for running
   procedure Set_Motor_Details (vJm, vJl, vKt, vKdw, vTf, vTl : Long_Float; 
				vN : integer)
   is
   begin
      M_Jm  := Vjm;  
      M_Jl  := Vjl;
      M_Kt  := Vkt;
      M_Kdw := Vkdw;
      M_Tf  := Vtf; 
      M_Tl  := Vtl;
      M_N   := Vn;
      Start_Ready := Start_Ready + 1;
   end Set_Motor_Details;
   
   procedure Set_Drive_Details (Vvcc, vMax_Current, Vmax_limt, 
				 Va1, Vkp_Phi, Vki_Phi, Vki, Vkp : Long_Float;
				Vn                                : Positive)
   is
   begin
      C_Vcc         := Vvcc;
      C_Max_Current := Vmax_Current;
      C_Max_Limt    := Vmax_Limt;
      C_A1          := Va1;
      C_Kp_Phi      := Vkp_Phi;
      C_Ki_Phi      := Vki_Phi;
      C_Kp          := Vkp;
      C_Ki          := Vki;
      C_N           := Vn;
      Start_Ready   := Start_Ready + 1;
   end Set_Drive_Details;
   
   
   task body Cnc_Sim 
      is
      use type Cal.Time;
      use type Art.Time_Span;
      Link_Enabled,
      Enabled,
      Done          : Boolean := False;
      
      Drive_Period,                -- EPL scan period
      Running,                     -- how long the test has been running.
      Run_Period,                  -- period the test will run, from the commandline
      Log_Interval,                -- time between speed log points.
      S_Period      : Duration   := 0.0; -- test square wave period
      S_Speed       : Long_Float := 0.0; -- test square wave amplitude
					 -- so the destination is advanced by 
					 -- s_speed * epl scan period each scan.
      
      Position      : Long_Float := 0.0; -- position at the last sync
      
   begin
      while not Done loop
	 select
	    when Start_Ready = 2  =>
	       accept Start_Link (Dperiod, Eplperiod : Duration)
	       do
		  Epl_Period   := Eplperiod;
		  Drive_Period := Dperiod;
		  -- start motor simulation
		  Simulate.Start (M_Jm, M_Jl, M_Kt, M_Kdw, M_Tf, M_Tl, M_N);
		  -- eplink and sync parms to the drive
		  Set_Init_Pars (Unsigned32 (Eplperiod * 1000_000.0), Dperiod);
		  null;
		  delay Eplperiod;
		  Epl_Sync_Time := Cal.Clock;
		  Epl_Req_Time := Cal.Clock + 1.5 * Eplperiod;
		  Link_Enabled := True;
		  Start_Ready := Start_Ready + 1;
		  --delay Eplperiod;
	       end Start_Link;
	 or
	    when Start_Ready = 3  =>
	       accept Start_Sim (Runperiod, Speriod, Loginterval : Duration; 
				 Sspeed : Long_Float)
	       do
		  Running      := 0.0;  -- start time
		  Run_Period   := Runperiod;
		  Log_Interval := Loginterval;
		  Log_Time     := Cal.Clock + Log_Interval;
		  S_Period     := Speriod;
		  S_Speed      := S_Speed;
		  Enabled      := True;
	       end Start_Sim;
	 or
	    when Enabled =>
	       accept Stop
	       do
		  Running       := 0.0;
		  Run_Period    := 0.0;
		  S_Period      := 0.0;
		  S_Speed       := 0.0;
		  Enabled := False;
		  Done := True;
		  null;
	       end Stop;
	 or
	    when Link_Enabled =>
	       delay until Epl_Sync_Time;
	       Drive_Sim.Sync_Pulse;
	       Epl_Sync_Time := Epl_Sync_Time + Epl_Period;
	 or 
	    when Link_Enabled =>
	       delay until Epl_Req_Time;
	       Get_Position (Position);
	       if Enabled then
		  if Running < Run_Period then
		     if (Art.To_Time_Span (Running) - 
			   ((Art.To_Time_Span (Running) / 
			       Art.To_Time_Span (S_Period)) * 
			      Art.To_Time_Span (S_Period))) < 
		       (Art.To_Time_Span (S_Period) / 2) 
		     then
			Set_New_Dest (S_Speed * Long_Float (Running));
		     else
			Set_New_Dest (-S_Speed * Long_Float (Running));
		     end if;
		     Running := Running + Drive_Period;
		  else
		     Set_New_Dest (0.0);
		     Enabled := False;
		  end if; -- running loop
	       end if; -- enabled
	       Epl_Req_Time:= Epl_Req_Time + Drive_Period;
	 or 
	    when Enabled =>
	       delay until Log_Time;
	       Tio.Put_Line (Duration'Image (Running) & " " & 
			       Long_Float'Image (Position));
	 end select;
	 if Done then exit; end if;
      end loop;
   end Cnc_Sim;
   
 end Sim.Calc;  
