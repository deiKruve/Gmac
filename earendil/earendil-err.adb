------------------------------------------------------------------------------
--                                                                          --
--                            EARENDIL COMPONENTS                           --
--                                                                          --
--                          E A R E N D I L . E R R                         --
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
--               Earendil is maintained by J de Kruijf Engineers            --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- error handling for Earendil modules

with GNATCOLL.Traces;

package body Earendil.Err is
   package Gct renames GNATCOLL.Traces;
 
   -------------------
   -- handle errors --
   -------------------
   -- logging
   Stream1 : constant Gct.Trace_Handle := Gct.Create ("EARENDIL");
   Stream2 : constant Gct.Trace_Handle := 
     Gct.Create ("EARENDIL.EXCEPTIONS");
   Debug_Str : constant Gct.Trace_Handle := Gct.Create ("EARENDIL.DEBUG");

   
   --Error_Reported : Boolean := False;
   
   procedure Report_Error (Err_Str : String)
   is
   begin
      --M_Report_Error (Err_Str);
      Gct.Trace (Stream1, Err_Str);
   end Report_Error;
   pragma Inline (Report_Error);
   
begin
   Gct.Parse_Config_File;   --  parses default ./.gnatdebug
end Earendil.Err;
