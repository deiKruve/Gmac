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
--  via the file selector to tasks.
---
-- the sixth axis remains to be done.
--
with Ada.Exceptions;
with GNATCOLL.Traces;
with Ada.Text_IO;
--with Ada.Text_IO.Float_IO;
with Ada.Streams;

with Generic_Scanner;
with Ada.Strings.Unbounded;
with Silmaril.Dll;

package body Silmaril.Reader is
   
   package Gct renames GNATCOLL.Traces;
   package Asu renames Ada.Strings.Unbounded;
   package Ics renames Interfaces.C.Strings;
   package Dll renames Silmaril.Dll;
   
   subtype Fedrat_Type is Long_Float;
   Fedrat : Fedrat_Type := 0.0;
   
   -- anything distance --
   subtype Posvec1_Type is Long_Float;
   package Pvio  is new Ada.Text_IO.Float_IO (Num => Posvec1_Type);
   
   type Extended_Token_Type is
     (
      Clamp, Release,          -- digital m-functions
      Spindl, Fadein, Fadeout, -- analog M-fuctions
      Beam, Sixa, F,           -- analog values
      From, Gto,
      Fini,
      A, B, C, X, Y, Z, D, T, Istop,
      Float, Number,
      Tru, Flse, On, Off,
      Secs, Percent, Colon,
      EOF, Error, Ok);
   -- the tokens recognized by this scanner --

   subtype Token_Type is Extended_Token_Type range Clamp .. EOF;
   
   subtype Cmd_Token_Type is Extended_Token_Type range Clamp .. Fini;
   
   subtype Poscmd_Token_Type is Extended_Token_Type range From .. Gto;
   
   subtype Pos_Token_Type is Extended_Token_Type range A .. Z;
   
   package Scan is new Generic_Scanner (Token_Type);
   
   function "+" (X : String) return Asu.Unbounded_String
     renames Asu.To_Unbounded_String;
   
   
   -- logging
   Stream1 : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER");
   Stream2 : constant Gct.Trace_Handle := 
     Gct.Create ("SILMARILREADER.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER.DEBUG");

   Tokens : constant Scan.Token_Regexp_Array :=
     (Clamp       => +"CLAMP",
      Release     => +"RELEASE",
      Spindl      => +"SPINDL",
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
      Tru         => +"TRUE",
      Flse        => +"FALSE",
      On          => +"ON",
      Off         => +"OFF",
      Secs        => +"secs",
      Percent     => +"%",
      Colon       => +":",
      Fini        => +"FINI",
      EOF         => +"");

   
   procedure Debug_Line (Pos : Dll.Posvec_Class_Access_Type)
   is
      Listpos9 : aliased Dll.Posvec9_Access_Type;
      Xstr, Ystr, Zstr, Tstr, Fstr   : String := "        ";
      Astr, Bstr, Cstr, d3dstr       : String := "        ";
      Cmdstr                         : String := "    ";
      use type Dll.Cmd_Token_Type;
   begin
      if Gct.Active (Debug_Str) then
      	 if Pos.all in Dll.Posvec9_Type then
	    Listpos9 := Dll.Posvec9_Access_Type (Pos);
	    Pvio.Put (Xstr, Listpos9.X, 3, 0);
	    Pvio.Put (Ystr, Listpos9.Y, 3, 0);
	    Pvio.Put (Zstr, Listpos9.Z, 3, 0);
	    Pvio.Put (Tstr, Posvec1_Type (Listpos9.Tightness), 3, 0);
	    Pvio.Put (Fstr, Listpos9.Fedrat, 2, 0);
	    if Listpos9.From then Cmdstr := "FROM";
	    else Cmdstr := "GOTO"; end if;
	    Gct.Trace (Debug_Str, Cmdstr & " X " & Xstr & " Y " & Ystr & 
			    " Z " & Zstr & " T " & Tstr & " F " & Fstr & ASCII.LF);
	    Pvio.Put (Astr, Posvec1_Type (Listpos9.A), 5, 0);
	    Pvio.Put (Bstr, Posvec1_Type (Listpos9.B), 5, 0);
	    Pvio.Put (Cstr, Posvec1_Type (Listpos9.C), 5, 0);
	    Pvio.Put (d3dstr, Posvec1_Type (Listpos9.d3d), 5, 0);
	    Gct.Trace (Debug_Str, " A " & Astr & " B " & Bstr & " C " & Cstr & 
			    " D " & D3dstr & " istop : " & 
			    Boolean'Image (ListPos9.Istop) & ASCII.LF);
	 elsif Pos.all in Dll.Posvec_S_Type  then
	    Gct.Trace (Debug_Str, Dll.Posvec_S_Access_Type (Pos).Sa.all & 
			    ASCII.LF);
	 elsif Pos.all in Dll.Posvec_C_Type then
	    declare
	       Cmdstrn : String := Dll.Cmd_Token_Type'Image 
		 (Dll.Posvec_C_Access_Type (Pos).C);
	    begin
	       if Dll.Posvec_C_Access_Type (Pos).C = Dll.Clamp or 
		 Dll.Posvec_C_Access_Type (Pos).C = Dll.Release then
		  declare
		     Axstrn  : String := Dll.Axis_Token_Type'Image 
		       (Dll.Posvec_C_Access_Type (Pos).Ax);
		  begin
		     Gct.Trace (Debug_Str, Cmdstrn & " " & Axstrn & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (Pos).C = Dll.Fadein or
		 Dll.Posvec_C_Access_Type (Pos).C = Dll.Fadeout then
		  declare
		     Valstrn : String := Long_Float'Image 
		       (Dll.Posvec_C_Access_Type (Pos).Val);
		  begin
		     Gct.Trace 
		       (Debug_Str, Cmdstrn & " " & Valstrn & "secs" & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (Pos).C = Dll.F then
		  declare  -- this section is not applicable
		     Valstrn : String := Long_Float'Image 
		       (Dll.Posvec_C_Access_Type (Pos).Val);
		  begin
		     Gct.Trace (Debug_Str, Cmdstrn & " " & Valstrn & ASCII.LF);
		  end;
	       elsif Dll.Posvec_C_Access_Type (Pos).C = Dll.Spindl or
		 Dll.Posvec_C_Access_Type (Pos).C = Dll.Beam then
		  declare
		     Trstrn : String := Boolean'Image 
		       (Dll.Posvec_C_Access_Type (Pos).Tr);
		  begin
		     if Dll.Posvec_C_Access_Type (Pos).Tr = True then
			declare
			   Valstrn : String := Long_Float'Image 
			     (Dll.Posvec_C_Access_Type (Pos).Val);
			begin
			   Gct.Trace  (Debug_Str, Cmdstrn & " " & Trstrn & " " & 
					    Valstrn & ASCII.LF);
			end;
		     else
			Gct.Trace (Debug_Str, Cmdstrn & " " & Trstrn & ASCII.LF);
		     end if;
		  end;
	       elsif Dll.Posvec_C_Access_Type (Pos).C = Dll.Fini then
		  Gct.Trace (Debug_Str, "THE END OF THINGS." & ASCII.LF);
	       else 
		  Gct.Trace (Debug_Str, "Debug_Line : not done yet!!!!");
	       end if;
	    end;
	 else 
	    Gct.Trace (Debug_Str, "Debug_Line : unknown class");
	 end if;
      end if;
   end Debug_Line;
   
   
   function Scanit (S : String) return Boolean
   is
      List, 
      List_Next  : Dll.Dllist_Access_Type := null;
      Curtok     : Extended_Token_Type;
      Val        : Long_Float             := 0.0;
      Last_Istop : Boolean                := False;
      use type Dll.Dllist_Access_Type;
      
      Scanner : Scan.Scanner_Type :=
	Scan.New_Scanner
	(Input            => S,
	 Regexps          => Tokens,
	 Xtra_White_Space => "",
	 Comment_Delim    => Scan.Comment_Like (Scan.Shell_Like),
	 Scan             => False);
      
      function Next_Tok return Extended_Token_Type
      is
      begin
	 if not Scanner.At_Eof then
	    return Scanner.Next_Token;
	 else return EOF;
	 end if;
      end Next_Tok;
      
      function Find_Command return Extended_Token_Type
      is
	 Token : Token_Type;
      begin
	 Token := Scanner.Next_Token;
	 if Scanner.At_Eof or Token = EOF then return EOF;
	 elsif Token in Cmd_Token_Type then return Token;
	 else return Error; 
	 end if;
      end Find_Command;
      
      function Find_Val_Tok (Val : in out Long_Float) 
			    Return Extended_Token_Type
      is
	 Token : Token_Type;
      begin
	 if not Scanner.At_Eof then
	    Token := Scanner.Next_Token;
	    if Token = Float then
	       Val := Long_Float'Value (Scanner.String_Value);
	       return Ok;
	    else return Error; 
	    end if;
	 else return Error;
	 end if;
      end Find_Val_Tok;
      
      function Find_Bool_Tok (B : in out Boolean) 
			     return Extended_Token_Type
      is
	 Token : Token_Type;
      begin
	 if not Scanner.At_Eof then
	    Token := Scanner.Next_Token;
	    if Token = On or Token = Tru then B := True; return Ok;
	    elsif Token = Off or Token = Flse then B := False; return Ok;
	    else return Error; 
	    end if;
	 else return Error;
	 end if;
      end Find_Bool_Tok;
      
      function Find_Percent_Tok return Extended_Token_Type
      is
	 Token : Token_Type;
      begin
	 if not Scanner.At_Eof then
	    Token := Scanner.Next_Token;
	    if Token = Percent then return Ok;
	    else return Error; 
	    end if;
	 else return Error;
	 end if;
      end Find_Percent_Tok;
      
      function Find_Pos (Pos9 : access Dll.Posvec9_Type) 
			return Extended_Token_Type
      is
	 Curtok : Token_Type;
	 Val    : Long_Float := 0.0;
	 Truth  : Boolean := False;
      begin
	 loop
	    Curtok := Next_Tok;
	    exit when Curtok /= X;
	    exit when Find_Val_Tok (Val) = Error;
	    Pos9.X := Val;
	    Curtok := Next_Tok;
	    exit when Curtok /= Y;
	    exit when Find_Val_Tok (Val) = Error;
	    Pos9.Y := Val;
	    Curtok := Next_Tok;
	    exit when Curtok /= Z;
	    exit when Find_Val_Tok (Val) = Error;
	    Pos9.Z := Val;
	    Curtok := Next_Tok;
	    exit when Curtok /= T;
	    exit when Find_Val_Tok (Val) = Error;
	    Pos9.Tightness := Val;
	    Curtok := Next_Tok;
	    if Curtok = A then
	       exit when Find_Val_Tok (Val) = Error;
	       Pos9.A := Val;
	       Curtok := Next_Tok;
	       exit when Curtok /= B;
	       exit when Find_Val_Tok (Val) = Error;
	       Pos9.B := Val;
	       Curtok := Next_Tok;
	       exit when Curtok /= C;
	       exit when Find_Val_Tok (Val) = Error;
	       Pos9.C := Val;
	       Curtok := Next_Tok;
	    else 
	       Pos9.A := 0.0;
	       Pos9.B := 0.0;
	       Pos9.C := 0.0;
	    end if;
	    exit when Curtok /= D;
	    exit when Find_Val_Tok (Val) = Error;
	    Pos9.D3d := Val;
	    Curtok := Next_Tok;
	    exit when Curtok /= Istop;
	    Curtok := Next_Tok;
	    exit when Curtok /= Colon;
	    exit when Find_Bool_Tok (Truth) = Error;
	    Pos9.Istop := Truth;
	    Pos9.Fedrat := Fedrat;
	    if Last_Istop and  Truth then -- both on
	       Pos9.Blend := Dll.Straight;
	    elsif Last_Istop and not Truth then 
	       Pos9.Blend := Dll.Blendout;
	    elsif not Last_Istop and Truth then
	       Pos9.Blend := Dll.Blendin;
	    elsif not Last_Istop and not Truth then
	       Pos9.Blend := Dll.Blendboth;
	    end if;
	    Last_Istop := Truth;
	    return Ok;
	 end loop;
	 return Error;
      end Find_Pos;
      
      function Find_Axis (Posc : access Dll.Posvec_C_Type) 
			 return Extended_Token_Type
      is
	 Curtok : Token_Type;
      begin
	 loop
	    Curtok := Next_Tok;
	    exit when Curtok not in Pos_Token_Type;
	    case Curtok is
	       when A => Posc.Ax := Dll.A;
	       when B => Posc.Ax := Dll.B;
	       when C => Posc.Ax := Dll.C;
	       when X => Posc.Ax := Dll.X;
	       when Y => Posc.Ax := Dll.Y;
	       when Z => Posc.Ax := Dll.Z;
	       when others => null;
	    end case;
	    return Ok;
	 end loop;
	 return Error;
      end Find_Axis;
      
      function Find_Time (Posc : access Dll.Posvec_C_Type) 
			 return Extended_Token_Type
      is
	 Curtok : Token_Type;
	 Val    : Long_Float := 0.0;
      begin
	 loop
	    exit when Find_Val_Tok (Val) = Error;
	    Curtok := Next_Tok;
	    exit when Curtok /= Secs;
	    Posc.Val := Val;
	    return Ok;
	 end loop;
	 return Error;
      end Find_Time;
      
      function Find_Beam (Posc : access Dll.Posvec_C_Type) 
			 return Extended_Token_Type
      is
	 Val    : Long_Float := 0.0;
	 B      : Boolean    := False;
      begin
	 loop
	    exit when Find_Bool_Tok (B) = Error;
	    if B = True then
	       exit when Find_Val_Tok (Val) = Error;
	       Posc.Val := Val;
	       Posc.Tr  := B;
	       exit when Find_Percent_Tok = Error;
	    else
	       Posc.Tr  := False;
	    end if;
	    return Ok;
	 end loop;
	 return Error;
      end Find_Beam;
      
   begin
      if Prog_Anchor /= null then
	 Prog_Q.Finalize (Prog_Anchor);
	 Prog_Anchor := null;
      end if;
      Prog_Anchor := new Dll.Dllist_Type;
      Dll.Initialize (Prog_Anchor);
      Curtok := Find_Command;
      while Curtok /= EOF and Curtok /= Error loop
	 loop
	    --Ada.Text_IO.Put_line (Token_Type'Image (Curtok));
	    case Curtok is
	       when F       => 
		  exit when Find_Val_Tok (Val) = Error;
		  Fedrat := Val;
	       when Gto     =>
		  declare
		     Pos9 : access Dll.Posvec9_Type := 
		       new Dll.Posvec9_Type;
		  begin
		     Pos9.From := False;
		     exit when Find_Pos (Pos9) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec3_Class_Access_Type (Pos9), 
			Next  => Prog_Anchor,
			Mnext => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Pos9));
		  end;
	       when Sixa    =>
		  null;
	       when Clamp   =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Clamp;
		     exit when Find_Axis (Posc) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when Release =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Release;
		     exit when Find_Axis (Posc) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when Beam | Spindl    =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Beam;
		     exit when Find_Beam (Posc) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when Fadein  =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Fadein;
		     exit when Find_Time (Posc) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when Fadeout =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Fadeout;
		     exit when Find_Time (Posc) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when From    =>
		  declare
		     Pos9 : access Dll.Posvec9_Type := 
		       new Dll.Posvec9_Type;
		  begin
		     Pos9.From := True;
		     exit when Find_Pos (Pos9) = Error;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec3_Class_Access_Type (Pos9), 
			Next  => Prog_Anchor,
			Mnext => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Pos9));
		  end;
	       when Fini    =>
		  declare
		     Posc : access Dll.Posvec_C_Type :=
		       new Dll.Posvec_C_Type;
		  begin
		     Posc.C := Dll.Fini;
		     Prog_Q.Insert_Pv_Before 
		       (This  => Dll.Posvec_Class_Access_Type (Posc), 
			Next  => Prog_Anchor);
		     Debug_Line (Dll.Posvec_Class_Access_Type (Posc));
		  end;
	       when others =>
		  null;
	    end case;
	    Curtok := Ok;
	    exit;
	 end loop;
	 if Curtok = Ok then
	    Curtok := Find_Command;
	 else 
	    Gct.Trace (Debug_Str, "Faulty line started with " & 
			 Token_Type'Image (Curtok) & "token.");
	    exit;
	 end if;
      end loop;
      if Curtok = EOF then
	 return True;  -- must have been EOF.
      else
	 return False; -- return false if eof was not reached
      end if;
   exception
      when E : others =>
	 Gct.Trace (Stream2, Ada.Exceptions.Exception_Information (E));
	 return False;
   end Scanit;
   
   
   function Start_Reading (Cs : in Interfaces.C.Strings.Chars_ptr)
			  return Boolean
     -- function Start_Reading parses the char_array it is given by 
     -- Silmaril.File_Selector. It will return true when done, or false on error.
     -- an error would be indicated in a pop up window in File_Selector perhaps.
     -- do we have to log it??
   is
   begin
      return Scanit (Ics.Value (Cs));
   end Start_Reading;
   
   function Start_Reading (Str : String) return Boolean
     -- for testing
   is
   begin
      return Scanit (Str);
   end Start_Reading;
   
   
end Silmaril.Reader;
