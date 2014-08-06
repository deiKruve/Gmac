------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                             B E R E N . J O G                            --
--                                                                          --
--                                  S p e c                                 --
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

with Beren.Objects;
with Beren.Jogobj;
generic
   Name : String := "";
   Xis : Axis_type;
package Beren.Jog is
   
   ----------------------------------
   -- real time dataflow interface --
   ----------------------------------
   --Jog_En           : access Boolean;
   -- enables the jog module
   Jog_Plus,
   -- initiates jog in pos dir
   -- depending on the mode it is a pulse or a duration action
   Jog_Min          : access Boolean;
   -- initiates jog in neg dir
   -- depending on the mode it is a pulse or a duration action
   In_Cpos          : access M_Type;
   -- command position in from up-stream (low level planner a.t.l.)
   Out_Cpos         : M_Type;
   -- Command Position out to down-stream (motor drive a.t.l.)
   In_Rpos          : access M_Type;
   -- present position in from down-stream (motor drive a.t.l.)
   Out_Rpos         : M_Type;
   -- present position out to up-stream (low level planner a.t.l.)
   
   --In_Sigma_Offset  : access M_Type;
   --Out_Sigma_Offset : M_Type;
   
   
   -----------------------
   -- Message interface --
   -----------------------
   -- the following messages are understood:
   -- . File_Msg
   -- . . Store: writes the setup parameters for this module like this:
   --            X_Jog = {Jog_Rate = { 1.20000000000000E+03 m/min}}
   -- . . Load:  reads the setup parameters for this module like this:
   --            Jog_Rate = { 1.20000000000000E+03 m/min}}
   --     so the name of the module is written but not read.
   -- . Attr_Msg
   -- . . Set: sets an attribute to a value
   -- . . Get: gets an attribute value
   -- . . Enum: sends each attribute name and value to an enumeration routine
   --           for debug purposes a.t.l.
   --
   -- Atributes:
   -- . setup parameters:
   -- . . Jog_Rate
   -- . . 
   -- . operation parameters
   -- . . Enable : enables the jog module
   -- . . Scale : from the jog scaling knob, in % of Jog_Rate
   -- . . Puls_Mod (0, 0.01, 0.1, 1, 10) mm / pulse (0 is duration mode)
   -- . . Offset: holds the present offset accumulated by the jog module
   -- . . Offs_Rst: pulse: resets the Offset Attribute
   -- . . 
   Type Jog_Object_Type is new Beren.Objects.Object_Desc with
   record
      Jog_Rate : Mpsec_Type := 0.02; -- meters per second
      Enable   : Boolean    := False;
      Scale    : Natural    := 100;  -- 100 %
      Puls_Mod : Beren.Jogobj.Pulse_Mode_Enumeration_Type := Beren.Jogobj.Off;
      Offset   : M_Type     := 0.0;
      --Offs_Rst : Boolean    := False;
   end record;
   type Jog_Object_P is access all Jog_Object_Type;
   
   -- message object --
   Jogger : Jog_Object_P := new Jog_Object_Type;
   
   -- message handler --
   procedure Handle (Obj : in out Beren.Objects.Object; 
		     M   : in out Beren.Objects.Obj_Msg'Class);
   

   end Beren.Jog;
