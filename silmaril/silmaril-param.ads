------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                        S I L M A R I L . P A R A M                       --
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

-- the machine parameters are read here on start up and stored
-- for retreaval by the runtime

package Silmaril.Param is
   
   type Pparam_Enum_Type is
     (Tightnes,
      Maxangle);
   
   Post_Par : array (Pparam_Enum_Type) of Long_Float;
   -- this array will hold the postprocessor parameters, if at all needed --
   
   type Mparam_Enum_Type is
     (X_Maxfeed,
      Y_Maxfeed,
      Z_Maxfeed,
      A_Maxfeed,
      B_Maxfeed,
      C_Maxfeed,
      X_Accel,
      Y_Accel,
      Z_Accel,
      A_Accel,
      B_Accel,
      C_Accel,
      X_Jerktime,
      Y_Jerktime,
      Z_Jerktime,
      A_Jerktime,
      B_Jerktime,
      C_Jerktime);
   
   Mach_Par : array (Mparam_Enum_Type) of Long_Float;
   -- this array will hold the machine parameters --
   
   protected type Parameter_Table_Type is
      -- protected type to query the machine parameters from runtime --
      pragma Priority (Prog_Q_Thread_Priority);
      
      entry Set_Postpar (I : in Pparam_Enum_Type; Val : in Long_Float);
      entry Get_Postpar (I : in Pparam_Enum_Type; Val : out Long_Float);
      
      entry Set_Machpar (I : in Mparam_Enum_Type; Val : in Long_Float);
      entry Get_Machpar (I : in Mparam_Enum_Type; Val : out Long_Float);
   private
      Open: Boolean := True;
   end Parameter_Table_Type;
   
   function Read_Parameters return Boolean;
   
   -- so we can report errors to the real time thread.
   type Error_Reporter_Type is access procedure (Err_Str : String);
   M_Report_Error : Error_Reporter_Type;
   
end Silmaril.Param;
