------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                        B E R E N . S C A N N E R                         --
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
-- Scanner Thread Framework for the Beren Modules.
--
-- The Beren Module Set has the unique property that each module keeps 
-- its own generated offset locally, where it gets applied both to the commanded 
-- value for an axis, and to the feedback value from the encoder.
-- This brings some unique design benefits. However, the chain of modules must 
-- be build carefully to realize those advantages, since the data must pass through 
-- a few modules from the llp to the motor and back again from the motor to the llp.
-- And preferably within 2 scan periods.
--
-- This package allows automatic building of the scan thread for the Beren modules.
-- Since there are 2 main data streams connecting the low level parser 
-- to the motor / encoder, that are going in oposite direction through the modules,
-- it is necessary to construct the chain in such a way that:
-- a. the motor recieves the commanded velocity within one scan and
-- b. the llp receives the encoder feedback at the end of the next scan.
-- as is usual in any robotic system.
--
-- this can be archieved with the Beren module set if the modules closest to 
-- the motor are inserted in the chain first (motor drive and encoder) 
-- then the next modules upstream from the motor are inserted, and the next, 
-- and so on.
-- at last the llp module is inserted in the chain.
-- the down_scan procedure of the llp does the command data o/p, and the 
-- up_scan proc does the encoder data input.
-- the chain builds such that the down_scan procedure runs first every scan period
-- and the up_scan proc runs last.
-- the motor is in the middle of the chain, so it gets the data delivered in its 
-- down_scan proc, and the encoder (which is next in the chain of scan procs) gives
-- out its data in its up_scan proc. And by the time the chain of up_scan procs 
-- has been exhausted the data has arrived back at the llp.
--
-- see an example in berentest1.ads for the building of the chain,
-- and berentest1.adb for an example how to wire the data stream from module to
-- module.
-- the wiring must follow the insertion order as in the examples.

package Beren.Thread is
   
   type Scan_Entry_Type;
   type Scan_Entry_P_Type is access all Scan_Entry_Type;
   type Scan_Entry_Type is 
      record
	 Prev, Next : Scan_Entry_P_Type;
	 Scan : access procedure;
      end record;
   
   type Scan_Proc_P_Type is access procedure;
   
   procedure Insert_Down_Scan (Ds : Scan_Proc_P_Type);
   
   procedure Insert_Up_Scan (Us : Scan_Proc_P_Type);
   
   procedure Scan (Q : Scan_Entry_P_Type);
   -- normally Scan_list is passed as an argument to Scan, but it is possible to 
   -- use another root. The insert porcs will have to be modified though.
   Scan_List : Scan_Entry_P_Type := new Scan_Entry_Type;
   
end Beren.Thread;
