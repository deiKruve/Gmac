------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                            B E R E N . S T O P                           --
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
-- beren-stop implements a central movement stop module
--

package Beren.Stop is
   
   
   ----------------------------------
   -- real time dataflow interface. 
   -- note:
   -- this works together with the 
   -- scan sequence, to insure
   -- the right dataflow through
   -- the system.
   ----------------------------------
   
      E_stop           : access Boolean;
      -- Set On An Emergency stop
      
      Xidx_Stop_Instr : access Stop_Inst_Type;
      Yidx_Stop_Instr : access Stop_Inst_Type;
      Aidx_Stop_Instr : access Stop_Inst_Type;
      -- (Noinstr, Idx_Lls, Idx_Rls, Idx_Hls)
      -- indicates that some index unit requests service from B.Stop
      
      Xidx_Stop_Repl  : aliased Stop_Repl_Type := Norepl;
      Yidx_Stop_Repl  : aliased Stop_Repl_Type := Norepl;
      Aidx_Stop_Repl  : aliased Stop_Repl_Type := Norepl;
      -- (Norepl, Reached, Error)
      -- answer that stop instr has been reached and movement has stopped.
      
end Beren.Stop;
