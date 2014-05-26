------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                        P O S T . S C A N N E R                           --
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
--  The post.scanner that scans the incoming data stream from APT360
--   (the Binary file)
--


with GNATCOLL.Traces;
with Ada.Unchecked_Conversion;
with Text_Io;

package body Post.Scanner is
   package As  renames Ada.Streams;  
   package Tio renames Text_Io; 
   package Gct renames GNATCOLL.Traces;
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");

   
   function "<" (Left, Right : Kwi_Type) return Boolean is
   begin
      return false;
   end "<";

   function "<" (Left, Right : MKwi_Type) return Boolean is
   begin
      return false;
   end "<";
   
   function "=" (Left, Right : Key_Word_Type) return Boolean is 
   begin
      return false;
   end "=";
   
   function "=" (Left, Right : MKey_Word_Type) return Boolean is 
   begin
      return false;
   end "=";   
   
   
   ------------------------------
   -- cl file scanner routines --
   ------------------------------
   
   -- scan 64 bit integer --
   function Scan_Long_Long_Integer (I : in out Long_Long_Integer) return Boolean
   is
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
      Err : Boolean                  := False;
      R   : As.Stream_Element_Offset := Next_Token;
      Sa  : Stream_Element_Array (1 .. 8);
      it  : Long_Long_Integer;
      for It'Address use Sa'Address;
   begin
      Sa := Text (R .. (R + 7));
      If R <= Text'Last + 1 and It'Valid then
	 I := It;
	 Next_Token := R + 8;
      else
	 Gct.Trace 
	   (Debug_Str, "input file: badly formed long integer or end of file");
	 Err := True;
      end if;
      return Err;
   end Scan_Long_Long_Integer;
   
   
   -- scan 32 bit integer --
   function Scan_Integer (I : in out Integer) return Boolean
   is
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
      Err : Boolean                  := False;
      R   : As.Stream_Element_Offset := Next_Token;
      Sa  : Stream_Element_Array (1 .. 4);
      It  : Integer;
      for It'Address use Sa'Address;
   begin
      Sa := Text (R .. (R + 3));
      If R <= Text'Last + 1 and It'Valid then
	 I := It;
	 Next_Token := R + 4;
      else
	 Gct.Trace 
	   (Debug_Str, "input file: badly formed integer or end of file");
	 Err := True;
      end if;
      return Err;
   end Scan_Integer;
   
   
   -- scan a long float --
   function Scan_Double (D : in out Long_Float) return Boolean
   is
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
      Err : Boolean                  := False;
      R   : As.Stream_Element_Offset := Next_Token;
      Sa  : Stream_Element_Array (1 .. 8);
      Dt  : Long_Float;
      for Dt'Address use Sa'Address;
   begin
      Sa := Text (R .. (R + 7));
      If R <= Text'Last + 1 and Dt'Valid then
	 D := Dt;
	 Next_Token := R + 8;
      else
	 Gct.Trace 
	   (Debug_Str, "input file: badly formed float or end of file");
	 Err := True;
      end if;
      return Err;
   end Scan_Double;
   
   
   function Scan_String8 (S : in out String) return Boolean
   is
      type S8 is new String (1 .. 8);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Stream_Element_Array,
	 Target => S8);
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
      Err : Boolean                  := False;
      R   : As.Stream_Element_Offset := Next_Token;
   begin
      S := String (convert (Text (R .. (R + 7))));
      Next_Token := R + 8;
      return Err;
   end Scan_String8;
   
   
   function Scan_Info (S : in out String) return Boolean
   is
      type S88 is new String (1 .. 88);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Stream_Element_Array,
	 Target => S88);
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
      Err : Boolean                  := False;
      R   : As.Stream_Element_Offset := Next_Token;
   begin
      S := String (convert (Text (R .. (R + 87))));
      Next_Token := R + 88;
      return Err;
   end Scan_info;
   
   
   function Scan_Special_Feature_Index (V : in out Special_Feature_Type) 
				       return Boolean 
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Integer,
	 Target => Special_Feature_Type);
      pragma Warnings (On);
      I   : Integer  := 0;
      M   : Special_Feature_Type;
      Err : Boolean  := False;
   begin
      loop
	 Err := Scan_Integer (I);
	 exit when Err;
	 declare
	 begin
	    M := Convert (I);
	 exception
	    when Constraint_Error =>
	       Gct.Trace (Stream2, "Scan_Special_Feature_Index Error");
	       Err := True;
	       exit;
	 end;
	 V := M;
	 exit;
      end loop;
      return Err;
   end Scan_Special_Feature_Index;
     
    
   function Scan_Cut_Tol_Index (V : in out Cut_Tol_Type) return Boolean
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Integer,
	 Target => Cut_Tol_Type);
      pragma Warnings (On);
      I   : Integer  := 0;
      M   : Cut_Tol_Type;
      Err : Boolean  := False;
   begin
      loop
	 Err := Scan_Integer (I);
	 exit when Err;
	 declare
	 begin
	    M := Convert (I);
	 exception
	    when Constraint_Error =>
	       Gct.Trace (Stream2, "Scan_Cut_Tol_Index error");
	       Err := True;
	       exit;
	 end;
	 V := M;
	 exit;
      end loop;
      return Err;
   end Scan_Cut_Tol_Index;
   
   
   function Scan_Mov_Rec_Index (V : in out Move_Rec_Type) return Boolean
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Integer,
	 Target => Move_Rec_Type);
      pragma Warnings (On);
      I   : Integer  := 0;
      M   : Move_Rec_Type;
      Err : Boolean  := False;
   begin
      loop
	 Err := Scan_Integer (I);
	 exit when Err;
	 declare
	 begin
	    M := Convert (I);
	 exception
	    when Constraint_Error =>
	       Gct.Trace (Stream2, "Scan_Mov_Rec_Index error");
	       Err := True;
	       exit;
	 end;
	 V := M;
	 exit;
      end loop;
      return Err;
   end Scan_Mov_Rec_Index;
   
   
   function Scan_Kwi_Index (V : in out Kwi_Type) return Boolean 
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion 
	(Source => Integer,
	 Target => Kwi_Type);
      pragma Warnings (On);
      I   : Integer  := 0;
      M   : Kwi_Type;
      Err : Boolean  := False;
   begin
      loop
	 Err := Scan_Integer (I);
	 exit when Err;
	 declare
	 begin
	    M := Convert (I);
	 exception
	    when Constraint_Error =>
	       Gct.Trace (Stream2, "Scan_Kwi_Index error");
	       Err := True;
	       exit;
	 end;
	 V := M;
	 exit;
      end loop;
      return Err;
   end Scan_Kwi_Index;
   
   
   function Scan_Source_Line_Number (V : in out Long_Long_Integer) return boolean
   is
      Err  : Boolean                  := False;
      Byte : As.Stream_Element;
      R    : As.Stream_Element_Offset;
      I    : Long_Long_Integer        := 0;
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
   begin
      loop
	 Err := Scan_Long_Long_Integer (I);
	 exit when Err;
	 R := Next_Token - 1;
	 for I in 1 .. 4 loop
	    R := R + 1;
	    Byte := Text(R);
	    if Byte /= 0 then
	       Gct.Trace (Debug_Str, "input file: null Space Error");
	       Err := True;
	       exit when Err; 
	    end if;
	 end loop;
	 for I in 1 .. 8 loop
	    R := R + 1;
	    Byte := Text(R);
	    if Byte /= 16#20# then
	       Gct.Trace (Debug_Str, "input file: space Space Error");
	       Err := True;
	       exit when Err;
	    end if;
	 end loop;
	 Next_Token := R + 1;
	 V := I;
	 exit;
      end loop;
      return Err;
   end Scan_Source_Line_Number;
   
   
   function Scan_Header 
     (Header : in out Header_Type; Done : in out boolean) return Boolean 
   is
      pragma Warnings (Off);
      function Convert is new Ada.Unchecked_Conversion (Source => Integer,
							Target => Rec_Type);
      pragma Warnings (On);
      Err  : Boolean         := True;
      V    : Integer         := 0;
      M    : Rec_Type;
      R    : As.Stream_Element_Offset := Next_Token;
      use type As.Stream_Element_Offset;
      use type Ada.Streams.Stream_Element;
   begin
      if R + 11 > Text'Last then
	 Done := True;
	 Err  := False;
      else
	 Gct.Trace (Debug_Str, "# file pos: " & 
		      Ada.Streams.Stream_Element_Offset'Image (R));
	 loop
	    Err := Scan_Integer (V);
	    exit when Err;
	    Header.Rec_No := V;
	    
	    Err := Scan_Integer (V);
	    exit when Err;
	    Header.Rec_Len := Natural (V);

	    Err := Scan_Integer (V);
	    exit when Err;
	    declare
	    begin
	       M := Convert (V);
	    exception
	       when Constraint_Error =>
		  Gct.Trace 
		    (Stream2, "internal fault : Rec_Type not in the table");
		  Err := True;
		  exit;
	    end;
	    Header.Rec_T := M;
	    Done := False;
	    Err := False;
	    exit;
	 end loop;
      end if;
      return Err;
   end Scan_Header;
   
   Position : Keyw_Dict.Cursor;
   Inserted : Boolean;
begin
   Kwi_Map.Clear;
   Kwi_Map.Insert (Endk, New String'("END"), Position, Inserted);
   --Text_IO.Put_Line ("# pos= " & boolean'Image (inserted));
   Kwi_Map.Insert (Stop, new String'("STOP"), Position, Inserted);
   --Text_IO.Put_Line ("# pos= " & boolean'Image (inserted));
   Kwi_Map.Include (Opstop, new String'("OPSTOP"));
   Kwi_Map.Include (Istop, new String'("ISTOP"));
   Kwi_Map.Include (Rapid, new String'("RAPID"));
   Kwi_Map.Include (Switch, new String'("SWITCH"));
   Kwi_Map.Include (Retrct, new String'("RETRCT"));
   Kwi_Map.Include (Dress, new String'("DRESS"));
   Kwi_Map.Include (Pickup, new String'("PICKUP"));
   Kwi_Map.Include (Unload, new String'("UNLOAD"));
   Kwi_Map.Include (Penup, new String'("PENUP"));
   Kwi_Map.Include (Pendwn, new String'("PENDWN"));
   Kwi_Map.Include (Zero, new String'("ZERO"));
   Kwi_Map.Include (Gohome, new String'("GOHOME"));
   Kwi_Map.Include (Reset, new String'("RESET"));
   Kwi_Map.Include (Gocler, new String'("GOCLER"));
   Kwi_Map.Include (Drawli, new String'("DRAWLI"));
   Kwi_Map.Include (Proby, new String'("PROBY"));
   Kwi_Map.Include (Probx, new String'("PROBX"));
   Kwi_Map.Include (Ulockx, new String'("ULOCKX"));
   Kwi_Map.Include (Lockx, new String'("LOCKX"));
   Kwi_Map.Include (Faceml, new String'("FACEML"));
   Kwi_Map.Include (Plunge, new String'("PLUNGE"));
   Kwi_Map.Include (Head, new String'("HEAD"));
   Kwi_Map.Include (Mode, new String'("MODE"));
   Kwi_Map.Include (Clearp, new String'("CLEARP"));
   Kwi_Map.Include (Tmark, new String'("TMARK"));
   Kwi_Map.Include (Rewind, new String'("REWIND"));
   Kwi_Map.Include (Cutcom, new String'("CUTCOM"));
   Kwi_Map.Include (Revers, new String'("REVERS"));
   Kwi_Map.Include (Fedrat, new String'("FEDRAT"));
   Kwi_Map.Include (Delayk, new String'("DELAY"));
   Kwi_Map.Include (Air, new String'("AIR"));
   Kwi_Map.Include (Delete, new String'("DELETE"));
   Kwi_Map.Include (Leader, new String'("LEADER"));
   Kwi_Map.Include (Pplot, new String'("PPLOT"));
   Kwi_Map.Include (Machin, new String'("MACHIN"));
   Kwi_Map.Include (Mchtol, new String'("MCHTOL"));
   Kwi_Map.Include (Pivotz, new String'("PIVOTZ"));
   Kwi_Map.Include (Mchfin, new String'("MCHFIN"));
   Kwi_Map.Include (Seqno, new String'("SEQNO"));
   Kwi_Map.Include (Intcod, new String'("INTCOD"));
   Kwi_Map.Include (Disply, new String'("DISPLY"));
   Kwi_Map.Include (Auxfun, new String'("AUXFUN"));
   Kwi_Map.Include (Check, new String'("CHECK"));
   Kwi_Map.Include (Postn, new String'("POSTN"));
   Kwi_Map.Include (Toolno, new String'("TOOLNO"));
   Kwi_Map.Include (Rotabl, new String'("ROTABL"));
   Kwi_Map.Include (Origin, new String'("ORIGIN"));
   Kwi_Map.Include (Safety, new String'("SAFETY"));
   Kwi_Map.Include (Arcslp, new String'("ARCSLP"));
   Kwi_Map.Include (Coolnt, new String'("COOLNT"));
   Kwi_Map.Include (Spindl, new String'("SPINDL"));
   Kwi_Map.Include (Ifro, new String'("IFRO"));
   Kwi_Map.Include (Turret, new String'("TURRET"));
   Kwi_Map.Include (Notused, new String'("NOTUSED"));
   Kwi_Map.Include (Rothed, new String'("ROTHED"));
   Kwi_Map.Include (Thread, new String'("THREAD"));
   Kwi_Map.Include (Trans, new String'("TRANS"));
   Kwi_Map.Include (Tracut, new String'("TRACUT"));
   Kwi_Map.Include (Index, new String'("INDEX"));
   Kwi_Map.Include (Copy, new String'("COPY"));
   Kwi_Map.Include (Plot, new String'("PLOT"));
   Kwi_Map.Include (Ovplot, new String'("OVPLOT"));
   Kwi_Map.Include (Letter, new String'("LETTER"));
   Kwi_Map.Include (Pprint, new String'("PPRINT"));
   Kwi_Map.Include (Partno, new String'("PARTNO"));
   Kwi_Map.Include (Insert, new String'("INSERT"));
   Kwi_Map.Include (Camera, new String'("CAMERA"));
   Kwi_Map.Include (Prefun, new String'("PREFUN"));
   Kwi_Map.Include (Couple, new String'("COUPLE"));
   Kwi_Map.Include (Pitch, new String'("PITCH"));
   Kwi_Map.Include (Mdwrit, new String'("MDWRIT"));
   Kwi_Map.Include (Mdend, new String'("MDEND"));
   Kwi_Map.Include (Aslope, new String'("ASLOPE"));
   Kwi_Map.Include (Cycle, new String'("CYCLE"));
   Kwi_Map.Include (Loadtl, new String'("LOADTL"));
   Kwi_Map.Include (Selctl, new String'("SELCTL"));
   Kwi_Map.Include (Clrsrf, new String'("CLRSRF"));
   Kwi_Map.Include (Dwell, new String'("DWELL"));
   Kwi_Map.Include (Draft, new String'("DRAFT"));
   Kwi_Map.Include (Clamp, new String'("CLAMP"));
   Kwi_Map.Include (Plabel, new String'("PLABEL"));
   Kwi_Map.Include (Maxdpm, new String'("MAXDPM"));
   Kwi_Map.Include (Slowdn, new String'("SLOWDN"));
   Kwi_Map.Include (Maxvel, new String'("MAXVEL"));
   Kwi_Map.Include (Lprint, new String'("LPRINT"));
   Kwi_Map.Include (Moveto, new String'("MOVETO"));
   Kwi_Map.Include (Cornfd, new String'("CORNFD"));
   Kwi_Map.Include (Pbs, new String'("PBS"));
   Kwi_Map.Include (Regbrk, new String'("REGBRK"));
   Kwi_Map.Include (Vtlaxs, new String'("VTLAXS"));
   Kwi_Map.Include (Wcorn, new String'("WCORN"));
   Kwi_Map.Include (Magtap, new String'("MAGTAP"));


   Mkwi_Map.Include (Atangl, new String'("ATANGL"));
   Mkwi_Map.Include (Center, new String'("CENTER"));
   Mkwi_Map.Include (Cross, new String'("CROSS"));
   Mkwi_Map.Include (Funofy, new String'("FUNOFY"));
   Mkwi_Map.Include (Intof, new String'("INTOF"));
   Mkwi_Map.Include (Invers, new String'("INVERS"));
   Mkwi_Map.Include (Large, new String'("LARGE"));
   Mkwi_Map.Include (Left, new String'("LEFT"));
   Mkwi_Map.Include (Length, new String'("LENGTH"));
   Mkwi_Map.Include (Minus, new String'("MINUS"));
   Mkwi_Map.Include (Negx, new String'("NEGX"));
   Mkwi_Map.Include (Negy, new String'("NEGY"));
   Mkwi_Map.Include (Negz, new String'("NEGZ"));
   Mkwi_Map.Include (Nox, new String'("NOX"));
   Mkwi_Map.Include (Noy, new String'("NOY"));
   Mkwi_Map.Include (Noz, new String'("NOZ"));
   Mkwi_Map.Include (Parlel, new String'("PARLEL"));
   Mkwi_Map.Include (Perpto, new String'("PERPTO"));
   Mkwi_Map.Include (Plus, new String'("PLUS"));
   Mkwi_Map.Include (Posx, new String'("POSX"));
   Mkwi_Map.Include (Posy, new String'("POSY"));
   Mkwi_Map.Include (Posz, new String'("POSZ"));
   Mkwi_Map.Include (Radius, new String'("RADIUS"));
   Mkwi_Map.Include (Right, new String'("RIGHT"));
   Mkwi_Map.Include (Scale, new String'("SCALE"));
   Mkwi_Map.Include (Small, new String'("SMALL"));
   Mkwi_Map.Include (Tanto, new String'("TANTO"));
   Mkwi_Map.Include (Dstan, new String'("DSTAN"));
   Mkwi_Map.Include (Times, new String'("TIMES"));
   Mkwi_Map.Include (Transl, new String'("TRANSL"));
   Mkwi_Map.Include (Unit, new String'("UNIT"));
   Mkwi_Map.Include (Xlarge, new String'("XLARGE"));
   Mkwi_Map.Include (Xsmall, new String'("XSMALL"));
   Mkwi_Map.Include (Xyplan, new String'("XYPLAN"));
   Mkwi_Map.Include (Xyrot, new String'("XYROT"));
   Mkwi_Map.Include (Ylarge, new String'("YLARGE"));
   Mkwi_Map.Include (Ysmall, new String'("YSMALL"));
   Mkwi_Map.Include (Yzplan, new String'("YZPLAN"));
   Mkwi_Map.Include (Yzrot, new String'("YZROT"));
   Mkwi_Map.Include (Zlarge, new String'("ZLARGE"));
   Mkwi_Map.Include (Zsmall, new String'("ZSMALL"));
   Mkwi_Map.Include (Zxplan, new String'("ZXPLAN"));
   Mkwi_Map.Include (Zxrot, new String'("ZXROT"));
   Mkwi_Map.Include (Threept2sl, new String'("THREEPT2SL"));
   Mkwi_Map.Include (Fourpt1sl, new String'("FOURPT1SL"));
   Mkwi_Map.Include (Fivept, new String'("FIVEPT"));
   Mkwi_Map.Include (Interc, new String'("INTERC"));
   Mkwi_Map.Include (Slope, new String'("SLOPE"));
   Mkwi_Map.Include (Ink, new String'("IN"));
   Mkwi_Map.Include (Outk, new String'("OUT"));
   Mkwi_Map.Include (Open, new String'("OPEN"));
   Mkwi_Map.Include (Allk, new String'("ALL"));
   Mkwi_Map.Include (Last, new String'("LAST"));
   Mkwi_Map.Include (Nomore, new String'("NOMORE"));
   Mkwi_Map.Include (Same, new String'("SAME"));
   Mkwi_Map.Include (Modify, new String'("MODIFY"));
   Mkwi_Map.Include (Mirror, new String'("MIRROR"));
   Mkwi_Map.Include (Start, new String'("START"));
   Mkwi_Map.Include (Endarc, new String'("ENDARC"));
   Mkwi_Map.Include (Cclw, new String'("CCLW"));
   Mkwi_Map.Include (Clw, new String'("CLW"));
   Mkwi_Map.Include (Medium, new String'("MEDIUM"));
   Mkwi_Map.Include (High, new String'("HIGH"));
   Mkwi_Map.Include (Low, new String'("LOW"));
   Mkwi_Map.Include (Const, new String'("CONST"));
   Mkwi_Map.Include (Decr, new String'("DECR"));
   Mkwi_Map.Include (Incr, new String'("INCR"));
   Mkwi_Map.Include (Persp, new String'("PERSP"));
   Mkwi_Map.Include (Rotref, new String'("ROTREF"));
   Mkwi_Map.Include (To, new String'("TO"));
   Mkwi_Map.Include (Past, new String'("PAST"));
   Mkwi_Map.Include (On, new String'("ON"));
   Mkwi_Map.Include (Off, new String'("OFF"));
   Mkwi_Map.Include (Ipm, new String'("IPM"));
   Mkwi_Map.Include (Ipr, new String'("IPR"));
   Mkwi_Map.Include (Circul, new String'("CIRCUL"));
   Mkwi_Map.Include (Linear, new String'("LINEAR"));
   Mkwi_Map.Include (Parab, new String'("PARAB"));
   Mkwi_Map.Include (Rpm, new String'("RPM"));
   Mkwi_Map.Include (Maxrpm, new String'("MAXRPM"));
   Mkwi_Map.Include (Turn, new String'("TURN"));
   Mkwi_Map.Include (Face, new String'("FACE"));
   Mkwi_Map.Include (Bore, new String'("BORE"));
   Mkwi_Map.Include (Both, new String'("BOTH"));
   Mkwi_Map.Include (Xaxis, new String'("XAXIS"));
   Mkwi_Map.Include (Yaxis, new String'("YAXIS"));
   Mkwi_Map.Include (Zaxis, new String'("ZAXIS"));
   Mkwi_Map.Include (Arc, new String'("ARC"));
   Mkwi_Map.Include (Auto, new String'("AUTO"));
   Mkwi_Map.Include (Flood, new String'("FLOOD"));
   Mkwi_Map.Include (Mist, new String'("MIST"));
   Mkwi_Map.Include (Tapkul, new String'("TAPKUL"));
   Mkwi_Map.Include (Step, new String'("STEP"));
   Mkwi_Map.Include (Main, new String'("MAIN"));
   Mkwi_Map.Include (Side, new String'("SIDE"));
   Mkwi_Map.Include (Lincir, new String'("LINCIR"));
   Mkwi_Map.Include (Maxipm, new String'("MAXIPM"));
   Mkwi_Map.Include (Rev, new String'("REV"));
   Mkwi_Map.Include (Typek, new String'("TYPE"));
   Mkwi_Map.Include (Nixie, new String'("NIXIE"));
   Mkwi_Map.Include (Light, new String'("LIGHT"));
   Mkwi_Map.Include (Fourpt, new String'("FOURPT"));
   Mkwi_Map.Include (Twopt, new String'("TWOPT"));
   Mkwi_Map.Include (Ptslop, new String'("PTSLOP"));
   Mkwi_Map.Include (Ptnorm, new String'("PTNORM"));
   Mkwi_Map.Include (Spline, new String'("SPLINE"));
   Mkwi_Map.Include (Rtheta, new String'("RTHETA"));
   Mkwi_Map.Include (Thetar, new String'("THETAR"));
   Mkwi_Map.Include (Xyz, new String'("XYZ"));
   Mkwi_Map.Include (Tanon, new String'("TANON"));
   Mkwi_Map.Include (Trform, new String'("TRFORM"));
   Mkwi_Map.Include (Normal, new String'("NORMAL"));
   Mkwi_Map.Include (Up, new String'("UP"));
   Mkwi_Map.Include (Down, new String'("DOWN"));
   Mkwi_Map.Include (Lock, new String'("LOCK"));
   Mkwi_Map.Include (Sfm, new String'("SFM"));
   Mkwi_Map.Include (Xcoord, new String'("XCOORD"));
   Mkwi_Map.Include (Ycoord, new String'("YCOORD"));
   Mkwi_Map.Include (Zcoord, new String'("ZCOORD"));
   Mkwi_Map.Include (Multrd, new String'("MULTRD"));
   Mkwi_Map.Include (Xyview, new String'("XYVIEW"));
   Mkwi_Map.Include (Yzview, new String'("YZVIEW"));
   Mkwi_Map.Include (Zxview, new String'("ZXVIEW"));
   Mkwi_Map.Include (Solid, new String'("SOLID"));
   Mkwi_Map.Include (Dash, new String'("DASH"));
   Mkwi_Map.Include (Dotted, new String'("DOTTED"));
   Mkwi_Map.Include (Cirlin, new String'("CIRLIN"));
   Mkwi_Map.Include (Ditto, new String'("DITTO"));
   Mkwi_Map.Include (Pen, new String'("PEN"));
   Mkwi_Map.Include (Scribe, new String'("SCRIBE"));
   Mkwi_Map.Include (Black, new String'("BLACK"));
   Mkwi_Map.Include (Red, new String'("RED"));
   Mkwi_Map.Include (Green, new String'("GREEN"));
   Mkwi_Map.Include (Blue, new String'("BLUE"));
   Mkwi_Map.Include (Intens, new String'("INTENS"));
   Mkwi_Map.Include (Lite, new String'("LITE"));
   Mkwi_Map.Include (Med, new String'("MED"));
   Mkwi_Map.Include (Dark, new String'("DARK"));
   Mkwi_Map.Include (Chuck, new String'("CHUCK"));
   Mkwi_Map.Include (Collet, new String'("COLLET"));
   Mkwi_Map.Include (Aaxis, new String'("AAXIS"));
   Mkwi_Map.Include (Baxis, new String'("BAXIS"));
   Mkwi_Map.Include (Caxis, new String'("CAXIS"));
   Mkwi_Map.Include (Tpi, new String'("TPI"));
   Mkwi_Map.Include (Option, new String'("OPTION"));
   Mkwi_Map.Include (Rangek, new String'("RANGE"));
   Mkwi_Map.Include (Pstan, new String'("PSTAN"));
   Mkwi_Map.Include (Full, new String'("FULL"));
   Mkwi_Map.Include (Front, new String'("FRONT"));
   Mkwi_Map.Include (Rear, new String'("REAR"));
   Mkwi_Map.Include (Saddle, new String'("SADDLE"));
   Mkwi_Map.Include (Mill, new String'("MILL"));
   Mkwi_Map.Include (Thru, new String'("THRU"));
   Mkwi_Map.Include (Deep, new String'("DEEP"));
   Mkwi_Map.Include (Trav, new String'("TRAV"));
   Mkwi_Map.Include (Setool, new String'("SETOOL"));
   Mkwi_Map.Include (Setang, new String'("SETANG"));
   Mkwi_Map.Include (Holder, new String'("HOLDER"));
   Mkwi_Map.Include (Manual, new String'("MANUAL"));
   Mkwi_Map.Include (Adjust, new String'("ADJUST"));
   Mkwi_Map.Include (Cutang, new String'("CUTANG"));
   Mkwi_Map.Include (Now, new String'("NOW"));
   Mkwi_Map.Include (Next, new String'("NEXT"));
   Mkwi_Map.Include (Drill, new String'("DRILL"));
   Mkwi_Map.Include (Binary, new String'("BINARY"));
   Mkwi_Map.Include (Bcd, new String'("BCD"));
   Mkwi_Map.Include (Part, new String'("PART"));
   Mkwi_Map.Include (Ream, new String'("REAM"));
   Mkwi_Map.Include (Tap, new String'("TAP"));
   Mkwi_Map.Include (Cam, new String'("CAM"));
   Mkwi_Map.Include (Zigzag, new String'("ZIGZAG"));
   Mkwi_Map.Include (Retain, new String'("RETAIN"));
   Mkwi_Map.Include (Omit, new String'("OMIT"));
   Mkwi_Map.Include (Avoid, new String'("AVOID"));
   Mkwi_Map.Include (Random, new String'("RANDOM"));
   Mkwi_Map.Include (Atk, new String'("AT"));
   Mkwi_Map.Include (Antspi, new String'("ANTSPI"));
   Mkwi_Map.Include (Null1, new String'("NULL1"));
   Mkwi_Map.Include (Null2, new String'("NULL2"));
   Mkwi_Map.Include (Null3, new String'("NULL3"));
   Mkwi_Map.Include (Gaples, new String'("GAPLES"));
   Mkwi_Map.Include (Normps, new String'("NORMPS"));
   Mkwi_Map.Include (Normds, new String'("NORMDS"));
   Mkwi_Map.Include (Tands, new String'("TANDS"));
   Mkwi_Map.Include (Fan, new String'("FAN"));

end Post.Scanner;
