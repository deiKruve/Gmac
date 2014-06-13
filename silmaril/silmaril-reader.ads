------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                        S I L M A R I L . R E A D E R                     --
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

--  Is called by Silmaril.File_Selector to read the file and store it
--  in the master dll.
-- In case of error it gets reported to either the file_selector or 
--  via the file selctor to tasks.

with Interfaces.C.Strings;
with Silmaril.Dll;
package Silmaril.Reader is
   
   Prog_Anchor : aliased Silmaril.Dll.Dllist_Access_Type := null;
   Prog_Q      : Dll.Program_Queue_Type;
   -- this stores the program that comes from the postprocessor for further
   -- processing
   
   function Start_Reading (Cs : in Interfaces.C.Strings.Chars_ptr)
			  return boolean;
   -- function Start_Reading parses the char_array it is given by 
   -- Silmaril.File_Selector. It will return true when done, or false on error.
   -- an error would also be indicated in a pop up window in File_Selector perhaps.
   
   function Start_Reading (Str : String) 
			  return Boolean;
   
end Silmaril.Reader;
