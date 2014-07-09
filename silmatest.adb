-- Compile command: gnatmake -o silmatest silmatest -P"/home/jan/MMS/programs-PC/silmatest.gpr" -g -cargs -gnatq -gnatQ -bargs  -largs 
-- M-x customize-variable
-- ada-prj-default-gpr-file
-- "/home/jan/MMS/programs-PC/silmatest.gpr"
with Text_Io; 
with Ada.Characters.Latin_1;
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with System;
with Silmaril.Reader;
with Silmaril.Tasks;
with Silmaril.Dll;
with Silmaril.Param;
with Ada.Synchronous_Task_Control;
with Ada.Exceptions;
with GNATCOLL.Traces;

procedure Silmatest is
   
   package Tio   renames Text_Io; 
   package Tiots renames Ada.Text_IO.Text_Streams;
   package Astc  renames Ada.Synchronous_Task_Control;
   package St    renames Silmaril.Tasks;
   package Sr    renames Silmaril.Reader;
   package Dll   renames Silmaril.Dll;
   package Spar  renames Silmaril.Param;
   
   -- anything distance --
   subtype Posvec1_Type is Long_Float;
   package Pvio  is new Ada.Text_IO.Float_IO (Num => Posvec1_Type);
   
   package Gct  renames GNATCOLL.Traces;
   
   --Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   --Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   --Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");
   
   
   Ch            : Character;
   --Errres,
   Available     : Boolean;
   
   Res, Last_Res : St.Ld_Result_Type;
   use type St.Ld_Result_Type;
   
   
   procedure Output_Program 
     -- outputs the dllist that has been read from the nc file 
     -- for checking purposes.
   is
      List : aliased Dll.Dllist_Access_Type := Sr.Prog_Anchor.Next;
      Listpos9 : aliased Dll.Posvec9_Access_Type;
      Xstr, Ystr, Zstr, Tstr, Fstr   : String := "        ";
      Astr, Bstr, Cstr, d3dstr       : String := "        ";
      Cmdstr                         : String := "    ";
      Ofd      : Tio.File_Type;
      Ostr     : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
      use type Dll.Dllist_Access_Type;
      use type Dll.Cmd_Token_Type;
   begin
      Ostr := Tiots.Stream (Tio.Standard_Output);
      loop
	 if List.Pos.all in Dll.Posvec9_Type then
	    Listpos9 := Dll.Posvec9_Access_Type (List.Pos);
	    Pvio.Put (Xstr, Listpos9.X, 3, 0);
	    Pvio.Put (Ystr, Listpos9.Y, 3, 0);
	    Pvio.Put (Zstr, Listpos9.Z, 3, 0);
	    Pvio.Put (Tstr, Posvec1_Type (Listpos9.Tightness), 3, 0);
	    Pvio.Put (Fstr, Listpos9.Fedrat, 2, 0);
	    if Listpos9.From then Cmdstr := "FROM";
	    else Cmdstr := "GOTO"; end if;
	    String'Write (Ostr, Cmdstr & " X " & Xstr & " Y " & Ystr & 
			    " Z " & Zstr & " T " & Tstr & " F " & Fstr & ASCII.LF);
	    Pvio.Put (Astr, Posvec1_Type (Listpos9.A), 5, 0);
	    Pvio.Put (Bstr, Posvec1_Type (Listpos9.B), 5, 0);
	    Pvio.Put (Cstr, Posvec1_Type (Listpos9.C), 5, 0);
	    Pvio.Put (d3dstr, Posvec1_Type (Listpos9.d3d), 5, 0);
	    String'Write (Ostr, " A " & Astr & " B " & Bstr & " C " & Cstr & 
			    " D " & D3dstr & 
			    " istop : " & Boolean'Image (ListPos9.Istop) & 
			    " Blend : " & Dll.Move_Type'Image (Listpos9.Blend) &
			    ASCII.LF);
	 elsif List.Pos.all in Dll.Posvec_S_Type  then
	    String'Write (Ostr, Dll.Posvec_S_Access_Type (List.Pos).Sa.all & 
			    ASCII.LF);
	 elsif List.Pos.all in Dll.Posvec_C_Type then
	    declare
	       Cmdstrn : String := Dll.Cmd_Token_Type'Image 
		 (Dll.Posvec_C_Access_Type (List.Pos).C);
	    begin
	       if Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Clamp or 
		 Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Release then
		  declare
		     Axstrn  : String := Dll.Axis_Token_Type'Image 
		       (Dll.Posvec_C_Access_Type (List.Pos).Ax);
		  begin
		     String'Write (Ostr, Cmdstrn & " " & Axstrn & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Fadein or
		 Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Fadeout then
		  declare
		     Valstrn : String := Long_Float'Image 
		       (Dll.Posvec_C_Access_Type (List.Pos).Val);
		  begin
		     String'Write 
		       (Ostr, Cmdstrn & " " & Valstrn & "secs" & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (List.Pos).C = Dll.F then
		  declare  -- this section is not applicable
		     Valstrn : String := Long_Float'Image 
		       (Dll.Posvec_C_Access_Type (List.Pos).Val);
		  begin
		     String'Write (Ostr, Cmdstrn & " " & Valstrn & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Spindl or
		 Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Beam then
		  declare
		     Trstrn : String := Boolean'Image 
		       (Dll.Posvec_C_Access_Type (List.Pos).Tr);
		  begin
		     if Dll.Posvec_C_Access_Type (List.Pos).Tr = True then
			declare
			   Valstrn : String := Long_Float'Image 
			     (Dll.Posvec_C_Access_Type (List.Pos).Val);
			begin
			   String'Write  (Ostr, Cmdstrn & " " & Trstrn & " " & 
					    Valstrn & ASCII.LF);
			end;
		     else
			String'Write (Ostr, Cmdstrn & " " & Trstrn & ASCII.LF);
		     end if;
		  end;
	       elsif Dll.Posvec_C_Access_Type (List.Pos).C = Dll.Fini then
		  String'Write (Ostr, "THE END OF THINGS." & ASCII.LF);
	       else 
		  String'Write (Ostr, "not done yet!!!!");
	       end if;
	    end;

	 else 
	    String'Write (Ostr, "Output_Program : unknown class");
	 end if;
	 List := List.Next; -- this goes to the following vector !!
	 exit when List = Sr.Prog_Anchor;
      end loop;
   end Output_Program;
   
   
   
begin
   Gct.Parse_Config_File;   --  parses default ./.gnatdebug
   null;
   St.Load_Result.Set (St.Working);
   Astc.Set_True (St.Param_Button_Push);
   Res := St.Load_Result.Get;
   Last_Res := Res;
   loop
      while Last_Res = Res loop
	 Res := St.Load_Result.Get ;
      end loop;
      Last_Res := Res;
      case Res is
	 when St.Done    => 
	    Text_Io.Put_Line ("done reading the param file");
	    exit;
	 when St.Not_Done =>
	    Text_Io.Put_Line ("no parameter file has been read.");
	    exit;
	 when St.Error   => 
	    Text_Io.Put_Line ("an error occurred reading the param file");
	    exit;
	 when St.Working => 
	    Text_Io.Put_Line ("waiting . . . .");
      end case;
   end loop;
   
   loop
      St.Load_Result.Set (St.Working);
      Astc.Set_True (St.Prog_Button_Push);
      --delay (0.1);
      Res := St.Load_Result.Get ;
      Last_Res := Res;
      loop
   	 while Last_Res = Res loop
   	    Res := St.Load_Result.Get ;
   	 end loop;
   	 Last_Res := Res;
   	 case Res is
   	    when St.Done     => 
   	       Text_Io.Put_Line ("done reading the post file");
   	       exit;
	    when St.Not_Done =>
	       Text_Io.Put_Line ("no post file has been read.");
	       exit;
   	    when St.Error    => 
   	       Text_Io.Put_Line ("an error occurred reading the post file");
   	    when St.Working  => 
   	       Text_Io.Put_Line ("waiting . . . .");
   	 end case;
      end loop;
      Output_Program;
      --Gct.Finalize;
      Tio.Get_Immediate (Ch, Available);
      while not Available loop
   	 Tio.Get_Immediate (Ch, Available);
      end loop;
      if Ch = Ada.Characters.Latin_1.ETX then
   	 exit;
      end if;
   end loop;
   Gct.Finalize;
   --St.Finalize;
   
end Silmatest;
