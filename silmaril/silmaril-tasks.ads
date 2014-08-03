------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                        S I L M A R I L . T A S K S                       --
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
--                Silmaril is maintained by J de Kruijf Engineers           --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- this is the main interface between the plc thread(s) and some 
-- low priority threads.
-- at the moment it implements the tasks to be called from a plc thread 
-- when data input is needed. Like reading the parameter file of the program file.
--  a reportback task to the plc is implemented.
--

with System;
with Ada.Synchronous_Task_Control;

package Silmaril.tasks is
   
   -- Thread_Priority : can be found in Silmaril.
   -- this defines the ceiling priority of 'protected Load_Result'
   -- it must match the calling thread.
   
   type Ld_Result_Type is (Done, Error, Working);
   
   
   -----------------------------
   -- result reporting        --
   -- to the real time thread --
   -----------------------------
   -- call something like this from a plc thread (see also silmatest.adb):
   -- LOOP that is enabled by a button push-
   --    IF loadresult.get = done THEN
   --       loadresult.set (working)
   --       Astc.Set_True (whatever Button_push)
   --    END IF
   --    IF loadresult.get = error THEN
   --       process error
   --       EXIT
   --    ELSIF loadresult.get = done THEN
   --       EXIT
   --    ELSE
   --       WHEN timeout 
   --             process error
   --             EXIT
   --    END IF
   -- END LOOP
   -- and make sure no two jobs are in progress together
   protected Load_Result is
      function Get return Ld_Result_Type;
      -- get the result of the reading operation
      procedure Set (Res : Ld_Result_Type);
      -- perhaps set this to Working before setting Button_Push in order
      -- to avoid a race condition.
   private
      pragma Priority(Load_Result_Thread_Priority); 
      -- Any callers must have priority 
      -- no greater than Thread_Priority
      Ld_Result : Ld_Result_Type; -- Shared data declaration
   end Load_Result;
   
   
   ------------------------------------
   -- activation of post file reader --
   -- from the realtime thread       --
   ------------------------------------
   Prog_Button_Push : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- set true to initiate reading of the program file from the post
   -- the reading operation will be initiated in due course by 
   -- calling Silmaril.File_Selector.Start
   -- NOTE: make sure to 'Silmaril.tasks.Load_Result.Set (Silmaril.tasks.Working);'
   -- before pushing this button otherwise a glitch will result.
   
   Param_Button_Push : aliased Ada.Synchronous_Task_Control.Suspension_Object;
   -- set true to initiate reading of the parameter file, as previous.
   
   Err_Flag : Ada.Synchronous_Task_Control.Suspension_Object;
   
   procedure Finalize;
   -- call at the End of Things to abort the tasks.
   
private
   procedure Report_Error (Err_Str : String);
   -- for up call to report error in the reader
end Silmaril.tasks;
