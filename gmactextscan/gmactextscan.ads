------------------------------------------------------------------------------
--                                                                          --
--                             GMAC COMPONENTS                              --
--                                                                          --
--                          T E X T S C A N N E R                           --
--                                                                          --
--                                 S p e c                                  --
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
--                  Gmac is maintained by J de Kruijf Engineers                       --
--                     (email: jan.de.kruyf@hotmail.com)                           --
--                                                                          --
------------------------------------------------------------------------------

--  Scanner for the Gmac setup file

-----------------------------------------------------------------------------------
-- EBNF for the setup file (a setup file has many configurations):
-- Configuration = Group.
--   Group = { Entry }.
--     Entry = [ Name "=" ] Value.
--       Value = Token | "{" Group "}".
--         Token = any token from the textsscanner; "{" and "}" must occur pairwise.
--                 dont use + or - , they are used for float representation.
--   a named group is referred to as a "section".
--   an unnamed group is skipped as being comment.
-----------------------------------------------------------------------------------

with Ada.Streams;
package Gmactextscan is

   If_Debug                 : Boolean := False;
   --If_Trace                 : Boolean := False;
   --If_Debug                 : Boolean := True;
   --If_Trace                 : Boolean := True;
     
   Setup_File : constant String := "/home/jan/MMS/programs-PC/gmac.text";
   -- full path to the set up file --
   
   type Extended_Token_Type is
     (ID, Number, Float, T_String, Comma, 
      Exclamation, Equal, Open_Brace, Close_Brace, EOF, 
      Error);
   -- the tokens recognized by this scanner --

   subtype Token_Type is Extended_Token_Type range ID .. EOF;

   function Find_Parameter (Param : String) return Extended_Token_Type;
   -- Look for a parameter, the parameter must be in dot notation as follows
   --  <group.subgroup.subsubgroup> etc.
   -- The first token of the associated Entry will be returned. (see EBNF)
   -- If more tokens are needed to find the full value of the parameter then
   --  call Next_Token one or more times.
  
   
   function Next_Token return Extended_Token_Type;
   -- Returns the next token from the setup file, wherever Find_Parameter left
   --  the token pointer.
   
   function String_Value return String;
   -- Returns the string value of the last parsed token from the setup file.
   -- be it as a result of Find_Parameter or Next_Token.
   
end Gmactextscan;
