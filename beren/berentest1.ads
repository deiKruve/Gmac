
with Beren.Objects;
with Beren.Jog;

package Berentest1 is
   
   package X_Jog is new Beren.Jog (Name => "X_Jog", Xis => Beren.Linear);
   package Y_Jog is new Beren.Jog (Name => "Y_Jog", Xis => Beren.Linear);
   
   procedure Enumerate_Attr (Name : String; M : Beren.Objects.Attr_Msg);
   
end Berentest1;
