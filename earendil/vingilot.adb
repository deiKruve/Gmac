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
--with Beren.Despatch.Helpers;
--with Berentest1;

with Earendil.Client1;
with Vingilot_Helpers;
with Ada.Text_IO;
with Ada.Characters.Latin_1;

procedure Vingilot is
   
   package Erd renames Earendil;
   package Ec1 renames Earendil.Client1;
   package Tio renames Ada.Text_IO;
   package Chr renames Ada.Characters.Latin_1;
   
   J, K : Integer;
begin
   Ec1.String_Displayer := Vingilot_Helpers.Str_Display'Access;
   loop
      Tio.Put ("vingilot >> ");
      declare 
	 S : String := Tio.Get_Line;
      begin
	 Tio.Put_Line ("string: " & S);
	 -- find 1st space:
	 for I in S'First .. S'Last loop
	    exit when S (Integer (I)) in ' ' | Chr.Cr;
	    K := Integer (I);
	 end loop;
	 J := K + 1;
	 for I in J .. S'Last loop
	    exit when S (i) /= ' ';
	    J := J + 1;
	 end loop;
	 declare 
	    Command : String := S (S'First .. S'First + K - 1);-- & "@";
	    Argument : String := S (J .. S'Last);-- & "@";
	 begin
	    Tio.Put_Line ("Command  : " & Command);
	    Tio.Put_Line ("Argument : " & Argument);
	    if Command = "setpar" then
	       Ec1.Send_Parset_Msg (S (J .. S'Last));
	       null;
	    elsif Command = "load" then
	       Ec1.Send_File_Msg (S (J .. S'Last), Erd.Load);
	       null;
	    elsif Command = "store" then
	       Ec1.Send_File_Msg (S (J .. S'Last), Erd.Store);
	       null;
	    elsif Command = "enum" then
	       Ec1.Send_Enum_Msg;
	       null;
	    else Tio.Put_Line ("  command syntax error.");
	    end if; -- command
	 end;
      end;
   end loop;
exception
   when others => Tio.Put_Line ("-------------------> No connection.");
end Vingilot;
