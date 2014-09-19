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
with Ada.Unchecked_Deallocation;
with Ada.Numerics;
with Gmactextscan;
with O_String;
with Beren.Err;
with Beren.Jogobj;

package body Beren.Index is
   package Tio renames Ada.Text_Io; -- debug??
   package Math renames Ada.Numerics;
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
   
    
   -------------------------------
   -- clear a instruction table --
   -------------------------------
   procedure Clear_Table (T : Table_P_Type)
   is
      procedure Free is 
	 new Ada.Unchecked_Deallocation (Table_Type, Table_P_Type);
      Tn : Table_P_Type := T.Next;
   begin
      while Tn /= T loop
	 T.Next      := Tn.Next;
	 T.Next.Prev := T;
	 Free (Tn);
	 Tn          := T.Next;
      end loop;
   end Clear_Table;
   
   
   -------------------------------------
   -- to radian or not to radian . .  --
   -------------------------------------
   function To_Radians (Deg : Long_Float) return Long_Float
   is
   begin
      return (Deg * 2.0 * Math.Pi) / 360.0;
   end To_Radians;
   
   function To_Degrees (Rad : Long_Float) return Long_Float
   is
   begin
      return (Rad * 360.0) / (2.0 * Math.Pi);
   end To_Degrees;
   
   pragma Inline (To_Radians, To_Degrees);
   
  
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
	 Tmp_Val : Long_Float := 0.0;
	 Tmp_Instr : Index_Instr_Type := Bjo.No_Go;
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
	 use type Bjo.Enumeration_Type;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then 
	    M.Res := 0;
	    if Obs.Eq (M.Name, "Enabled") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Enabled;
	    elsif Obs.Eq (M.Name, "Offset") then
	      M.Class := Bjo.Real;
	      M.X     := Obj.Offset;
	    elsif Obs.Eq (M.Name, "Preset") then
	      M.Class := Bjo.Real;
	      M.X     := Obj.Preset;
	    elsif Obs.Eq (M.Name, "Instr_Table") then
	       declare 
		  T   : Table_P_Type := Indexer.Instr_table.Next;
	       begin
		  while T /= Indexer.Instr_Table loop
		     M.Class := Bjo.Enum_Real_Pair;
		     M.E     := Index_Instr_Type'Pos (Indexer.all.Instr_Table.Inst);
		     M.E1    := Bjo.Index_Instr;
		     M.X     := Indexer.all.Instr_Table.Feed;
		     M.Enum  (Name, M);
		     T := T.Next;
		  end loop;
	       end;
	    elsif Obs.Eq (M.Name, "Idx_Stop_Instr") then
	      M.Class := Bjo.Enum;
	      M.E1    := Bjo.Stop_Inst;
	      M.E     := Stop_Inst_Type'Pos (Idx_Stop_Instr);
	    elsif Obs.Eq (M.Name, "Idx_Stop_Repl") then
	      M.Class := Bjo.Enum;
	      M.E1    := Bjo.Stop_Repl;
	      M.E     := Stop_Repl_Type'pos (Idx_Stop_Repl.all);
	    elsif Obs.Eq (M.Name, "In_Cpos") then
	       M.Class := Bjo.Real;
	       M.X     := In_Cpos.all;
	    elsif Obs.Eq (M.Name, "Out_Cpos") then
	       M.Class := Bjo.Real;
	       M.X     := Out_Cpos;
	    elsif Obs.Eq (M.Name, "In_Rpos") then
	       M.Class := Bjo.Real;
	       M.X     := In_Rpos.all;
	    elsif Obs.Eq (M.Name, "Out_Rpos") then
	       M.Class := Bjo.Real;
	       M.X     := Out_Rpos;
	    else
	       Ber.Report_Error 
		 ("get param: " & Name & "no such attribute");
	       M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Set and then Obs.Eq (M.S, Name) then
	    M.Res := 0;
	    if Obs.Eq (M.Name, "Preset") and then M.Class = Bjo.Real then
	       Obj.Preset := M.X;
	    elsif Obs.Eq (M.Name, "Cli") and then M.Class = Bjo.Bool then
	       Clear_Table (Obj.Instr_Table);
	    elsif Obs.Eq (M.Name, "Instr") and then 
	      M.Class = Bjo.Enum_Real_Pair and then M.E1 = Bjo.Index_Instr then
	       declare
		  T, Tn  : Table_P_Type;
	       begin
		  T := Obj.Instr_Table;
		  Tn := new Table_type;
		  T.Prev.Next := Tn;
		  Tn.Prev := T.Prev;
		  Tn.Next := T;
		  T.Prev  := Tn;
		  Tn.Inst := Index_Instr_Type'Val (M.E);
		  Tn.Feed := M.X;
	       end;
	    else
	       M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Setpar then
	    -- dissect the string 
	    --   <Name> ".Preset = " <floatValue> ["mm" | "deg"]
	    --   <Name> ".Cli = " <boolValue>
	    --   <Name> ".Instr = " ["Go_Pos_Ls"|"Go_Neg_Ls"|"Go_Pos_Hs"|
	    --                    "Go_Neg_Hs"|"Go_Pos_Idxm"|"Go_Neg_Idxm"] 
	    --                    " F" <floatValue> ["m/min" | "deg/min"]
	    if M.Class = Bjo.Str then
	       declare
		  J, K : Integer := 0;
		  Tmp_Val : Long_Float := 0.0;
	       begin
		  for I in M.S'Range loop
		     J := I;
		     exit when M.S (I) = '.';
		     exit when M.S (I) /= Name (I);
		  end loop;
		  if M.S (J) = '.' then -- module name found
		     for I in J + 1 .. M.S'Length loop
			exit when M.S (I) in ' ' | '=';
			K := I;
		     end loop;
		     if String (M.S) (J + 1 .. K) = "Preset" then
			-- set Preset
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Tmp_Val := Long_Float'Value (String (M.S) (K .. J - 1));
			while M.S (J) = ' ' loop
			   J := J + 1;
			end loop;
			if Xis = Linear and then 
			  String (M.S) (J .. J + 1) = "mm" then
			   Obj.Preset := Tmp_Val / 1000.0;
			   M.Res := 0; -- success
			elsif Xis = Linear and then 
			  String (M.S) (J .. J) = "m" then
			   Obj.Preset := Tmp_Val;
			   M.Res := 0; -- success
			elsif Xis = Rotary and then 
			  String (M.S) (J .. J + 2) = "deg" then
			   Obj.Preset := To_Radians (Tmp_Val);
			   M.Res := 0; -- success
			elsif Xis = Rotary and then 
			  String (M.S) (J .. J + 2) = "rad" then
			   Obj.Preset := Tmp_Val;
			   M.Res := 0; -- success
			else
			   
			   Ber.Report_Error 
			     ("set param: " & Name & ".Preset -> wrong units.");
			   M.Res := 2; -- units wrong
			end if;
		     elsif String (M.S) (J + 1 .. K) = "Cli" then
		     	-- clear the table
		     	K := K + 1;
		     	while M.S (K) in ' ' | '=' loop
		     	   K := K + 1;
		     	end loop;
		     	J := K;
		     	while M.S (J) in 'T' | 'a' .. 'z' loop
		     	   J := J + 1;
		     	end loop;
		     	if String (M.S) (K .. J - 1) in "True" | "true" then
		     	   Clear_Table (Obj.Instr_Table);
		     	   M.Res := 0;
		     	else
		     	   Ber.Report_Error 
		     	     ("set param: " & Name & 
		     		".Relative -> expected 'True'.");
		     	   M.Res := 3; -- exception in conversion
		     	end if; -- true
		     elsif String (M.S) (J + 1 .. K) =  "Instr" then
			-- add an instruction to the table
			K := K + 1;
		     	while M.S (K) in ' ' | '=' loop
		     	   K := K + 1;
		     	end loop;
		     	J := K;
		     	while M.S (J) in 'G' | 'a' .. 'z' loop
		     	   J := J + 1;
		     	end loop;
			M.Res := 0;
		     	if String (M.S) (K .. J - 1) = "Goposls" then
			   Tmp_Instr := Bjo.Go_Pos_Ls;
			elsif String (M.S) (K .. J - 1) = "Gonegls" then
			   Tmp_Instr := Bjo.Go_Neg_Ls;
			elsif String (M.S) (K .. J - 1) = "Goposhs" then
			   Tmp_Instr := Bjo.Go_Pos_Hs;
			elsif String (M.S) (K .. J - 1) = "Goneghs" then
			   Tmp_Instr := Bjo.Go_Neg_Hs;
			elsif String (M.S) (K .. J - 1) = "Goposidxm" then
			   Tmp_Instr := Bjo.Go_Pos_Idxm;
			elsif String (M.S) (K .. J - 1) = "Gonegidxm" then
			   Tmp_Instr := Bjo.Go_Neg_Idxm;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & ".Instr -> expected " & 
				ASCII.LF & 
				"'Go_Pos_Ls'|'Go_Neg_Ls'|'Go_Pos_Hs'|" & 
				"'Go_Neg_Hs'|'Go_Pos_Idxm'|'Go_Neg_Idxm'");
			   M.Res := 3; -- exception in conversion
			end if; -- index instruction.
			K := J;
			while M.S (K) in (' ',  'F') loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '.' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Tmp_Val := Long_Float'Value (String (M.S) (K .. J - 1));
			while M.S (J) = ' ' loop
			   J := J + 1;
			end loop;
			if Xis = Linear and then 
			  String (M.S) (J .. J + 4) = "m/min" then
			   Tmp_Val := Tmp_Val / 60.0;
			   --M.Res := 0; -- success
			elsif Xis = Rotary and then 
			  String (M.S) (J .. J + 6) = "deg/min" then
			   Tmp_Val := To_Radians (Tmp_Val / 60.0);
			   --M.Res := 0; -- success
			else
			   Ber.Report_Error 
			    ("set param: " & Name & ".Instr . . F -> wrong units.");
			   M.Res := 2; -- units wrong
			end if;
			if M.Res = 0 then -- found a validly formatted instruction
			   declare 
			      T, Tn  : Table_P_Type;
			   begin
			      T := Obj.Instr_Table;
			      Tn := new Table_type;
			      T.Prev.Next := Tn;
			      Tn.Prev := T.Prev;
			      Tn.Next := T;
			      T.Prev  := Tn;
			      Tn.Inst := Tmp_Instr;
			      Tn.Feed := Tmp_Val;
			   end;
			end if;
		     else
			Ber.Report_Error 
			  ("set param: " & Name & "no such attribute");
			M.Res := 1; -- no such attribute
		     end if; -- attr name found
		  else
		     M.Res := -4; -- name not found, this is not an error
		  end if; -- module name found
	       exception
		  when others =>
		     Ber.Report_Error 
		       ("set param: " & Name & 
			  ".Instr . . F -> expected a real value.");
		     M.Res := 3; -- exception in conversion
	       end; -- m.class = string block	
	    end if; -- if m.class = string
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
		  M.E     := Index_Instr_Type'Pos (Indexer.all.Instr_Table.Inst);
		  M.E1    := Bjo.Index_Instr;
		  M.X     := Indexer.all.Instr_Table.Feed;
		  M.Enum  (Name, M);
		  T := T.Next;
	       end loop;
	    end;
	    
	    M.Name  := Obs.To_O_String (32, "-> Idx_Stop_Instr");
	    M.Class := Bjo.Enum;
	    M.E1    := Bjo.Stop_Inst;
	    M.E     := Stop_Inst_Type'Pos (Idx_Stop_Instr);
	    M.Enum  (Name, M);
	    
	    M.Name  := Obs.To_O_String (32, "<- Idx_Stop_Repl");
	    M.Class := Bjo.Enum;
	    M.E1    := Bjo.Stop_Repl;
	    M.E     := Stop_Repl_Type'pos (Idx_Stop_Repl.all);
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
	    declare
	    begin
	       String'Write (M.Ostr, "" & Name & " = {");
	       String'Write (M.Ostr, "      Preset = {" &
			       Long_Float'Image (Obj.Preset) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "          Instr_Table = {" & ASCII.LF);
	       declare                                      
		  T   : Table_P_Type := Obj.Instr_Table.Next;
	       begin
		  while T /= Obj.Instr_Table loop
		     if Xis = Linear then 
			declare 
			   Ustr : String := " m/min}";
			begin
			   String'Write 
			     (M.Ostr, "                       {"& 
				Index_Instr_Type'Image (T.Inst) & " " &
				Long_Float'Image (T.Feed * 60.0)  & 
				Ustr & ASCII.LF);
			end;
		     elsif Xis = Rotary then
			declare 
			   Ustr : String := " deg/min}";
			begin
			   String'Write 
			     (M.Ostr, "                       {"& 
				Index_Instr_Type'Image (T.Inst) & " " &
				Long_Float'Image (To_Degrees (T.Feed) * 60.0) &
				Ustr & ASCII.LF);
			end;
		     end if; -- Xis = . .
		     T := T.Next;
		  end loop;
	       end;
	       String'Write (M.Ostr, "                    }" & ASCII.LF);
	       String'Write (M.Ostr, "         }" & ASCII.LF);
	       M.Res := -1; -- success with this unit
	    exception
	       when others => M.Res := 4; -- disk full
	    end;
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
   Indexer.Instr_Table.Inst  := Bjo.No_Go;
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
