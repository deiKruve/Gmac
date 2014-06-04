------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                          S I L M A R I L . T A S K                       --
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
-- implements the task to be called from a plc thread when data input is needed.
-- and also a reportback task
--

with System;
with Ada.Synchronous_Task_Control;

package Silmaril.tasks is
   
   Thread_Priority : constant  System.Priority := 60;
   -- this defines the ceiling priority of 'protected Load_Result'
   -- it must match the calling thread.
   
   type Ld_Result_Type is (Done, Error, Working);
   
   ----------------------
   -- result reporting --
   ----------------------
   protected Load_Result is
      function Get return Ld_Result_Type;
      -- get the result of the reading operation
      procedure Set (Res : Ld_Result_Type);
      -- perhaps set this to Working before setting Button_Push in order
      -- to avoid a race condition.
   private
      pragma Priority(Thread_Priority); -- All callers must have priority 
					-- no greater than Thread_Priority
      Ld_Result : Ld_Result_Type; -- Shared data declaration
   end Load_Result;
   
   ------------------------------------
   -- activation of post file reader --
   ------------------------------------
   Button_Push : Ada.Synchronous_Task_Control.Suspension_Object;
   -- set true to initiate reading of the program file from the post
   -- the reading operation will be initiated in due course by 
   -- calling Silmaril.File_Selector.Start
   
   procedure Finalize;
   -- call at the End of Things to abort the tasks.
   
private
   procedure Report_Error (Err : Boolean := True);
   -- for up call to report error in the reader
end Silmaril.tasks;
