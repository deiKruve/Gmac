--
--  Copyright (C) 2015, Jan de Kruijf.
--
with AUnit;
with AUnit.Test_Fixtures;

package Luthien.Sonja3.Main.Test is
   
   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;
   
   procedure Test_Fsm_State1 (T : in out Test);
   
   -- enz
   
end Luthien.Sonja3.Main.Test;
