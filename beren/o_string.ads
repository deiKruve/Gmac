
with Ada.Strings;
package O_String is
   --pragma Pure (O_String);
   pragma Elaborate_Body;

   -- type O_String (Max : Positive) is private;
   --type O_String is new String;
   subtype Positive is Integer range 1 .. Integer'Last;
   type O_String is array(Positive range <>) of Character;
   
   function Len (Source : O_String) return Natural;
   -- number of characters excluding the closing 'nul'
   
   procedure Copy (Source : O_String; Dest : in out O_String);
   
   procedure Copy (Source : String; Dest : in out O_String);
   
   --  procedure Move (Source : in  O_String;
   --                  Target : out O_String;
   --                  Drop   : in  Ada.Strings.Truncation := Ada.Strings.Error);

   function  To_String  (Source : O_String) return String;
   
   function  To_O_String (Max    : Positive;
			  Source : String := "")
			 return O_String;
   
   procedure To_O_String (Source : in  String := "";
			  Target : out O_String);

   function Concat (Left : O_String; Right : String)    return O_String ;
   -- works with an O_String and a literal or a String
   
   function "&" (Left : O_String; Right : Character) return O_String ;
   function "&" (Left : O_String; Right : O_String)  return O_String ;
   -- works with 2 O_Strings.
   
   function "=" (Left : O_String; Right : O_String) return Boolean;
   -- works with 2 O_Strings
   
   function Eq  (Left : O_String; Right : String)   return Boolean;
   -- works with an O_String and a literal.
   
   --function "="  (Left : String;   Right : O_String) return Boolean;

   function "<"  (Left : O_String; Right : O_String) return Boolean;
   function "<"  (Left : O_String; Right : String)   return Boolean;
   --function "<"  (Left : String;   Right : O_String) return Boolean;

   function "<=" (Left : O_String; Right : O_String) return Boolean;
   function "<=" (Left : O_String; Right : String)   return Boolean;
   --function "<=" (Left : String;   Right : O_String) return Boolean;

   function ">"  (Left : O_String; Right : O_String) return Boolean;
   function ">"  (Left : O_String; Right : String)   return Boolean;
   --function ">"  (Left : String;   Right : O_String) return Boolean;

   function ">=" (Left : O_String; Right : O_String) return Boolean;
   function ">=" (Left : O_String; Right : String)   return Boolean;
   --function ">=" (Left : String;   Right : O_String) return Boolean;

   Length_Error : exception renames Ada.Strings.Length_Error;

private
   --  type O_String (Max : Positive) is
   --     record
   --        Length  : Natural := 0;
   --        Content : String (1..Max);
   --     end record;
end O_String;
