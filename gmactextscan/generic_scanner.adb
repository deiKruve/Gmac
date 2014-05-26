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
--           the Generic_Scanner is written by Riccardo Bernardini          --
------------------------------------------------------------------------------

--  Generic_Scanner

with System.Storage_Elements;
with Ada.Characters.Latin_1;
with Ada.Unchecked_Deallocation;
with Ada.Strings.Fixed;
with Ada.Text_IO;
pragma Warnings (Off, Ada.Text_IO);

package body Generic_Scanner is

   -----------------
   -- New_Scanner --
   -----------------
   
   function New_Scanner (Input          : Stream_Element_Array_Access;
                         Regexps        : Token_Regexp_Array;
			 Xtra_White_Space : String := "";
                         History_Size   : Positive := 1024;
                         Comment_Delim  : Comment_Specs := No_Comment;
                         Callbacks      : Callback_Array := No_Callbacks;
                         Scan           : Boolean := True)
			return Scanner_Type
   is
      function S_To_String (Stream_A : Stream_Element_Array_Access)
			   return String
      is
	 Stream_Size    : System.Storage_Elements.Storage_Offset := 
	   Stream_A.all'Length;
	 Stream_Address : System.Address := Stream_A.all'Address;
	 S : String (1 .. Integer (Stream_Size));
	 for S'Address use Stream_Address;
      begin
	 return S;
      end S_To_String;
      
      Si : String := S_To_String (Input);
      
   begin
      return New_Scanner 
	(Si, Regexps, Xtra_White_Space, History_Size, Comment_Delim, Callbacks, Scan);
   end New_Scanner;
   
   -----------------
   -- New_Scanner --
   -----------------
   
   function New_Scanner (Input          : String;
                         Regexps        : Token_Regexp_Array;
			 Xtra_White_Space : String := "";
                         History_Size   : Positive := 1024;
                         Comment_Delim  : Comment_Specs := No_Comment;
                         Callbacks      : Callback_Array := No_Callbacks;
                         Scan           : Boolean := True)
                         return Scanner_Type
   is
      use Ada.Strings.Maps;
      use Ada.Characters.Latin_1;

      procedure Parse_Comment_Delim (Specs : Comment_Specs;
                                     Style         : out Comment_Style_Type;
                                     Start         : out Unbounded_String;
                                     Stop          : out Unbounded_String)
      is
         use Ada.Strings.Fixed;

         Pos : Natural;
      begin
         if Specs = "" then
            Style := Void;
            Start := Null_Unbounded_String;
            Stop := Null_Unbounded_String;
         else
            Pos := Index (Source  => String (Specs),
                          Pattern => " ");

            if Pos = 0 then
               Style := End_At_EOL;
               Start := To_Unbounded_String (String (Specs));
               Stop := Null_Unbounded_String;
            else
               if
                 Pos = Specs'Last or else
                 Pos = Specs'First or else
                 Index (String (Specs (Pos + 1 .. Specs'Last)), " ") /= 0
               then
                  raise Constraint_Error;
               else
                  Style := End_Delimeter;
                  Start := To_Unbounded_String (String (Specs (Specs'First .. Pos - 1)));
                  Stop := To_Unbounded_String (String (Specs (Pos + 1 .. Specs'Last)));
               end if;
            end if;
         end if;
      end Parse_Comment_Delim;
      Tmp : Scanner_Access;
      
   begin
      Tmp := new True_Scanner_Type'(Ada.Finalization.Controlled with
                                      Size           => Input'Length,
                                    History_Size   => History_Size,
                                    Regexp_Table   => (others => null),
                                    Input          => Input,
                                    Cursor         => 1,
                                    On_Eof         => <>,
                                    On_EOF_Valid   => False,
                                    Current_Token  => <>,
				    Last_Token     => <>,
                                    String_Value   => <>,
				    Last_String_Val => <>,
                                    Whitespace     =>
                                      To_Set (" " & CR & LF & VT & HT & 
						Xtra_White_Space),
                                    History        => <>,
                                    History_Cursor => 0,
                                    Callbacks      => Callbacks,
                                    Comment_Style  => Void,
                                    Comment_Start  => Null_Unbounded_String,
                                    Comment_End     => Null_Unbounded_String,
                                    First_Scan_Done => False,
                                    Token_Used      => <>);

      Parse_Comment_Delim (Comment_Delim,
                           Tmp.Comment_Style,
                           Tmp.Comment_Start,
                           Tmp.Comment_End);

      Initialize (Tmp.all, Regexps);
      return Result : Scanner_Type :=
        (Ada.Finalization.Limited_Controlled with S => Tmp)
      do
         pragma Warnings (Off, Result);

         if Scan then
            Result.Next;
         end if;
      end return;
   end New_Scanner;
   
   
   ---------------------
   -- Restart_Scanner --
   ---------------------
   
   procedure Restart_Scanner (S : Scanner_Type; Scan : Boolean := True)
   is
   begin
      S.S.Cursor          := 1;
      S.S.History_Cursor  := 0;
      S.S.First_Scan_Done := False;
      if Scan then
	 S.Next;
      end if;
   end Restart_Scanner;
   

   ------------
   -- Expect --
   ------------

   procedure Expect_Current
     (Scanner   : Scanner_Type;
      Expected  : Token_Type)
   is
   begin
      if Scanner.Current_Token /= Expected then
         raise Unmatched_Token with
           "Expected: <"
           & Token_Type'Image (Expected)
           & "> Got: <"
           & Token_Type'Image (Scanner.S.Current_Token)
           & ">";
      end if;

      Scanner.Next;
   end Expect_Current;

   ------------
   -- Expect --
   ------------

   procedure Expect_Current
     (Scanner  : Scanner_Type;
      Expected : Token_Array)
   is
   begin
      for I in Expected'Range loop
         if Scanner.Current_Token = Expected (I) then
            Scanner.Next;
            return;
         end if;
      end loop;

      raise Unmatched_Token;
   end Expect_Current;

   ----------------
   -- Next_Token --
   ----------------

   function Next_Token (Scanner : Scanner_Type) return Token_Type is
   begin
      Scanner.Next;
      return Scanner.Current_Token;
   end Next_Token;

   -----------------
   -- Skip_At_EOF --
   -----------------

   procedure Skip_At_EOF (Scanner : Scanner_Type) is
   begin
      Scanner.S.Cursor := Scanner.S.Input'Last + 1;
   end Skip_At_EOF;

   -----------------------------------
   -- Save_Current_Token_In_History --
   -----------------------------------

   procedure Save_Current_Token_In_History (Scanner : Scanner_Type) is
   begin
      if Scanner.S.First_Scan_Done then
         Scanner.S.History (Scanner.S.History_Cursor) :=
           (Token => Scanner.S.Current_Token,
            Value => Scanner.S.String_Value);

         Scanner.S.History_Cursor :=
           (Scanner.S.History_Cursor + 1) mod Scanner.S.History_Size;
      end if;
   end Save_Current_Token_In_History;

   ----------
   -- Next --
   ----------

   procedure Next (Scanner : Scanner_Type) is
      use GNAT.Regpat;

      function Current_Char (Scanner : Scanner_Type) return Character is
      begin
         return Scanner.S.Input (Scanner.S.Cursor);
      end Current_Char;

      pragma Inline (Current_Char);

      procedure Skip_Spaces (Scanner : Scanner_Type);
      pragma Postcondition (Scanner.At_EOF or else not Ada.Strings.Maps.Is_In
                            (Current_Char (Scanner), Scanner.S.Whitespace));
      --  Skip spaces until a non-space char or EOF.

      procedure Skip_Spaces (Scanner : Scanner_Type) is
         use Ada.Strings.Maps;
         use Ada.Strings.Fixed;
         use Ada.Strings;

         Pos : Natural;
      begin
         Pos := Index (Source => Scanner.S.Input,
                       Set    => Scanner.S.Whitespace,
                       From   => Scanner.S.Cursor,
                       Test   => Outside);

         if Pos = 0 then
            Scanner.Skip_At_EOF;
         else
            Scanner.S.Cursor := Pos;
         end if;
      end Skip_Spaces;

      function Skip_Comment (Scanner : Scanner_Type) return Boolean is
         use Ada.Strings.Fixed;
         use Ada.Characters.Latin_1;
         use Ada.Strings.Maps;

         procedure Skip_EOL (Scanner : Scanner_Type) is
            pragma Precondition (not Scanner.At_EOF);
         begin
            if Current_Char (Scanner) = CR then
               Scanner.S.Cursor := Scanner.S.Cursor + 1;
            end if;

            if not Scanner.At_EOF and then Current_Char (Scanner) = LF then
               Scanner.S.Cursor := Scanner.S.Cursor + 1;
            end if;
         end Skip_EOL;



      begin
         if Scanner.S.Comment_Style = Void then
            return False;
         end if;

         declare
            Start : constant String := To_String (Scanner.S.Comment_Start);
            Stop  : constant String := To_String (Scanner.S.Comment_End);
            Last  : constant Natural := Scanner.S.Cursor + Start'Length - 1;
         begin
            if Last > Scanner.S.Input'Last then
               return False;
            end if;

            if Scanner.S.Input (Scanner.S.Cursor .. Last) /= Start then
               return False;
            end if;

            Scanner.S.Cursor := Last + 1;

            case Scanner.S.Comment_Style is
            when Void =>
               raise Program_Error;

            when End_At_EOL =>
               declare
                  Pos : Natural;
               begin
                  --  Search for the beginning of a line delimiter: CR or
                  --  LF
                  Pos := Index (Source => Scanner.S.Input,
                                Set    => To_Set (CR & LF),
                                From   => Scanner.S.Cursor);

                  if Pos = 0 then
                     --  No line delimiter found, but this is OK: the
                     --  comment ends at EOF
                     Scanner.Skip_At_EOF;
                  else
                     --  Move to the beginning of the line delimiter
                     --  and skip it
                     Scanner.S.Cursor := Pos;
                     Skip_EOL (Scanner);
                  end if;

                  return True;
               end;
            when End_Delimeter =>
               declare
                  Pos : Natural;
               begin
                  Pos := Index (Source  => Scanner.S.Input,
                                Pattern => Stop,
                                From    => Scanner.S.Cursor);

                  if Pos = 0 then
                     --  No closing delimiter found
                     raise Unexpected_EOF;
                  end if;

                  --  Move to the first character after the delimiter
                  Scanner.S.Cursor := Pos + Stop'Length;
                  return True;
               end;
            end case;
         end;
      end Skip_Comment;

      type Match_Descriptor is
         record
            Length : Natural;
            Token  : Token_Type;
            First  : Positive;
            Last   : Positive;
         end record;

      function Find_Best_Match (Expr : String)  return Match_Descriptor is
         Best_Match : Match_Descriptor := (Length => 0, others => <>);
         Buffer       : Match_Array (0 .. 0);
      begin
         for Token in Scanner.S.Regexp_Table'Range loop
            Match (Self    => Scanner.S.Regexp_Table (Token).all,
                   Data    => Expr,
                   Matches => Buffer);

            if Buffer (0) /= No_Match then
               if Buffer (0).Last - Buffer (0).First + 1 > Best_Match.Length then
                  Best_Match := (Length => Buffer (0).Last - Buffer (0).First + 1,
                                 Token  => Token,
                                 First  => Buffer (0).First,
                                 Last   => Buffer (0).Last);
               end if;
            end if;
         end loop;

         return Best_Match;
      end Find_Best_Match;


   begin
      loop
         Skip_Spaces (Scanner);
         exit when not Skip_Comment (Scanner);
      end loop;


      if Scanner.At_EOF then
         if not Scanner.S.On_Eof_Valid then
            --  The user did not declare any "EOF" symbol
            raise Unexpected_EOF;
         else
	    Scanner.S.Last_Token      := Scanner.S.Current_Token;
            Scanner.S.Current_Token   := Scanner.S.On_Eof;
	    Scanner.S.Last_String_Val := Scanner.S.String_Value;
            Scanner.S.String_Value    := Null_Unbounded_String;
            Scanner.S.Token_Used      := False;
            return;
         end if;
      end if;

      pragma Assert (not Scanner.At_EOF);

      declare
         Best_Match : constant Match_Descriptor :=
                        Find_Best_Match
                          (Scanner.S.Input (Scanner.S.Cursor .. Scanner.S.Input'Last));
      begin
         if Best_Match.Length = 0 then
            raise Unrecognized_Token;
         else
            Scanner.Save_Current_Token_In_History;
            Scanner.S.First_Scan_Done := True;
	    
	    Scanner.S.Last_Token    := Scanner.S.Current_Token;
            Scanner.S.Current_Token := Best_Match.Token;

            declare
               Value : constant String :=
                         Scanner.S.Input (Best_Match.First .. Best_Match.Last);
            begin
	       Scanner.S.Last_String_Val := Scanner.S.String_Value;	       
               if Scanner.S.Callbacks (Best_Match.Token) /= null then
                  Scanner.S.String_Value :=
                    To_Unbounded_String (Scanner.S.Callbacks (Best_Match.Token) (Value));
               else
                  Scanner.S.String_Value :=
                    To_Unbounded_String (Value);
               end if;
            end;

            Scanner.S.Cursor := Best_Match.Last + 1;
         end if;
      end;

      Scanner.S.Token_Used := False;
   end Next;
   
   
   ------------------
   -- Eat_If_Equal --
   ------------------
   
   function Eat_If_Equal (Scanner  : Scanner_Type;
                          Expected : Token_Type)
                          return Boolean
   is
   begin
      if Expected = Scanner.Current_Token then
         Scanner.Next;
         return True;
      else
         Scanner.Unuse_Current_Token;
         return False;
      end if;
   end Eat_If_Equal;


   -------------------
   -- Current_Token --
   -------------------

   function Current_Token (Scanner : Scanner_Type) return Token_Type is
   begin
      Scanner.S.Token_Used := True;
      return Scanner.S.Current_Token;
   end Current_Token;
   
   
   ----------------
   -- Last_Token --
   ----------------
   
   function Last_Token (Scanner : Scanner_Type) return Token_Type is
   begin
      --Scanner.S.Token_Used := True;
      return Scanner.S.Last_Token;
   end Last_Token;
   
   ----------
   -- Peek --
   ----------

   function Peek (Scanner : Scanner_Type) return Token_Type is
   begin
      return Scanner.S.Current_Token;
   end Peek;

   ------------------
   -- String_Value --
   ------------------

   function String_Value (Scanner : Scanner_Type) return String is
   begin
      Scanner.S.Token_Used := True;
      return To_String (Scanner.S.String_Value);
   end String_Value;
   
   
   -----------------------
   -- Last_String_Value --
   -----------------------

   function Last_String_Value (Scanner : Scanner_Type) return String is
   begin
      --Scanner.S.Token_Used := True;
      return To_String (Scanner.S.Last_String_Val);
   end Last_String_Value;

   
   ----------------
   -- Full_Token --
   ----------------

   function Full_Token (Scanner : Scanner_Type) return Full_Token_Type
   is
   begin
      Scanner.S.Token_Used := True;
      return (Scanner.S.Current_Token, Scanner.S.String_Value);
   end Full_Token;

   -----------
   -- Image --
   -----------

   function Image (Item : Full_Token_Type) return String is
   begin
      return Token_Type'Image (Item.Token)
        & ": """
        & To_String (Item.Value)
        & '"';
   end Image;

   -----------
   -- Value --
   -----------

   function Value (Input : String) return Full_Token_Type is
      use Ada.Strings;

      function Normalize (X : String) return Unbounded_String is
         Trimmed : constant String := Fixed.Trim (X, Both);
      begin
         if Trimmed (Trimmed'First) = '"' then
            if Trimmed (Trimmed'Last) /= '"' then
               raise Constraint_Error;
            else
               return To_Unbounded_String (Unquote_Ada_Style (Trimmed));
            end if;
         else
            return To_Unbounded_String (Trimmed);
         end if;
      end Normalize;

      Token : Token_Type;
      Separator : Natural;
   begin
      Separator := Fixed.Index (Source  => Input,
                                Pattern => ":");

      if Separator < Input'First + 1 then
         --  This includes both the cases where no ':' is in Input and
         --  when the ':' is at the beginning of the string, so that
         --  the token name is empty.

         raise Constraint_Error with "Bad token name in '" & Input & "'";
      end if;

      begin
         Token := Token_Type'Value (Input (Input'First .. Separator - 1));
      exception
         when Constraint_Error =>
            raise Constraint_Error with "Bad token name in '" & Input & "'";
      end;

      return (Token => Token,
              Value => Normalize(Input (Separator + 1 .. Input'Last)));
   end Value;

   ------------
   -- At_EOF --
   ------------

   function At_EOF (Scanner : Scanner_Type) return Boolean is
   begin
      return Scanner.S.Cursor > Scanner.S.Input'Last;
   end At_EOF;

   function ID_Regexp (Additional_ID_Chars : String := "";
                       Basic_ID_Chars      : String := "a-zA-Z0-9_";
                       Begin_ID_Chars      : String := "a-zA-Z")
                       return Unbounded_String
   is
      Tmp : Constant String := "[" & Begin_ID_Chars & "]"
        &
      "[" & Basic_ID_Chars & Additional_ID_Chars & "]*";
   begin
--        Ada.Text_IO.Put_Line ("<<" & Tmp & ">>");
      return To_Unbounded_String(Tmp);
--          ("[" & Begin_ID_Chars & "]"
--           &
--           "[" & Basic_ID_Chars & Additional_ID_Chars & "]*");
   end ID_Regexp;

   function Number_Regexp return Unbounded_String
   is
   begin
      return To_Unbounded_String ("[-]?[1-9][0-9]*");
   end Number_Regexp;


   -------------------
   -- String_Regexp --
   -------------------

   function String_Regexp (Quote_Char : Character) return Unbounded_String
   is
      use Ada.Strings.Maps;
      use Ada.Strings.Fixed;

      Pattern : constant String := "'([^\\']|\\.)*'";
   begin
      return To_Unbounded_String
        (Translate (Source  => Pattern,
                    Mapping => To_Mapping ("'", "" & Quote_Char)));
   end String_Regexp;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Item   : in out True_Scanner_Type;
      Tokens : Token_Regexp_Array)
   is
      use GNAT.Regpat;

      function Anchored (X : Unbounded_String) return String is
         Tmp : constant String := To_String (X);
      begin
         if Tmp (Tmp'First) = '^' then
            return Tmp;
         else
            return '^' & Tmp;
         end if;
      end Anchored;
   begin
      Item.On_EOF_Valid := False;

      for I in Tokens'Range loop
         if Tokens (I) = Null_Unbounded_String then
            if Item.On_EOF_Valid then
               raise Constraint_Error
                 with "Too many EOF symbols";
            end if;

            Item.On_EOF := I;
            Item.On_EOF_Valid := True;
            Item.Regexp_Table (I) := new Pattern_Matcher'(Never_Match);
         else
            Item.Regexp_Table (I) :=
              new Pattern_Matcher'(Compile (Anchored (Tokens (I))));
         end if;
      end loop;
   end Initialize;



   -------------
   -- Destroy --
   -------------

   overriding procedure Finalize (Item : in out True_Scanner_Type) is
      use GNAT.Regpat;

      procedure Free is
        new Ada.Unchecked_Deallocation (Object => Pattern_Matcher,
                                        Name   => Matcher_Access);
   begin
--        Ada.Text_IO.Put_Line ("Finalize di TRUE Scanner");
      for I in Item.Regexp_Table'Range loop
         if Item.Regexp_Table (I) /= null then
            Free (Item.Regexp_Table (I));
         end if;
      end loop;
--        Ada.Text_IO.Put_Line ("Finalize di TRUE Scanner: DONE");
   end Finalize;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Object : in out Scanner_Type) is
      procedure Free is
        new Ada.Unchecked_Deallocation (Object => True_Scanner_Type,
                                        Name   => Scanner_Access);
   begin
--        Ada.Text_IO.Put_Line ("Finalize di Scanner");
--        Destroy (Object.S.all);
      Free (Object.S);
--        Ada.Text_IO.Put_Line ("Finalize di Scanner: DONE");
   end Finalize;

   -------------------------------
   -- Single_Delimeter_Comments --
   -------------------------------

   function Single_Delimeter_Comments (Start : String) return Comment_Specs is
   begin
      return Comment_Specs (Start);
   end Single_Delimeter_Comments;


   -------------------------------
   -- Double_Delimeter_Comments --
   -------------------------------

   function Double_Delimeter_Comments (Start, Stop : String) return Comment_Specs is
   begin
      return Comment_Specs (Start & " " & Stop);
   end Double_Delimeter_Comments;

   function Comment_Like (Style : Comment_Style) return Comment_Specs is
   begin
      case Style is
         when Shell_Like =>
            return Single_Delimeter_Comments ("#");
         when Ada_Like =>
            return Single_Delimeter_Comments ("--");
         when LaTeX_Like =>
            return Single_Delimeter_Comments ("%");
         when C_Like =>
            return Double_Delimeter_Comments ("/*", "*/");
         when C_Plus_Plus_Like =>
            return Single_Delimeter_Comments ("//");
         when Asm_Like =>
            return Single_Delimeter_Comments (";");
      end case;
   end Comment_Like;

   function Regexp_Quote (Str : String) return Unbounded_String
   is
   begin
      return To_Unbounded_String (GNAT.Regpat.Quote (Str));
   end Regexp_Quote;

   function Float_Regexp return Unbounded_String is
   begin
      return To_Unbounded_String ("[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?");
   end Float_Regexp;

   function Simple_Unquote (X : String; Quote : Character) return String is
   begin
      if (X'Length < 2 or X (X'First) /= Quote or X (X'Last) /= Quote) then
         raise Constraint_Error;
      end if;

      return X (X'First + 1 .. X'Last - 1);
   end Simple_Unquote;

   function Unquote_Ada_Style (X : String) return String is
      Tmp : constant String := Simple_Unquote (X, '"');
      Result : String (Tmp'Range);
      From, To : Natural;
   begin
      From := Tmp'First;
      To := Result'First;

      while From <= Tmp'Last loop
         if Tmp (From) = '"' then
            if From = Tmp'Last or else Tmp (From + 1) /= '"' then
               raise Constraint_Error;
            end if;

            From := From + 1;
         end if;

         Result (To) := Tmp (From);
         From := From + 1;
         To := To + 1;
      end loop;

      return Result (Result'First .. To - 1);
   end Unquote_Ada_Style;

   ----------
   -- Used --
   ----------

   function Used (Scanner : Scanner_Type) return Boolean is
   begin
      return Scanner.S.Token_Used;
   end Used;

   -------------------------
   -- Unuse_Current_Token --
   -------------------------

   procedure Unuse_Current_Token (Scanner : Scanner_Type) is
   begin
      Scanner.S.Token_Used := False;
   end Unuse_Current_Token;
end Generic_Scanner;
















