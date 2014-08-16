------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                              B E R E N . H W                             --
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
-- Template for a hand wheel module
--
with Ada.Text_Io;

with Ada.Numerics;
with Gmactextscan;
with O_String;
with Beren.Err;

package body Beren.Hw is
   package Tio renames Ada.Text_Io;
   
   package Gts renames Gmactextscan;
   package Obs renames O_String;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Bth renames Beren.Thread;
   package Ber renames Beren.Err;
   package Math renames Ada.Numerics;
   
   --------------------
   -- Scan variables --
   --------------------
   --Lj_Plus,
   --Lj_Min           : Boolean := False;
   --Jp_Plus,
   --Jp_Min           : Boolean := False;
   Lhw_Pos          : Long_Float with Atomic; -- in pulses, to be multiplied with 
                                              -- Pulse_Mod factor
   Ljog_Enable, 
   P_Jog_Enable     : Boolean := False; 
   C_Pos_Before_Jog : M_Type := 0.0;
   
   Req_Move         : M_Type with Atomic;
   -- to send to sonja on jog
   
   
   -------------------------------------
   -- to radian or not to radian . .  --
   -------------------------------------
   function To_Radians (Deg : Long_Float) return Long_Float
   is
   begin
      return (Deg * 2.0 * Math.Pi) / 360.0;
   end To_Radians;
   
   function To_Degrees (Rad : Long_Float) return Long_Float
   is
   begin
      return (Rad * 360.0) / (2.0 * Math.Pi);
   end To_Degrees;
   
   pragma Inline (To_Radians, To_Degrees);
   
   
   -----------------------
   -- Message interface --
   -----------------------
   
   --  message handler  --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Jog_Object_Type; 
			       M : in out Bjo.Attr_Msg) 
	with Inline
      is
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then 
	   if Obs.Eq (M.Name, "Jog_Rate") then
	      M.Class := Bjo.Real;
	      M.X     := Jog_Object_Type (Obj).Jog_Rate;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Enable") then
	      M.Class := Bjo.Bool;
	      M.B := Jog_Object_Type (Obj).Enable;
	      M.Res := 0;
	   elsif Obs.Eq (M.Name, "Scale") then
	      M.Class := Bjo.Int;
	      M.I := Jog_Object_Type (Obj).Scale;
	      M.Res := 0;
	   elsif Obs.Eq (M.Name, "Puls_Mod") then
	      M.Class := Bjo.Enum;
	      M.E := Jog_Object_Type (Obj).Puls_Mod;
	      M.Res := 0;
	   elsif Obs.Eq (M.Name, "Offset") then
	      M.Class := Bjo.Real;
	      M.X     := Jog_Object_Type (Obj).Offset;
	      M.Res := 0;
	   else
	      M.Res := 1; -- attr. name not known
	   end if;
	   
	 elsif M.Id = Bob.Set and then Obs.Eq (M.S, Name) then
	   if Obs.Eq (M.Name, "Jog_Rate") and then M.Class = Bjo.Real then
	      Jog_Object_Type (Obj).Jog_Rate := M.X;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Enable" ) and then M.Class = Bjo.Bool then
	      Jog_Object_Type (Obj).Enable := M.B;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Scale") and then M.Class = Bjo.Int then
	      Jog_Object_Type (Obj).Scale := M.I;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Puls_Mod") and then M.Class = Bjo.Enum then
	      Jog_Object_Type (Obj).Puls_Mod := M.E;
	      case Jogger.Puls_Mod is
		 when Bjo.Off       => Req_Move := 1.0; -- all in meters
		 when Bjo.Hundredth => Req_Move := 0.000_01;
		 when Bjo.Tenth     => Req_Move := 0.000_1;
		 when Bjo.Unit      => Req_Move := 0.001;
		 when Bjo.Ten       => Req_Move := 0.010;
		 --when others => null;
	      end case;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Offset") and then M.Class = Bjo.Real then
	      Jog_Object_Type (Obj).Offset := M.X;
	      M.Res   := 0;
	   elsif Obs.Eq (M.Name, "Offs_Rst") and then M.Class = Bjo.Bool and then
	     M.B = True then
	      Jog_Object_Type (Obj).Offset := 0.0;
	      M.Res := 0;
	   else
	      M.Res := 1; -- attr. name not known
	   end if;
	   
	 elsif M.Id = Bob.Setpar then
	    -- dissect the string 
	    --   <Name> ".Jog_Rate = " <floatValue> [" m/min"|" deg/min"] 
	    if M.Class = Bjo.Str then
	       declare
		  J, K : Integer := 0;
		  Tmp_Val : Long_Float := 0.0;
	       begin
		  for I in M.S'Range loop
		     J := I;
		     exit when M.S (I) = '.';
		     exit when M.S (I) /= Name (I);
		  end loop;
		  if M.S (J) = '.' then -- module name found
		     for I in J + 1 .. M.S'Length loop
			exit when M.S (I) in ' ' | '=';
			K := I;
		     end loop;
		     if String (M.S) (J + 1 .. K) = "Jog_Rate" then
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Tmp_Val := Long_Float'Value (String (M.S) (K .. J - 1));
			while M.S (J) = ' ' loop
			   J := J + 1;
			end loop;
			if Xis = Linear and then 
			  String (M.S) (J .. J + 4) = "m/min" then
			   Jogger.Jog_Rate := Tmp_Val / 60.0;
			   M.Res := 0; -- success
			elsif Xis = Rotary and then 
			  String (M.S) (J .. J + 6) = "deg/min" then
			   Jogger.Jog_Rate := To_Radians (Tmp_Val / 60.0);
			   M.Res := 0; -- success
			else
			   Ber.Report_Error 
			     ("set param: " & Name & ".Jog_Rate -> wrong units.");
			   M.Res := 2; -- units wrong
			end if;
		     else
			Ber.Report_Error 
			     ("set param: " & Name & "no such attribute");
			M.Res := 1; -- no such attribute
		     end if;
		  else
		     M.Res := -4; -- name not found, this is not an error
		  end if;
	       exception
		  when others =>
		     Ber.Report_Error 
		       ("set param: " & Name & 
			  ".Jog_Rate -> expected a float value.");
		     M.Res := 3; -- exception in conversion
	       end;
	    end if;
	    
	 elsif M.Id = Bob.Enum then
	    M.Name  := Obs.To_O_String (32, "Jog_Rate");
	    M.Class := Bjo.Real;
	    M.X     := Jogger.all.Jog_Rate;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "Enable");
	    M.Class := Bjo.Bool;
	    M.B := Jogger.all.Enable;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "Scale");
	    M.Class := Bjo.Int;
	    M.I := Jogger.all.Scale;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "Puls_Mod");
	    M.Class := Bjo.Enum;
	    M.E := Jogger.all.Puls_Mod;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "Offset");
	    M.Class := Bjo.Real;
	    M.X     := Jogger.all.Offset;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "-> E_stop");
	    M.Class := Bjo.Bool;
	    M.B := E_Stop.all;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "-> In_Hwpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Hwpos.all;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "-> In_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Cpos.all;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "-> In_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Rpos.all;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "<- Out_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Cpos;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "<- Out_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Rpos;
	    M.Enum (Name, M);
	 end if;
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Jog_Object_Type; 
			       M : in out Bob.File_Msg)
	with Inline
      is
	 Token     : Gts.Extended_Token_Type;
	 Ljograte  : Mpsec_Type := 0.0;
	 Done      : Boolean    := False;
	 use type Bob.File_Op_Type;
	 use type Gts.Extended_Token_Type;
      begin
	 if M.Id = Bob.Store then
	    declare
	    begin
	       String'Write (M.Ostr, "" & Name & " = {");
	       if Xis = Linear then 
		  declare 
		     Ustr : String := " m/min}";
		  begin
		     String'Write (M.Ostr, "Jog_Rate = {" & 
				     Mpsec_Type'Image (Obj.Jog_Rate * 60.0) &
				     Ustr);
		  end;
	       elsif Xis = Rotary then
		  declare 
		     Ustr : String := " deg/min}";
		  begin
		     String'Write 
		       (M.Ostr, "Jog_Rate = {" & 
			  Mpsec_Type'Image (To_Degrees (Obj.Jog_Rate) * 60.0) &
			  Ustr);
		  end;
	       end if;
	       String'Write (M.Ostr, "}" & ASCII.LF);
	       M.Res := -1; -- success with this unit
	    exception
	       when others => M.Res := 4; -- disk full
	    end;
	 elsif M.Id = Bob.Load then
	    Token := Gts.Find_Parameter ("Machine." & Name & ".Jog_Rate");
	    case Token is
	       when Gts.Float =>
		  Ljograte := Mpsec_Type'Value (Gts.String_Value);
		  Token := Gts.Next_Token;
		  loop
		     exit when Token /= Gts.Id;
		     if Gts.String_Value = "inch" then
			exit when Xis /= Linear;
			Ljograte := Ljograte * 0.0254 / 60.0;
		     elsif Gts.String_Value = "m" then
			exit when Xis /= Linear;
			Ljograte := Ljograte / 60.0;
		     elsif Gts.String_Value = "deg" then
			exit when Xis /= Rotary;
			Ljograte := To_Radians (Ljograte) / 60.0;
		     elsif Gts.String_Value = "rad" then
			exit when Xis /= Rotary;
			Ljograte := Ljograte / 60.0;
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
	       when Gts.Error =>
		  Ber.Report_Error 
		    ("gmac.text: " & Name & " : attr. name not known.");
		  M.Res := 1; -- attr. name not known.
	       when others    =>
		  Ber.Report_Error 
		    ("gmac.text: " & Name & ".Jog_Rate -> expected a float value.");
		  M.Res := 3; -- exception in conversion
	    end case;

	    if not Done then
	       Ljograte := 0.0;
	       if Xis = Linear then
		  Ber.Report_Error 
		    ("gmac.text: " & Name & 
		       ".Jog_Rate -> expected m/min or inch/min.");
	       elsif Xis = Rotary then
		  Ber.Report_Error 
		    ("gmac.text: " & Name & 
		       ".Jog_Rate -> expected deg/min or rad/min.");
	       end if;
	       M.Res := 2; -- error - wrong units.
	    else -- Done
	       Jogger.Jog_Rate := Ljograte;
	       M.Res := 0;
	    end if;
	 end if;
      end Handle_File_M;
      ------------------
   begin
      if Obj.all in Jog_Object_Type then
	 if M in Bjo.Attr_Msg then
	    Handle_Attr_M (Jog_Object_Type (Obj.all), Bjo.Attr_Msg (M));
	 elsif M in Bob.File_Msg then
	    Handle_File_M (Jog_Object_Type (Obj.all), Bob.File_Msg (M));
	 end if;
      end if;
   end Handle;
   
   
   -------------------------------------------
   -- Scan once per cnc scan period         --
   -- this is executed in a priority thread --
   -------------------------------------------
   procedure Down_Scan
   is
      --JogPlus : Boolean := Jog_Plus.all;
      --JogMin  : Boolean := Jog_Min.all;
      use type Bjo.Pulse_Mode_Enumeration_Type;
   begin
      -- llp handshaking
      if Stretch_Move_Req then
	 if not Llp_Hsk.all then
	    -- request from sonja (Stretch_Move)
	    null;
	 else -- stretch was granted.
	    Stretch_Move_Req := False;
	 end if;
      end if;
      
      -- the buttons
      if Jogger.Enable and not E_Stop.all Then
	 if not Ljog_Enable then
	    C_Pos_Before_jog := In_Cpos.all;
	    Ljog_Enable      := True;
	 end if;
	 Stretch_Move := (In_HwPos.all - Lhw_Pos) * Req_Move;
	 Lhw_Pos := In_HwPos.all;
	 Stretch_Move_Req := True;
      else
	 if Ljog_Enable and not E_Stop.all then -- save offset on disabling
	    Jogger.Offset := Jogger.Offset + (In_Cpos.all - C_Pos_Before_Jog);
	    Ljog_Enable := False;
	 end if;
	 --Out_Cpos := In_Cpos.all + Jogger.Offset;
	 --Out_Rpos := In_Rpos.all - Jogger.Offset;
      end if;
      Out_Cpos := In_Cpos.all + Jogger.Offset; -- the command data
      -- reset flqags on Estop!
      null;
   end Down_Scan;
   
   
   procedure Up_Scan
   is
   begin
      Out_Rpos := In_Rpos.all - Jogger.Offset; -- the feedback data
   end Up_Scan;
   
   -- input defaults
   E_Stop_Xf   : aliased Boolean := E_Stop_Init;
   In_Hwpos_Xf : aliased M_Type  := In_Hwpos_Init;
   In_Cpos_Xf  : aliased M_Type  := In_Cpos_Init;
   In_Rpos_Xf  : aliased M_Type  := In_Rpos_Init;
   
begin
   Bob.Init_Obj (Bob.Object (Jogger), Name);
   Jogger.Handle := Handle'Access;
   Jogger.Jog_Rate := 0.02; -- meters per second
   Jogger.Enable := False;
   Jogger.Scale := 100; -- %
   Jogger.Puls_Mod := Bjo.tenth;
   Jogger.Offset := 0.0; --- meters
   Lhw_Pos  := 0.0; -- pulses
   Req_Move := 0.0; -- meters
   
   -- connect inputs to the defaults
   E_Stop   := E_Stop_Xf'Access;
   In_Hwpos := In_Hwpos_Xf'Access;
   In_Cpos  := In_Cpos_Xf'Access;
   In_Rpos  := In_Rpos_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   Bth.Insert_Down_Scan (Ds);
   Bth.Insert_Up_Scan (Us);
end Beren.Hw;
