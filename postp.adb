------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                 P O S T . M A C H I N . I N T E R F A C E                --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                     Copyright (C) 2014, Jan de Kruyf                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.                                               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
--                  Post is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
--
--  This is the package called when the post-processor is called for.
--  it is machine specific.


--pragma Debug_Policy (Check); -- (IGNORE);

with Text_Io; 
with Ada.Command_Line;
with Ada.Characters.Handling;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Gnat.Strings;

with GNATCOLL.Traces;

with Post.Parser;
with Ebwm1.Machin;
-- any other machine architectures for which a code generation module is
-- written must be withed here and provision must be made in the code below for 
-- calling it.
function Postp return Integer 
is
   package Ach    renames Ada.Characters.Handling;
   package Tio    renames Text_Io; 
   package Gs     renames Gnat.Strings;
   package Acl    renames Ada.Command_Line;
   package Machin renames Ebwm1.Machin;
   package Pp     renames Post.Parser;
   package Atio   renames Ada.Text_IO;
   package Asu    renames Ada.Strings.Unbounded;
   package Gct    renames GNATCOLL.Traces;
   
   use type Pp.Stream_Element_Array_Access;
   use type Pp.Result;
   use type Ada.Strings.Unbounded.Unbounded_String;
   
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");
   
   N           : Natural := 1;
   Arg_Counter : Natural := 1;
   Postproc    : String  := "EBWM1";
   P1          : Asu.Unbounded_String;
   
begin
   Gct.Parse_Config_File;   --  parses default ./.gnatdebug
   if Acl.Argument_Count = 0 then
      goto Uit1;
   end if;
   while Arg_Counter <= Acl.Argument_Count loop
      if (Acl.Argument(Arg_Counter)(1..2)) = "-n" then
	 declare
	    S : String := Ach.To_Upper (Acl.Argument(Arg_Counter));
	 begin
	    if S'Length > 2 then
	       if S (3 .. S'Last) = "1" then
		  null; -- thats ok
	       else
		  null; -- thats nonsense at this moment, so it is also ok
	       end if;
	    else
	       null; -- The subscript is forgotten, but for now it does not matter
	    end if;
	 end;
	 goto Loopend;
      end if;
      if (Acl.Argument(Arg_Counter)(1..2)) = "-p" then
	 declare
	    S : String := Ach.To_Upper (Acl.Argument(Arg_Counter));
	 begin
	    if S (3 .. S'Last) = Postproc then
	       null; --thats ok
	    else
	       Gct.Trace 
		 (Stream1, "This postprocessor is not supported at this moment");
	       goto Uit0;
	    end if;
	 end;
	 goto Loopend;
      end if;
      if Ach.To_Upper (Acl.Argument(Arg_Counter)) = "CL.TAP" then
	 P1 := Asu.To_Unbounded_String ("cl.tap"); -- used from vapt most likely
      elsif
	(Acl.Argument(Arg_Counter)(1) in 'A'..'Z') or
	(Acl.Argument(Arg_Counter)(1) in 'a'..'z')
      then  -- used on the commandline
	 P1 := Asu.To_Unbounded_String (Acl.Argument(Arg_Counter));
      else
	 goto Uit1;
      end if;
  <<Loopend>>
      Arg_Counter := Arg_Counter + 1;
   end loop;
   Gct.Trace (Debug_Str, "# input file: " & Asu.To_String (P1) &";");
   if P1 = "" then
      Gct.Trace (Stream1, Asu.To_String (P1) & " : No input file specified");
      goto Uit0;
   end if;
   -- if we got here we should have a valid commandline
   
   Pp.Text := Pp.Open (Name => Asu.To_String (P1));
   if Pp.Text = null then -- error
      Gct.Trace (Stream1, Asu.To_String (P1) & " : File does not exist");
      goto Uit0;
   end if;
   -- if we got here we are ready to parse
   
   if Pp.Parse (Pp.Text) = Pp.Success then
      --Pp.Close (Pp.Text);
      goto Uit;
   else
      Gct.Trace 
	(Stream1, "The cutter-location file did not parse, it contains errors");
      --Pp.Close (Pp.Text);
      goto Uiterr;
   end if;
   
<<Uit1>>
   Gct.Trace 
	(Stream1, "Syntax Error");
<<Uit0>>
   Machin.Help;
<<Uiterr>>
   return 1; -- PostpFail in vapt
<<Uit>>
   return 0; -- success in vapt.
end Postp;

