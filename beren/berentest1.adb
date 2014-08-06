
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
   
   
end Berentest1;
