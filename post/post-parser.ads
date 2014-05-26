------------------------------------------------------------------------------
--                                                                          --
--                            POST COMPONENTS                               --
--                                                                          --
--                         P O S T . P A R S E R                            --
--                                                                          --
--                                 S p e c                                  --
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
--              Post is maintained by J de Kruijf Engineers                 --
--                  (email: jan.de.kruyf@hotmail.com)                       --
--                                                                          --
------------------------------------------------------------------------------
--
--  The pst.parser parses the token stream and calls the apropriate 
--   routines in the Post.Machine package
--

with Post.Scanner;
with Ada.Streams;  
with POSIX.IO;

package Post.Parser is
   --with Post.Scanner;
   --package As renames Ada.Streams;  
   
   type Result is (Failure, Success);
   --subtype Stream_Element_Array is As.Stream_Element_Array;
   --type Stream_Element_Array_Access is access all Stream_Element_Array;
   subtype Stream_Element_Array_Access is Post.Scanner.Stream_Element_Array_Access;
   
   Text : Stream_Element_Array_Access := null;
   -- pointer to the Stream we want to process
   
   
   -- upcalls to Ebwm1.Machin
   type Comment_Print_Proc_Type is access procedure (M : in String := "Error!");
   M_Print_Comment      : Comment_Print_Proc_Type;
   type Cl_Tap_Block_Print_Proc_Type is access procedure (N : in Positive := 1);
   M_Print_Cl_Tap_Block : Cl_Tap_Block_Print_Proc_Type;
   type Apt_Block_Print_Proc_Type is access procedure (N : in Long_Long_Integer := 0);
   M_Print_Apt_Block    : Apt_Block_Print_Proc_Type;
   type Beam_Current_Print_Proc_Type is access procedure (N : in Integer := 0);
   M_Print_Beam_Current : Beam_Current_Print_Proc_Type;
   type Fadein_Print_Proc_Type is access procedure (F : in Float := 0.0);
   M_Print_Fadein_Time  : Fadein_Print_Proc_Type;
   type Fedrat_Units_Print_Proc_Type is access procedure (S : in String);
   M_Print_Fedrat_Units : Fedrat_Units_Print_Proc_Type;
   type Error_Print_Proc_Type is access procedure (M : in String := "Error!");
   M_Print_Error        : Error_Print_Proc_Type;
   type Multax_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Multax       : Multax_Print_Type;
   type Spindle_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Spindle      : Spindle_Print_Type;
   type Cut_Tol_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Cut_Tol      : Cut_Tol_Print_Type;
   type Machine_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Machine      : Machine_Print_Type;
   type Origin_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Origin       : Origin_Print_Type;
   type Pos_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Pos          : Pos_Print_Type;
   type Debug_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Debug        : Debug_Print_Type;
   type Fini_Print_Type is access procedure (M : in String := "Error!");
   M_Print_Fini         : Fini_Print_Type;
   type Istop_Printer_Type is access procedure (M : in String := "Error!");
   M_Print_Istop        : Istop_Printer_Type;
   
   
   function Open (Name : String)
		 return Stream_Element_Array_Access;
   --  Open A File for reading
   
   procedure wClose (Fd : POSIX.IO.File_Descriptor);
   
   function Parse (Text : Stream_Element_Array_Access)
		  return Result;
   -- parse this cutter-location file.
   
end Post.Parser;
