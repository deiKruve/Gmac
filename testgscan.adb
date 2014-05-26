------------------------------------------------------------------------------
--                                                                          --
--                             GMAC COMPONENTS                              --
--                                                                          --
--                          T E X T S C A N N E R                           --
--                                                                          --
--                                 b o d y                                 --
--                                                                          --
--         Copyright (C) 2001-2012, Free Software Foundation, Inc.          --
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
--                  Gmac is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

--  Scanner tester
with Ada.Text_IO;
with Gmactextscan;
procedure Testgscan is
   package Gts renames Gmactextscan;
   Token : Gts.Extended_Token_Type;
begin
   Token := Gts.Find_Parameter ("Prin.ter.COM1");
   --Token := Gts.Find_Parameter ("PSPrinter.Width");
   --Token := Gts.Find_Parameter ("PSPrinter.TopMargin");
   Token := Gts.Find_Parameter ("NetSystem.Hosts.Domain");
   Ada.Text_IO.Put_Line (Gts.Extended_Token_Type'Image (Token));
   Ada.Text_IO.Put_Line (Gts.String_Value);
   null;
end Testgscan;
