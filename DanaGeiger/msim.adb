with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Sim.Calc;

procedure Msim is
   package Acl renames Ada.Command_Line;
   package Tio renames Ada.Text_IO;
   
   ---------------------
   -- input variables --
   ---------------------
   vJ,                            -- r 10
   VJh,
   vKd,                           -- r 12
   vKt,                           -- r 14
   vPm   : Long_Float := 0.0;     -- r 16
   vN    : Positive := 1;         -- r 18
   vVcc,                          -- r 20
   vHrpm,                         -- r 22
     vWc   : Long_Float := 0.0;     -- r 24
   
   vA1,
   vKrho,
   vKi,
   vG1   : Long_Float := 0.0; -- gain factors from plldes.
   
   vTf   : Long_Float := 0.0; -- total friction torque (tf + tl).
   
   Runperiod : Long_Float := 0.0; -- in secs, duration of the test.
   Logperiod : Long_Float := 0.0; -- in secs, interval od log outputs.
   dPeriod : Long_Float := 0.0; -- in secs, drive samoling period
   Speriod : Long_Float := 0.0; -- in secs, stimulation square wave period
   Sspeed  : Long_Float := 0.0; -- in w / sec, stimulation square wave amplitude
   
   
   
   -------------------------
   
   type Arg_Type is (None, J, Jh, Kd, Kt, Pm, N, Vcc, Hrpm, Wc, A1, Krho, Ki, G1, Tf, Rp, Lp, Dp, Sp, Ssp);
   Argv  : Arg_Type := None;
   Jj    : Natural := 0;
   Gotname,
   Wrong_Spec            : Boolean := False;
   Arg_Exeption,
   Wrong_Spec_exeption   : exception;
   
begin
   for Arg in 1 .. Argument_Count loop
      declare
	 Sarg : String := Acl.Argument(Arg);
      begin
	 if sArg (sArg'First) = '-' then
	    if Gotname = True then
	       raise Arg_Exeption;
	    end if;
	    for K in sArg'First .. sArg'Last loop
	       Jj := K;
	       exit when sArg (K) /= '-';
	    end loop;
	    Argv := Arg_Type'Value (sArg (Jj .. sArg'Last));
	    Gotname := True;
	 else
	    if Gotname = False then
	       raise Arg_Exeption;
	    end if;
	    Tio.Put (Arg_Type'Image (Argv) & "   ");
	    Tio.Put_Line (Sarg);
	    case Argv is
	       when J     => vJ    := Long_Float'Value (sArg);
	       when Jh    => VJh   := Long_Float'Value (sArg);
	       when Kd    => Vkd   := Long_Float'Value (sArg);
	       when Kt    => Vkt   := Long_Float'Value (sArg);
	       when Pm    => Vpm   := Long_Float'Value (sArg);
	       when N     => Vn    := Positive'Value (Sarg);
	       when Vcc   => Vvcc  := Long_Float'Value (sArg);
	       when Hrpm  => Vhrpm := Long_Float'Value (sArg);
	       when Wc    => Vwc   := Long_Float'Value (sArg);
	       when A1    => Va1   := Long_Float'Value (sArg);
	       when Krho  => Vkrho := Long_Float'Value (sArg);
	       when Ki    => Vki   := Long_Float'Value (sArg);
	       when G1    => Vg1   := Long_Float'Value (sArg);
	       when Tf    => Vtf   := Long_Float'Value (sArg);
	       when Rp    => Runperiod := Long_Float'Value (sArg);
	       when Lp    => Logperiod := Long_Float'Value (sArg);
	       when Dp    => Dperiod   := Long_Float'Value (sArg);
	       when Sp    => Speriod   := Long_Float'Value (sArg);
	       when Ssp   => Sspeed    := Long_Float'Value (sArg);
	       when others => raise Arg_Exeption;
	    end case;
	    Gotname := False;
	 end if;
      exception
	 when others => Tio.Put_Line ("this argument is not accepted here.");
      end;
      
      null;
   end loop;
   if Vj   = 0.0 then 
      Tio.Put_Line ("J    has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if vkd  = 0.0 then 
      Tio.Put_Line ("Kd   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vkt  = 0.0 then 
      Tio.Put_Line ("Kt   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vpm  = 0.0 then 
      Tio.Put_Line ("PM   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vn   = 1 then 
      Tio.Put_Line ("N    has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vvcc = 0.0 then 
      Tio.Put_Line ("Vcc  has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vhrpm = 0.0 then 
      Tio.Put_Line ("hRPM has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Vwc  = 0.0 then 
      Tio.Put_Line ("Wc   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Va1 = 0.0 then 
      Tio.Put_Line ("A1   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Runperiod = 0.0 then 
      Tio.Put_Line ("RunPeriod   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Dperiod = 0.0 then 
      Tio.Put_Line ("Drive SamplePeriod   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Speriod = 0.0 then
      Tio.Put_Line ("SimulationPeriod   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Sspeed = 0.0 then
      Tio.Put_Line ("simulationSpeed   has not been specified."); 
      Wrong_Spec := True; 
   end if;
   if Wrong_Spec then raise Wrong_Spec_Exeption; end if;
   
   
exception
   when Wrong_Spec_Exeption => Tio.Put_Line ("Execution halted.");
end Msim;
