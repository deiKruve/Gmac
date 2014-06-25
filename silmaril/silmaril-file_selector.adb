------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                S I L M A R I L . F I L E _ S E L E C T O R               --
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
-- its a dummy
-- this is to be replaced with the proper file selector

with Ada.Text_IO;
with POSIX.IO;
with POSIX.Memory_Mapping;
with System.Storage_Elements;
with Silmaril.Reader;

package body Silmaril.File_Selector is
   
   function Read_Entire_File return Boolean
   is
      use POSIX, POSIX.IO, POSIX.Memory_Mapping;
      use System.Storage_Elements;
      
      Text_File    : File_Descriptor;
      Text_Size    : System.Storage_Elements.Storage_Offset;
      Text_Address : System.Address;
      
      Reading_Result : Boolean := False;
   begin
      Text_File := Open (Name => "ring.post",
			 Mode => Read_Only);
      Text_Size := Storage_Offset (File_Size (Text_File));
      Text_Address := Map_Memory (Length     => Text_Size,
				  Protection => Allow_Read,
				  Mapping    => Map_Shared,
				  File       => Text_File,
				  Offset     => 0);
      
      declare
	 Text : String (1 .. Natural (Text_Size));
	 for Text'Address use Text_Address;
      begin
	 Reading_Result := Silmaril.Reader.Start_Reading (Text);
	 if not Reading_Result then
	    M_Report_Error ("Silmaril.Reader: could not interpret the program");
	 end if;
      end;
      
      Unmap_Memory (First  => Text_Address,
		    Length => Text_Size);
      Close (File => Text_File);
      return Reading_Result;
   exception
      when others => 
   	 M_Report_Error ("Silmaril.File_selector: could not read the program.");
   	 return False;
   end Read_Entire_File;
   
   
   function Start return Boolean
   is
   begin
      --  delay(1.0);
      --  M_Report_Error (True);
      --  delay (1.0);
      --  return True;
      return Read_Entire_File;
   end Start;
      
   
end Silmaril.File_Selector;
