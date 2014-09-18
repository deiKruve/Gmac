------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                           B E R E N . I N D E X                          --
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
-- Template for an index module
--
-- on an index request the module inteprets the stored table and issues
-- indefinite travel requests to the parser. At the same time 
-- the stop module is requested to look out for the appropriate switch 
-- or index signal and stop the movement when found.
-- When this signal is found, the happy news triggers a store of the present 
-- position into a temp value. Once the movement is completed the 
-- table intepreter moves on to the next command, untill the commands 
-- are exausted. Then the appropriate preset is loaded into the offset register.
--

with Ada.Text_Io;-- debug??
--with Ada.Numerics;
with Gmactextscan;
with O_String;
with Beren.Err;
with Beren.Jogobj;

package body Beren.Index is
   package Tio renames Ada.Text_Io; -- debug??
   
   package Bst renames Beren.Stop;
   
   package Gts renames Gmactextscan;
   package Obs renames O_String;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Bth renames Beren.Thread;
   package Ber renames Beren.Err;
   
   
   --------------------
   -- Scan variables --
   --------------------
   Req_Move         : M_Type with Atomic;
   -- to send to sonja on jog
   Tmp_Pos         : M_Type with Atomic;
   -- to keep the position on a signal from Beren.Stop.
   
   
   -----------------------
   -- Message interface --
   -----------------------
   
   --  message handler  --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Index_Object_Type; 
			       M : in out Bjo.Attr_Msg) 
	with Inline
      is
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
	 use type Bjo.Enumeration_Type;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then 
	    null;
	    
	 elsif M.Id = Bob.Set and then Obs.Eq (M.S, Name) then
	    null;
	    
	 elsif M.Id = Bob.Setpar then
	    null;
	    
	 elsif M.Id = Bob.Enum then
	    M.Name  := Obs.To_O_String (32, "Enabled");
	    M.Class := Bjo.Bool;
	    M.B := Indexer.all.Enabled;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Offset");
	    M.Class := Bjo.Real;
	    M.X := Indexer.all.Offset;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "Preset");
	    M.Class := Bjo.Real;
	    M.X := Indexer.all.Preset;
	    M.Enum  (Name, M);
	    
	    declare 
	       T   : Table_P_Type := Indexer.Instr_table.Next;
	    begin
	       while T /= Indexer.Instr_Table loop
		  M.Name  := Obs.To_O_String (32, "Instr_Table");
		  M.Class := Bjo.Enum_Real_Pair;
		  M.E     := Indexer.all.Instr_Table.Inst;
		  M.E1    := Bjo.Index_Instr;
		  M.X := Indexer.all.Instr_Table.Feed;
		  M.Enum  (Name, M);
		  T := T.Next;
	       end loop;
	    end;
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Corrector");
	    M.Class := Bjo.Real;
	    M.X     := In_Corrector.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Cpos.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "-> In_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := In_Rpos.all;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Out_Cpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Cpos;
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Out_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Rpos;
	    M.Enum  (Name, M);
	    
	 end if; -- M.Id = ..
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Index_Object_Type; 
			       M : in out Bob.File_Msg)
	with Inline
      is
	 Token     : Gts.Extended_Token_Type;
	 use type Bob.File_Op_Type;
	 use type Gts.Extended_Token_Type;
      begin
	 if M.Id = Bob.Store then
	    null;
	    
	 elsif M.Id = Bob.Load then
	    null;
	    
	 end if;
      end Handle_File_M;
      ------------------
   begin
      if Obj.all in Index_Object_Type then
	 if M in Bjo.Attr_Msg then
	    Handle_Attr_M (Index_Object_Type (Obj.all), Bjo.Attr_Msg (M));
	 elsif M in Bob.File_Msg then
	    Handle_File_M (Index_Object_Type (Obj.all), Bob.File_Msg (M));
	 end if;
      end if;
   end Handle;
   
   
   -------------------------------------------
   -- Scan once per cnc scan period         --
   -- this is executed in a priority thread --
   -------------------------------------------
   procedure Down_Scan
   is
   begin
      null;
   end Down_Scan;
   
   procedure Up_Scan
   is
   begin
      null;
   end Up_Scan;
   
   -- input defaults
   E_Stop_Xf        : aliased Boolean        := E_Stop_Init;
   Idx_Stop_Repl_Xf : aliased Stop_Repl_Type := Norepl;
   In_Cpos_Xf       : aliased M_Type         := In_Cpos_Init;
   In_Rpos_Xf       : aliased M_Type         := In_Rpos_Init;
   
begin
   Bob.Init_Obj (Bob.Object (Indexer), Name);
   Indexer.Handle := Handle'Access;
   Indexer.Preset := 0.0;
   Indexer.Offset := 0.0;
   Indexer.Enabled := False;
   Indexer.Instr_Table := new Table_Type;
   Indexer.Instr_Table.Next  := Indexer.Instr_Table;
   Indexer.Instr_Table.Prev  := Indexer.Instr_Table;
   Indexer.Instr_Table.Inst  := No_Go;
   Indexer.Instr_Table.Feed  := 0.0;
   
   Req_Move := 0.0;
   Tmp_Pos := 0.0;
   
   -- connect inputs to the defaults
   E_Stop        := E_Stop_Xf'Access;
   Idx_Stop_Repl := Idx_Stop_Repl_Xf'Access;
   In_Cpos       := In_Cpos_Xf'Access;
   In_Rpos       := In_Rpos_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   Bth.Insert_Down_Scan (Ds);
   Bth.Insert_Up_Scan (Us);
end Beren.Index;
