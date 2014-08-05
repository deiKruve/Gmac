
with Text_Io;
with O_String;

package body Berentest1 is
   package Tio renames Text_Io;
   package Bob renames Beren.Objects;
   package Obs renames O_String;

   procedure Enumerate_Attr (Name : String; M : Beren.Objects.Attr_Msg)
   is
      use type Bob.Attr_Class;
   begin
      if M.Class = Bob.Real then
	 declare 
	    Rstr : String := Long_Float'Image (M.X);
	 begin
	    Tio.Put_Line (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	 end;
      end if;
   end Enumerate_Attr;
   
   
end Berentest1;
