------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                          S I L M A R I L . T A S K                       --
--                                                                          --
--                                  B o d y                                 --
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

with Text_Io; 
with Silmaril.File_Selector;
with Silmaril.Param;
with Silmaril.Reader;

package body Silmaril.tasks is
   
   package Astc renames Ada.Synchronous_Task_Control;
   package Tio  renames Text_Io; 
   
   -----------------------------
   -- result reporting        --
   -- to the real time thread --
   -----------------------------
   protected body Load_Result is
      
      function Get return Ld_Result_Type 
      is
      begin
	 return Ld_Result;
      end Get;
      
      procedure Set (Res : Ld_Result_Type)
      is
      begin
	 Ld_Result := Res;
      end Set;
      
   end Load_Result;
   
   
   ------------------------------------
   -- activation of post file reader --
   -- from the realtime thread       --
   ------------------------------------
   task type Pushed_Button_Type (Pri    : System.Priority; 
				 Button : access Astc.Suspension_Object) is
      pragma Priority (Pri);
      ----waits for Button_Push; 
      -- initiates the reading operation by 
      -- calling Silmaril.File_Selector.Start
   end Pushed_Button_Type;
   
   task body Pushed_Button_Type
      is
      Fin : Boolean := False;
   begin
      loop
	 Astc.Suspend_Until_True (Button.all);
	 Astc.Set_False (Button.all);
	 Load_Result.Set (Working);
	 if Button.all in Prog_Button_Push then
	    Fin := Silmaril.File_Selector.Start;
	 elsif Button.all in Param_Button_Push then
	    Fin := Silmaril.Param.Read_Parameters;
	 end if;
	 if Fin then Load_Result.Set (Done); 
	 else Load_Result.Set (Not_Done);
	 end if;
	 Fin := False;
	 -- must be aborted!!!!!!
	 -- note the race condition: done is set until the slow thread starts
      end loop;
   end Pushed_Button_Type;
   
   T1 : Pushed_Button_Type (Pushed_Loadp_Button_Priority, Prog_Button_Push'access); 
   --this is a slow thread
   T3 : Pushed_Button_Type (Pushed_Loadp_Button_Priority, Param_Button_Push'access);

  
   task type Err_Check_Type (Pri : System.Priority) is
      pragma Priority (Pri);
      -- checks the error flag perhaps returned by the app process
      -- and sets the protected flag accordingly;
      -- this is to alleviate time skew;
   end Err_Check_Type;
   
   task body Err_Check_Type 
      is
   begin
      loop
	 Astc.Suspend_Until_True (Err_Flag);
	 Astc.Set_False (Err_Flag);
	 Load_Result.Set (Error);
	 -- must also be aborted!!
      end loop;
   end Err_Check_Type;
   
   T2 : Err_Check_Type (Load_Result_Thread_Priority); 
   -- this is called by a Proview thread
   
   
   procedure Report_Error (Err_Str : String)
   is
   begin
      Astc.Set_True (Err_Flag);
      Tio.Put_Line (Err_Str); -- take out when proview
      ---   notify the Proview error handling system  ---  ?!!!!!!!!!!!!!!!!!!
   end Report_Error;
   
   
   procedure Finalize
   is
   begin
      abort T1;
      abort T2;
   end Finalize;
   
begin
   Astc.Set_False (Prog_Button_Push);
   Astc.Set_False (Param_Button_Push);
   Astc.Set_False (Err_Flag);
   Silmaril.Reader.M_Report_Error        := Report_Error'access;
   Silmaril.File_Selector.M_Report_Error := Report_Error'access;
   Silmaril.Param.M_Report_Error         := Report_Error'access;
end Silmaril.tasks;
