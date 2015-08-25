--
--  Copyright (C) 2015, Jan de Kruijf.
--
with AUnit;
with AUnit.Test_Fixtures;

generic
package Luthien.Sonja.Sonja3.Test is
   
   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;
   
   procedure Test_Math312_314 (T : in out Test);
   
   procedure Test_Math315_316 (T : in out Test);
   
   procedure Test_Math317_318 (T : in out Test);
   
   procedure Test_Math324_325 (T : in out Test);
   
   procedure Test_Math326_325 (T : in out Test);
   
   procedure Test_Math_B_Dv (T : in out Test);
   
   
end Luthien.Sonja.Sonja3.Test;
