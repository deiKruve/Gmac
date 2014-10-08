with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Pll.Calc;

procedure Plldes is
   package Acl renames Ada.Command_Line;
   package Tio renames Ada.Text_IO;
   
   ---------------------
   -- input variables --
   ---------------------
   vJ,
   vKd,
   vKt,
   vPm   : Long_Float := 0.0;
   vN    : Positive := 1;
   vVcc,
   vHrpm,
   vWc   : Long_Float := 0.0;
   
   
   -------------------------
   
   type Arg_Type is (None, J, Kd, Kt, Pm, N, Vcc, Hrpm, Wc);
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
	       when Kd    => Vkd   := Long_Float'Value (sArg);
	       when Kt    => Vkt   := Long_Float'Value (sArg);
	       when Pm    => Vpm   := Long_Float'Value (sArg);
	       when N     => Vn    := Positive'Value (Sarg);
	       when Vcc   => Vvcc  := Long_Float'Value (sArg);
	       when Hrpm  => Vhrpm := Long_Float'Value (sArg);
	       when Wc    => Vwc   := Long_Float'Value (sArg);
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
   if Wrong_Spec then raise Wrong_Spec_Exeption; end if;
   Pll.Calc.Calcit (vJ, vKd, vKt, vPm, vVcc, vHrpm, VWc, Vn);
   
exception
   when Wrong_Spec_Exeption => Tio.Put_Line ("Execution halted.");
end Plldes;

--20 : eta  =  5.02677478877489E+00
-- 10: eta  =  5.02677478877489E+00
-- 5 : eta  =  5.02677478877489E+00
-- 3 : eta  =  5.02677478877489E+00
