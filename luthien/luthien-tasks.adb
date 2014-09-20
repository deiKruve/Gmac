------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                         L U T H I E N . T A S K S                        --
--                                                                          --
--                                  B o d y                                 --
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

with Text_Io; 
package body Luthien.Tasks is
      
   package Astc renames Ada.Synchronous_Task_Control;
   package Tio  renames Text_Io; 
   
   -----------------------------
   -- result reporting        --
   -- to the real time thread --
   -----------------------------
   protected body Planner_State is
      
      function Get return Command_Type 
      is
      begin
	 return Command_Res;
      end Get;
      
      procedure Set (State : Command_Type)
      is
      begin
	 Command_Res := State;
      end Set;
      
   end Planner_State;
   
   
   task type State_Selector_Type (Pri      : System.Priority; 
				  Selector : access Astc.Suspension_Object) is 
      pragma Priority (Pri);
      -- waits for a Selector 
      -- and sets the planner state accordingly
   end State_Selector_Type;
   
   task body State_Selector_Type 
      is
   begin
      loop
	 Astc.Suspend_Until_True (Selector.all);
	 Astc.Set_False (Selector.all);--??????
	 if Selector.all in Idle_Selector then
	    null;
	 elsif Selector.all in Hand_Selector then
	    null;
	 elsif Selector.all in Index_Selector then
	    null;
	 elsif Selector.all in Hw_Selector then
	    null;
	 elsif Selector.all in Imm_Selector then
	    null;
	 elsif Selector.all in Single_Selector then
	    null;
	 elsif Selector.all in Auto_Selector then
	    null;
	 else null; -- bubu
	 end if;
	 
      end loop;
   end State_Selector_Type;
   
   
   
   
end Luthien.Tasks;
