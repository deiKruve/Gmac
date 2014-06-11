------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                          P O S T . M A C H I N                           --
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
--  Post.Machin has the machine-specific routines.
--  it is called from the machin interface
--
--  On loading they are registered with post.parser in a subroutine pointer
--  so the parser can make up-calls.
--


-- !!! fast moves have not been delt with

-- !!! this must be delt with for machining, not for welding
--

pragma Debug_Policy (Check); -- (IGNORE);
with System.Address_Image;
with Ada.Tags;

with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Unchecked_Deallocation;
with Ada.Text_Io; 
with Ada.Text_IO.Text_Streams;
with Ada.Characters.Latin_1;
with Text_Io;
with GNATCOLL.Traces;
with Gmactextscan;
with Math3d;
with Post.Parser;

package body Ebwm1.Machin is
   package Tio renames Text_Io; 
   package Tiots renames Ada.Text_IO.Text_Streams;
   package Pp  renames Post.Parser;
   package Gct renames GNATCOLL.Traces;
   package Gts renames Gmactextscan;
   package Math renames Ada.Numerics;
   
   Stream1   : constant Gct.Trace_Handle := Gct.Create ("POSTP");
   Stream2   : constant Gct.Trace_Handle := Gct.Create ("POSTP.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("POSTP.DEBUG");

   --type Mystr is new String;
   --type Mystr_Access_Type is access all Mystr;
   type Fedratunit_Type is (Mmpm, Ipm);
   -- anything distance --
   subtype Posvec1_Type is Long_Float;
   -- anything angle    --
   subtype Posangl_Type is Long_Float;
   
   package Posmath is new Math.Generic_Elementary_Functions
     (Float_Type => Posvec1_Type);
   package Pvio  is new Ada.Text_IO.Float_IO (Num => Posvec1_Type);
   package Avio  is new Ada.Text_IO.Float_IO (Num => Posangl_Type);
   package Lfio  is new Ada.Text_IO.Float_IO (Num => Long_Float);
   package Fio   is new Ada.Text_IO.Float_IO (Num => Float);
   
   ---------------------------
   -- machine command state --
   ---------------------------
   Machine    : String          := "EBWM1";
   type Sp_State_Type is (Off, On);  -- spindle
   Sp_State   : Sp_State_Type   := Off; 
   Sp_Revs    : Long_Float      := 0.0;
   Cutter,
   Intol      : Posvec1_Type    := 0.0;
   Outtol     : Posvec1_Type    := 0.0005;
   Orig_X,
   Orig_Y,
   Orig_Z     : Posvec1_Type    := 0.0;
   Multax_On,
   From_Seen  : Boolean         := False;
   Fedratunit : Fedratunit_Type := Mmpm;
   Fedrat     : Posvec1_Type    := 0.0;
   
   Print_Sourcelines : Boolean := False;
   
   
   -----------------
   -- local stuff --
   -----------------
   
   ---------------------------------------------------
   -- doubly linked list for all positional records --
   ---------------------------------------------------
   
   -- the base of all machining records --
   type Posvec_Type;
   type Posvec_Class_Access_Type is access all Posvec_Type'Class;
   type Posvec_Type is abstract tagged record
      null;
   end record;
   
   -- the list construction
   -- it has forward and backward connections for
   -- 2 lists that are interwoven.
   -- prev and next link all records, but
   -- mprevand mnext only the movement records.
   type Dllist_Type;
   type Dllist_Access_Type is access all Dllist_Type;
   type Dllist_Type is tagged record
      Pos        : Posvec_Class_Access_Type := null;
      Prev, Next,
	Mprev, Mnext : Dllist_Access_Type       := null;
   end record;
   
   
   -- the beginning of any list, we might need more  --
   -- must be initialized in the elaboration section --
   Pos_list_Anchor : aliased Dllist_Access_Type  := new Dllist_Type;
   

   procedure Free_Dllist_Node is 
      new Ada.Unchecked_Deallocation (Dllist_Type, Dllist_Access_Type);
   
   
   -- inserts 'this' before 'next'
   -- only in the general list
   procedure Insert_Pv_Before 
     (This : access Posvec_Type'Class;  
      next : access Dllist_Type)
     with Pre => This /= null and Next /= null;
   procedure Insert_Pv_Before 
     (This : access Posvec_Type'Class;  
      next : access Dllist_Type)
   is
      P : Dllist_Access_Type := 
	new Dllist_Type'(Pos => Posvec_Class_Access_Type (This), 
			 Prev => Next.prev, 
			 Next => Dllist_Access_Type (Next),
			 Mprev => null, Mnext => null);
   begin
      Next.Prev   := P;
      P.Prev.Next := P;
   end Insert_Pv_Before;
   
   
   -- inserts 'this' after 'next'
   -- only in the general list
   procedure Insert_Pv_After
     (This : access Posvec_Type'Class;   
      Prev : access Dllist_Type )
     with Pre => This /= null and Prev /= null;
   procedure Insert_Pv_After
     (This : access Posvec_Type'Class;   
      Prev : access Dllist_Type )
   is
      P : Dllist_Access_Type := 
	new Dllist_Type'(Pos => Posvec_Class_Access_Type (This), 
			 Prev => Dllist_Access_Type (Prev), 
			 Next => Prev.Next,
			 Mprev => null, Mnext => null);
   begin
      Prev.Next   := P;
      P.Next.Prev := P;
   end Insert_Pv_After;
   
   
   -- destroy a Dllist-item in the link
   procedure Unlink_Dllist_Item (This : access Dllist_Type)
     with Pre => This.Pos = null;
   procedure Unlink_Dllist_Item (This : access Dllist_Type)
   is
   begin 
      This.Prev.Next := This.Next;
      This.Next.Prev := This.Prev;
      if This.Mnext /= This then
	 This.Mprev.Mnext := This.Mnext;
      end if;
      if This.Mprev /= This then
	 This.mNext.mPrev := This.mPrev;
      end if;
   end Unlink_Dllist_Item;
   
   
   --------------------------------------
   -- the list item for a 3 axis entry --
   --------------------------------------
   type Posvec3_Type is tagged;
   type Posvec3_Access_Type is access  all Posvec3_Type;
   type Posvec3_Class_Access_Type is access all Posvec3_Type'Class;
   type Posvec3_Type is new Posvec_Type
     with record
	From,
	Istop  : Boolean := False;
	Fedrat : Posvec1_Type := 0.0;
	D3d    : Posangl_Type := 0.0;  -- space angle between segments
	Tightness : Long_Float;
	X      : Posvec1_Type;
	Y      : Posvec1_Type;
	Z      : Posvec1_Type;
   end record;
   
   procedure Free_Posvec3 is 
      new Ada.Unchecked_Deallocation(Posvec3_Type, Posvec3_Access_type);
   
   
   -- unlink a pos3 node from the chain --
   procedure Unlink_Pos3_Node (This : access Dllist_Type)
   is
   begin
      Free_Posvec3 (Posvec3_Access_Type (This.Pos));
      Unlink_Dllist_Item (This);
   end Unlink_Pos3_Node;
   
   
   -- inserts 'this' before 'next' and before 'mnext'
   -- so we must know who 'mnext' is, normally the anchor
   --  i.e. the same as next
   -- only for movement records
   procedure Insert_Pv_Before 
     (This        : access Posvec3_Type'Class;  
      Next, Mnext : access Dllist_Type)
     with Pre => This /= null and Next /= null and Mnext /= null;
   procedure Insert_Pv_Before 
     (This        : access Posvec3_Type'Class;  
      Next, Mnext : access Dllist_Type)
   is
      P : Dllist_Access_Type := 
	new Dllist_Type'(Pos => Posvec_Class_Access_Type (This), 
			 Prev => Next.prev, Next => Dllist_Access_Type (Next),
			 Mprev => Mnext.Mprev, Mnext => Dllist_Access_Type (Mnext)); 
   begin
      Next.Prev     := P;
      Mnext.Mprev   := P;
      P.Prev.Next   := P;
      P.Mprev.Mnext := P;
   end Insert_Pv_Before;
   
   
   -- inserts 'this' after 'prev' and after 'mprev'
   -- so we must know who 'mprev' is, normally the anchor
   --  i.e. the same as prev
   -- only for movement records
   procedure Insert_Pv_After
     (This        : access Posvec3_Type'Class;   
      Prev, Mprev : access Dllist_Type)
     with Pre => This /= null and Prev /= null and Mprev /= null;
   procedure Insert_Pv_After
     (This        : access Posvec3_Type'Class;   
      Prev, Mprev : access Dllist_Type)
   is
      P : Dllist_Access_Type := 
      	new Dllist_Type'(Pos => Posvec_Class_Access_Type (This), 
			 Prev => Dllist_Access_Type (Prev), Next => Prev.Next,
			 Mprev => Dllist_Access_Type (Mprev), Mnext => Mprev.mnext);
   begin
      Prev.Next     := P;
      Mprev.MNext   := P;
      P.Next.Prev   := P;
      P.Mnext.Mprev := P;
   end Insert_Pv_After;
   
   
   --------------------------------------
   -- the list item for a 9 axis entry --
   --------------------------------------
   type Posvec9_Type;
   type Posvec9_Access_Type is access  all Posvec9_Type;
   type Posvec9_Type is new Posvec3_Type 
     with record
	I,
	J,
	K      : Posvec1_Type := 0.0;  -- rotation vector
	Xr,
	Yr,
	Zr     : Posvec1_Type := 0.0;  -- new xyz, to be modified.
	A,
	B,
	C      : Posangl_Type := 0.0;  -- rotation angles
   end record;
   
   procedure Free_Posvec9 is 
      new Ada.Unchecked_Deallocation(Posvec9_Type, Posvec9_Access_type);
   
   procedure Unlink_Pos9_Node  (This : access Dllist_Type)
   is
   begin
      Free_Posvec9 (Posvec9_Access_Type (This.Pos));
      Unlink_Dllist_Item (This);
   end Unlink_Pos9_Node;
   

   ----------------------------------------
   -- the list item for a command string --
   ----------------------------------------
   type Posvec_S_Type;
   type Posvec_S_Access_Type is access  all Posvec_S_Type;
   type Posvec_S_Type is new Posvec_Type 
     with record
   	Sa : access String;
   end record;
   
   procedure Free_Posvec_S is 
      new Ada.Unchecked_Deallocation(Posvec_S_Type, Posvec_S_Access_Type);
   
   procedure Unlink_Pos_S_Node  (This : access Dllist_Type)
   is
   begin
      Free_Posvec_S (Posvec_S_Access_Type (This.Pos));
      Unlink_Dllist_Item (This);
   end Unlink_Pos_S_Node;
   
   
   --===========--
   -- the maths --
   --===========--
   procedure Debug_Print_Vector (V : Math3d.Long_Vector_3d)
   is
   begin
      Tio.Put (" X");
      Pvio.Put (V(1), 4, 3, 0);
      Tio.Put (" Y");
      Pvio.Put (V(2), 4, 3, 0);
      Tio.Put (" Z");
      Pvio.Put (V(3), 4, 3, 0);
      Tio.Put_Line (" in ebwm1-machin");
   end Debug_Print_Vector;
   
   
   function To_Radians (Deg : Posangl_Type) return Posangl_Type
   is
   begin
      return (Deg * 2.0 * Math.Pi) / 360.0;
   end To_Radians;
   
   function To_Degrees (Rad : Posangl_Type) return Posangl_Type
   is
   begin
      return (Rad * 360.0) / (2.0 * Math.Pi);
   end To_Degrees;
   
   pragma Inline (To_Radians, To_Degrees);
   
   
   procedure Angles (I, J, K : in Posvec1_Type := 0.0; 
		     A, B, C : in out Posangl_Type)
     -- a, b, c in radials.
     -- no C yet
   is
   begin
      if K > 0.0 then -- K is above the horizon of XY plane
	 B := Posangl_Type ((Posmath.Arctan (I / K)) * (-1.0));
	 A := Posangl_Type 
	   (Posmath.Arctan((J / K) * Posmath.Cos (Posvec1_Type (B))));
      elsif K = 0.0 then -- impossible situation, K is on the horizon
			 -- Prevent Division by Zero Error by 
			 --  'Assigning the smallest non-zero value to K
			 --K = 0.0000000000000001;
	 B := Posangl_Type ((Posmath.Arctan (I / 0.0000000000000001)) * (-1.0));
	 A := Posangl_Type 
	   (Posmath.Arctan((J / 0.0000000000000001) * 
			     Posmath.Cos (Posvec1_Type (B))));
      else --  Vector K is below horizon of XY Plane
	   -- +180.0 adjustment indicates Vector K below horizon of XY Plane
	 B := Posangl_Type ((Posmath.Arctan (I / K)) * (-1.0));
	 A := Posangl_Type 
	   (Math.Pi + Posmath.Arctan((J / K) * 
				       Posmath.Cos (Posvec1_Type (B))));
      end if;
   end Angles;
   
   
   procedure Rotate_V 
     (X, Y, Z : in out Posvec1_Type; A, B, C: in Posangl_Type := 0.0)
     -- a, b, c in radials.
     -- no rotation yet for B and C
   is
      Xtick, Ytick, Ztick : Posvec1_Type;
      Cos_A, Sin_A : Posvec1_Type;
   begin
      Cos_A := Posmath.Cos (Posvec1_Type (A));
      Sin_A := Posmath.Sin (Posvec1_Type (A));
      Ytick := Y * Cos_A - Z * Sin_A;
      Ztick := Y * Sin_A + Z * Cos_A;
      Y := Ytick;
      Z := Ztick;
   end Rotate_V;
   
   
   --------------------------------------------
   -- print out the linked list of positions --
   --------------------------------------------
   
   procedure Print_Vectors 
   is
      List : Dllist_Access_Type := Pos_List_Anchor.Next;
      Listpos3 : Posvec3_Access_Type;
      Listpos9 : Posvec9_Access_Type;
      Xstr, Ystr, Zstr    : String := "        ";
      Istr, Jstr, Kstr    : String := "        ";
      Xrstr, Yrstr, Zrstr : String := "        ";
      Astr, Bstr, Cstr    : String := "        ";
   begin
      loop
	 if List.Pos.all in Posvec9_Type then
	    Listpos3 := Posvec3_Access_Type (List.Pos);
	    Listpos9 := Posvec9_Access_Type (List.Pos);
	    Pvio.Put (Xstr, Listpos9.X, 3, 0);
	    Pvio.Put (Ystr, Listpos9.Y, 3, 0);
	    Pvio.Put (Zstr, Listpos9.Z, 3, 0);
	    Gct.Trace (Debug_Str, " X " & Xstr & " Y " & Ystr & " Z " & Zstr);
	    Pvio.Put (Istr, Listpos9.I, 3, 0);
	    Pvio.Put (Jstr, Listpos9.J, 3, 0);
	    Pvio.Put (Kstr, Listpos9.K, 3, 0);
	    Gct.Trace (Debug_Str, " I " & Istr & " J " & Jstr & " K " & Kstr);
	    Pvio.Put (Xrstr, Listpos9.XR, 3, 0);
	    Pvio.Put (Yrstr, Listpos9.YR, 3, 0);
	    Pvio.Put (Zrstr, Listpos9.ZR, 3, 0);
	    Gct.Trace (Debug_Str, " XR" & Xrstr & " YR" & Yrstr & " ZR" & Zrstr);
	    Pvio.Put (Astr, Posvec1_Type (Listpos9.A), 5, 0);
	    Pvio.Put (Bstr, Posvec1_Type (Listpos9.B), 5, 0);
	    Pvio.Put (Cstr, Posvec1_Type (Listpos9.C), 5, 0);
	    Gct.Trace (Debug_Str, " A " & Astr & " B " & Bstr & " C " & Cstr & 
			 " istop : " & Boolean'Image (ListPos3.Istop));
	 elsif List.Pos.all in Posvec3_Type  then
	    Listpos3 := Posvec3_Access_Type (List.Pos);
	    Pvio.Put (Xstr, Listpos3.X, 3, 0);
	    Pvio.Put (Ystr, Listpos3.Y, 3, 0);
	    Pvio.Put (Zstr, Listpos3.Z, 3, 0);
	    Gct.Trace (Debug_Str, " X " & Xstr & " Y " & Ystr & " Z " & Zstr & 
			 " istop : " & Boolean'Image (ListPos3.Istop));
	 elsif List.Pos.all in Posvec_S_Type  then
	    Gct.Trace (Debug_Str, Posvec_S_Access_Type (List.Pos).Sa.all);
	    
	 else 
	    Gct.Trace (Debug_Str, " debugoutput : unknown class");
	 end if;
	 
	 List := List.Next; -- this goes to the following vector !!
	 exit when List = Pos_List_Anchor;
      end loop;
   end Print_Vectors;
   
   
   ------------------------------------------
   -- output the program ready for the cnc --
   ------------------------------------------
   
   procedure Output_Program 
   is
      List : aliased Dllist_Access_Type := Pos_List_Anchor.Next;
      Listpos3 : aliased Posvec3_Access_Type;
      Listpos9 : aliased Posvec9_Access_Type;
      Xstr, Ystr, Zstr, Tstr   : String := "        ";
      Astr, Bstr, Cstr, d3dstr : String := "        ";
      Cmdstr   : String := "    ";
      Ofd      : Tio.File_Type;
      Ostr     : Tiots.Stream_Access := Tiots.Stream (Tio.Standard_Output);
   begin
      declare
	 Token : Gts.Extended_Token_Type;
      begin
	 Token := Gts.Find_Parameter ("Post.OutputFile");
	 case Token is
	    when Gts.Id =>
	       declare
	       begin
		  Tio.Open (File => Ofd, Mode => Tio.Out_File, 
			    Name => Gts.String_Value);
	       exception when Tio.Name_error =>
		  Tio.Create (File => Ofd, Mode => Tio.Out_File, 
			      Name => Gts.String_Value);
	       end;
	       Ostr := Tiots.Stream (Ofd);
	    when others => 
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Post.OutputFile: expected a Filename" & 
		    ASCII.LF & "I will revert to standard output");
	       Ostr := Tiots.Stream (Tio.Standard_Output);
	 end case;
      exception when others => 
	 Ostr := Tiots.Stream (Tio.Standard_Output);
      end;
      loop
	 if List.Pos.all in Posvec9_Type then
	    Listpos9 := Posvec9_Access_Type (List.Pos);
	    Pvio.Put (Xstr, Listpos9.XR, 3, 0);
	    Pvio.Put (Ystr, Listpos9.YR, 3, 0);
	    Pvio.Put (Zstr, Listpos9.ZR, 3, 0);
	    Pvio.Put (Tstr, Posvec1_Type (Listpos9.Tightness), 3, 0);	    
	    if Listpos9.From then Cmdstr := "FROM";
	    else Cmdstr := "GOTO"; end if;
	    String'Write (Ostr, Cmdstr & " X " & Xstr & " Y " & Ystr & 
			    " Z " & Zstr & " T " & Tstr & ASCII.LF);
	    Pvio.Put (Astr, Posvec1_Type (Listpos9.A), 5, 0);
	    Pvio.Put (Bstr, Posvec1_Type (Listpos9.B), 5, 0);
	    Pvio.Put (Cstr, Posvec1_Type (Listpos9.C), 5, 0);
	    Pvio.Put (d3dstr, Posvec1_Type (Listpos9.d3d), 5, 0);
	    String'Write (Ostr, " A " & Astr & " B " & Bstr & " C " & Cstr & 
			    " D " & D3dstr & " istop : " & 
			    Boolean'Image (ListPos9.Istop) & ASCII.LF);
	 elsif List.Pos.all in Posvec3_Type  then
	    Listpos3 := Posvec3_Access_Type (List.Pos);
	    Pvio.Put (Xstr, Listpos3.X, 3, 0);
	    Pvio.Put (Ystr, Listpos3.Y, 3, 0);
	    Pvio.Put (Zstr, Listpos3.Z, 3, 0);
	    Pvio.Put (d3dstr, Posvec1_Type (Listpos3.d3d), 5, 0);
	    Pvio.Put (Tstr, Posvec1_Type (Listpos3.Tightness), 3, 0);	 
	    if Listpos3.From then Cmdstr := "FROM";
	    else Cmdstr := "GOTO"; end if;
	    String'Write (Ostr, Cmdstr &  " X " & Xstr & " Y " & Ystr & 
			    " Z " & Zstr & " T " & Tstr & " D " & D3dstr &
			  " istop : " & Boolean'Image (ListPos3.Istop) & ASCII.LF);
	    
	 elsif List.Pos.all in Posvec_S_Type  then
	    String'Write (Ostr, Posvec_S_Access_Type (List.Pos).Sa.all & ASCII.LF);
	 else 
	    Gct.Trace (Debug_Str, " Output_Program : unknown class");
	 end if;
	 
	 List := List.Next; -- this goes to the following vector !!
	 exit when List = Pos_List_Anchor;
      end loop;
   end Output_Program;
   
   
   ----------------------------------
   -- process the movement vectors --
   -- for doubles and join angle   --
   ----------------------------------
   
   procedure Print_Comment (S : String);

   procedure Process_Vectors
   is
      List         : aliased Dllist_Access_Type := Pos_List_Anchor.mNext;
      Listpos3,
      Listnextpos3 : aliased Posvec3_Access_Type;

      Token     : Gts.Extended_Token_Type;
      Tightness,
      Distance  : Long_Float := 0.0;
      Max_Angle : Posangl_Type := To_Radians (0.0);
      Vector1,
      Vector2,
      Vector3   : Math3d.Long_Vector_3d := (0.0, 0.0, 0.0);
      Vector    : array (1 .. 4) of Math3d.Long_Vector_3d:= ((0.0, 0.0, 0.0),
							     (0.0, 0.0, 0.0),
							     (0.0, 0.0, 0.0),
							     (0.0, 0.0, 0.0));
      use type Math3d.Long_Vector_3d;

      
      -- find the tightness in the setup file --
      procedure Get_Tightness
      is
      begin
	 Token := Gts.Find_Parameter ("Post.Tightness");
	 case Token is
	    when Gts.Number => 
	       Tightness := Long_Float (Integer'Value (Gts.String_Value));
	    when Gts.Float  =>
	       Tightness := Long_Float'Value (Gts.String_Value);
	    when others     =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Post.Tightness: expected number or float");
	 end case;
	 Token := Gts.Next_Token;
	 case Token is
	    when Gts.Id =>
	       if Gts.String_Value = "inch" then
		  Tightness := Tightness * 25.4;
	       elsif Gts.String_Value = "mm" then
		  null;
	       else
		  Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Post.Tightness: expected 'mm' or 'inch'");
	       end if;
	    when others =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Post.Tightness: expected 'mm' or 'inch'");
	 end case;
	 Gct.Trace (Debug_Str, "tightness is " & 
		      Long_Float'Image (Tightness) & " mm");
      end Get_Tightness;
      
      -- find the max angle in the setup file -- 
      procedure Get_Max_Angle
      is
      begin
	 Token := Gts.Find_Parameter ("Post.Maxangle");
	 case Token is
	    when Gts.Number => 
	       Max_Angle := Posangl_Type (Integer'Value (Gts.String_Value));
	    when Gts.Float  =>
	       Max_Angle := Posangl_Type'Value (Gts.String_Value);
	    when others     =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Post.Maxangle: expected number or float");
	 end case;
	 Token := Gts.Next_Token;
	 case Token is
	    when Gts.Id => 
	       if Gts.String_Value = "degrees" then
		  Max_Angle := To_Radians (Max_Angle);
	       elsif Gts.String_Value = "radians" then
		  null;
	       else
		  Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Post.Maxangle: " & 
		       "expected 'degrees' or 'radians'");
	       end if;
	    when others =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Post.Maxangle: " & 
		    "expected 'degrees' or 'radians'");
	 end case;
	 Gct.Trace 
	   (Debug_Str, "maxangle is " & 
	      Posangl_Type'Image (Max_Angle) & " radians");
      end Get_Max_Angle;      
      
      procedure Load_Vector4
      is
      begin
	 Listpos3 := Posvec3_Access_Type (List.Pos);
	 Vector (4) (1) := Listpos3.X;
	 Vector (4) (2) := Listpos3.Y;
	 Vector (4) (3) := Listpos3.Z;
	 Listpos3.Tightness := Tightness;
      end Load_Vector4;
      pragma Inline (Get_Tightness, Get_Max_Angle, Load_vector4);
      
      --------------------
   begin
      Get_Tightness;
      Get_Max_Angle;
      
      -- check for nodes that are too close --
      -- 
      -- use 4 points, the things get done between 2 and 3
      --  we need 4 so we can do angles if needed.
      --
      -- if 3 is a stop and 2 overlaps then 
      --    reduce 2tightness
      --    get 1 new point
      -- if 2 is a stop and 3 overlaps then
      --    reduce 3tightness
      --    get 1 new point
      -- if 2 and 3 overlap then
      --    calculate angles at 2 and 3 and 
      --    drop the one with the smallest angle
      --    and get 2 new points
      
      List := Pos_List_Anchor.mNext;
      -- load initial 4 vectors
      for I in 1 .. 4 loop
	 exit when List = Pos_List_Anchor;
	 Listpos3 := Posvec3_Access_Type (List.Pos);
	 Vector (I) (1) := Listpos3.X;
	 Vector (I) (2) := Listpos3.Y;
	 Vector (I) (3) := Listpos3.Z;
	 Listpos3.Tightness := Tightness;
	 List := List.Mnext;
	 Listpos3 := Posvec3_Access_Type (List.Pos);
      end loop;
      List := List.Mprev;  -- back on item 4
      -- Vector (1) is the Startpoint so it is a Stop thus:
      Distance := Vector (2) - Vector (1);
      if Distance < Tightness then -- reduce V2 tightness
	 Posvec3_Access_Type (List.mPrev.mPrev.mPrev.Pos).Tightness := Distance;
      end if;
      -- process the rest of the vector list
      while  List /= Pos_List_Anchor loop
	 Distance := Vector (3) - Vector (2);
	 if Math3d.Almost_Zero (Distance) then -- set a stop on v2 and report it
	    declare 
	       Xstr, Ystr, Zstr : String := "        ";
	       Prev : aliased Dllist_Access_Type;
	    begin
	       Posvec3_Access_Type (List.mPrev.mPrev.Pos).Istop := True;
	       Listpos3 := Posvec3_Access_Type (List.mPrev.mPrev.Pos);
	       Pvio.Put (Xstr, Listpos3.X, 3, 0); -- keep pos for printing.
	       Pvio.Put (Ystr, Listpos3.Y, 3, 0);
	       Pvio.Put (Zstr, Listpos3.Z, 3, 0);
	       Prev := List.MPrev.mPrev;
	       declare
		  Strp : access String := new 
		    String'("# I put a stop X " & Xstr & 
			      " Y " & Ystr & " Z " & Zstr);
		  Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
	       begin
		  Pv.Sa := Strp;
		  Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				   Prev => Prev);
		  Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				   Prev => Pos_List_Anchor);
		  Gct.Trace (Stream1, Strp.all);
		  Gct.Trace (Stream1, "# it has 0 distance to the next point.");
		  Gct.Trace 
		    (Stream1, "# if you did not mean to do that remove it"); 
	       end;
	    end;
	 end if;
	 if Posvec3_Access_Type (List.mPrev.Pos).Istop = True 
	 then -- v3.stop on
	    if Distance < Tightness and 
	      Posvec3_Access_Type(List.mPrev.MPrev.Pos).Tightness > Distance 
	    then -- Reduce V2 Tightness if needed
	       Posvec3_Access_Type (List.mPrev.MPrev.Pos).Tightness 
		 := Distance;
	    end if;
	    Vector (1) := Vector (2);
	    Vector (2) := Vector (3);
	    Vector (3) := Vector (4);
	    --Load_Vector4 later;
	 elsif Posvec3_Access_Type (List.mPrev.mPrev.Pos).Istop = True 
	 then -- v2.stop on
	    if Distance < Tightness and 
	      Posvec3_Access_Type (List.mPrev.Pos).Tightness > Distance 
	    then  -- Reduce V3.Tightness if needed
	       Posvec3_Access_Type (List.mPrev.Pos).Tightness := Distance;
	    end if;
	    Vector (1) := Vector (2);
	    Vector (2) := Vector (3);
	    Vector (3) := Vector (4);
	    --Load_Vector4 later;
	 elsif Distance < 2.0 * Tightness then -- Eliminate 1 of the 2
	    declare 
	       D3d2             : Long_Float := 
		 Math3d.Angle (Vector (1), Vector (2), Vector (3));
	       D3d3             : Long_Float := 
		 Math3d.Angle (Vector (2), Vector (3), Vector (4)); -- the 2 angles
	       Prev, This       : aliased Dllist_Access_Type;
	       Xstr, Ystr, Zstr : String     := "        ";
	       Listpos3         : aliased Posvec3_Access_Type;
	       Listpos9         : aliased Posvec9_Access_Type;
	    begin
	       -- Fix null vector mishaps
	       if Math3d.Almost_Zero (D3d2 - 4.0 * Ada.numerics.Pi) then 
		  D3d2 := 0.0; 
	       end if;
	       if Math3d.Almost_Zero (D3d3 - 4.0 * Ada.numerics.Pi) then 
		  D3d3 := 0.0; 
	       end if;
	       if D3d2 < D3d3 then -- eliminate v2		  
		  if List.mPrev.mPrev.Pos.all in Posvec9_Type then
		     Listpos9 := Posvec9_Access_Type (List.mPrev.mPrev.Pos);
		     Pvio.Put (Xstr, Listpos9.X, 3, 0); -- keep pos for printing.
		     Pvio.Put (Ystr, Listpos9.Y, 3, 0);
		     Pvio.Put (Zstr, Listpos9.Z, 3, 0);
		     This := List.MPrev.mPrev;
		     Unlink_Pos9_Node (List.mPrev.mPrev); -- remove v2
		     Free_Dllist_Node (This);
		     Prev := List.mPrev.MPrev;
		  elsif List.mPrev.mPrev.Pos.all in Posvec3_Type then
		     Listpos3 := Posvec3_Access_Type (List.mPrev.mPrev.Pos);
		     Pvio.Put (Xstr, Listpos3.X, 3, 0); -- keep pos for printing.
		     Pvio.Put (Ystr, Listpos3.Y, 3, 0);
		     Pvio.Put (Zstr, Listpos3.Z, 3, 0);
		     This := List.MPrev.mPrev;	     
		     Unlink_Pos3_Node (List.mPrev.mPrev); -- remove v2
		     Free_Dllist_Node (This);
		     Prev := List.mPrev.MPrev;
		  else 
		     Gct.Trace (Debug_Str, " L740 : unknown class");
		  end if;
		  Vector (2) := Vector (3);
		  Vector (3) := Vector (4);
		  --Load_Vector4 later;
	       else -- eliminate v3
		  if List.mPrev.Pos.all in Posvec9_Type then
		     Listpos9 := Posvec9_Access_Type (List.mPrev.Pos);
		     Pvio.Put (Xstr, Listpos9.X, 3, 0); -- keep pos for printing.
		     Pvio.Put (Ystr, Listpos9.Y, 3, 0);
		     Pvio.Put (Zstr, Listpos9.Z, 3, 0);
		     This := List.MPrev;
		     Unlink_Pos9_Node (List.mPrev); -- remove V3
		     Free_Dllist_Node (This);
		     Prev := List.MPrev;
		  elsif List.mPrev.Pos.all in Posvec3_Type then
		     Listpos3 := Posvec3_Access_Type (List.mPrev.Pos);
		     Pvio.Put (Xstr, Listpos3.X, 3, 0); -- keep pos for printing.
		     Pvio.Put (Ystr, Listpos3.Y, 3, 0);
		     Pvio.Put (Zstr, Listpos3.Z, 3, 0);
		     This := List.MPrev;
		     Unlink_Pos3_Node (List.mPrev); -- remove V3
		     Free_Dllist_Node (This);
		     Prev := List.MPrev;
		  else 
		     Gct.Trace (Debug_Str, " L760 : unknown class");
		  end if;
		  Vector (3) := Vector (4);
		  --Load_Vector4 later;
	       end if;
	       declare
		  Strp : access String := new 
		    String'("# I Eliminated X " & Xstr & 
			      " Y " & Ystr & " Z " & Zstr);
		  Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
	       begin
		  Pv.Sa := Strp;
		  Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				   Prev => Prev);
		  Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				   Prev => Pos_List_Anchor);
		  Gct.Trace (Stream1, Strp.all);
		  Gct.Trace (Stream1, "# it was too close  to a neighbor.");
		  Gct.Trace 
		    (Stream1, "# either insert a stop or change the tightness"); 
	       end;
	    end;
	 else
	    Posvec3_Access_Type (List.mPrev.mPrev.Pos).Tightness := Tightness;----
	    Vector (1) := Vector (2);
	    Vector (2) := Vector (3);
	    Vector (3) := Vector (4);
	    --Load_Vector4 later;
	 end if;
	 List := List.mNext;
	 exit when List = Pos_List_Anchor;
	 Load_Vector4; -- here we load vector4 finally;
      end loop;
      Distance := Vector (3) - Vector (2);      
      if Distance < Tightness then -- reduce V2 (old V3) tightness.
	 Posvec3_Access_Type (List.mPrev.mPrev.Pos).Tightness := Distance;
      end if;
      
      --  calculate the segment angles --
      --  and set stops if too sharp   --
      List := Pos_List_Anchor.mNext;
      Listpos3 := Posvec3_Access_Type (List.Pos);
      -- impossible value for the first one
      ListPos3.D3d := 4.0 * Math.Pi; 
      Vector2 (1) := Listpos3.X;
      Vector2 (2) := Listpos3.Y;
      Vector2 (3) := Listpos3.Z;
      List := List.mNext;
      if List /= Pos_List_Anchor then
	 Listpos3 := Posvec3_Access_Type (List.Pos);
	 Vector3 (1) := Listpos3.X;
	 Vector3 (2) := Listpos3.Y;
	 Vector3 (3) := Listpos3.Z;
      end if;
      while  List /= Pos_List_Anchor loop
	 Vector1 := Vector2;
	 Vector2 := Vector3;
	 Listpos3 := Posvec3_Access_Type (List.Pos);
	 if List.mNext /= Pos_List_Anchor then
	    Listnextpos3 := Posvec3_Access_Type (List.mNext.Pos);
	    Vector3 (1) := ListnextPos3.X;
	    Vector3 (2) := ListnextPos3.Y;
	    Vector3 (3) := ListnextPos3.Z;
	    -- do the angle
	    ListPos3.D3d := 
	      Math3d.Angle (Vector1, Vector2, Vector3);
	    if ListPos3.D3d = 4.0 * Ada.numerics.Pi then 
	       ListPos3.D3d := 0.0; 
	    end if;
	    -- set a stop if angle too big
	    if ListPos3.D3d < Max_Angle then
	       ListPos3.Istop := True;
	       declare
		  Xstr, Ystr, Zstr : String := "        ";
	       begin
		  Pvio.Put (Xstr, Vector2 (1), 3, 0);
		  Pvio.Put (Ystr, Vector2 (2), 3, 0);
		  Pvio.Put (Zstr, Vector2 (3), 3, 0);
		  declare
		     Strp : access String := 
		       new String'("# I put a stop X " &  Xstr & " Y " & Ystr & 
				     " Z " & Zstr);
		     Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
		  begin
		     Pv.Sa := Strp;
		     Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				      Prev => List);
		     Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
				      Prev => Pos_List_Anchor);
		     Gct.Trace (Stream1, Strp.all);
		     Gct.Trace (Stream1, 
				"# the angle between the segments was too big");
		  end;
	       end;
	    else
	       null; -- do not Change A Previous setting
	    end if;
	 else 
	    -- impossible value for the last one
	    ListPos3.D3d := 4.0 * Math.Pi; 
	    null;--Done := True;
	 end if;
	 Gct.Trace (Debug_Str, " space angle : " & 
		      Long_Float'Image (ListPos3.D3d));
	 List := List.mNext;
      end loop;
      
      --  List := Pos_List_Anchor.mNext;
      --  while  List /= Pos_List_Anchor loop
	 
	 
      --  	 List := List.mNext;
      --  	 exit when List = Pos_List_Anchor;
      --  end loop;
   end Process_Vectors;
   
   
   
   ------------------
   -- public procs --
   ------------------
   
   procedure Help
   is
      use Ada.Characters.Latin_1;
   begin
      Tio.Put_Line ("");
      Tio.Put_Line ("postp <options> <input file>");
      Tio.Put_Line ("");
      Tio.Put_Line ("post processes an cl.tap file generated by apt360 ");
      Tio.Put_Line ("for use by the Steigerwald Gmac CNC computer.");
      Tio.Put_Line ("");
      Tio.Put_Line ("options: ");
      Tio.Put_Line ("    -p       : postprocessor name to use - default is 'Ebwm1'.");
      Tio.Put_Line ("    -n       : postprocessor option number - default is '1'.");
      Tio.Put_Line ("input file   : defaults to cl.tap in the current directory");
      Tio.Put_Line ("");
   end Help;
   
   
   ----------------------------------------------
   --      machine tape output routines        --
   -- called from the post-parser by an upcall --
   ----------------------------------------------
   
   procedure Print_Error (S : String)
   is
   begin
      Gct.Trace 
	(Stream1, "# ERROR " & S);
   end Print_Error;
   
   
   
   procedure Print_Comment (S : String)
   is
      Strp : access String := new String'("# " & S);
      Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
   begin
      Pv.Sa := Strp;
      Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			Next => Pos_List_Anchor);
   end Print_Comment;
   
   
   procedure Print_Machine (S : String)
   is
   begin
      if S /= Machine then
	 Print_Error ("The backend specified is wrong, this is not " & S); 
      else
	 null;
      end if;
   end Print_Machine;
   
   
   procedure Print_Cl_Tap_Block (N : in Positive)
   is
   begin
      -- Gct.Trace  (Debug_Str, "# cl tap block " & Integer'Image (N));
      if Print_Sourcelines then
	 Print_Comment ("# cl tap block " & Integer'Image (N));
      end if;
   end Print_Cl_Tap_Block;
   
   
   procedure Print_Apt_Block (N : in Long_Long_Integer)
   is
   begin
      if Print_Sourcelines then
	 Print_Comment ("# source file block " & Long_Long_Integer'Image (N));
      end if;
   end Print_Apt_Block;
   
   
   procedure Print_Debug (S : in String)
   is
   begin
      if S (S'First .. S'First + 3) = "SLON" then
	 Print_Sourcelines := True;
      elsif S (S'First .. S'First + 3) = "SLOF" then
	 Print_Sourcelines := False;
      end if;
   end Print_Debug;
   
   
   procedure Print_Beam_Current (N : in Integer)
     with Pre => (N <= 100 and N > 0);
   procedure Print_Beam_Current (N : in Integer)
   is
      Strp : access String := new String'("BEAM" & Integer'Image (N));
      Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
   begin
      Pv.Sa := Strp;
      Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			Next => Pos_List_Anchor);
   end Print_Beam_Current;
   
   
   procedure Print_Fadeout_Time (F : in Float)
     with Pre => (F >= 0.0 and F <= 5.0);
   procedure Print_Fadeout_Time (F : in Float)
   is
      Tstr : String := "        ";
   begin
      Pvio.Put (Tstr, Long_Float (F), 2, 0);
      declare
	 Strp : access String := new String'("FADEOUT " & Tstr &  " secs");
	 Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
      begin
	 Pv.Sa := Strp;
	 Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			   Next => Pos_List_Anchor);
      end;
   end Print_Fadeout_Time;
   
   
   procedure Print_Fadein_Time (F : in Float)
     with Pre => (F >= 0.0 and F <= 5.0);
   procedure Print_Fadein_Time (F : in Float)
   is
      Tstr : String := "        ";
   begin
      Pvio.Put (Tstr, Long_Float (F), 2, 0);
      declare
	 Strp : access String := new String'("FADEIN " & Tstr &  " secs");
	 Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
      begin
	 Pv.Sa := Strp;
	 Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			   Next => Pos_List_Anchor);
      end;
   end Print_Fadein_Time;
   
   
   procedure Print_Fedrat_Units (S : in String)
   is
      Strp : access String := new String'("          ");
      Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
   begin
      if S (S'First .. S'First + 2) = "IPM" then
	 Fedratunit := Ipm;
      end if;
      declare
	 Fi : Posvec1_Type := 0.0;
	 I  : Integer      := S'First + 3;
      begin
	 while S (I) not in '0' .. '9' loop
	    I := I + 1;
	 end loop;
	 Fi := Posvec1_Type'Value (S (I .. I + 19));
	 if Fedratunit = Ipm then
	    Fedrat := 25.4 * Fi;
	 else
	    Fedrat := Fi;
	 end if;
	 if Fedrat < 0.0 then Fedrat := 0.0;
	 elsif Fedrat > 10_000.0 then Fedrat := 10_000.0;
	 end if;
      exception when Constraint_Error =>
	 Gct.Trace (Debug_Str, "Print_Fedrat_Units error");
      end;
      Pvio.Put (Strp.all(3 .. 9), Posvec1_Type (Fedrat), 1, 0);
      Strp (1) := 'F';
      Pv.Sa := Strp;
      Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			Next => Pos_List_Anchor);
   end Print_Fedrat_Units;
   
   
   procedure Print_Spindle (S : in String)
   is
      S1 : String := S (S'First .. (S'First + 5)); -- 'SPINDL or BEAM'
      S2 : String := S ((S'First + 7) .. (S'First + 10)); -- 'OFF', 'ON ', 'CLW' ...
      S3 : String := S ((S'First + 12) .. S'Last); -- 'NaN', or spindle revs
      V  : Long_Float := 0.0;   
      Sps : String := "        ";
   begin
      if S2 = "OFF " then
	 Sp_State := Off;
      elsif S2 = "ON  " then
	 Sp_State := On;
      elsif S2 = "CLW " then
	 Sp_State := On; -- normally the direction would come into it here
      elsif S2 = "CCLW" then
	 Sp_State := On;
      end if;
      
      if S3 /= "NaN" then
	 V := Long_Float'Value (S3);
	 -- out of range checking
	 if    V < 0.0   then Sp_Revs := 0.0;
	 elsif V > 100.0 then Sp_Revs := 100.0;
	 else                 Sp_Revs := V;
	 end if;
      end if;
      if Sp_State = On then
	 Pvio.Put (Sps (1 .. 6), Posvec1_Type (Sp_Revs), 1, 0);
	 Sps (8) := '%';
      end if;
      declare
	 Strp : access String := 
	   new String'(S1 & " " & Sp_State_Type'Image (Sp_State) & Sps);
	 Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
      begin
	 Pv.Sa := Strp;
	 Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			   Next => Pos_List_Anchor);
      end;
   end Print_Spindle;
   
   
   procedure Print_Cut_Tol (S : in String)
   is
      S1 : String     := S (S'First .. (S'First + 6));
      V  : Posvec1_Type := Posvec1_Type'Value (S ((S'First + 8).. (S'Last))); 
   begin
      if    S1 = "TOLER " then
	 Intol  := 0.0;
	 Outtol := V;
      elsif S1 = "INTOL " then
	 Intol  := V;
      elsif S1 = "OUTTOL" then
	 Outtol := V;
      elsif S1 = "CUTTER" then
	 Cutter := V;
      end if;
      -- !!! this must be dealt with for machining, not for welding
   end Print_Cut_Tol;
   
   
   procedure Print_Multax (S : in String)
   is
   begin
      if S (S'First + 7 .. S'First + 8) = "ON" then
	 Multax_On := True;
	 declare 
	    Strp : access String := 
	      new String'("RELEASE A" & ASCII.LF & "RELEASE B" & ASCII.LF & 
			    "RELEASE C");
	    Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
	 begin
	    Pv.Sa := Strp;
	    Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			      Next => Pos_List_Anchor);
	 end;
      elsif S (S'First + 7 .. S'First + 8) = "OF" then
	 Multax_On := False;
	 declare 
	    Strp : access String := 
	      new String'("CLAMP A" & ASCII.LF & "CLAMP B" & ASCII.LF & "CLAMP C");
	    Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
	 begin
	    Pv.Sa := Strp;
	    Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			      Next => Pos_List_Anchor);
	 end;
      end if;
   end Print_Multax;
   
   
   procedure Print_Origin (S : in String)
   is
      I  : Integer := S'First + 8;
      Sx : String (1 .. 88);
      Xi : Integer := Sx'First - 1;
      Sy : String (1 .. 88);
      Yi : Integer := Sy'First - 1;
      Sz : String (1 .. 88);
      Zi : Integer := Sz'First - 1;
      X  : Posvec1_Type := 0.0;
      Y  : Posvec1_Type := 0.0;
      Z  : Posvec1_Type := 0.0;
   begin
      while S (I) /= ' ' loop
	 Xi := Xi + 1;
	 Sx (Xi) := S (I);
	 I := I + 1;
      end loop;
      while S (I) not in '0' .. '9' loop
	 I := I + 1;
      end loop;
      while S (I) /= ' ' loop
	 Yi := Yi + 1;
	 Sy (Yi) := S (I);
	 I := I + 1;
      end loop;
      while S (I) not in '0' .. '9' loop
	 I := I + 1;
      end loop;
      while S (I) /= ' ' loop
	 Zi := Zi + 1;
	 Sz (Zi) := S (I);
	 I := I + 1;
      end loop;
      X := Posvec1_Type'Value (Sx (Sx'First .. Xi));
      Y := Posvec1_Type'Value (Sy (Sy'First .. Yi));
      Z := Posvec1_Type'Value (Sz (Sz'First .. Zi));
      
      Orig_X := X;
      Orig_Y := Y;
      Orig_Z := Z;
   end Print_Origin;
   
   
   procedure Print_Pos (S : String)
   is
      Ix      : Integer := S'First + 8;
      Command : String (1 .. 4);
      Sl      : String (1 .. 8);
      X, Y, Z, I, J, K : Posvec1_Type;
      A, B, C : Posangl_Type := 0.0;
      Pos3    : access Posvec3_Type := new Posvec3_Type;
      Pos9    : access Posvec9_Type := new Posvec9_Type;
      
      function Scan_Posvec_Str (S : String) return Posvec1_Type
      is
	 V : Posvec1_Type := 0.0;
      begin
	 if S (S'First) = '-' then
	    V  := Posvec1_Type'Value (S (S'First .. S'First + 20));
	    Ix := Ix + 21;
	 else
	    V  := Posvec1_Type'Value (S (S'First .. S'First + 19));
	    Ix := Ix + 20;
	 end if;
	 return V;
      end Scan_Posvec_Str;
      
   begin
      Command := S (S'First .. (S'First + 3));
      if Command = "FROM" and From_Seen then
	 Gct.Trace (Stream1, "Too Many 'From' statements");
	 declare
	    Strp : access String := 
	      new String'("# Too Many 'From' statements");
	    Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
	 begin
	    Pv.Sa := Strp;
	    Insert_Pv_After (This => Posvec_Class_Access_Type (Pv),
			     Prev => Pos_List_Anchor);
	 end;
      else
	 Ix := S'First + 5;
	 Sl := S (Ix .. Ix + 7);
	 Ix  := Ix + 8;
	 while S (Ix) not in '0' .. '9'|'-' loop
	    Ix := Ix + 1;
	 end loop;
	 X := Scan_Posvec_Str (S(Ix .. S'Last));
	 while S (Ix) not in '0' .. '9'|'-' loop
	    Ix := Ix + 1;
	 end loop;
	 Y := Scan_Posvec_Str (S(Ix .. S'Last));
	 while S (Ix) not in '0' .. '9'|'-' loop
	    Ix := Ix + 1;
	 end loop;
	 Z := Scan_Posvec_Str (S(Ix .. S'Last));
	 if Multax_On then
	    while S (Ix) not in '0' .. '9'|'-' loop
	       Ix := Ix + 1;
	    end loop;
	    I := Scan_Posvec_Str (S(Ix .. S'Last));
	    while S (Ix) not in '0' .. '9'|'-' loop
	       Ix := Ix + 1;
	    end loop;
	    J := Scan_Posvec_Str (S(Ix .. S'Last));
	    while S (Ix) not in '0' .. '9'|'-' loop
	       Ix := Ix + 1;
	    end loop;
	    K := Scan_Posvec_Str (S(Ix .. S'Last));
	    
	    Pos9.X := X;
	    Pos9.Y := Y;
	    Pos9.Z := Z;
	    Pos9.I := I;
	    Pos9.J := J;
	    Pos9.K := K;
	    
	    Angles (I, J, K, A, B, C);
	    
	    Pos9.A := A;
	    Pos9.B := B;
	    Pos9.C := C;	 
	    
	    Rotate_V (X, Y, Z, A, B, C);
	    
	    Pos9.Xr := X;
	    Pos9.Yr := Y;
	    Pos9.Zr := Z;
	    if Command = "FROM" then Pos9.From := True;
	    else Pos9.From := False; end if;
	    Insert_Pv_Before (This => Posvec3_Class_Access_Type (Pos9), 
			      Next => Pos_List_Anchor,
			      Mnext => Pos_List_Anchor
			     );
	 else
	    Pos3.X := X;
	    Pos3.Y := Y;
	    Pos3.Z := Z;
	    if Command = "FROM" then Pos3.From := True;
	    else Pos3.From := False; end if;
	    Insert_Pv_Before (This => Posvec3_Class_Access_Type (Pos3), 
			      Next => Pos_List_Anchor,
			      Mnext => Pos_List_Anchor
			     );
	 end if;
	 if Sl (Sl'First) /= Character'Val(0) then
	    Print_Comment ("point label: " & Sl);
	 end if;
	 if From_Seen = False and Command = "FROM" then
	    From_Seen := True;
	 end if;
      end if;
   end Print_Pos;
   
   
   procedure Print_Istop (S : String)
   is
   begin
      Posvec3_Access_Type (Pos_List_Anchor.mPrev.Pos).Istop := True;
   end Print_Istop;
   
   
   procedure Print_Fini (S : String)
   is
      Strp : access String := new String'("FINI");
      Pv :  Posvec_S_Access_Type := new Posvec_S_Type;
   begin
      Pv.Sa := Strp;
      Insert_Pv_Before (This => Posvec_Class_Access_Type (Pv),
			Next => Pos_List_Anchor);
      From_Seen := False;
      Print_Vectors;
      Process_Vectors;
      Output_Program;
   end Print_Fini;
   
   
begin
   Pos_List_Anchor.Pos  := null; 
   Pos_List_Anchor.Prev := Pos_List_Anchor;
   Pos_List_Anchor.mPrev := Pos_List_Anchor;
   Pos_List_Anchor.Next := Pos_List_Anchor;
   Pos_List_Anchor.mNext := Pos_List_Anchor;
   
   Pp.M_Print_Error        := Print_Error'Access;   
   Pp.M_Print_Comment      := Print_Comment'Access; 
   Pp.M_Print_Cl_Tap_Block := Print_Cl_Tap_Block'Access;
   Pp.M_Print_Apt_Block    := Print_Apt_Block'Access;
   Pp.M_Print_Beam_Current := Print_Beam_Current'Access;
   Pp.M_Print_Fadein_Time  := Print_Fadein_Time'Access;
   Pp.M_Print_Fadeout_Time := Print_Fadeout_Time'Access;   
   Pp.M_Print_Fedrat_Units := Print_Fedrat_Units'Access;
   Pp.M_Print_Spindle      := Print_Spindle'Access;
   Pp.M_Print_Multax       := Print_Multax'Access;
   Pp.M_Print_Cut_Tol      := Print_Cut_Tol'Access;
   Pp.M_Print_Machine      := Print_Machine'Access;
   Pp.M_Print_Origin       := Print_Origin'Access;
   Pp.M_Print_Pos          := Print_Pos'Access;
   Pp.M_Print_Debug        := Print_Debug'Access;
   Pp.M_Print_Fini         := Print_Fini'Access;
   Pp.M_Print_Istop        := Print_Istop'Access;
   
end Ebwm1.Machin;


--  IF Vector K > 0.0 Then
--  'Vector K is above horizon of XY Plane

--  Angle B = (ATN(Vector I/Vector K))*(-1)
--  Angle B = (ATN(0.42426406/0.70710678))*(-1)
--  Angle B = (ATN(0.59999999))*(-1)
--  Angle B = 30.964*(-1) (Rounded to 3 places)
--  Angle B = -30.964

--  Angle A = ATN((Vector J/Vector K) * COS(Angle B))
--  Angle A = ATN((0.56568542/0.70710678) * COS(-30.964))
--  Angle A = ATN((0.79999999) * COS(-30.964))
--  Angle A = ATN((0.79999999) * 0.85749074)
--  Angle A = ATN(0.68599258)
--  Angle A = 34.450 (Rounded to 3 places)

--  ELSE IF Vector K = 0.0 Then
--  ' Vector K is at horizon of XY Plane

--  'Prevent Division by Zero Error by 
--  'Assigning the smallest non-zero double-precision value
--  Vector K = 0.0000000000000001

--  Angle B = (ATN(Vector I/Vector K))*(-1)
--  Angle A = ATN((Vector J/Vector K) * COS(Angle B))

--  ELSE
--  'Vector K is below horizon of XY Plane

--  ' +180.0 adjustment indicates Vector K below horizon of XY Plane
--  Angle B = (ATN(Vector I/Vector K)+180.0)*(-1)
--  Angle A = ATN((Vector J/Vector K) * COS(Angle B))

--  END IF
-------------------------------------------------------------------------

-- this is for a machine with a swivel head:

--  MACHINE TOOL  : SNK PC60-V
--  PIVOT DISTANCE: 5.9055  (150mm given by the manufacturer)
--  CUTTING TOOL  : 0.5 DIA LOLLIPOP BALL END MILL
--  GAUGE LENGTH  : 7.0

--  Calculate X,Y,Z Coordinates for CNC Program 

--  APT-CL Point   

--  GOTO /   9.29710,-1.00459,-0.32250,-0.25740, 0.00000, 0.96630

--  Total Pivot Length = (Pivot Distance + Tool Gauge Length)
--  Total Pivot Length = (5.9055+7.0)
--  Total Pivot Length = 12.9055

--  X Coordinate = (X CL Position + (Total Pivot Length * Vector I))
--  X Coordinate = (9.29710 + (12.9055 * -0.25740))
--  X Coordinate = 5.9752

--  Y Coordinate = (Y CL Position + (Total Pivot Length * Vector J))
--  Y Coordinate = (-1.00459 + (12.9055 * 0.00000))
--  Y Coordinate = -1.0046

--  Z Coordinate = (Z CL Position +(Total Pivot Length * Vector K))
--  Z Coordinate = (-0.32250 + (12.9055* 0.96630))
--  Z Coordinate =12.1481

-------------------------------

-- in Our case Y Will Always Be 0 if We Choose The Beamcentre As The Ref Point.

-- when we choose the hypothetical turning point of the B axis as the x reference 
-- then the distance to the workpiece basepoint as decided is the Pivot Distance
-- plus the distance from there to the centre of the beam is the toollength i think.

-- so X as given by APT at each point will be part of the  Total Pivot Length

-- xxx if the ref point is at the workpiece basepoint then:
--  add 'base pivot distance' as given, to the X => Xbase
--  real X := Xbase * COS (B)
--  real X := Xbase * SQRT(1 - SIN(B)^2)
--  real X := Xbase * SQRT(1 - I^2)


---------------------------------------------------
-- while S (Ix) not in '0' .. '9' loop
-- 
