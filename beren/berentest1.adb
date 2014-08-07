
with Text_Io;
with O_String;

package body Berentest1 is
   package Tio renames Text_Io;
   package Bob renames Beren.Objects;
   package Bjo renames Beren.Jogobj;
   package Obs renames O_String;

   procedure Enumerate_Attr (Name : String; M : Beren.Jogobj.Attr_Msg)
   is
      use type Bjo.Attr_Class;
   begin
      if M.Class = Bjo.Real then
	 declare 
	    Rstr : String := Long_Float'Image (M.X);
	 begin
	    Tio.Put_Line (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	 end;
      elsif M.Class = Bjo.Int then
	 declare
	    Rstr  : String := Integer'Image (M.I);
	 begin
	    Tio.Put_Line (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	 end;
      elsif M.Class = Bjo.Bool then
	 declare
	    Rstr  : String := Boolean'Image (M.B);
	 begin
	    Tio.Put_Line (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	 end;
      elsif M.Class = Bjo.Enum then
	 declare
	    Rstr  : String := Bjo.Pulse_Mode_Enumeration_Type'Image (M.E);
	 begin
	    Tio.Put_Line (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	 end;
      end if;
   end Enumerate_Attr;
   

begin

   --connect the hi-speed data flow interface
   X_Jog.In_Cpos := X_Hw.Out_Cpos'Access;
   X_Hw.In_Rpos  := X_Jog.Out_Rpos'Access;
   Y_Jog.In_Cpos := Y_Hw.Out_Cpos'Access;
   Y_Hw.In_Rpos  := Y_Jog.Out_Rpos'Access;
   A_Jog.In_Cpos := A_Hw.Out_Cpos'Access;
   A_Hw.In_Rpos  := A_Jog.Out_Rpos'Access;
   
end Berentest1;
