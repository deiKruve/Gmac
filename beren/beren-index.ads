------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                           B E R E N . I N D E X                          --
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
-- Template for an index module
--
-- on an index request the module inteprets the stored table and issues
-- indefinite travel requests to the parser. At the same time 
-- the stop module is requested to look out for the appropriate switch 
-- or index signal and stop the movement when found.
-- When this signal is found, the happy news triggers a store of the present 
-- position into a temp value. Once the movement is completed the 
-- table intepreter moves on to the next command, untill the commands 
-- are exausted. Then the appropriate preset is loaded into the offset register.

with Earendil.Objects;
with Beren.Stop;
with Beren.Thread;
with Beren.Jogobj;

generic 
  Name : String := "";
   Xis : Axis_type;
   -- type Axis_Type is (Linear, Rotary);
   E_Stop_Init        : Boolean        := False;
   Idx_Stop_Repl_Init : Stop_Repl_Type := Norepl;
   In_Cpos_Init       : M_Type         := 0.0;
   In_Rpos_Init       : M_Type         := 0.0;
   -- these are init values for the real time dataflow interface
   -- in case any of these is not needed. They  can be changed
   -- on instantiation.
package Beren.Index is
      
   ----------------------------------
   -- real time dataflow interface. 
   -- note:
   -- this works together with the 
   -- scan sequence, to insure
   -- the right dataflow through
   -- the system.
   ----------------------------------
   
   E_stop           : access Boolean;
   -- Set On An Emergency stop
   -- after setting a disable message must be send after eom??
   -- jogging might be reenabled after the Estop is resolved.
   
   Idx_Stop_Instr   : aliased Stop_Inst_Type := Noinstr;
   -- flags to the stop unit to look out for a ls switch or index pulse.
   
   Idx_Stop_Repl    : access Stop_Repl_Type;
   -- answer from the stop module that the requested pos has been reached.
   
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
   --            X_idx = {Preset = { 1.20000000000000E+03 m}}
   -- . . Load:  reads the setup parameters for this module like this:
   --            Preset = { 1.20000000000000E+03 m}}
   --     so the name of the module is written but not read.
   
   -- . Attr_Msg
   -- . . Set: sets an attribute to a value
   -- . . Get: gets an attribute value
   -- . . Enum: sends each attribute name and value to an enumeration routine
   --           for debug purposes a.t.l.
   --
   -- Atributes:
   -- . setup parameters:
   -- . . instr : adds a movement instruction to the table of movements for
   --               reaching the home position
   -- . . iclr  : clears the instruction table
   -- . . preset : sets the preset that must be loaded for the home position
   --
   -- . operation parameters
   -- . . enabled : starts the indexing sequence for the axis,
   --                 gets cleared when that position is reached, 
   --                              when there is an error
   
   Type Index_Object_Type is limited private;
   
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
   subtype Index_Instr_Type is Beren.Jogobj.Index_Instr_Enumeration_Type;
  --type Index_Instr_Type is 
  --(No_Go, Go_Pos_Ls, Go_Neg_Ls, Go_Pos_Hs, Go_Neg_Hs, Go_Pos_Idxm, Go_Neg_Idxm);
   
   type Table_Type;
   type Table_P_Type is access all Table_Type;
   type Table_Type is
      record
	 Prev,
	 Next   : Table_P_Type;
	 Inst   : Index_Instr_Type;
	 Feed   : Long_Float with Atomic;
      end record;
   
   Type Index_Object_Type is new Earendil.Objects.Object_Desc with
      record
	 Instr_Table : Table_P_Type;
	 Preset      : Long_Float with Atomic; -- preset of the offset on
					       -- reaching the last position, 
	 Offset      : M_Type  with Atomic;
	 Enabled     : Boolean with Atomic;
      end record;
   type Index_Object_P is access all Index_Object_Type;
   
   -- message object
   Indexer : Index_Object_P := new Index_Object_Type;
   
   
   ----------------------------
   -- beren.thread interface --
   ----------------------------
   Ds : Beren.Thread.Scan_Proc_P_Type := Down_Scan'Access;
   Us : Beren.Thread.Scan_Proc_P_Type := Up_Scan'Access;

end Beren.Index;
