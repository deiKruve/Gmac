------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                        S I L M A R I L . R E A D E R                     --
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
--                Silmaril is maintained by J de Kruijf Engineers           --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

--  Is called by Silmaril.File_Selector to read the file and store it
--  in the master dll.
-- In case of error it gets reported to either the file_selector or 
--  via the file selctor to tasks.

with GNATCOLL.Traces;
with Generic_Scanner;
with Ada.Strings.Unbounded;

package body Silmaril.Reader is
   
   package Gct renames GNATCOLL.Traces;
   package Asu renames Ada.Strings.Unbounded;
   package Ics renames Interfaces.C.Strings;
   
   type Extended_Token_Type is
     (
      Clamp, Release,          -- digital m-functions
      Spindl, Fadein, Fadeout, -- analog M-fuctions
      Beam, Sixa, F,           -- analog values
      From, Gto,
      Fini,
      A, B, C, D, T, X, Y, Z, Istop,
      Float, Number,
      On, Off,
      Secs, Percent, 
      EOF, Error);
   -- the tokens recognized by this scanner --

   subtype Token_Type is Extended_Token_Type range Clamp .. EOF;
   
   subtype Cmd_Token_Type is Extended_Token_Type range Clamp .. Fini;
   
   subtype Poscmd_Token_Type is Extended_Token_Type range From .. Gto;
   
   subtype Pos_Token_Type is Extended_Token_Type range A .. Z;
   
   package Scan is new Generic_Scanner (Token_Type);
   
   function "+" (X : String) return Asu.Unbounded_String
                 renames Asu.To_Unbounded_String;
   
   
   -- package Gct renames GNATCOLL.Traces;
   Stream1 : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER");
   Stream2 : constant Gct.Trace_Handle := 
     Gct.Create ("SILMARILREADER.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER.DEBUG");

   Tokens : constant Scan.Token_Regexp_Array :=
     (Clamp       => +"CLAMP",
      Release     => +"RELEASE",
      Spindl      => +"SPINDLE",
      Fadein      => +"FADEIN",
      Fadeout     => +"FADEOUT",
      Beam        => +"BEAM",
      Sixa        => +"SIXA",
      F           => +"F",
      From        => +"FROM",
      Gto         => +"GOTO",
      A           => +"A",
      B           => +"B",
      C           => +"C",
      D           => +"D",
      T           => +"T",
      X           => +"X",
      Y           => +"Y",
      Z           => +"Z",
      Istop       => +"istop",
      Float       => Scan.Float_Regexp,
      Number      => Scan.Number_Regexp,
      On          => +"ON",
      Off         => +"OFF",
      Secs        => +"secs",
      Percent     => +"%",
      Fini        => +"FINI",
      EOF         => +"");
      
   procedure Error_Message (Message : String)
   is
   begin
      Gct.Trace (Stream1, Message);
   end Error_Message;
   
   --function "+" (X : String) return Asu.Unbounded_String
                 --renames Asu.To_Unbounded_String;
   
   
   function Find_Command return Cmd_Token_Type
   is
   begin
      return Error;
   end Find_Command;
   
   
   --function Find_Pos return Pos_Token_Type, Long_Real;
   
   --function Find_Val return Long_Real;
   
   --function Find_Truth return Boolean;
   
   
   function Scanit (S : String) return Boolean
   is
      --package Scan is new Generic_Scanner (Token_Type);
      Scanner : Scan.Scanner_Type :=
     Scan.New_Scanner
     (Input         => S,
      Regexps       => Tokens,
      Xtra_White_Space => "",
      Comment_Delim => Scan.Comment_Like (Scan.Shell_Like),
      Scan          => False);
   begin
      case Find_Command is
	 when Gto     =>
	    null;
	 when Sixa    =>
	    null;
	 when Clamp   =>
	    null;
	 when Release =>
	    null;
	 when Beam | Spindl    =>
	    null;
	 when Fadein  =>
	    null;
	 when Fadeout =>
	    null;
	 when From    =>
	    null;
	    
	 when Fini    =>
	    return True;
	 when others =>
	    null;
      end case;
      return False;
   end Scanit;
   
   
   
   function Start_Reading (Cs : in Interfaces.C.Strings.Chars_ptr)
			  return Boolean
     -- function Start_Reading parses the char_array it is given by 
     -- Silmaril.File_Selector. It will return true when done, or false on error.
     -- an error would also be indicated in a pop up window in File_Selector perhaps.function Value (Item : chars_ptr) return String;
   is
   begin
      return Scanit (Ics.Value (Cs));
   end Start_Reading;
   
   function Start_Reading (Str : String) return Boolean
   is
   begin
      return Scanit (Str);
   end Start_Reading;
   
   
end Silmaril.Reader;
