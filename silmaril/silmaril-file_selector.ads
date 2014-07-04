------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                S I L M A R I L . F I L E _ S E L E C T O R               --
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
-- implements  a Gtk.Ada file selector with limited file editing posibilities
-- The Reader gets called with the file selected which then gets parsed for
-- the rt part of the system.
--
-- there is a host of error popups here. which dont really need logging
-- but Tasks should know about an error, so to limit polling time we should
-- make an upcall to tasks to inform about any error.
--


package Silmaril.File_Selector is
   
   function Start return Boolean;
   
   -- error upcall machinery
   type Error_Reporter_Type is access procedure (Err_Str : String);
   M_Report_Error : Error_Reporter_Type;
end Silmaril.File_Selector;

  
