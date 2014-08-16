------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                               V I N G I L O T                            --
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
-- This is a first try at a terminal for earendil.

-- these must move to their own partition ultimately
with Beren.Despatch.Helpers;
with Berentest1;
with Beren.Thread;

with Earendil.Client1;
with Vingilot_Helpers;
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;

procedure Vingilot is
   package Vh   renames Vingilot_Helpers;
   package Erd  renames Earendil;
   package Ec1  renames Earendil.Client1;
   package Tio  renames Ada.Text_IO;
   package Tiots renames Ada.Text_IO.Text_Streams;
   package Chr  renames Ada.Characters.Latin_1;
   package Aubs renames Ada.Strings.Unbounded;
   
   J, K : Integer;
begin
   -- set up some up-calls.
   Ec1.String_Displayer    := Vh.Str_Display'Access;
   Ec1.Boolean_Displayer   := Vh.Boolean_Display'Access;
   Ec1.Character_Displayer := Vh.Character_Display'Access;
   Ec1.Real_Displayer      := Vh.Real_Display'Access;
   Ec1.Integer_Displayer   := Vh.Integer_Display'Access;
   -- and connect.
   Ec1.Send_Connect_Msg;
   -- the main loop.
   loop
      Tio.Put ("vingilot >> ");
      declare 
	 S : String := Tio.Get_Line;
      begin
	 --Tio.Put_Line ("string: " & S);
	 -- find 1st space:
	 K := 0;
	 for I in S'First .. S'Last loop
	    exit when S (Integer (I)) in ' ' | Chr.Cr;
	    K := Integer (I);
	 end loop;
	 J := K + 1;
	 for I in J .. S'Last loop
	    exit when S (i) /= ' ';
	    J := J + 1;
	 end loop;
	 if K > 1 then
	    declare 
	       Command : String := S (S'First .. S'First + K - 1);-- & "@";
	       Argument : String := S (J .. S'Last);-- & "@";
	    begin
	       --Tio.Put_Line ("Command  : " & Command);
	       --Tio.Put_Line ("Argument : " & Argument);
	       if Command = "setpar" then 
		  -- <Name> ".Jog_Rate = " <floatValue> [" m/min"|" deg/min"]
		  -- and any other we may think of
		  Ec1.Send_Parset_Msg (S (J .. S'Last));
		  null;
	       --elsif Command = "setattr" then
		  -- "setattr "<moduleName>"."<attrName>" = "<floatValue><units>
		  -- like setpar but has more possibilities. for debugging
		  --Ecl.Send_Attr_Msg (S (J .. S'Last), Erd.Set);
	       elsif Command = "getattr" then
		  -- "getattr " <moduleName> "." <attrName>
		  
		  Ec1.Send_Attr_Msg (S (J .. S'Last), Erd.Get);
	       elsif Command = "load" then 
		  -- "load " <filename>|<>
		  Ec1.Send_File_Msg (S (J .. S'Last), Erd.Load);
		  null;
	       elsif Command = "store" then 
		  -- "store " <filename>|<>
		  Ec1.Send_File_Msg (S (J .. S'Last), Erd.Store);
		  null;
	       elsif Command = "enum" then 
		  -- "enum " <grepfilter>|<>
		  Vh.Patrn := Aubs.To_Unbounded_String (Argument);
		  Ec1.Send_Enum_Msg;
		  null;
	       else Tio.Put_Line ("  command syntax error.");
	       end if; -- command
	    end;
	 end if; --k > 1
      end;
   end loop;
--exception
--   when others => Tio.Put_Line ("-------------------> No connection.");
end Vingilot;
