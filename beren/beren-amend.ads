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
--
-- this module might correct:
--  the effect of temperature on distance travelled. 
--    the output will have a correction based on the In_Corrector input
--  the output as a function of the input as in the case where
--    a focus voltage is dependent on a hight or similar.
--    in this case the output is directly described by the correction curve
--

with Earendil.Objects;
with Beren.Thread;
with Beren.Jogobj;

generic
   Name : String := "";
   -- the name by which the instantiation is known in the system.
   -- for parameter setting, debugging etc.
   Xis : Axis_type;
   -- type Axis_Type is (Linear, Rotary);
   Use_In_Corrector : Boolean := False;
   -- when this is true it is assumed that the correction applied to the
   -- command position is f(In_Corrector) and that it is a multiplier. 
   -- therefore the B in the input table holds a zero offset for purposes of
   -- the correction.
   -- the formula applied is as follows:
   -- Out_Cpos := In_Cpos.all + 
   --                ((In_Cpos.all - B_Table_Now.B) * 
   --                            (B_Table_Now.M * In_Corrector.all + B_Table_Now.N));
   -- where m and n are the factors of the line equation A = B.m + n;
   -- the straight lines are interpolation segments of the correction curve.
   -- 
   -- The B Value is copied from the input table that is used to generate the curve
   --  so every curve segment can have its own offset in terms of the used formula.
   --
   -- when Use_In_Corrector is false, Out_Cpos = f(In_Cpos), 
   -- the function is described by the curve.
   --
   
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
   -- -- . . Relative : set when the Value is relative to the Key in C_Table
   -- -- . . Bdirectional : set when there are 2 values for each Key, one for pos travel
   -- --                     and one for negative travel.
   -- --                    not compatible with Bezier or Poly curve below.
   -- . . Curve : linear - linear interpretation between C_Table sections
   --             bezier - linear interpretation between B_table sections.
   --                      the sections are generated fron the spline knots 
   --                       in C-table
   --                      and are not more than <Dmax> from each other.
   --             poly   - polynomial interpretation of C_Table. 
   --                      The curve is generated  with the sum-least-square 
   --                       algorithm from C_Table.
   --             whenever a "setpar bezier" or a "setpar poly" is send 
   --                       the curve gets regenerated. 
   -- . . C_Table : table of correction point Key - Value triplets.
   --                 Key and Val describe the correction curve.
   --                 B is a zero offset in case of 'Use_In_Corrector' being true
   --                 This is described under 'Use_In_Corrector'
   --                In the case of a Bezier curve pline for the correction values :
   --     Dmax :   sets the max straight lengths between the curve points in B_table.
   -- 
   -- . operation parameters
   -- . . Enable : enables the amend module. 
   --              
   -- . . 
   
   type Amend_Object_Type is limited private;
   
   -- message handler --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class);
   
   -- these 2 are used in the case of        --
   -- Out_Cpos is a function of In_Cpos.     --
   --
   -- must be scanned every cnc scan period;
   -- with the flow of the data from llp to motors
   -- so the data travels in 1 scan period to the motor drive
   procedure Down_Scan;
   
   -- must be scanned every cnc scan period;
   -- with the flow of the data from motors to llp 
   -- so the encoder data travels in 1 scan period to the llp.
   procedure Up_Scan;
   
   -- these are used in the case of a relative offset --
   -- which is a function of the 'In_Corrector input' --
   procedure Down_Scan_C;
   procedure Up_Scan_C;
   
private
   type Table_Type;
   type Table_P_Type is access all Table_Type;
   type Table_Type is
      record
	 Prev,
	 Next  : Table_P_Type;
	 Key,
	 Val   : Long_Float with Atomic; -- when Bdirectional : plus dir values
	 B     : Long_Float with Atomic; -- in case of Q curve 
					 -- when Bdirectional : minus dir values
	 M, N  : Long_Float with Atomic; -- in case of Bezier and also pointtopoint?
					 -- hold the Y = X.m + n factors
      end record;
   
   Type Amend_Object_Type is new Earendil.Objects.Object_Desc with
      record
	 --Relative     : Boolean with Atomic;
	 --Bdirectional : Boolean with Atomic;
	 --Qcurve       : Boolean with Atomic;
	 Curve        : Beren.Jogobj.Curve_Enumeration_Type with Atomic;
	 C_Table      : Table_P_Type;
	 Dmax         : Long_Float with Atomic;
	 Enable       : Boolean with Atomic;
      end record;
   type Amend_Obj_P is access all Amend_Object_Type;
   
   -- message object --
   Amender : Amend_Obj_P := new Amend_Object_Type;
   
   
   ----------------------------
   -- beren.thread interface --
   ----------------------------
   Ds  : Beren.Thread.Scan_Proc_P_Type := Down_Scan'Access;
   Dsc : Beren.Thread.Scan_Proc_P_Type := Down_Scan_C'Access;
   Us  : Beren.Thread.Scan_Proc_P_Type := Up_Scan'Access;
   Usc : Beren.Thread.Scan_Proc_P_Type := Up_Scan_C'Access;
   
   
end Beren.Amend;
