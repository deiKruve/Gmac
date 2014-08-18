
with Earendil.Objects;
with Beren.Jogobj;
with Beren.Jog;
with Beren.Hw;
with Beren.Encoder;

package Berentest1 is
   procedure Enumerate_Attr (Name : String; M : Beren.Jogobj.Attr_Msg);
   
   package X_Enc is new Beren.Encoder (Name => "X_Enc");
   
   package X_Jog is new Beren.Jog (Name => "X_Jog", Xis => Beren.Linear);
   package Y_Jog is new Beren.Jog (Name => "Y_Jog", Xis => Beren.Linear);
   package A_Jog is new Beren.Jog (Name => "A_Jog", Xis => Beren.Rotary);
   
   package X_Hw is new Beren.Hw (Name => "X_Hw", Xis => Beren.Linear,
				 E_Stop_Init => False, In_Hwpos_Init => 0.0,
				 In_Cpos_Init => 0.0, In_Rpos_Init => 0.0);
   package Y_Hw is new Beren.Hw (Name => "Y_Hw", Xis => Beren.Linear,
				 E_Stop_Init => False, In_Hwpos_Init => 0.0,
				 In_Cpos_Init => 0.0, In_Rpos_Init => 0.0);
   package A_Hw is new Beren.Hw (Name => "A_Hw", Xis => Beren.Rotary);
   
   
   
end Berentest1;
