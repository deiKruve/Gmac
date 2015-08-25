--
--  Copyright (C) 2015, Jan de Kruijf.
--

with Luthien.Dll;
with Luthien.Sonja.Sonja3.Test;
with AUnit.Test_Caller;

package body Luthien_Suite is
   package Dll is new Luthien.Dll;
   package Ls is new Luthien.Sonja (Nof_Axes => 1);
   package Lss3 is new Ls.Sonja3;
   package Lss3t is new Lss3.Test;
   --package Lssti renames Luthien_Sonja_Sonja3_Test_Inst;
   package Auts renames AUnit.Test_Suites;
   
   package Caller is 
      new AUnit.Test_Caller (Lss3t.Test);
   
   
   function Suite return Auts.Access_Test_Suite is
      Ret : constant Auts.Access_Test_Suite := new Auts.Test_Suite;
   begin
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-1", Lss3t.Test_Math312_314'Access));
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-2", Lss3t.Test_Math315_316'Access));
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-3", Lss3t.Test_Math317_318'Access));
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-4", Lss3t.Test_Math324_325'Access));
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-5", Lss3t.Test_Math326_325'Access));
      Ret.Add_Test
        (Caller.Create ("Test_Sonja3-6", Lss3t.Test_Math_B_Dv'Access));
      
      -- insert more tests here.
      
      return Ret;
   end Suite;

end Luthien_Suite;
