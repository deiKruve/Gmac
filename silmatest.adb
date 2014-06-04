with Text_Io; 
--with Ada.Command_Line;
--with Ada.Characters.Handling;
--with Ada.Text_IO;
--with Ada.Strings.Unbounded;
--with Gnat.Strings;
with System;
--with Silmaril.File_Selector;
--with Silmaril.Reader;
with Silmaril.Tasks;
with Ada.Synchronous_Task_Control;

with GNATCOLL.Traces;

procedure Silmatest is
   
   package Astc renames Ada.Synchronous_Task_Control;
   package St   renames Silmaril.Tasks;
   package Gct  renames GNATCOLL.Traces;
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");
   
   Res, Last_Res : St.Ld_Result_Type;
   use type St.Ld_Result_Type;
begin
   
   null;
   Astc.Set_True (St.Button_Push);
   --delay (0.1);
   Res := St.Load_Result.Get ;
   Last_Res := Res;
   loop
      while Last_Res = Res loop
	 Res := St.Load_Result.Get ;
      end loop;
      Last_Res := Res;
      case Res is
	 when St.Done    => 
	    Text_Io.Put_Line ("read the post file");
	 when St.Error   => 
	    Text_Io.Put_Line ("an error occurred reading the post file");
	 when St.Working => 
	    Text_Io.Put_Line ("waiting . . . .");
      end case;
   end loop;
   St.Finalize;
   
end Silmatest;
