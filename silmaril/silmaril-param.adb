------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                        S I L M A R I L . P A R A M                       --
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

-- the machine parameters are read here on start up and stored
-- for retreaval by the runtime

--!!!!!!!!!errors must be integrated into the proview env.---------

with Ada.Numerics;
with Gmactextscan;
with GNATCOLL.Traces;

package body Silmaril.Param is
   
   package Math renames Ada.Numerics;
   package Gts renames Gmactextscan;
   package Gct renames GNATCOLL.Traces;
   
   -- anything distance --
   subtype Posvec1_Type is Long_Float;
   -- anything angle    --
   subtype Posangl_Type is Long_Float;
   
   -- logging
   Stream1 : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER");
   Stream2 : constant Gct.Trace_Handle := 
     Gct.Create ("SILMARILREADER.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("SILMARILREADER.DEBUG");
   
   
   -------------------------------------
   -- to radian or not to radian . .  --
   -------------------------------------
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
   
   
   -------------------------------------------
   -- the parameter table and its interface --
   -------------------------------------------
   Parameter_Table : Parameter_Table_Type;
   
   protected body Parameter_Table_Type is
      
      entry Set_Postpar (I : in Pparam_Enum_Type; Val : in Long_Float)
      when Open is
      begin
	 Open := False;
	 Post_Par (I) := Val;
	 Open := True;
      end Set_Postpar;
      
      entry Get_Postpar (I : in Pparam_Enum_Type; Val : out Long_Float)
      when Open is
      begin
	 Open := False;
	 Val := Post_Par (I);
	 Open := True;
      end Get_Postpar;
      
      entry Set_Machpar (I : in Mparam_Enum_Type; Val : in Long_Float)
      when Open is
      begin
	 Open := False;
	 Mach_Par (I) := Val;
	 Open := True;
      end Set_Machpar;
      
      entry Get_Machpar (I : in Mparam_Enum_Type; Val : out Long_Float)
      when Open is
      begin
	 Open := False;
	 Val  := Mach_Par (I);
	 Open := True;
      end Get_Machpar;
      
   end Parameter_Table_Type;
   
   
   ------------------------------------------
   -- find the tightness in the setup file --
   ------------------------------------------
   procedure Get_Tightness
   is
      Done      : Boolean    := False;
      Token     : Gts.Extended_Token_Type;
      Tightness : Long_Float := 0.0;
      use type Gts.Extended_Token_Type;
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
      loop
	 exit when Token /= Gts.Id;
	 if Gts.String_Value = "inch" then
	    Tightness := Tightness * 25.4;
	 elsif Gts.String_Value = "mm" then
	    null;
	 else exit;
	 end if;
	 Done := True;
	 exit;
      end loop;
      if not Done then
	 Gct.Trace 
	   (Stream1, 
	    "error in gmac.text-Post.Tightness: expected 'mm' or 'inch'");
      else
	 Gct.Trace (Debug_Str, "tightness is " & 
		      Long_Float'Image (Tightness) & " mm");
	 Parameter_Table.Set_Postpar (Tightnes, Tightness);
      end if;
   end Get_Tightness;
   
   
   ------------------------------------------
   -- find the max angle in the setup file --
   ------------------------------------------
   procedure Get_Max_Angle
   is
      Token     : Gts.Extended_Token_Type;
      Max_Angle : Long_Float := 0.0;
      Done      : Boolean    := False;
      use type Gts.Extended_Token_Type;
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
      loop
	 exit when Token /= Gts.Id;
	 if Gts.String_Value = "degrees" then
	    Max_Angle := To_Radians (Max_Angle);
	 elsif Gts.String_Value = "radians" then
	    null;
	 else exit;
	 end if;
	 Done := True;
	 exit;
      end loop;
      if not Done then
	 Gct.Trace 
	   (Stream1, 
	    "error in gmac.text-Post.Maxangle: " & 
	      "expected 'degrees' or 'radians'");
      else
	 Gct.Trace 
	   (Debug_Str, "maxangle is " & 
	      Posangl_Type'Image (Max_Angle) & " radians");
	 Parameter_Table.Set_Postpar (Maxangle, Max_Angle);
      end if;
   end Get_Max_Angle;
   
   
   ----------------------------------------------
   -- find the maximum feeds in the setup file --
   ----------------------------------------------
   procedure Get_Maximum_Feed 
   is
      Token     : Gts.Extended_Token_Type;
      
      procedure Get_Max_Feed (Axis : Character; Feed_Param : Mparam_Enum_Type)
      is
	 F : Long_Float;
	 
	 procedure M_Convert (Feed : in out Long_Float)
	   -- converts feed to m/sec --
	 is
	    Done : Boolean := False;
	    use type Gts.Extended_Token_Type;
	 begin
	    Token := Gts.Next_Token;
	    loop
	       exit when Token /= Gts.Id;
	       if Gts.String_Value = "inch" then
		     Feed := Feed * 0.0254 / 60.0;
	       elsif Gts.String_Value = "m" then
		  Feed := Feed / 60.0;
	       else exit;
	       end if;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Fwd_Slash;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Id;
	       exit when Gts.String_Value /= "min";
	       Done := True;
	       exit;
	    end loop;
	    if not Done then
	       Feed := 0.0;
	      Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Machine." & Axis & "axis.MaxFeed: " & 
		       "expected 'm/min' or 'inch/min'");
	    end if;
	 end M_Convert;
	 
	 procedure Rad_Convert (Angle : in out Long_Float)
	   -- converts feed to rads / sec --
	 is
	    Done : Boolean := False;
	    use type Gts.Extended_Token_Type;
	 begin
	    Token := Gts.Next_Token;
	    loop
	       exit when Token /= Gts.Id;
	       if Gts.String_Value = "deg" then
		  Angle := To_Radians (Angle) / 60.0;
	       elsif Gts.String_Value = "rad" then
		  Angle := Angle / 60.0;
	       else exit;
	       end if;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Fwd_Slash;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Id;
	       exit when Gts.String_Value /= "min";
	       Done := True;
	       exit;
	    end loop;
	    if not Done then
	       Angle := 0.0;
		  Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Machine.MaxFeed: " & 
		       "expected 'deg/min' or 'rad/min'");
	    end if;
	 end Rad_Convert;
	 
      begin -- Get_Max_Feed
	 Gct.Trace (Debug_Str, "Gettoken Machine." & Axis & "axis.MaxFeed");
	 Token := Gts.Find_Parameter ("Machine." & Axis & "axis.MaxFeed");
	 case Token is
	    when Gts.Number => 
	       F := Long_Float (Integer'Value (Gts.String_Value));
	    when Gts.Float  =>
	       F := Long_float'Value (Gts.String_Value);
	    when others     =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Machine." & Axis & "axis.MaxFeed: " & 
		    "expected number or float");
	 end case;
	 case Axis is
	    when 'X' | 'Y' | 'Z' => 
	       M_Convert (F);
	       Gct.Trace (Debug_Str, "MaxFeed" & Axis & "is " &
			    Long_Float'Image (F) & " m / sec");
	    when 'A' | 'B' | 'C' => 
	       Rad_Convert (F);
	       Gct.Trace (Debug_Str, "MaxFeed" & Axis & "is " &
			    Long_Float'Image (F) & " rad / sec");
	    when others          => null;
	 end case;
	 Parameter_Table.Set_Machpar (I => Feed_Param, Val => F);
      end Get_Max_Feed;
      
   begin --Get_Maximum_Feed
      Get_Max_Feed ('X', X_Maxfeed);
      Get_Max_Feed ('Y', Y_Maxfeed);
      Get_Max_Feed ('Z', Z_Maxfeed);
      Get_Max_Feed ('A', A_Maxfeed);
      Get_Max_Feed ('B', B_Maxfeed);
      Get_Max_Feed ('C', C_Maxfeed);	 
   end Get_Maximum_Feed;
   
   
   procedure Get_Acceleration
   is
      Token     : Gts.Extended_Token_Type;
      
      procedure Get_Accel (Axis : Character; Accel_Param : Mparam_Enum_Type)
      is
	 A : Long_Float;
	 
	  procedure M_Convert (Accel : in out Long_Float)
	   -- converts accel to m/sec^2 --
	 is
	    Done : Boolean := False;
	    use type Gts.Extended_Token_Type;
	 begin
	    Token := Gts.Next_Token;
	    loop
	       exit when Token /= Gts.Id;
	       if Gts.String_Value = "inch" then
		     Accel := Accel * 0.0254;
	       elsif Gts.String_Value = "m" then
		  null; --Accel := Accel / 60.0;
	       else exit;
	       end if;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Fwd_Slash;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Id;
	       exit when Gts.String_Value /= "sec";
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Caret;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Number;
	       exit when Gts.String_Value /= "2";
	       Done := True;
	       exit;
	    end loop;
	    if not Done then
	       Accel := 0.0;
	      Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Machine." & Axis & "axis.Acceleration: " & 
		       "expected 'm/sec^2' or 'inch/sec^2'");
	    end if;
	 end M_Convert;
	 
	 procedure Rad_Convert (Angle : in out Long_Float)
	   -- converts feed to rads / sec --
	 is
	    Done : Boolean := False;
	    use type Gts.Extended_Token_Type;
	 begin
	    Token := Gts.Next_Token;
	    loop
	       exit when Token /= Gts.Id;
	       if Gts.String_Value = "deg" then
		  Angle := To_Radians (Angle);
	       elsif Gts.String_Value = "rad" then
		  null; --Angle := Angle / 60.0;
	       else exit;
	       end if;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Fwd_Slash;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Id;
	       exit when Gts.String_Value /= "sec";
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Caret;
	       Token := Gts.Next_Token;
	       exit when Token /= Gts.Number;
	       exit when Gts.String_Value /= "2";
	       Done := True;
	       exit;
	    end loop;
	    if not Done then
	       Angle := 0.0;
	       Gct.Trace 
		    (Stream1, 
		     "error in gmac.text-Machine." & Axis & "axis.Acceleration: " & 
		       "expected 'deg/sec^2' or 'rad/sec^2'");
	    end if;
	 end Rad_Convert;
	 
      begin
	 Token := Gts.Find_Parameter ("Machine." & Axis & "axis.Acceleration");
	 case Token is
	    when Gts.Number => 
	       A := Long_Float (Integer'Value (Gts.String_Value));
	    when Gts.Float  =>
	       A := Long_float'Value (Gts.String_Value);
	    when others     =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Machine." & Axis & "axis.Acceleration: " & 
		    "expected number or float");
	 end case;
	 case Axis is
	    when 'X' | 'Y' | 'Z' => 
	       M_Convert (A);
	       Gct.Trace (Debug_Str, "Acceleration " & Axis & " is " &
			    Long_Float'Image (A) & " m / sec^2");
	    when 'A' | 'B' | 'C' => 
	       Rad_Convert (A);
	       Gct.Trace (Debug_Str, "Acceleration " & Axis & " is " &
			    Long_Float'Image (A) & " rad / sec^2");
	    when others          => null;
	 end case;
	 Parameter_Table.Set_Machpar (I => Accel_Param, Val => A);
      end Get_Accel;
      
   begin
      Get_Accel ('X', X_Accel);
      Get_Accel ('Y', Y_Accel);
      Get_Accel ('Z', Z_Accel);
      Get_Accel ('A', A_Accel);
      Get_Accel ('B', B_Accel);
      Get_Accel ('C', C_Accel);
   end Get_Acceleration;
   
   procedure Get_Jerk_Time
   is
      Token     : Gts.Extended_Token_Type;
      
      procedure Get_Jrk_Time (Axis : Character; Jerk_Param : Mparam_Enum_Type)
      is
	 Done : Boolean := False;
	 T    : Long_Float;
	 use type Gts.Extended_Token_Type;
      begin
	 Token := Gts.Find_Parameter ("Machine." & Axis & "axis.JerkTime");
	 case Token is
	    when Gts.Number => 
	       T  := Long_Float (Integer'Value (Gts.String_Value));
	    when Gts.Float  =>
	       T := Long_float'Value (Gts.String_Value);
	    when others     =>
	       Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Machine." & Axis & "axis.JerkTime: " & 
		    "expected number or float");
	 end case;
	 Token := Gts.Next_Token;
	 loop
	    exit when Token /= Gts.Id;
	    exit when Gts.String_Value /= "secs" and Gts.String_Value /= "sec";
	    Done := True;
	    exit;
	 end loop;
	 if not Done then
	    Gct.Trace 
		 (Stream1, 
		  "error in gmac.text-Machine." & Axis & "axis.JerkTime: " & 
		    "expected 'secs'.");
	 else
	    Parameter_Table.Set_Machpar (I => Jerk_Param, Val => T);
	 end if;
      end Get_Jrk_Time;
      
   begin
      Get_Jrk_Time ('X', X_Jerktime);
      Get_Jrk_Time ('Y', Y_Jerktime);
      Get_Jrk_Time ('Z', Z_Jerktime);
      Get_Jrk_Time ('A', A_Jerktime);
      Get_Jrk_Time ('B', B_Jerktime);
      Get_Jrk_Time ('C', C_Jerktime);
   end Get_Jerk_Time;
   
   
   procedure Read_Parameters
   is
   begin
      Get_Tightness;
      Get_Max_Angle;
      Get_Maximum_Feed;
      Get_Acceleration;
      Get_Jerk_Time;
      null;
   end Read_Parameters;
   
begin
   null;
end Silmaril.Param;
