------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                              L U T H I E N                               --
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
--                Luthien is maintained by J de Kruijf Engineers            --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- root of all parser and low level parser structures
--
with System;
-- with Ada.Numerics.Generic_Real_Arrays;

package Luthien is
   

   Parser_Q_Thread_Priority : constant  System.Priority := 60;
   -- this defines the ceiling priority of 'Luthien.dll.Protected Proq_Q' and
   -- it must match the calling threads.
   
   Planner_State_Thread_Priority : constant  System.Priority := 60;
   -- this defines the ceiling priority of 'Luthien.Tasks.Planner_State' and
   -- it must match the calling threads.
   
   
   ---------------------------------------
   --    for the planner and friends    --
   -- see cnc-states-of-the-planner.dot --
   ---------------------------------------
   --  type Planner_State_Type is (State1,   -- idle
   --       		       State2,   -- hand mode
   --       		       State3,   -- index mode
   --       		       State4,   -- hw mode
   --       		       State4a,  -- imm mode
   --       		       State5,   -- single mode
   --       		       State6,   -- auto mode
   --       		       State7,   -- run hand-move, wait pb release
   --       		       State8,   -- run index-move, wait index ls
   --       		       State9,   -- run hw-move, wait eom or click
   --       		       State10,  -- hand, wait eom
   --       		       State11,  -- hw-mode, wait eom
   --       		       State12,  -- stop, look for decelleration
   --       		       State13,  -- stop-mode, wait eom
   --       		       State5a,  -- single-mode, wait eom
   --       		       State5b,  -- single-mode, wait pb
   --       		       State6a,  -- auto-mode, run program
   --       		       State15,  -- auto-mode, wait eom
   --       		       State16); -- switch auxes off
   

   ---------------------------
   -- for sonja and friends --
   ---------------------------
   subtype Sec_Type is Long_Float;
   subtype M_Type is Long_Float; -- this is disingenious, 
				 --rads are now also called meters.
   subtype Rad_Type is Long_Float;
   subtype Mpsec_Type is Long_Float;  -- speed type
   subtype Mpsec2_Type is Long_Float; -- acc type
   subtype Mpsec3_Type is Long_Float; -- jerk type
   
   --  package Mv is new Ada.Numerics.Generic_Real_Arrays 
   --    (Real => Long_Float);
   

   --  type Real_Vector_Type is new Mv.Real_Vector (1 .. Nof_Axes);

end Luthien;
