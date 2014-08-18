------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                        B E R E N . E N C O D E R                         --
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
-- Template for an encoder module
--

with Earendil.Objects;
with Beren.Thread;

--with Beren.Jogobj;
generic
   Name : String := "";
   -- the name by which the instantiation is known in the system.
   -- for parameter setting, debugging etc.
   --Xis : Axis_type;
   -- type Axis_Type is (Linear, Rotary);
   
   In_Enc_Count_Init : U16value_Type := 0;
   -- these are init values for the real time dataflow interface
   -- in case any of these is not needed. They  can be changed
   -- on instantiation.
package Beren.Encoder is
      
   ----------------------------------
   -- real time dataflow interface. 
   -- note:
   -- this works together with the 
   -- scan sequence, to insure
   -- the right dataflow through
   -- the system.
   ----------------------------------
   
   In_Enc_Count          : access U16value_Type;
   -- present encoder count from the hardware.
   Out_Rpos         : aliased M_Type;
   -- present position out to up-stream (low level planner a.t.l.)
   Out_Speed        : aliased Mpsec_Type;
   -- present axis speed out to upstream.
   Out_Index         : aliased Boolean;
   -- index pulse to ref-zero module
   Out_Index_Pos      : aliased M_Type;
   -- index position to the ref-zero module.
   
   
   -----------------------
   -- Message interface --
   -----------------------
   -- the following messages are understood:
   -- . File_Msg
   -- . . Store: writes the setup parameters for this module like this:
   --            X_Enc = {multiplier = { 100 p}}
   -- . . Load:  reads the setup parameters for this module like this:
   --            Resolution = { 1024 p/mm}}
   --     so the name of the module is written but not read.
   -- . Attr_Msg
   -- . . Set: sets an attribute to a value
   -- . . Get: gets an attribute value
   -- . . Enum: sends each attribute name and value to an enumeration routine
   --           for debug purposes a.t.l.
   --
   -- Atributes:
   -- . setup parameters
   -- . . dir : count direction. True is fwd, false is backward.
   -- . . Multiplier : in_count is multiplied by this factor
   -- . . divider : result is divided by this factor
   --              these 2 factors are used in scaling the counter.
   --          encoder-pulses /  mm X multiplier / divider = resolution /  mm.
   --          encoder-pulses / deg X multiplier / divider = resolution / deg.
   ---
   -- the encoder will start up with 0 in counter and position.
   --
   -- . . Offset: holds the present offset accumulated by the encoder module
   -- . . 
   type Encoder_Object_Type is limited private;
   
   -- message handler --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class);
   
   -- must be scanned every cnc scan period;
   -- with the flow of the data from llp to motors
   -- so the data travels in 1 scan period to the motor drive
   --procedure Down_Scan;
   -- down scan is not used in an encoder.
   
   -- must be scanned every cnc scan period;
   -- with the flow of the data from motors to llp 
   -- so the encoder data travels in 1 scan period to the llp.
   procedure Up_Scan;
   
private
   
   type Encoder_Object_Type is new  Earendil.Objects.Object_Desc with
      record
	 Reset : Boolean with Atomic;
	 Dir   : Boolean with atomic; -- True is fwd, false is backwd
	 Multiplier : Integer with atomic;
	 Divider    : Integer with atomic;
	 --Resolution : Integer with Atomic;
	 --Offset     : M_Type  with Atomic;
      end record;
   type Encoder_Object_P is access all Encoder_Object_Type;
   
   -- message object --
   Encoder : Encoder_Object_P := new Encoder_Object_Type;
   
   
   ----------------------------
   -- beren.thread interface --
   ----------------------------
   --Ds : Beren.Thread.Scan_Proc_P_Type := Down_Scan'Access;
   Us : Beren.Thread.Scan_Proc_P_Type := Up_Scan'Access;
  
end Beren.Encoder;
