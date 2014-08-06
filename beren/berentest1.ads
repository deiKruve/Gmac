
with Beren.Objects;
with Beren.Jogobj;
with Beren.Jog;

package Berentest1 is
   
   package X_Jog is new Beren.Jog (Name => "X_Jog", Xis => Beren.Linear);
   package Y_Jog is new Beren.Jog (Name => "Y_Jog", Xis => Beren.Linear);
   package A_Jog is new Beren.Jog (Name => "A_Jog", Xis => Beren.Rotary);
   
   procedure Enumerate_Attr (Name : String; M : Beren.Jogobj.Attr_Msg);
   
end Berentest1;
