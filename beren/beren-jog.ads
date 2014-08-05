------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                             B E R E N . J O G                            --
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
-- Template for a jog module
--

with Beren.Objects;

generic
   Name : String := "";
   Xis : Axis_type;
package Beren.Jog is
   
   ------------------------
   -- dataflow interface --
   ------------------------
   Jog_En           : access Boolean;
   Jog_Plus,
   Jog_Min          : access Boolean;
   In_Cpos          : access M_Type;
   In_Sigma_Offset  : access M_Type;
   Out_Cpos         : M_Type;
   Out_Sigma_Offset : M_Type;
   
   -----------------------
   -- Message interface --
   -----------------------
   Type Jog_Object_Type is new Beren.Objects.Object_Desc with
   record
     Jog_Rate : Mpsec_Type := 0.02; -- meters per second
   end record;
   type Jog_Object_P is access all Jog_Object_Type;
   
   -- message object --
   Jogger : Jog_Object_P := new Jog_Object_Type;
   
   -- message handler --
   procedure Handle (Obj : in out Beren.Objects.Object; 
		     M   : in out Beren.Objects.Obj_Msg'Class);

   end Beren.Jog;
