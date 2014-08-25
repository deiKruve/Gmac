------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                B E R E N . D E S P A T C H . H E L P E R S               --
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
--                 Beren is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with O_String;
with Beren.Jogobj;

package body Beren.Despatch.Helpers is
   package Tio   renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
   
   package Bjo renames Beren.Jogobj;
   package Obs renames O_String;
   
   procedure Enumerate_Attr (Name : String; M : Beren.Jogobj.Attr_Msg)
   is
      use type Bjo.Attr_Class;
   begin
      case M.Class is
	 when Bjo.Str  =>  Send_Reply_Msg (Obs.To_String (M.S));
	 when Bjo.Int  => 
	    declare
	       Rstr  : String := Integer'Image (M.I);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Real => 
	    declare 
	       Rstr : String := Long_Float'Image (M.X);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Real_Pair =>
	    declare 
	       Rstr : String := Long_Float'Image (M.X);
	       R1str : String := Long_Float'Image (M.X1);
	    begin
	       Send_Reply_Msg 
		(Name & " : " & Obs.To_String (M.Name) & " = " & Rstr & " " & R1str);
	    end;
	 when Bjo.Char => Send_Reply_Msg (M.C);
	 when Bjo.Bool => 
	    declare
	       Rstr  : String := Boolean'Image (M.B);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when Bjo.Enum => 
	    declare
	       Rstr  : String := Bjo.Pulse_Mode_Enumeration_Type'Image (M.E);
	    begin
	       Send_Reply_Msg 
		 (Name & " : " & Obs.To_String (M.Name) & " = " & Rstr);
	    end;
	 when others   => 
	    null;
      end case;
   end Enumerate_Attr;
   
   
   ----------------------------------
   -- parameter file handling      --
   -- not  used here at the moment --
   ----------------------------------
   
   -- open a file for writing, or std.out --
   procedure Opens_Out_File (Name : String := ""; 
			     Ofd  : in out Tio.File_Type; 
			     Ostr : in out Tiots.Stream_Access)
   is
   begin
      if Name = "" then
	 Send_Reply_Msg ("file could not be found.");
	 --Ofd  := Tio.Standard_Output; --Tio.Standard_Output;
	 Ostr := Tiots.Stream (Tio.Standard_Output);
	 --Tio.Put_Line("we got here1");
      else
	 declare
	 begin
	    Tio.Open (File => Ofd, Mode => Tio.Out_File, 
		      Name => Name);
	 exception 
	    when Tio.Name_error =>
	       Tio.Create (File => Ofd, Mode => Tio.Out_File, 
			   Name => Name);
	 end;
	 Ostr := Tiots.Stream (Ofd);
	 --Tio.Put_Line("we got here2");
      end if;
   exception
      when others =>
	 Send_Reply_Msg ("file could not be found.");
	 --Ofd  := Tio.Standard_Output; --Tio.Standard_Output;
	 Ostr := Tiots.Stream (Tio.Standard_Output);
   end Opens_Out_File;
   
   
   -- open a file for reading --
   procedure Opens_In_File (Name : String := ""; 
			   Ifd  : in out Tio.File_Type; 
			   Istr : in out Tiots.Stream_Access)
   is
   begin
      Tio.Open (File => Ifd, Mode => Tio.In_File, 
		Name => Name);
      Istr := Tiots.Stream (Ifd);
   exception when others =>
      Send_Reply_Msg ("file could not be found.");
      -- Tio.Put_Line ("file could not be found.");
      --ifd  := null;
      istr := null;
   end Opens_In_File;
   
begin
   Enumerate     := Enumerate_Attr'Access;
   Open_Out_File := Opens_Out_File'Access;
   Open_In_File  := Opens_In_File'Access;
end Beren.Despatch.Helpers;
