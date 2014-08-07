------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                             B E R E N . J O G                            --
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
-- Template for a jog module
--
with Ada.Numerics;
with O_String;

package body Beren.Jog is
   package Obs renames O_String;
   package Bob renames Beren.Objects;
   package Bjo renames Beren.Jogobj;
   package Bth renames Beren.Thread;
   package Math renames Ada.Numerics;
   
   --------------------
   -- Scan variables --
   --------------------
   Lj_Plus,
   Lj_Min           : Boolean := False;
   Jp_Plus,
   Jp_Min           : Boolean := False;
   Ljog_Enable, 
   P_Jog_Enable     : Boolean := False; 
   C_Pos_Before_Jog : M_Type := 0.0;
   
   Req_Move : M_Type with Atomic;
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
   procedure Handle (Obj : in out Beren.Objects.Object; 
		     M   : in out Beren.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Jog_Object_Type; 
			       M : in out Bjo.Attr_Msg) 
	with Inline
      is
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
      begin
	 if M.Id = Bob.Get then 
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
	   --  elsif Obs.Eq (M.Name, "Offs_Rst" then
	   --     M.Class := Bjo.Boolean;
	   --     M.B := Jog_Object_Type (Obj).Offs_Rst;
	   --     M.Res := 0;
	   else
	      M.Res := 1;
	   end if;
	 elsif M.Id = Bob.Set then
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
		 when Bjo.Off       => Req_Move := 10.0; -- all in meters
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
	      M.Res := 1;
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
	    M.Name  := Obs.To_O_String (32, "-> Jog_Plus");
	    M.Class := Bjo.Bool;
	    M.B := Jog_Plus.all;
	    M.Enum (Name, M);
	    M.Name  := Obs.To_O_String (32, "-> Jog_Min");
	    M.Class := Bjo.Bool;
	    M.B := Jog_Min.all;
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
	 use type Bob.File_Op_Type;
      begin
	 if M.Id = Bob.Store then
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
      JogPlus : Boolean := Jog_Plus.all;
      JogMin  : Boolean := Jog_Min.all;
      use type Bjo.Pulse_Mode_Enumeration_Type;
   begin
      -- llp handshaking
      if Skipto_Stop_Quint then
	 if not Llp_Hsk.all then
	    -- ERROR!!!!
	    null;
	 else
	    Skipto_Stop_Quint := False;
	 end if;
      elsif Stretch_Move_Req then
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
	 Jp_Plus := JogPlus xor Lj_Plus;
	 Jp_Min  := JogMin  xor Lj_Min;
	 Lj_Plus := JogPlus;
	 Lj_Min  := JogMin;
	 if Jogger.Puls_Mod = Bjo.Off then
	    if Jp_Plus and  JogPlus then
	       -- sonja (req_move); can be a message
	       null;
	    elsif Jp_Min and JogMin then
	       -- sonja (- req_move);
	       null;
	    elsif (Jp_Plus and not JogPlus) or (Jp_Min and not JogMin) then
	       Skipto_Stop_Quint := True; -- request to the llp.
	    end if;
	 else
	    if Jp_Plus and JogPlus then -- note that this request can be denied.
	       Stretch_Move     := Req_Move;
	       Stretch_Move_Req := True;
	    elsif Jp_Min and JogMin then
	       Stretch_Move     := - Req_Move;
	       Stretch_Move_Req := True;
	    end if;
	 end if;

      else
	 if Ljog_Enable and not E_Stop.all then -- save offset on disabling
	    Jogger.Offset := Jogger.Offset + (In_Cpos.all - C_Pos_Before_Jog);
	    Ljog_Enable := False;
	 end if;
	 Out_Cpos := In_Cpos.all + Jogger.Offset;
      end if;
      -- reset flqags on Estop!
   end Down_Scan;
   
   procedure Up_Scan
   is
   begin
      Out_Rpos := In_Rpos.all - Jogger.Offset; -- the feedback data
   end Up_Scan;
   
   -- input defaults
   E_Stop_Xf   : aliased Boolean := E_Stop_Init;
   Jog_Plus_Xf : aliased Boolean := Jog_Plus_Init;
   Jog_Min_Xf  : aliased Boolean := Jog_Min_Init;
   In_Cpos_Xf  : aliased M_Type  := In_Cpos_Init;
   In_Rpos_Xf  : aliased M_Type  := In_Rpos_Init;
   
begin
   Bob.Init_Obj (Bob.Object (Jogger), Name);
   Jogger.Handle   := Handle'Access;
   Jogger.Jog_Rate := 0.02; -- meters per second
   Jogger.Enable   := False;
   Jogger.Scale    := 100; -- %
   Jogger.Puls_Mod := Bjo.Off;
   Jogger.Offset   := 0.0; --- meters
   Req_Move        := 0.0; -- meters
   
   -- connect inputs to the defaults
   E_Stop   := E_Stop_Xf'Access;
   Jog_Plus := Jog_Plus_Xf'Access;
   Jog_Min  := Jog_Min_Xf'Access;
   In_Cpos  := In_Cpos_Xf'Access;
   In_Rpos  := In_Rpos_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   Bth.Insert_Down_Scan (Ds);
   Bth.Insert_Up_Scan (Us);
end Beren.Jog;
