with Beren.Objects;
with Beren.Jogobj;
with Text_Io;
with Ada.Text_IO.Text_Streams;
with O_String;
with Berentest1; -- realizes the jog template

procedure Berentest is
   package Tio renames Text_Io;
   package Bob renames Beren.Objects;
   package Bjo renames Beren.Jogobj;
   package Obs renames O_String;
   package Tiots renames Ada.Text_IO.Text_Streams;
   -- open a file on std out
   Ostr     : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
   
   M : Bjo.Attr_Msg;
   Mf : Bob.File_Msg;
begin
   -- change the X_Jog jog rate
   M.Id := Bob.Set;
   M.Name := Obs.To_O_String (32, "Jog_Rate");
   M.Class := Bjo.Real;
   M.X := 20.0;
   Berentest1.X_Jog.Handle (Bob.Object (Berentest1.X_Jog.Jogger), M);
   
   -- print out all attributes
   M.Id := Bob.Enum;
   M.Enum := Berentest1.Enumerate_Attr'access;
   Bob.Stamp (M);
   Bob.Broadcast (M);
   
   -- test file message
   Mf.Id := Bob.Store;
   Mf.Ostr := Ostr;
   Bob.Stamp (Mf);
   Bob.Broadcast (Mf);
   
   Mf.Id := Bob.Load;
   Bob.Stamp (Mf);
   Bob.Broadcast (Mf);
   
-- test file message to see we loaded properly.
   Mf.Id := Bob.Store;
   Mf.Ostr := Ostr;
   Bob.Stamp (Mf);
   Bob.Broadcast (Mf);
end Berentest;
