------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                           B E R E N . A M E N D                          --
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
-- Template for a correction module

with Earendil.Objects;
with Beren.Thread;

generic
   Name : String := "";
   -- the name by which the instantiation is known in the system.
   -- for parameter setting, debugging etc.
   Xis : Axis_type;
   -- type Axis_Type is (Linear, Rotary);
   
   In_Corrector_Init : M_Type := 0.0;
   In_Cpos_Init      : M_Type := 0.0;
   In_Rpos_Init      : M_Type := 0.0;
   -- these are init values for the real time dataflow interface
   -- in case any of these is not needed. They  can be changed
   -- on instantiation.
   
package Beren.Amend is
   
   ----------------------------------
   -- real time dataflow interface. 
   -- note:
   -- this works together with the 
   -- scan sequence, to insure
   -- the right dataflow through
   -- the system.
   ----------------------------------
   
   In_Corrector     : access M_Type;
   -- corrector input.
   In_Cpos          : access M_Type;
   -- command position in from up-stream (low level planner a.t.l.)
   Out_Cpos         : aliased M_Type;
   -- Command Position out to down-stream (motor drive a.t.l.)
   In_Rpos          : access M_Type;
   -- present position in from down-stream (motor drive a.t.l.)
   Out_Rpos         : aliased M_Type;
   -- present position out to up-stream (low level planner a.t.l.)
   
   -----------------------
   -- Message interface --
   -----------------------
   -- the following messages are understood:
   -- . File_Msg
   -- . . Store: writes the setup parameters for this module like this:
   --            X_Jog = {Jog_Rate = { 1.20000000000000E+03 m/min}}?????????????
   -- . . Load:  reads the setup parameters for this module like this:
   --            Jog_Rate = { 1.20000000000000E+03 m/min}}??????????????????????
   --     so the name of the module is written but not read.
   -- . Attr_Msg
   -- . . Set: sets an attribute to a value
   -- . . Get: gets an attribute value
   -- . . Enum: sends each attribute name and value to an enumeration routine
   --           for debug purposes a.t.l.
   --
   -- Atributes:
   -- . setup parameters:
   -- . . table of correction points
   -- . . table of quintic coefficients (b values) 
   -- 
   -- . operation parameters
   -- . . Enable : enables the jog module. 
   --              disabling might help to construct the table
   -- . . 
   
   type Amend_Object_Type is limited private;
   
   -- message handler --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class);
   
   -- must be scanned every cnc scan period;
   -- with the flow of the data from llp to motors
   -- so the data travels in 1 scan period to the motor drive
   procedure Down_Scan;
   
   -- must be scanned every cnc scan period;
   -- with the flow of the data from motors to llp 
   -- so the encoder data travels in 1 scan period to the llp.
   procedure Up_Scan;
   
private
   type Table_Type;
   type Table_P_Type is access all Table_Type;
   type Table_Type is
      record
	 Prev,
	 Next : Table_P_Type;
	 Key,
	 Val : Long_Float with Atomic;
	 B   : Long_Float with Atomic; -- in case of Q curve 
				       -- no connection with key and val
      end record;
   
   Type Amend_Object_Type is new Earendil.Objects.Object_Desc with
      record
	 Relative     : Boolean with Atomic;
	 Bdirectional : Boolean with Atomic;
	 Qcurve       : Boolean with Atomic;
	 C_Table      : Table_P_Type;
	 Enable       : Boolean with Atomic;
	 
      end record;
   type Amend_Obj_P is access all Amend_Object_Type;
   
   -- message object --
   Amender : Amend_Obj_P := new Amend_Object_Type;
   Amender.C_Table       := new Table_Type;
   
   
   ----------------------------
   -- beren.thread interface --
   ----------------------------
   Ds : Beren.Thread.Scan_Proc_P_Type := Down_Scan'Access;
   Us : Beren.Thread.Scan_Proc_P_Type := Up_Scan'Access;
   
end Beren.Amend;
