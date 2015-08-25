--
--  Copyright (C) 2015, Jan de Kruijf.
--

with System.Assertions;
with Ada.Exceptions;

with AUnit;
with AUnit.Test_Fixtures;
with AUnit.Assertions;

--with Ada.Text_IO;
--with Luthien.Dll;

package body Luthien.Sonja.Sonja3.Test is
   package Aua renames AUnit.Assertions;
   --package Tio renames Ada.Text_IO;
   --package Dll is new Luthien.Dll;
   
   
   ---------------------
   --  Test_Sonja3-1  --
   ---------------------
   procedure Test_Math312_314 (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
      -- call routine under test
      Math312_314;
      -- assert the result. Lm.Sa, Lm.Sb, Lm.D1
      Aua.Assert (abs (Lm.Sa - 0.0) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t1 : lm.sa is not 0.0 but " & 
                    Mpsec_Type'Image (Lm.Sa));
      Aua.Assert (abs (Lm.Sb - 0.0) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t1 : lm.sb is not 0.0 but " & 
                    Mpsec_Type'Image (Lm.Sb));
      Aua.Assert (abs (Lm.D1 - 0.0) < M_Type'Epsilon,
                  "Test_Math312_314-t1 : Lm.D1 is not 0.0 but " & 
                    M_Type'Image (Lm.D1));
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 0.0;
      Lm.S2         := 1.0;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math312_314;
      -- assert the result. Lm.Sa, Lm.Sb, Lm.D1
      Aua.Assert (abs (Lm.Sa - 0.05) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t2 : lm.sa is not 0.05 but " & 
                    Mpsec_Type'Image (Lm.Sa));
      Aua.Assert (abs (Lm.Sb - 0.95) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t2 : lm.sb is not 0.95 but " & 
                    Mpsec_Type'Image (Lm.Sb));
      Aua.Assert (abs (Lm.D1 - 1.48678816357662e-3) < M_Type'Epsilon,
               "Test_Math312_314-t2 : Lm.D1 is not 1.48678816357662e-3 but " & 
                    M_Type'Image (Lm.D1));
      
      ------------- 3rd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := -1.0;
      Lm.S2         := 1.0;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math312_314;
      -- assert the result. Lm.Sa, Lm.Sb, Lm.D1
      Aua.Assert (abs (Lm.Sa - (-0.95)) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t3 : lm.sa is not -0.95 but " & 
                    Mpsec_Type'Image (Lm.Sa));
      Aua.Assert (abs (Lm.Sb - 0.95) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t3 : lm.sb is not 0.95 but " & 
                    Mpsec_Type'Image (Lm.Sb));
      Aua.Assert (abs (Lm.D1 - (-0.0985132118364234)) < M_Type'Epsilon,
               "Test_Math312_314-t3 : Lm.D1 is not -0.0985132118364234 but " & 
                    M_Type'Image (Lm.D1));
      
      ------------- 4th test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 2.0;
      Lm.S2         := 1.0;
      Lm.Amax       := -1.0;
      Lm.Delta_Tmax := 0.5;
      -- call routine under test
      Math312_314;
      -- assert the result. Lm.Sa, Lm.Sb, Lm.D1
      Aua.Assert (abs (Lm.Sa - 1.75) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t4 : lm.sa is not 1.75 but " & 
                    Mpsec_Type'Image (Lm.Sa));
      Aua.Assert (abs (Lm.Sb - 1.25) < Mpsec_Type'Epsilon,
                  "Test_Math312_314-t4 : lm.sb is not 1.25 but " & 
                    Mpsec_Type'Image (Lm.Sb));
      Aua.Assert (abs (Lm.D1 - 0.962830295910584) < M_Type'Epsilon,
                 "Test_Math312_314-t4 : Lm.D1 is not 0.962830295910584 but " & 
                    M_Type'Image (Lm.D1));
      
      -- put it back the way you found it
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
   end Test_Math312_314;
   
   
   ---------------------
   --  Test_Sonja3-2  --
   ---------------------
   procedure Test_Math315_316 (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
      -- call routine under test
      Math312_314;
      Math315_316;
      -- assert the result.
      --  begin
      --     Aua.Assert (False, "it should have raised a 'divide by 0' exception");
      --  exception
      --     when System.Assertions.Assert_Failure =>
      --        --  Precondition failed. OK
      --        null;
      --     when E : others =>
      --        Aua.Assert (False, "Wrong exception raised: " &
      --                Ada.Exceptions.Exception_Name (E));
      --  end;
      Aua.Assert (Lm.D2'Valid = False, 
                  "Test_Math315_316-t1 : lm.d2 is not NaN but a valid number");
      --  Aua.Assert (abs (Lm.D2 - 0.0) < Mpsec_Type'Epsilon,
      --              "Test_Math315_316-t1 : lm.d2 is not 0.0 but " &
      --                M_Type'Image (Lm.D2));
      Aua.Assert (abs (Lm.D3 - 0.0) < Mpsec_Type'Epsilon,
               "Test_Math315_316-t1 : lm.d3 is not 0.0 but " &
                    M_Type'Image (Lm.D3));
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 0.0;
      Lm.S2         := 1.0;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math312_314;
      Math315_316;
      -- assert the result.
      Aua.Assert (abs (Lm.D2 - 0.45) < Mpsec_Type'Epsilon,
                  "Test_Math315_316-t2 : lm.d2 is not 0.45 but " &
                    M_Type'Image (Lm.D2));
      Aua.Assert (abs (Lm.D3 - 0.0985132118364234) < Mpsec_Type'Epsilon,
               "Test_Math315_316-t2 : lm.d3 is not 0.0985132118364234 but " &
                    M_Type'Image (Lm.D3));
      
      ------------- 3rd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := -1.0;
      Lm.S2         := 1.0;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math312_314;
      Math315_316;
      -- assert the result.
      Aua.Assert (abs (Lm.D2 - 0.0) < Mpsec_Type'Epsilon,
                  "Test_Math315_316-t3 : lm.d2 is not 0.0 but " &
                    M_Type'Image (Lm.D2));
      Aua.Assert (abs (Lm.D3 - 0.0985132118364234) < Mpsec_Type'Epsilon,
               "Test_Math315_316-t3 : lm.d3 is not 0.0985132118364234 but " &
                    M_Type'Image (Lm.D3));
      
      ------------- 4th test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax)
      Lm.S1         := 2.0;
      Lm.S2         := 1.0;
      Lm.Amax       := -1.0;
      Lm.Delta_Tmax := 0.5;
      -- call routine under test
      Math312_314;
      Math315_316;
      -- assert the result.
      Aua.Assert (abs (Lm.D2 - 0.75) < Mpsec_Type'Epsilon,
                  "Test_Math315_316-t4 : lm.d2 is not 0.75 but " &
                    M_Type'Image (Lm.D2));
      Aua.Assert (abs (Lm.D3 - 0.537169704089416) < Mpsec_Type'Epsilon,
               "Test_Math315_316-t4 : lm.d3 is not 0.537169704089416 but " &
                    M_Type'Image (Lm.D3));
      
      -- put it back the way you found it
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
   end Test_Math315_316;
   
   
   ---------------------
   --  Test_Sonja3-3  --
   ---------------------
   procedure Test_Math317_318 (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.D, Lm.S1, Lm.Sa, Lm.Amax, Lm.Delta_Tmax);
      Lm.D          := 0.0;
      Lm.S1         := 0.0;
      Lm.Sa         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
      -- call routine under test
      Math317_318;
      -- assert the result. Lm.Sb, Lm.S2
      Aua.Assert (Lm.Sb'Valid = False, 
                  "Test_Math317_318-t1 : lm.sb is not NaN but a valid number");
      Aua.Assert (Lm.S2'Valid = False, 
                  "Test_Math317_318-t1 : lm.s2 is not NaN but a valid number");
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.D, Lm.S1, Lm.Sa, Lm.Amax, Lm.Delta_Tmax);
      Lm.D          := 0.45;
      Lm.S1         := 0.0;
      Lm.Sa         := 0.05;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math317_318;
      -- assert the result. Lm.Sb, Lm.S2
      Aua.Assert (abs (Lm.Sb - 0.85) < 20.0 * Mpsec_Type'Epsilon,
                  "Test_Math317_318-t2 : lm.sb is not 0.85 but " & 
                    Mpsec_Type'Image (Lm.Sb));
      Aua.Assert (abs (Lm.S2 - 0.9) < 20.0 * Mpsec_Type'Epsilon,
                  "Test_Math317_318-t2 : lm.s2 is not 0.9 but " & 
                    Mpsec_Type'Image (Lm.S2));
      declare
         Sa : Mpsec_Type := Lm.Sa;
         Sb : Mpsec_Type := Lm.Sb;
         D  : M_Type;
      begin
         Math312_314;
         Math315_316;
         D := Lm.D1 + Lm.D2 + Lm.D3;
         Aua.Assert (abs (D - Lm.D) < 20.0 * Mpsec_Type'Epsilon,
                  "Test_Math317_318-t2 : sigma d is not 0.45 but " & 
                    M_Type'Image (D));
      end;
      
      ------------- 3rd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.D, Lm.S1, Lm.Sa, Lm.Amax, Lm.Delta_Tmax);
      Lm.D          := 0.2;
      Lm.S1         := 1.0;
      Lm.Sa         := -0.95;
      Lm.Amax       := 1.0;
      Lm.Delta_Tmax := 0.1;
      -- call routine under test
      Math317_318;
      declare
         D  : M_Type;
      begin
         Math312_314;
         Math315_316;
         D := Lm.D1 + Lm.D2 + Lm.D3;
         --  Aua.Assert (abs (D - Lm.D) < 20.0 * Mpsec_Type'Epsilon,
         --           "Test_Math317_318-t3 : sigma d is not 0.1 but " & 
         --             M_Type'Image (D));
      end;
      
      ------------- 4th test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.D, Lm.S1, Lm.Sa, Lm.Amax, Lm.Delta_Tmax);
      Lm.D          := 0.75;
      Lm.S1         := 2.0;
      Lm.Sa         := 1.75;
      Lm.Amax       := -1.0;
      Lm.Delta_Tmax := 0.5;
      -- call routine under test
      Math317_318;
      declare
         D  : M_Type;
      begin
         Math312_314;
         Math315_316;
         D := Lm.D1 + Lm.D2 + Lm.D3;
         Aua.Assert (abs (D - Lm.D) < (40.0 * M_Type'Epsilon),
                  "Test_Math317_318-t4 : sigma d is not 0.75 but " & 
                    M_Type'Image (D) & M_Type'Image (20.0 * M_Type'Epsilon));
      end;
      
   end Test_Math317_318;
   
   
   ---------------------
   --  Test_Sonja3-4  --
   ---------------------
   procedure Test_Math324_325 (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.D, Lm.Jmax)
      Lm.S1         := 0.0;
      Lm.D          := 0.0;
      Lm.Jmax       := 0.0;
      -- call routine under test
      Math324_325;
      -- assert the result. (Lm.Delta_T, Lm.Apeak)
      Aua.Assert (Lm.Delta_T'Valid = False, 
            "Test_Math324_325-t1 : Lm.Delta_T is not NaN but a valid number");
      Aua.Assert (Lm.Apeak'Valid = False, 
            "Test_Math324_325-t1 : Lm.Apeak is not NaN but a valid number");
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.D, Lm.Jmax)
      Lm.S1         := 0.0;
      Lm.D          := 0.1;
      Lm.Jmax       := 1.0;
      -- call routine under test (C.17 will be excercised)
      Math324_325; -- c17 3.25
      -- assert the result. (Lm.Delta_T, Lm.Apeak)
      Aua.Assert 
        (abs (Lm.Delta_T - 0.539560264642984) < 5.0 * Sec_Type'Epsilon,
         "Test_Math324_325-t2 : Lm.Delta_T is not 0.539560264642984 but " & 
           Sec_Type'Image (Lm.Delta_T));
      Aua.Assert 
        (abs (Lm.Apeak - 0.343494732855609) < 5.0 * Mpsec2_Type'Epsilon,
         "Test_Math324_325-t2 : Lm.Apeak is not 0.343494732855609 but " & 
           Mpsec2_Type'Image (Lm.Apeak));
      
      ------------- 3rd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.D, Lm.Jmax)
      Lm.S1         := 0.2;
      Lm.D          := 0.1;
      Lm.Jmax       := 0.7;
      -- call routine under test (C.17 will be excercised)
      Math324_325; -- c8 c9 c15 c16 3.25
      -- assert the result. (Lm.Delta_T, Lm.Apeak)
      Aua.Assert 
        (abs (Lm.Delta_T - 0.235457028635318) < 5.0 * Sec_Type'Epsilon,
         "Test_Math324_325-t3 : Lm.Delta_T is not 0.235457028635318 but " & 
           Sec_Type'Image (Lm.Delta_T));
      Aua.Assert 
        (abs (Lm.Apeak - 0.104927619980515) < 5.0 * Mpsec2_Type'Epsilon,
         "Test_Math324_325-t3 : Lm.Apeak is not 0.104927619980515 but " & 
           Mpsec2_Type'Image (Lm.Apeak));
      
      -- put it back the way you found it
      Lm.S1         := 0.0;
      Lm.D          := 0.0;
      Lm.Jmax       := 0.0;
   end Test_Math324_325;
   
   
   ---------------------
   --  Test_Sonja3-5  --
   ---------------------
   procedure Test_Math326_325 (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.s2, Lm.Jmax)
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Jmax       := 0.0;
      -- call routine under test
      Math326_325;
      -- assert the result. (Lm.Delta_T, Lm.Apeak)
      Aua.Assert (Lm.Delta_T'Valid = False, 
            "Test_Math326_325-t1 : Lm.Delta_T is not NaN but a valid number");
      Aua.Assert (Lm.Apeak'Valid = False, 
            "Test_Math326_325-t1 : Lm.Apeak is not NaN but a valid number");
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.s2, Lm.Jmax)
      Lm.S1         := 0.2;
      Lm.S2         := 0.25;
      Lm.Jmax       := 0.7;
      -- call routine under test
      Math326_325;
      -- assert the result. (Lm.Delta_T, Lm.Apeak)
      Aua.Assert 
        (abs (Lm.Delta_T - 0.33496229284534) < 5.0 * Sec_Type'Epsilon,
         "Test_Math326_325-t2 : Lm.Delta_T is not 0.33496229284534 but " & 
           Sec_Type'Image (Lm.Delta_T));
      Aua.Assert 
        (abs (Lm.Apeak - 0.149270533036047) < 5.0 * Mpsec2_Type'Epsilon,
         "Test_Math326_325-t2 : Lm.Apeak is not 0.149270533036047 but " & 
           Mpsec2_Type'Image (Lm.Apeak));
      
      -- put it back the way you found it
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Jmax       := 0.0;
   end Test_Math326_325;
   
   
   ---------------------
   --  Test_Sonja3-6  --
   ---------------------
   procedure Test_Math_B_Dv (T : in out Test)
   is
      pragma Unreferenced (T);
   begin
      ------------- first test
      -- preamble (nothing)
      -- fill in the entry variable values.
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax, Lm.Jmax, Lm.Delta_Smin)
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
      Lm.Jmax       := 0.0;
      Lm.Delta_Smin := 0.0;
      -- call routine under test
      Math_B_Dv;
      -- assert the result. Lm.Dv
      Aua.Assert (Lm.Dv'Valid = False, 
                  "Test_Math_B_Dv-t1 : Lm.Dv is not NaN but a valid number");
      
      ------------ 2nd test --
      -- preamble (nothing)
      -- fill in the entry variable values. 
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax, Lm.Jmax, Lm.Delta_Smin)
      Lm.S1         := 0.5;
      Lm.S2         := 2.0;
      Lm.Amax       := 0.6;
      Lm.Delta_Tmax := 1.0;
      Lm.Jmax       := 0.7;
      Lm.Delta_Smin := 0.2;
      -- call routine under test (excercises if block)
      Math_B_Dv;
      -- assert the result. Lm.Dv
      Aua.Assert (abs (Lm.Dv - 4.375) < 5.0 * M_Type'Epsilon,
                  "Test_Math_B_Dv-t2 : Lm.Dv is not 4.375 but " &
                    M_Type'Image (Lm.Dv)); --   4.43447152654306
                                           --   4.45621523863945
                                           --   4.375
      
      
      ------------- 3rd test --
      -- preamble (nothing)
      -- fill in the entry variable values.
      -- (Lm.S1, Lm.S2, Lm.Amax, Lm.Delta_Tmax, Lm.Jmax, Lm.Delta_Smin)
      Lm.S1         := 0.5;
      Lm.S2         := 0.7;
      Lm.Amax       := 0.6;
      Lm.Delta_Tmax := 1.0;
      Lm.Jmax       := 0.7;
      Lm.Delta_Smin := 0.3;
      -- call routine under test (excercises else block)
      Math_B_Dv;
      -- assert the result. Lm.Dv
      Aua.Assert (abs (Lm.Dv - 0.803909502828814) < 5.0 * M_Type'Epsilon,
                  "Test_Math_B_Dv-t3 : Lm.Dv is not 0.803909502828814 but " &
                    M_Type'Image (Lm.Dv));
      
      -- put it back the way you found it
      Lm.S1         := 0.0;
      Lm.S2         := 0.0;
      Lm.Amax       := 0.0;
      Lm.Delta_Tmax := 0.0;
      Lm.Jmax       := 0.0;
      Lm.Delta_Smin := 0.0;
      
   end Test_Math_B_Dv;
   
   
   
end Luthien.Sonja.Sonja3.Test;
