------------------------------------------------------------------------------
--                                                                          --
--                            LUTHIEN COMPONENTS                            --
--                                                                          --
--                       L U T H I E N . D L L . Q C P                      --
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
--                Luthien is maintained by J de Kruijf Engineers            --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

-- dll of all QCP controlpoints for the low level parser


--with Ada.Tags; use Ada.Tags;

package body Luthien.Dll.Qcp is
   
   procedure Get_Item (N : access Dllist_Type; 
		       Q_P : in out Qcp_Access_Type)
   is
      This : Cp_Access_Type;
   begin
      Pars_Q.Get_Item (N, This);
      if This.all in Qcp_Type then
	 Q_P  := Qcp_Access_Type (This);
      else
	 Q_P := null;
      end if;
   end Get_Item;
   
end Luthien.Dll.Qcp;
