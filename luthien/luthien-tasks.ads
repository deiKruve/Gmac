------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                         L U T H I E N . T A S K S                        --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--                     Copyright (C) 2014, Jan de Kruyf                     --
--                 Algorithms copyright (C) Sonja Macfarlane,               --
--                   The University of New Brunswick, 1999                  --
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
-- this is the interface between the plc thread(s) and the Cnc Task Planner
-- conceptually: when a cnc mode button is pressed, the cnc planner goes into 
-- some state where the cnc behaves as the operator expects. 
-- This module is the tasks interface: operator - plc - TASKS - planner.
--  a reportback task to the plc is implemented.
--
with System;
with Ada.Synchronous_Task_Control;
--with Luthien;

package Luthien.Tasks is
   
   --  type Planner_State_Type is (State1,   -- idle
   --  			           State2,   -- hand mode
   --  			           State3,   -- index mode
   --  			           State4,   -- hw mode
   --  			           State4a,  -- imm mode
   --  			           State5,   -- single mode
   --  			           State6,   -- auto mode
   subtype Command_Type is Planner_State_Type range State1 .. State6;
   
   protected Planner_State is
      function Get return Command_Type;
      
      procedure Set (State : Command_Type);
   private
      pragma Priority(Planner_State_Thread_Priority);
      -- Any callers must have priority 
      -- no greater than Thread_Priority
      Command_Res : Command_Type; -- the command executing at the moment
   end Planner_State;
   
   
   -------------------------------------------------------------------
   -- activation of the planner state from the plc real time thread --
   -------------------------------------------------------------------
   Idle_Selector   : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to idle mode.
   Hand_Selector   : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to hand mode.
   Index_Selector  : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to index mode.
   Hw_Selector     : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to hand wheel mode.
   Imm_Selector    : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to immediate mode.
   Single_Selector : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to single block mode.
   Auto_Selector  : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- switches the planner state to automatic mode.
   
   Err_Flag : Ada.Synchronous_Task_Control.Suspension_Object;
   -- i forgot but it sounds like we might need it.
   
   procedure Finalize;
   -- call at the End of Things to abort the tasks.
   
   private
      procedure Report_Error (Err_Str : String);
      -- for up call to report error in the reader
      
end Luthien.Tasks;
