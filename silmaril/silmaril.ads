------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                              S I L M A R I L                             --
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

--  The top of the Silmaril architecture
--                  /  
--     test_it     /                    real time
--          \     /      ___________________/
--           tasks       \                  \
--             |      build_jog_path   build_hw_path
--      file_selector       |           /
--             |            |          /
--          reader          |         /
--               \_____     |________/
--                     \   /
--             Auto.Dll   jog.Dll
--
-- Auto.Dll Gets Cleared Before loading
--
-- jog.dll gets cleared when switched to jogmode.
-- Since jog is an accumulative thing 
-- jog.dll can just expand and moves done could be wiped dynamically 
-- after a certain size has been reached.  
-- In this way we keep a reasonable backtrack possibility.
-- Jog works by reading an amount of pulses every 100msec and building
-- a path from them.

with System;

package Silmaril is
   Pushed_Loadp_Button_Priority : 
     constant System.Priority := System.Default_Priority; 
   -- this defines the ceiling priority of 'Silmaril.Tasks.Pushed_Loadp_Button_Type'
   -- it is a utility thread
   
   Load_Result_Thread_Priority : constant  System.Priority := 60;
   -- this defines the ceiling priority of 'Silmaril.Tasks.Protected Load_Result'
   -- it must match the calling threads.
   Prog_Q_Thread_Priority : constant  System.Priority := 60;
   -- this defines the ceiling priority of 'Silmaril.Reader.Protected Proq_Q'
   -- it must match the calling threads.
   
   
   --pragma Pure;
   If_Debug                 : Boolean := False;
   --If_Trace                 : Boolean := False;
   --If_Debug                 : Boolean := True;
   --If_Trace                 : Boolean := True;
end Silmaril;
