--
--  Copyright (C) 2015, Jan de Kruijf.
--
with AUnit;
with AUnit.Test_Fixtures;

with Luthien.Dll;

package body Luthien.Sonja3.Main.Test is
   package Aua renames AUnit.Assertions;
   package Dll renames Luthien.Dll;
   
   procedure Test_Fsm_State1 (T : in out Test)
   is
      pragma Unreferenced (T);
      Inp   : Sonja3_In_Type; 
      Queue : Dll.Dllist_Access_Type;
   begin
      ------------- first test
      -- preamble
      Fsm_Run_Enable := False;
      Fsm_State      := State1;
      -- fill in the critical variable values
      Lm.Smax        := 0.0;
      Lm.S2          := 0.0;
      -- Run the Fsm, it should stop after one iteration
      Fsm (Inp => Inp, Fsm_State => Fsm_State, Queue => Queue);
      -- assert the result
      Aua.Assert (Fsm_State = State3, 
                  "Test_Fsm_State1-1: s1 -> s3 transition not made");
      
      ------------ 2nd test --
      -- preamble
      Fsm_Run_Enable := False;
      Fsm_State      := State1;
      -- fill in the critical variable values
      Lm.Smax        := 0.0;
      Lm.S2          := 0.1;
      -- Run the Fsm, it should stop after one iteration
      Fsm (Inp => Inp, Fsm_State => Fsm_State, Queue => Queue);
      -- assert the result
      Aua.Assert (Fsm_State = State3, 
                  "Test_Fsm_State1-2: state1 -> state3 transition not made");
      
      ------------- 3rd test --
      -- preamble
      Fsm_Run_Enable := False;
      Fsm_State      := State1;
      -- fill in the critical variable values
      Lm.Smax        := 0.0;
      Lm.S2          := -0.1;
      -- Run the Fsm, it should stop after one iteration
      Fsm (Inp => Inp, Fsm_State => Fsm_State, Queue => Queue);
      -- assert the result
      Aua.Assert (Fsm_State = State2, 
                  "Test_Fsm_State1-3: s1 -> s2 transition not made");
      
      -- put it back the way you found it
      Fsm_Run_Enable := True;
      Fsm_State      := State1;
      
   end Test_Fsm_State1;
   
   
