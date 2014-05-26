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
--                  Gmac is maintained by J de Kruijf Engineers             --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
--           the Generic_Scanner is written by Riccardo Bernardini          --
------------------------------------------------------------------------------

-- Generic_Scanner


with Ada.Finalization;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;
with Ada.Strings.Maps;
with Ada.Streams;  
private with GNAT.Regpat;

generic
   type Token_Type is (<>);
package Generic_Scanner is
   type Scanner_Type (<>) is new
     Ada.Finalization.Limited_Controlled
   with
     private;
   
   subtype Stream_Element_Array is Ada.Streams.Stream_Element_Array;
   type Stream_Element_Array_Access is access all Stream_Element_Array;

   type Token_Regexp_Array is
     array (Token_Type) of Unbounded_String;
   --  A token regexp array maps each token into the corresponding regexp.
   --  If an element of the array is the null string, the corresponding token
   --  will be used as EOF token.  At most one element can be the null string.
   --  If no element is the null string, an exception will be raised when
   --  trying to read beyond the end of the input.
 
   type Token_Array is
     array (Positive range <>) of Token_Type;

   type Full_Token_Type is
      record
         Token : Token_Type;
         Value : Unbounded_String;
      end record;
   --  A token is represented by a pair: a token "class" (represented by
   --  type Token_Type) and the corresponding sequence of characters.  Type
   --  Full_Token_Type represents the token pair.

   function Image (Item : Full_Token_Type) return String;
   --  Return a printable representation of a token.  Useful mainly for
   --  debug.

   function Value (Input : String) return Full_Token_Type;
   --  Input is expected to have the form "<token class>:<token value>"
   --  where <token class> is a name of an element of Token_Type and
   --  <token value> is any string.  It returns a full token with the
   --  specified class and value.
   --
   --  For example, if Token_Type includes the value "ID" then
   --
   --      Value ("ID:foo bar:2")
   --
   --  will return (Token => ID,  Value => "foo bar:2")
   --
   --  This function is mainly useful for debug and test functions.

   type Callback_Array is
     array (Token_Type) of access function (X : String) return String;
   --  After recognizing a token, the scanner can call a "pre-processing"
   --  function whose duty is to pre-process the token "value" (i.e., the
   --  text representation of the token).  For example, the callback associated
   --  to the "string" token could remove the quotes and do escape replacement
   --  (i.e., replacing strings like \n or %20).
   --  A Callback_Array maps each token into the corresponding pre-processing
   --  function or null, if no pre-processing is required.

   No_Callbacks : constant Callback_Array := (others => null);

   type Comment_Specs is new String;
   --  The scanner can be programmed to recognize different types of "comment
   --  styles."  Currently it recognizes single delimited comments that
   --  end at the end of line (e.g., Shell, C++, Ada) or doubly delimited
   --  comments (e.g., C).  The delimiter description is given in a
   --  string of type Comment_Specs.
   --  Comment_Specs strings can be created using the functions
   --  Single_Delimeter_Comments and Double_Delimeter_Comments.

   No_Comment : constant Comment_Specs;
   --  Special specs used for the "no comment" case.  If this is used,
   --  the scanner does not recognize any type of comment.

   function Single_Delimeter_Comments (Start : String) return Comment_Specs;

   function Double_Delimeter_Comments (Start, Stop : String) return Comment_Specs;

   type Comment_Style is
     (
      Shell_Like,        --  Begin at '#'  ends at end-of-line
      Ada_Like,          --  Begin at '--' ends at end-of-line
      LaTeX_Like,        --  Begin at '%'  ends at end-of-line
      C_Like,            --  Begin at '/*' ends at '*/'
      C_Plus_Plus_Like,  --  Begin at '//' ends at end-of-line
      Asm_Like           --  Begin at ';'  ends at end-of-line
     );
   --  Used together with the function Comment_Like to create some very
   --  common comment conventions

   function Comment_Like (Style : Comment_Style) return Comment_Specs;


   function New_Scanner (Input          : String;
                         Regexps        : Token_Regexp_Array;
			 Xtra_White_Space : String := "";
                         History_Size   : Positive := 1024;
                         Comment_Delim  : Comment_Specs := No_Comment;
                         Callbacks      : Callback_Array := No_Callbacks;
                         Scan           : Boolean := True)
			return Scanner_Type;
   
   function New_Scanner (Input          : Stream_Element_Array_Access;
                         Regexps        : Token_Regexp_Array;
			 Xtra_White_Space : String := "";
                         History_Size   : Positive := 1024;
                         Comment_Delim  : Comment_Specs := No_Comment;
                         Callbacks      : Callback_Array := No_Callbacks;
                         Scan           : Boolean := True)
			return Scanner_Type;
   
   procedure Restart_Scanner (S    : Scanner_Type; 
			      Scan : Boolean := True);

   procedure Expect_Current (Scanner : Scanner_Type;
                             Expected  : Token_Type);
   pragma Postcondition (not Scanner.Used);
   --  If the current token is equal to Expected, eat it; otherwise
   --  raise Unmatched_Token.

   procedure Expect_Current (Scanner : Scanner_Type;
                             Expected : Token_Array);
   pragma Postcondition (not Scanner.Used);

   --  If the current token is in Expected, eat it; otherwise
   --  raise Unmatched_Token.


   function Eat_If_Equal (Scanner  : Scanner_Type;
                          Expected : Token_Type)
                          return Boolean;
   pragma Postcondition (not Scanner.Used);

   --  If the current token is equal to Expected, eat it and return True;
   --  otherwise return false.  Although it can seem funny, it is very
   --  convenient.  After this call the current token is always marked as
   --  "unused"


   function Next_Token (Scanner : Scanner_Type) return Token_Type;
   pragma Postcondition (Scanner.Used);
   --  Parse the next token and return it

   procedure Next (Scanner : Scanner_Type);
   pragma Postcondition (not Scanner.Used);
   --  Parse a new token


   function Current_Token (Scanner : Scanner_Type) return Token_Type;
   pragma Postcondition (Scanner.Used);
   --  Return the class of the last parsed token.  Make the token used
   
   function Last_Token (Scanner : Scanner_Type) return Token_Type;
   --  Return the class of the one before last parsed token.

   function Peek (Scanner : Scanner_Type) return Token_Type;
   --  Similarly to Current_Token returns the class of the most recently
   --  parsed token, with the difference that Peek does not force the
   --  token status to "used,"  but it leaves it as it is.
   --
   --  Quite convenient when doing a look-ahead to decide the next
   --  parsing step.


   function String_Value (Scanner : Scanner_Type) return String;
   pragma Postcondition (Scanner.Used);
   --  Return the string value of the last parsed token.  Make the token used
   
   function Last_String_Value (Scanner : Scanner_Type) return String;
   --  Return the string value of the one before last parsed token.

   function Full_Token (Scanner : Scanner_Type) return Full_Token_Type;
   pragma Postcondition (Scanner.Used);

   function Used (Scanner : Scanner_Type) return Boolean;
   --  Every time Next is called, the new token is marked as "unused" until
   --  one of the reading token functions (Current_Token, String_Value and
   --  Full_Token) is called.  This function return True if the current
   --  token has been used.
   --
   --  Note that after calling Next_Token, function Used return True since
   --  Next_Token is equivalent to Next followed by Current_Token.
   --
   --  Funny as it may seem, this function is quite useful, especially
   --  in pre / post conditions.

   procedure Unuse_Current_Token (Scanner : Scanner_Type);
   --  Sometimes a parser "peeks" the current token, but decides to not
   --  use it.  By calling this procedure we can reset the status of the
   --  current token to Unused.

   function At_EOF (Scanner : Scanner_Type) return Boolean;

   Unrecognized_Token : exception;
   Unmatched_Token    : exception;
   Unexpected_EOF     : exception;

   function Regexp_Quote(Str : String) return Unbounded_String;

   function ID_Regexp (Additional_ID_Chars : String := "";
                       Basic_ID_Chars      : String := "a-zA-Z0-9_";
                       Begin_ID_Chars      : String := "a-zA-Z")
                       return Unbounded_String;

   function Number_Regexp return Unbounded_String;

   function Float_Regexp return Unbounded_String;

   function String_Regexp (Quote_Char : Character) return Unbounded_String;

   function Simple_Unquote (X : String; Quote : Character) return String;
   pragma Precondition
     (X'Length >= 2 and X (X'First) = Quote and X (X'Last) = Quote);

   function Unquote_Ada_Style (X : String) return String;
   pragma Precondition
     (X'Length >= 2 and X (X'First) = '"' and X (X'Last) = '"');

   --  Remove begin-end quotes from String and maps every quote pair
   --  inside X into a single quote.
private
   No_Comment : constant Comment_Specs := "";

   type Matcher_Access is
     access GNAT.Regpat.Pattern_Matcher;

   type Regexp_Array is
     array (Token_Type) of Matcher_Access;

   type History_Entry is
      record
         Token : Token_Type;
         Value : Unbounded_String;
      end record;

--     type Comment_Config_Access is
--       access Comment_Config;

   type History_Array is
     array (Natural range <>) of History_Entry;

   type Comment_Style_Type is (Void, End_At_EOL, End_Delimeter);


   type True_Scanner_Type (Size         : Positive;
                           History_Size : Positive) is
     new Ada.Finalization.Controlled
   with
      record
         Regexp_Table    : Regexp_Array;
         Input           : String (1 .. Size);
         Cursor          : Positive;
         On_Eof          : Token_Type;
         On_EOF_Valid    : Boolean;
         Current_Token,
	 Last_Token      : Token_Type;
         String_Value,
	 Last_String_Val : Unbounded_String;
         Whitespace      : Ada.Strings.Maps.Character_Set;
         History         : History_Array (0 .. History_Size);
         History_Cursor  : Natural;
         Callbacks       : Callback_Array;
         Comment_Style   : Comment_Style_Type;
         Comment_Start   : Unbounded_String;
         Comment_End     : Unbounded_String;
         First_Scan_Done : Boolean;
         Token_Used      : Boolean;
      end record;

   procedure Initialize (Item   : in out True_Scanner_Type;
                         Tokens : Token_Regexp_Array);

   overriding procedure Finalize (Item : in out True_Scanner_Type);


   type Scanner_Access is access True_Scanner_Type;

   type Scanner_Type is new
     Ada.Finalization.Limited_Controlled
   with
      record
         S : Scanner_Access;
      end record;

   overriding procedure Finalize (Object : in out Scanner_Type);

   procedure Skip_At_EOF (Scanner : Scanner_Type);

   procedure Save_Current_Token_In_History (Scanner : Scanner_Type);
end Generic_Scanner;
