------------------------------------------------------------------------------
--                                                                          --
--                             BEREN COMPONENTS                             --
--                                                                          --
--                        B E R E N . E N C O D E R                         --
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
--                 Beren is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- Template for an encoder module
--
with Ada.Text_Io;-- debug??

with Beren.Jogobj;

--with Ada.Numerics;
with Gmactextscan;
with O_String;
with Beren.Err;

package body Beren.Encoder is
   package Tio renames Ada.Text_Io; -- debug??
   
   package Gts renames Gmactextscan;
   package Obs renames O_String;
   package Bob renames Earendil.Objects;
   package Bjo renames Beren.Jogobj;
   package Bth renames Beren.Thread;
   package Ber renames Beren.Err;
   --package Math renames Ada.Numerics;
   
   --------------------
   -- Scan variables --
   --------------------
   type Ll_Integer is range - (2 ** 63) + 1 .. +(2 ** 63) - 1;
   --type U16value_Type is mod 16;
   Totalizer : Ll_Integer;
   Value,
   O_Value : U16value_Type;
   
   
   -----------------------
   -- Message interface --
   -----------------------
   
   --  message handler  --
   procedure Handle (Obj : in out Earendil.Objects.Object; 
		     M   : in out Earendil.Objects.Obj_Msg'Class)
   is
      -------------
      procedure Handle_Attr_M (Obj : in out Encoder_Object_Type; 
			       M : in out Bjo.Attr_Msg) 
	with Inline
      is
	 use type Bob.Op_Type;
	 use type Bjo.Attr_Class;
      begin
	 if M.Id = Bob.Get and then Obs.Eq (M.S, Name) then 
	    if Obs.Eq (M.Name, "Dir") then
	       M.Class := Bjo.Bool;
	       M.B := Obj.Dir;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Multiplier") then
	       M.Class := Bjo.Int;
	       M.I := Obj.Multiplier;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Divider") then
	       M.Class := Bjo.Int;
	       M.I := Obj.Divider;
	       M.Res := 0;
	    --  elsif Obs.Eq (M.Name, "Resolution") then
	    --     M.Class := Bjo.Int;
	    --     M.I := Obj.Resolution;
	    --     M.Res   := 0;
	    elsif Obs.Eq (M.Name, "Out_Rpos") then
	       M.Class := Bjo.Real;
	       M.X     := Out_Rpos;
	       M.Res   := 0;
	    elsif Obs.Eq (M.Name, "Speed") then
	       M.Class := Bjo.Real;
	       M.X     := Out_Rpos;
	       M.Res   := 0;
	    elsif Obs.Eq (M.Name, "Out_index_Pos") then
	       M.Class := Bjo.Real;
	       M.X     := Out_Index_Pos;
	       M.Res   := 0;
	    elsif Obs.Eq (M.Name, "In_Enc_Count") then
	       M.Class := Bjo.Int;
	       M.I := Integer (In_Enc_Count.all);
	       M.Res := 0;
	    else
	       Ber.Report_Error 
		 ("get param: " & Name & "no such attribute");
	       M.Res := 1; -- attr. name not known
	    end if;
	    
	 elsif M.Id = Bob.Set and then Obs.Eq (M.S, Name) then
	    if Obs.Eq (M.Name, "reset") and then M.Class = Bjo.Bool then
	       Totalizer := 0;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Dir") and then M.Class = Bjo.Bool then
	       Obj.Dir := M.B;
	       M.Res := 0;
	    elsif Obs.Eq (M.Name, "Multiplier") and then M.Class = Bjo.Int then
	       Obj.Multiplier := M.I;
	       M.Res   := 0;
	    elsif Obs.Eq (M.Name, "Divider") and then M.Class = Bjo.Int then
	       Obj.Divider := M.I;
	       M.Res   := 0;
	    --  elsif Obs.Eq (M.Name, "Resolution") and then M.Class = Bjo.Int then
	    --     Obj.Resolution := M.I;
	    --     M.Res   := 0;
	    else
	       M.Res := 1; -- attr. name not known
	    end if;
	 elsif M.Id = Bob.Setpar then
	    -- dissect the string 
	    --   <Name> ".Dir = " <boolValue>
	    --   <Name> ".Multiplier = " <IntegerValue> 
	    --   <Name> ".Divider = " <IntegerValue> 
	    --   <Name> ".Resolution = " <IntegerValue> 
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
		     if String (M.S) (J + 1 .. K) = "Dir" then
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in 'T' | 'F' | 'a' .. 'z' loop
			   J := J + 1;
			end loop;
			if String (M.S) (K .. J - 1) in "True" | "true" | 
			  "False" | "false" then
			   Encoder.Dir := 
			     Boolean'Value (String (M.S) (K .. J - 1));
			   M.Res := 0;
			else
			   Ber.Report_Error 
			     ("set param: " & Name & 
				".Dir -> expected 'True' or 'False'.");
			   M.Res := 3; -- exception in conversion
			end if; -- true or false
		     elsif String (M.S) (J + 1 .. K) = "Multiplier" then
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Encoder.Multiplier := 
			  Integer'Value (String (M.S) (K .. J - 1));
			M.Res := 0;
		     elsif String (M.S) (J + 1 .. K) = "Divider" then
			K := K + 1;
			while M.S (K) in ' ' | '=' loop
			   K := K + 1;
			end loop;
			J := K;
			while M.S (J) in '0' .. '9' | '-' | '+' loop
			   J := J + 1;
			end loop;
			Encoder.Divider := 
			  Integer'Value (String (M.S) (K .. J - 1));
			M.Res := 0;
		     --  elsif String (M.S) (J + 1 .. K) = "Resolution" then
		     --  	K := K + 1;
		     --  	while M.S (K) in ' ' | '=' loop
		     --  	   K := K + 1;
		     --  	end loop;
		     --  	J := K;
		     --  	while M.S (J) in '0' .. '9' | '-' | '+' loop
		     --  	   J := J + 1;
		     --  	end loop;
		     --  	Encoder.Resolution := 
		     --  	  Integer'Value (String (M.S) (K .. J - 1));
		     else
			Ber.Report_Error 
			  ("set param: " & Name & "no such attribute");
			M.Res := 1; -- no such attribute
		     end if; -- attr name
		  else
		     M.Res := -4; -- name not found, this is not an error
		  end if; -- module name found
	       exception
		  when others =>
		     Ber.Report_Error 
		       ("set param: " & Name & 
			  ".some attr -> expected an integer value.");
		     M.Res := 3; -- exception in conversion
	       end;
	    end if; -- M.Class = Bjo.Str
	    
	 elsif M.Id = Bob.Enum then
	    M.Name  := Obs.To_O_String (32, "Dir");
	    M.Class := Bjo.Bool;
	    M.B := Encoder.all.Dir;
	    M.Enum  (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "Multiplier");
	    M.Class := Bjo.Int;
	    M.I     := Encoder.all.Multiplier;
	    M.Enum  (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "Divider");
	    M.Class := Bjo.Int;
	    M.I     := Encoder.all.Divider;
	    M.Enum  (Name, M);	       
	    --  M.Name  := Obs.To_O_String (32, "Resolution");
	    --  M.Class := Bjo.Int;
	    --  M.I     := Encoder.all.Resolution;
	    --  M.Enum  (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "<- Out_Rpos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Rpos;
	    M.Enum (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "<- Out_Speed");
	    M.Class := Bjo.Real;
	    M.X     := Out_Speed;
	    M.Enum (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "<- Out_Index_Pos");
	    M.Class := Bjo.Real;
	    M.X     := Out_Index_Pos;
	    M.Enum (Name, M);	       
	    M.Name  := Obs.To_O_String (32, "-> In_Enc_Count");
	    M.Class := Bjo.Int;
	    M.I     := Integer (In_Enc_Count.all);
	    M.Enum (Name, M);
	 end if;
      end Handle_Attr_M;
      -------------
      procedure Handle_File_M (Obj : in out Encoder_Object_Type; 
			       M : in out Bob.File_Msg)
	with Inline
      is
	 Token     : Gts.Extended_Token_Type;
	 --Ljograte  : Mpsec_Type := 0.0;
	 Done      : Boolean    := False;
	 use type Bob.File_Op_Type;
	 use type Gts.Extended_Token_Type;
      begin
	 if M.Id = Bob.Store then
	    declare
	    begin
	       String'Write (M.Ostr, "" & Name & " = {");
	       String'Write (M.Ostr, "Dir = {" &
			       Boolean'Image (Obj.Dir) & "}" & ASCII.LF);
	       
	       String'Write (M.Ostr, "         Multiplier = {" &
			       Integer'Image (Obj.Multiplier) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "         Divider = {" &
			       Integer'Image (Obj.Divider) & "}" & ASCII.LF);
	       --  String'Write (M.Ostr, "        Resolution = {" &
	       --  	         Integer'Image (Obj.Resolution) & "}" & ASCII.LF);
	       String'Write (M.Ostr, "        }" & ASCII.LF);
	       M.Res := -1; -- success with this unit
	    exception
	       when others => M.Res := 4; -- disk full
	    end;
	 elsif M.Id = Bob.Load then
	    loop
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Dir");
	       case Token is
		  when Gts.T_String =>
		     Encoder.Dir := Boolean'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & ".Dir -> expected 'True' or 'False'.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Multiplier");
	       case Token is
		  when Gts.Number =>
		     Encoder.Multiplier := Integer'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Multiplier -> expected Integer value.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       Token := Gts.Find_Parameter ("Machine." & Name & ".Divider");
	       case Token is
		  when Gts.Number =>
		     Encoder.Divider := Integer'Value (Gts.String_Value);
		  when Gts.Error =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & " : attr. name not known.");
		     M.Res := 1; -- attr. name not known.
		     exit;
		  when others    =>
		     Ber.Report_Error 
		       ("gmac.text: " & Name & 
			  ".Divider -> expected Integer value.");
		     M.Res := 3; -- exception in conversion
		     exit;
	       end case;
	       --  Token := Gts.Find_Parameter ("Machine." & Name & ".Resolution");
	       --  case Token is
	       --  	  when Gts.Number =>
	       --  	     Encoder.Resolution := Integer'Value (Gts.String_Value);
	       --  	  when Gts.Error =>
	       --  	     Ber.Report_Error 
	       --  	       ("gmac.text: " & Name & " : attr. name not known.");
	       --  	     M.Res := 1; -- attr. name not known.
	       --  	     exit;
	       --  	  when others    =>
	       --  	     Ber.Report_Error 
	       --  	       ("gmac.text: " & Name & 
	       --  		  ".Resolution -> expected Integer value.");
	       --  	     M.Res := 3; -- exception in conversion
	       --  	     exit;
	       --  end case;
	       M.Res := 0;
	       exit;
	    end loop;
	 end if;
      end Handle_File_M;
      ------------------
   begin
      if Obj.all in Encoder_Object_Type then
	 if M in Bjo.Attr_Msg then
	    Handle_Attr_M (Encoder_Object_Type (Obj.all), Bjo.Attr_Msg (M));
	 elsif M in Bob.File_Msg then
	    Handle_File_M (Encoder_Object_Type (Obj.all), Bob.File_Msg (M));
	 end if;
      end if;
   end Handle;
   
   
   -------------------------------------------
   -- Scan once per cnc scan period         --
   -- this is executed in a priority thread --
   -------------------------------------------
   procedure Up_Scan
   is
   begin
      Value := In_Enc_Count.all;
        --  if ((o->oldValue > 49152) && (u16value <= 16384))
	--    o->rollover += 65536;
	--  else if ((o->oldValue <= 16384) && (u16value > 49152))
	--    o->rollover -= 65536;
	--    o->oldValue = u16value;
	--  end if;
      if (O_Value > 49152) and (Value <= 16384) then 
	 Totalizer := Totalizer + 65536;
      elsif (O_Value <= 16384) and (Value > 49152) then 
	 Totalizer := Totalizer - 65536;
      end if;
      O_Value := Value;
      Out_Rpos := M_Type (((Totalizer + Ll_Integer (Value)) * 
			    Ll_Integer (Encoder.Multiplier)) / Ll_Integer (Encoder.Divider));
      null;
   end Up_Scan;
   
   
   -- input defaults
   In_Enc_Count_Xf : aliased U16value_Type := In_Enc_Count_Init;
   
   
begin
   Bob.Init_Obj (Bob.Object (Encoder), Name);
   Encoder.Handle     := Handle'Access;
   Encoder.Reset      := False;
   Encoder.Dir        := True;
   Encoder.Multiplier := 1;
   Encoder.Divider    := 1;
   --Encoder.Resolution := 1000;
   Totalizer := 0;
   
   -- connect inputs to the defaults
   In_Enc_Count := In_Enc_Count_Xf'Access;
   
   -- connect the scan routines in the scan thread.
   Bth.Insert_Up_Scan (Us);
   
end Beren.Encoder;
