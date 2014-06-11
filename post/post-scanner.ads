------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                        P O S T . S C A N N E R                           --
--                                                                          --
--                                 S p e c                                  --
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
with Ada.Containers;
with Ada.Containers.Ordered_Maps;
with Ada.Streams;  
package Post.Scanner is
   
   --   The postword dictionary maps the subtype number of a type 2000
   --  record to the corresponding keyword.  The minor word dictionary (Mkwi)
   --  is necessary to determine the remaining keywords in the record.
   type Kwi_Type  is (Endk, Stop, Opstop, Istop, Rapid, Switch,
		Retrct, Dress, Pickup, Unload, Penup,
		Pendwn, Zero, Gohome, Reset, Gocler,
		Drawli, Proby, Probx, Ulockx, Lockx,
		Faceml, Plunge, Head, Mode,
		Clearp, Tmark, Rewind, Cutcom,
		Revers, Fedrat, Delayk, Air,
		Delete, Leader, Pplot, Machin,
		Mchtol, Pivotz, Mchfin, Seqno,
		Intcod, Disply, Auxfun, Check,
		Postn, Toolno, Rotabl, Origin,
		Safety, Arcslp, Coolnt, Spindl,
		Ifro, Turret, Notused, Rothed,
		Thread, Trans, Tracut, Index,
		Copy, Plot, Ovplot, Letter,
		Pprint, Partno, Insert, Camera,
		Prefun, Couple, Pitch, Mdwrit,
		Mdend, Aslope, Cycle, Loadtl,
		Selctl, Clrsrf, Dwell, Draft,
		Clamp, Plabel, Maxdpm, Slowdn,
		Maxvel, Lprint, Moveto, Cornfd,
		Pbs, Regbrk, Vtlaxs, Wcorn,
		Magtap);  --94
   for Kwi_Type use ( Endk => 1, Stop => 2, Opstop => 3, Istop => 4, Rapid => 5, Switch => 6,
		Retrct => 7, Dress => 8, Pickup => 9, Unload => 10, Penup => 11,
		Pendwn => 12, Zero => 13, Gohome => 14, Reset => 15, Gocler => 16,
		Drawli => 17, Proby => 18, Probx => 19, Ulockx => 20, Lockx => 21,
		Faceml => 22, Plunge => 1001, Head => 1002, Mode => 1003,
		Clearp => 1004, Tmark => 1005, Rewind => 1006, Cutcom => 1007,
		Revers => 1008, Fedrat => 1009, Delayk => 1010, Air => 1011,
		Delete => 1012, Leader => 1013, Pplot => 1014, Machin => 1015,
		Mchtol => 1016, Pivotz => 1017, Mchfin => 1018, Seqno => 1019,
		Intcod => 1020, Disply => 1021, Auxfun => 1022, Check => 1023,
                Postn => 1024, Toolno => 1025, Rotabl => 1026, Origin => 1027,
                Safety => 1028, Arcslp => 1029, Coolnt => 1030, Spindl => 1031,
                Ifro => 1032, Turret => 1033, Notused => 1034, Rothed => 1035,
                Thread => 1036, Trans => 1037, Tracut => 1038, Index => 1039,
                Copy => 1040, Plot => 1041, Ovplot => 1042, Letter => 1043,
                Pprint => 1044, Partno => 1045, Insert => 1046, Camera => 1047,
                Prefun => 1048, Couple => 1049, Pitch => 1050, Mdwrit => 1051,
                Mdend => 1052, Aslope => 1053, Cycle => 1054, Loadtl => 1055,
                Selctl => 1056, Clrsrf => 1057, Dwell => 1058, Draft => 1059,
                Clamp => 1060, Plabel => 1061, Maxdpm => 1062, Slowdn => 1063,
                Maxvel => 1064, Lprint => 1065, Moveto => 1066, Cornfd => 1067,
                Pbs => 1068, Regbrk => 1069, Vtlaxs => 1070, Wcorn => 1071,
		      Magtap => 1072); 
   type Key_Word_Type is access constant String;
  
   type Mkwi_Type is (Atangl, Center, Cross, Funofy, Intof,
		 Invers, Large, Left, Length, Minus,
		 Negx, Negy, Negz, Nox, Noy,
		 Noz, Parlel, Perpto, Plus, Posx,
		 Posy, Posz, Radius, Right, Scale,
		 Small, Tanto, Dstan, Times, Transl,
		 Unit, Xlarge, Xsmall, Xyplan, Xyrot,
		 Ylarge, Ysmall, Yzplan, Yzrot, Zlarge,
		 Zsmall, Zxplan, Zxrot, Threept2sl,
		 Fourpt1sl, Fivept, Interc, Slope, Ink,
		 Outk, Open, Allk, Last, Nomore,
		 Same, Modify, Mirror, Start, Endarc,
		 Cclw, Clw, Medium, High, Low,
		 Const, Decr, Incr, Persp, Rotref,
		 To, Past, On, Off, Ipm,
		 Ipr, Circul, Linear, Parab, Rpm,
		 Maxrpm, Turn, Face, Bore, Both,
		 Xaxis, Yaxis, Zaxis, Arc, Auto,
		 Flood, Mist, Tapkul, Step, Main,
		 Side, Lincir, Maxipm, Rev,
		 Typek, Nixie, Light, Fourpt, Twopt,
		 Ptslop, Ptnorm, Spline, Rtheta, Thetar,
		 Xyz, Tanon, Trform, Normal, Up,
		 Down, Lock, Sfm, Xcoord, Ycoord,
		 Zcoord, Multrd, Xyview, Yzview, Zxview,
		 Solid, Dash, Dotted, Cirlin, Ditto,
		 Pen, Scribe, Black, Red, Green,
		 Blue, Intens, Lite, Med, Dark,
		 Chuck, Collet, Aaxis, Baxis, Caxis,
		 Tpi, Option, Rangek, Pstan, Full,
		 Front, Rear, Saddle, Mill, Thru,
		 Deep, Trav, Setool, Setang, Holder,
		 Manual, Adjust, Cutang, Now, Next,
		 Drill, Binary, Bcd, Part, Ream,
		 Tap, Cam, Zigzag, Retain, Omit,
		 Avoid, Random, Atk, Antspi,  --sometimes replaces Grid?
		 Null1, Null2, Null3,      -- dummies
		 Gaples, Normps, Normds, Tands, Fan);
   
   type MKey_Word_Type is access constant String;
   
   type Move_Rec_Type is (Nix0, Indirp, Indirv, From, Godlta, 
			  Gto, Nix6, Nix7, Srfvct);
   
   type Cut_Tol_Type is (Nix, Cut, Toler, Nix1, Intol, Outtol, Cutter);
   
   type Special_Feature_Type is (Nix, Tlaxis, Multax, Maxdp, Numpts, Thick, 
				 Nops, Autops, Gougck);
   
   
   type Rec_Type is (Source_Lnno, Kwi_Rec, Threethou, Fourthou, Move_Rec, Cut_Tol_Rec, Special_Feature_Rec, Fini);
   -- 1000, 2000, 3000, 5000, 9000, 14000
   for Rec_Type use (Source_Lnno         => 1000,
		     Kwi_Rec             => 2000,
		     Threethou           => 3000,
		     Fourthou            => 4000,
		     Move_Rec            => 5000,
		     Cut_Tol_Rec         => 6000,
		     Special_Feature_Rec => 9000,
		     Fini                => 14000);
   -- type of records in an apt360 cl file
   
   type Kwi_Ins_Type is (Beam, Fadein, Fadeout, Fedrat, Debug); -- for function Parse_Insert
   
   type Header_Type is record
	 Rec_No   : Positive;
	 Rec_Len  : Natural;
	 Rec_T    : Rec_Type;
   end record;
   
   type Onoff_Type is (Off, On);
   for Onoff_Type use (Off => 0, On => 1);
   
   subtype Stream_Element_Array is Ada.Streams.Stream_Element_Array;
   type Stream_Element_Array_Access is access all Stream_Element_Array;
   
   
   
   function "<" (Left, Right : Kwi_Type) return Boolean;
   function "<" (Left, Right : MKwi_Type) return Boolean;
   function "=" (Left, Right : Key_Word_Type) return Boolean;
   function "=" (Left, Right : MKey_Word_Type) return Boolean;
   
   package Keyw_Dict is new Ada.Containers.Ordered_Maps (Key_Type     => Kwi_Type,
							 Element_Type => Key_Word_Type,
							 "<"          => "<",
							 "="          => "=");

   package mKeyw_Dict is new Ada.Containers.Ordered_Maps (Key_Type     => MKwi_Type,
							  Element_Type => MKey_Word_Type,
							  "<"          => "<",
							  "="          => "=");
   
   Kwi_Map   : Keyw_Dict.Map;
   Mkwi_Map  : mKeyw_Dict.Map;
   
   Text : Stream_Element_Array_Access;
   Next_Token : Ada.Streams.Stream_Element_Offset := 1;
   
   function Scan_Header (Header : in out Header_Type; Done : in out boolean) 
			return Boolean;
   function Scan_Source_Line_Number (V : in out Long_Long_Integer) 
				    return Boolean;
   function Scan_Kwi_Index (V : in out Kwi_Type) return Boolean;
   function Scan_Mov_Rec_Index (V : in out Move_Rec_Type) return Boolean;
   function Scan_Cut_Tol_Index (V : in out Cut_Tol_Type) return Boolean;
   function Scan_Special_Feature_Index (V : in out Special_Feature_Type) 
				       return Boolean;
   function Scan_Info (S : in out String) return Boolean;
   function Scan_String8 (S : in out String) return Boolean;
   function Scan_Double (D : in out Long_Float) return Boolean;
   function Scan_Integer (I : in out Integer) return Boolean;
   function Scan_Long_Long_Integer (I : in out Long_Long_Integer) 
				   return Boolean;
  
end Post.Scanner;

--  minorword_dict={
--  1:"ATANGL",     2:"CENTER",  	3:"CROSS",  	4:"FUNOFY",  	5:"INTOF",
--  6:"INVERS",  	7:"LARGE",  	8:"LEFT",  	    9:"LENGTH",  	10:"MINUS",
--  11:"NEGX",  	12:"NEGY",  	13:"NEGZ",  	14:"NOX",  	    15:"NOY",
--  16:"NOZ",  	    17:"PARLEL",  	18:"PERPTO",  	19:"PLUS",  	20:"POSX",
--  21:"POSY",  	22:"POSZ",  	23:"RADIUS",  	24:"RIGHT",  	25:"SCALE",
--  26:"SMALL",  	27:"TANTO",  	27:"DSTAN",  	28:"TIMES",  	29:"TRANSL",
--  30:"UNIT",  	31:"XLARGE",  	32:"XSMALL",  	33:"XYPLAN",  	34:"XYROT",
--  35:"YLARGE",  	36:"YSMALL",  	37:"YZPLAN",  	38:"YZROT",  	39:"ZLARGE",
--  40:"ZSMALL",  	41:"ZXPLAN",  	42:"ZXROT",  	43:"THREEPT2SL",
--  44:"FOURPT1SL", 45:"FIVEPT", 	46:"INTERC",  	47:"SLOPE",  	48:"IN",
--  49:"OUT",  	    50:"OPEN",  	51:"ALL",  	    52:"LAST",  	53:"NOMORE",
--  54:"SAME", 	    55:"MODIFY",  	56:"MIRROR",  	57:"START",  	58:"ENDARC",
--  59:"CCLW", 	    60:"CLW",  	    61:"MEDIUM",  	62:"HIGH",  	63:"LOW",
--  64:"CONST", 	65:"DECR",  	66:"INCR",  	67:"PERSP",  	68:"ROTREF",
--  69:"TO",  	    70:"PAST",  	71:"ON",  	    72:"OFF",  	    73:"IPM",
--  74:"IPR",  	    75:"CIRCUL",  	76:"LINEAR",  	77:"PARAB",  	78:"RPM",
--  79:"MAXRPM",  	80:"TURN",  	81:"FACE",  	82:"BORE",  	83:"BOTH",
--  84:"XAXIS",  	85:"YAXIS",  	86:"ZAXIS",  	87:"ARC",  	    88:"AUTO",
--  89:"FLOOD",  	90:"MIST", 	    91:"TAPKUL",  	92:"STEP",  	93:"MAIN",
--  94:"SIDE",  	95:"LINCIR",  	96:"MAXIPM",  	97:"REV",
--  98:"TYPE",  	99:"NIXIE",  	100:"LIGHT",  	101:"FOURPT",   102:"TWOPT",
--  103:"PTSLOP",   104:"PTNORM",   105:"SPLINE",   106:"RTHETA",   107:"THETAR",
--  108:"XYZ",  	109:"TANON",  	110:"TRFORM",   111:"NORMAL",   112:"UP",
--  113:"DOWN",  	114:"LOCK",  	115:"SFM",  	116:"XCOORD",   117:"YCOORD",
--  118:"ZCOORD",   119:"MULTRD",   120:"XYVIEW",   121:"YZVIEW",   122:"ZXVIEW",
--  123:"SOLID",  	124:"DASH",  	125:"DOTTED",   126:"CIRLIN",   127:"DITTO",
--  128:"PEN",  	129:"SCRIBE",   130:"BLACK",  	131:"RED",  	132:"GREEN",
--  133:"BLUE",  	134:"INTENS",   135:"LITE",  	136:"MED",  	137:"DARK",
--  138:"CHUCK",  	139:"COLLET",   140:"AAXIS",  	141:"BAXIS",  	142:"CAXIS",
--  143:"TPI",  	144:"OPTION",   145:"RANGE",  	146:"PSTAN",  	147:"FULL",
--  148:"FRONT",  	149:"REAR",  	150:"SADDLE",   151:"MILL",  	152:"THRU",
--  153:"DEEP",  	154:"TRAV",  	155:"SETOOL",   156:"SETANG",   157:"HOLDER",
--  158:"MANUAL",   159:"ADJUST",   160:"CUTANG",   161:"NOW",  	162:"NEXT",
--  163:"DRILL",  	164:"BINARY",   165:"BCD",  	166:"PART",  	167:"REAM",
--  168:"TAP",  	169:"CAM",  	170:"ZIGZAG",   171:"RETAIN",   172:"OMIT",
--  173:"AVOID",  	174:"RANDOM",   175:"AT",  	    176:"GRID", 	176:"ANTSPI",
--  180:"GAPLES",   181:"NORMPS",   182:"NORMDS",   183:"TANDS",  	184:"FAN"}



--  postword_dict={
--  1:"END", 2:"STOP",3:"OPSTOP",4:"ISTOP",5:"RAPID",6:"SWITCH",
--  7:"RETRCT",8:"DRESS", 9:"PICKUP",10:"UNLOAD",11:"PENUP",
--  12:"PENDWN",13:"ZERO",14:"GOHOME",15:"RESET", 16:"GOCLER",
--  17:"DRAWLI",18:"PROBY",19:"PROBX",20:"ULOCKX",21:"LOCKX",
--  22:"FACEML", 1001:"PLUNGE", 1002:"HEAD", 1003:"MODE",
--  1004:"CLEARP", 1005:"TMARK", 1006:"REWIND", 1007:"CUTCOM",
--  1008:"REVERS", 1009:"FEDRAT", 1010:"DELAY", 1011:"AIR",
--  1012:"DELETE", 1013:"LEADER", 1014:"PPLOT", 1015:"MACHIN",
--  1016:"MCHTOL", 1017:"PIVOTZ", 1018:"MCHFIN", 1019:"SEQNO",
--  1020:"INTCOD", 1021:"DISPLY", 1022:"AUXFUN", 1023:"CHECK",
--  1024:"POSTN", 1025:"TOOLNO", 1026:"ROTABL", 1027:"ORIGIN",
--  1028:"SAFETY", 1029:"ARCSLP", 1030:"COOLNT", 1031:"SPINDL",
--  1032:"IFRO", 1033:"TURRET", 1034:"NOTUSED", 1035:"ROTHED",
--  1036:"THREAD", 1037:"TRANS", 1038:"TRACUT", 1039:"INDEX",
--  1040:"COPY", 1041:"PLOT", 1042:"OVPLOT", 1043:"LETTER",
--  1044:"PPRINT", 1045:"PARTNO", 1046:"INSERT", 1047:"CAMERA",
--  1048:"PREFUN", 1049:"COUPLE", 1050:"PITCH", 1051:"MDWRIT",
--  1052:"MDEND", 1053:"ASLOPE", 1054:"CYCLE", 1055:"LOADTL",
--  1056:"SELCTL", 1057:"CLRSRF", 1058:"DWELL", 1059:"DRAFT",
--  1060:"CLAMP", 1061:"PLABEL", 1062:"MAXDPM", 1063:"SLOWDN",
--  1064:"MAXVEL", 1065:"LPRINT", 1066:"MOVETO", 1067:"CORNFD",
--  1068:"PBS", 1069:"REGBRK", 1070:"VTLAXS", 1071:"WCORN",
--  1072:"MAGTAP"}
