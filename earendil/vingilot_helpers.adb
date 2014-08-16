------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                       V I N G I L O T . H E L P E R S                    --
--                                                                          --
--                                  B o d y                                 --
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
--                 Earendil is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- This is a first try at a terminal for earendil, the extra routines

with GNAT.Expect;
with Beren.Thread;
with Ada.Calendar; -- debug
package body Vingilot_Helpers is
   package Cal   renames Ada.Calendar; -- debug
   package Tio   renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
   package Gex   renames GNAT.Expect;
   package Aubs  renames Ada.Strings.Unbounded;
   
   ------------------------------------------------
   -- dislay the output of the enum command      --
   -- the argument is used as a pattern for grep --
   -- so a partial enumeration is possible       --
   ------------------------------------------------
   procedure Str_Display (S : String)
   is
      Status : aliased Integer := 0;
      Sr : String := Gex.Get_Command_Output
	(Command   => "grep",
	 Arguments => (new String'("-i"), 
		       new String'("-e" & Aubs.To_String (Patrn)), 
		       new String'("-")),
	 Input     => S,
	 Status    => Status'access);
   begin
      if Status = 0 then
	 Tio.Put_Line (sr);
      end if;
   end Str_Display;
   
   
   --------------------------------------------------
   -- display the output of some get attr commands --
   -- also Str_Display can be used, there will     --
   -- just be no pattern for grep                  --
   --------------------------------------------------
   procedure Boolean_Display (B : Boolean)
   is
   begin
      Tio.Put_Line (Boolean'Image (B));
   end Boolean_Display;
   
   
   procedure Character_Display (C : Character)
   is
   begin
      Tio.Put_Line (Character'Image (C));
   end Character_Display;
   
   
   procedure Real_Display (X : Long_Float)
   is
   begin
      Tio.Put_Line (Long_Float'Image (X));
   end Real_Display;
   
   
   procedure Integer_Display (I : Integer)
   is
   begin
      Tio.Put_Line (Integer'Image (I));
   end Integer_Display;
   
   
   -------------------------------
   -- taske to scan the modules --
   -- for debugging only        --
   -------------------------------
   task Scanner;
   task body Scanner 
      is
      use type Cal.Time;
      Busy : Boolean := True;
      Period : Duration := 1.0; -- secs
      Next_Time : Cal.Time := Cal.Clock + period;
      This_Time : Cal.Time := Next_Time;
      Done_Time : Cal.Time;
   begin
      while Busy loop
	 delay until Next_Time;
	 This_Time := Next_Time;
	 Next_Time := Next_Time + Period;
	 Beren.Thread.Scan;
	 Done_Time := Cal.Clock;
	 Tio.Put_Line ("Scan Time : " & Duration'Image (Done_Time - This_Time));
      end loop;
   end Scanner;
   
   
   
   --  ----------------------------------
   --  -- parameter file handling      --
   --  -- not  used here at the moment --
   --  ----------------------------------
   
   --  -- open a file for writing, or std.out --
   --  procedure Open_Out_File (Name : String := ""; 
   --  			     Ofd  : out Tio.File_Type; 
   --  			     Ostr : out Tiots.Stream_Access)
   --  is
   --  begin
   --     if Name = "" then
   --  	 Ofd  := Tio.Standard_Output;
   --  	 Ostr := Tiots.Stream (Tio.Standard_Output);
   --     else
   --  	 declare
   --  	 begin
   --  	    Tio.Open (File => Ofd, Mode => Tio.Out_File, 
   --  		      Name => Name);
   --  	 exception 
   --  	    when Tio.Name_error =>
   --  	       Tio.Create (File => Ofd, Mode => Tio.Out_File, 
   --  			   Name => Name);
   --  	 end;
   --  	 Ostr := Tiots.Stream (Ofd);
   --     end if;
   --  exception
   --     when others =>
   --  	 Ofd  := Tio.Standard_Output;
   --  	 Ostr := Tiots.Stream (Tio.Standard_Output);
   --  end Open_Out_File;
   
   
   --  -- open a file for reading --
   --  function Open_In_File (Name : String := ""; 
   --  			  Ifd  : out Tio.File_Type; 
   --  			  Istr : out Tiots.Stream_Access)
   --  is
   --  begin
   --     Tio.Open (File => Ifd, Mode => Tio.In_File, 
   --  		Name => Name);
   --     Istr := Tiots.Stream (Ifd);
   --  exception when others =>
   --     Tio.Put_Line ("file could not be found.");
   --     Ofd  := null;
   --     Ostr := null;
   --  end Open_In_File;
   
end Vingilot_Helpers;


