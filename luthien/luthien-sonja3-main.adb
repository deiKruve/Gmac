------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                  L U T H I E N . S O N J A 3 . M A I N                   --
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

-- implementation of chapter 3 of the Sonja Macfarlane Thesis
--
-- this package has the main entry and data preparation

package body Luthien.Sonja3.Main is
   
   type State is {
   
   procedure Fsm (Inp : in  Sonja3_In_Type)
   is
   begin
      
   end Fsm;
   
   
   procedure Start (Inp : in  Sonja3_In_Type; Outp : out Qcp.Qcp_Type) 
   is
      
   begin
      null;
   exception
      when others => null;
   end Start;
   
end Luthien.Sonja3.Main;
