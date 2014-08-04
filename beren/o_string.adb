
with Text_Io;
package body O_String is
   package Io renames Text_Io;
   ---------
   -- Len --
   ---------

   function Len (Source : O_String) return Natural is
      Len : Natural := 0;
   begin
      for J in Source'Range loop
	 case Source (J) is
	    when ASCII.Nul => return Len;
	    when others    => Len := Len + 1;
	 end case;
      end loop;
      raise Length_Error;
      return Len;
   end Len;

   ----------
   -- Copy --
   ----------

   procedure Copy (Source : O_String; Dest : in out O_String) is
      N      : Integer := Dest'First;
      Length : Natural := Len (Source);
   begin
      if Length + 1 > Dest'Length then
	 raise Length_Error;
      else
	 for J in Source'Range loop
	    case Source (J) is
	       when ASCII.Nul => exit;
	       when others    => 
		  Dest (N) := Source (J);
		  N := N + 1;
	    end case;
	 end loop;
	 Dest (N) := ASCII.Nul;
      end if;
   end Copy;
   
   procedure Copy (Source : String; Dest : in out O_String) is
      N      : Integer := Dest'First;
      Length : Natural := Source'Length;
   begin
      if Length + 1 > Dest'Length then
	 raise Length_Error;
      else
	 for J in Source'Range loop
	    Dest (N) := Source (J);
	    N := N + 1;
	 end loop;
	 Dest (N) := ASCII.Nul;
      end if;
   end Copy;
   
   ---------------
   -- To_String --
   ---------------

   function To_String (Source : O_String) return String is
      Dest : String (1 .. Len (Source));
      N    : Integer := Dest'First;		     
   begin
      for J in Source'Range loop
	 case Source (J) is
	       when ASCII.Nul => exit;
	       when others    => 
		  Dest (N) := Source (J);
		  N := N + 1;
	    end case;
	 end loop;

      return Dest;
   end To_String;

   -----------------
   -- To_O_String --
   -----------------

   function To_O_String
     (Max    : Positive;
      Source : String := "")
      return O_String
   is
      N : Integer := 1;
      Dest : O_String (1 .. Max) := (others => ASCII.Nul);
   begin
       if Source'Length + 1 > Max then
	 raise Length_Error;
       else
	  for J in Source'Range loop
	     Dest (N) := Source (J);
	     N := N + 1;
	  end loop;
       end if;
       return Dest;
   end To_O_String;

   -----------------
   -- To_O_String --
   -----------------

   procedure To_O_String
     (Source : in  String := "";
      Target : out O_String)
   is
      N : Integer  := 1;
      T : O_String (1 .. Source'length + 1) := (others => ASCII.Nul);
   begin
      for J in Source'Range loop
	 T (N) := Source (J);
	 N := N + 1;
      end loop;
      Target := T;
   end To_O_String;

   ------------
   -- Concat --
   ------------

   function Concat (Left : O_String; Right : String) return O_String is
      Left_Len   : Integer := Len (Left);
      Target     : O_String (1 .. (Left_Len + Right'Length + 1));
      Source_Pos : Integer := Left'First;
      Last_Char  : Integer := Source_Pos - 1 + Left_Len;
      Target_Pos : Integer := 1;
   begin
      while Source_Pos <= Last_Char loop
	 Target (Target_Pos) := Left (Source_Pos);
	 Source_Pos          := Source_Pos + 1;
	 Target_Pos          := Target_Pos + 1;
      end loop;
      Source_Pos := Right'First;
      Last_Char  := Source_Pos - 1 + Right'Length;
      while Source_Pos <= Last_Char loop
	 Target (Target_Pos) := Right (Source_Pos);
	 Source_Pos          := Source_Pos + 1;
	 Target_Pos          := Target_Pos + 1;
      end loop;
      Target (Target_Pos) := ASCII.Nul;
      return Target;
   end Concat;

   ---------
   -- "&" --
   ---------

   function "&" (Left : O_String; Right : Character) return O_String is
      Left_Len   : Integer := Len (Left);
      Target     : O_String (1 .. (Left_Len + 1 + 1));
      Source_Pos : Integer := Left'First;
      Last_Char  : Integer := Source_Pos - 1 + Left_Len;
      Target_Pos : Integer := 1;
   begin
      while Source_Pos <= Last_Char loop
	 Target (Target_Pos) := Left (Source_Pos);
	 Source_Pos          := Source_Pos + 1;
	 Target_Pos          := Target_Pos + 1;
      end loop;
      Target (Target_Pos) := Right;
      Target_Pos          := Target_Pos + 1;
      Target (Target_Pos) := ASCII.Nul;
      return Target;
   end "&";

   --------------
   -- O_Concat --
   --------------

   function "&" (Left : O_String; Right : O_String) return O_String is
      Left_Len   : Integer := Len (Left);
      Right_Len  : Integer := Len (Right);
      Target     : O_String (1 .. (Left_Len + Right_len + 1));
      Source_Pos : Integer := Left'First;
      Last_Char  : Integer := Source_Pos - 1 + Left_Len;
      Target_Pos : Integer := 1;
   begin
      while Source_Pos <= Last_Char loop
	 --Io.Put_Line (Integer'Image (Target_Pos) & Integer'Image (Source_Pos));--
	 Target (Target_Pos) := Left (Source_Pos);
	 Source_Pos          := Source_Pos + 1;
	 Target_Pos          := Target_Pos + 1;
      end loop;
      Source_Pos := Right'First;
      Last_Char  := Source_Pos - 1 + Right_Len;
      while Source_Pos <= Last_Char loop
	 Target (Target_Pos) := Right (Source_Pos);
	 Source_Pos          := Source_Pos + 1;
	 Target_Pos          := Target_Pos + 1;
      end loop;
      Target (Target_Pos) := ASCII.Nul;
      return Target;
   end "&";

   ----------
   -- "=" --
   ----------

   function "=" (Left : O_String; Right : O_String) return Boolean is
      N    : Integer := Right'First;
      Ch : Character;
   begin
      for J in Left'Range loop
	 Ch := Left (J);
	 case Ch is
	    when ASCII.Nul => 
	       if Right (N) = ASCII.Nul  then return True;
	       else return False;
	       end if;
	    when others    => 
	       if Ch /= Right (N) then return False;
	       else
		  N := N + 1;
	       end if;
	 end case;
      end loop;
      return False; -- should never happen
   end "=";

   ---------
   -- Eq --
   ---------

   function Eq (Left : O_String; Right : String) return Boolean is
      N  : Integer := Left'First;
   begin
      for J in Right'Range loop
	 if Right (J) = Left (N) then
	    N := N + 1;
	 else 
	    return False;
	 end if;
      end loop;
      if Left (N) = ASCII.Nul then
	 return True;
      else
	 return False;
      end if;
   end Eq;

   ---------
   -- "=" --
   ---------

   function "=" (Left : String; Right : O_String) return Boolean is
      N  : Integer := Right'First;
   begin
      for J in Left'Range loop
	 if Left (J) = Right (N) then
	    N := N + 1;
	 else 
	    return False;
	 end if;
      end loop;
      if Right (N) = ASCII.Nul then
	 return True;
      else
	 return False;
      end if;
   end "=";

   ---------
   -- "<" --
   ---------

   function "<" (Left : O_String; Right : O_String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Len (Right);
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) <= String (Right (1 .. Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) < String (Right (1 .. Lr)) then
	 return True;----------------------->>
      elsif String (Left) < String (Right) then
	return True;----------------------->>
      end if;
      return False;----------------------->>
   end "<";

   ---------
   -- "<" --
   ---------

   function "<" (Left : O_String; Right : String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Right'Length;
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) <= Right (Right'First .. (Right'First + Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) < Right (Right'First .. (Right'First + Lr)) then
	 return True;----------------------->>
      elsif String (Left (1 .. Ll)) < Right then
	return True;----------------------->>
      end if;
      return False;----------------------->>
   end "<";

   ---------
   -- "<" --
   ---------

   function "<" (Left : String; Right : O_String) return Boolean is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, """<"" unimplemented");
      raise Program_Error;
      return "<" (Left, Right);
   end "<";

   ----------
   -- "<=" --
   ----------

   function "<=" (Left : O_String; Right : O_String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Len (Right);
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) <= String (Right (1 .. Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) < String (Right (1 .. Lr)) then
	 return True;----------------------->>
      elsif String (Left) <= String (Right) then
	 return True;----------------------->>
      end if;
      return False;----------------------->>
   end "<=";

   ----------
   -- "<=" --
   ----------

   function "<=" (Left : O_String; Right : String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Right'Length;
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) <= Right (Right'First .. (Right'First + Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) < Right (Right'First .. (Right'First + Lr)) then
	 return True;----------------------->>
      elsif String (Left (1 .. Ll)) <= Right then
	 return True;----------------------->>
      end if;
      return False;----------------------->>
   end "<=";

   ----------
   -- "<=" --
   ----------

   function "<=" (Left : String; Right : O_String) return Boolean is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, """<="" unimplemented");
      raise Program_Error;
      return "<=" (Left, Right);
   end "<=";

   ---------
   -- ">" --
   ---------

   function ">" (Left : O_String; Right : O_String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Len (Right);
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) > String (Right (1 .. Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) >= String (Right (1 .. Lr)) then
	 return True;----------------------->>
      elsif String (Left) > String (Right) then
	return True;----------------------->>
      end if;
      return False;----------------------->>
   end ">";

   ---------
   -- ">" --
   ---------

   function ">" (Left : O_String; Right : String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Right'Length;
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) > Right (Right'First .. (Right'First + Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) >= Right (Right'First .. (Right'First + Lr)) then
	 return True;----------------------->>
      elsif String (Left (1 .. Ll)) > Right then
	 return True;----------------------->>
      end if;
      return False;----------------------->>
   end ">";

   ---------
   -- ">" --
   ---------

   function ">" (Left : String; Right : O_String) return Boolean is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, """>"" unimplemented");
      raise Program_Error;
      return ">" (Left, Right);
   end ">";

   ----------
   -- ">=" --
   ----------

   function ">=" (Left : O_String; Right : O_String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Len (Right);
   begin
      if Lr > Ll and then
	String (Left (1 .. Ll)) > String (Right (1 .. Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then
	String (Left (1 .. Lr)) >= String (Right (1 .. Lr)) then
	 return True;----------------------->>
      elsif String (Left) <= String (Right) then
	return True;----------------------->>
      end if;
      return False;----------------------->>
   end ">=";

   ----------
   -- ">=" --
   ----------

   function ">=" (Left : O_String; Right : String) return Boolean is
      Ll : Natural := Len (Left);
      Lr : Natural := Right'Length;
   begin
      if Lr > Ll and then 
	String (Left (1 .. Ll)) > Right (Right'First .. (Right'First + Ll)) then
	 return True;----------------------->>
      elsif Ll > Lr and then 
	String (Left (1 .. Lr)) >= Right (Right'First .. (Right'First + Lr)) then
	 return True;----------------------->>
      elsif String (Left (1 .. Ll)) <= Right then
	 return True;----------------------->>
      end if;
      return False;----------------------->>
   end ">=";

   ----------
   -- ">=" --
   ----------

   function ">=" (Left : String; Right : O_String) return Boolean is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, """>="" unimplemented");
      raise Program_Error;
      return ">=" (Left, Right);
   end ">=";

end O_String;
