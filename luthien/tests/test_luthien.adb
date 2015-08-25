--
--  Copyright (C) 2015, Jan de Kruijf.
--
with AUnit.Reporter.Text;
with AUnit.Run;
with Luthien_Suite;

procedure Test_Luthien is
   procedure Runner is new AUnit.Run.Test_Runner (Luthien_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Runner (Reporter);
end Test_Luthien;
