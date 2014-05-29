--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Tree_Model.Columned_Store               Luebeck            --
--  Implementation                                 Autumn, 2007       --
--                                                                    --
--                                Last revision :  16:14 10 Mar 2012  --
--                                                                    --
--  This  library  is  free software; you can redistribute it and/or  --
--  modify it under the terms of the GNU General Public  License  as  --
--  published by the Free Software Foundation; either version  2  of  --
--  the License, or (at your option) any later version. This library  --
--  is distributed in the hope that it will be useful,  but  WITHOUT  --
--  ANY   WARRANTY;   without   even   the   implied   warranty   of  --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU  --
--  General  Public  License  for  more  details.  You  should  have  --
--  received  a  copy  of  the GNU General Public License along with  --
--  this library; if not, write to  the  Free  Software  Foundation,  --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.    --
--                                                                    --
--  As a special exception, if other files instantiate generics from  --
--  this unit, or you link this unit with other files to produce  an  --
--  executable, this unit does not by  itself  cause  the  resulting  --
--  executable to be covered by the GNU General Public License. This  --
--  exception  does not however invalidate any other reasons why the  --
--  executable file might be covered by the GNU Public License.       --
--____________________________________________________________________--

with Glib.Messages;         use Glib.Messages;
with Gtk.Missed;            use Gtk.Missed;
with Interfaces.C.Strings;  use Interfaces.C.Strings;
with System;                use System;

with Ada.Unchecked_Conversion;
with Interfaces.C.Pointers;

package body Gtk.Tree_Model.Columned_Store is

   GTK_Type     : GType := GType_Invalid;
   Root_Changed : constant String := "root-changed" & ASCII.NUL;

   function Where (Text : String) return String is
   begin
      return " in Gtk.Tree_Model.Columned_Store." & Text;
   end Where;

   function From_Addr is
      new Ada.Unchecked_Conversion (Address, GInt);

   function To_Addr is
      new Ada.Unchecked_Conversion (GInt, Address);

   procedure Emit_Root_Changed
             (  Store : access Gtk_Columned_Store_Record'Class
             )  is
      procedure Internal (Object : System.Address; Name : String);
      pragma Import (C, Internal, "ada_g_signal_emit_by_name");
   begin
      Internal (Get_Object (Store), Root_Changed);
   end Emit_Root_Changed;

   procedure Set_Path (Path : in out Gtk_Tree_Path; Row : GInt) is
   begin
      Prepend_Index (Path, Row);
      if Up (Path) then
         null;
      end if;
   end Set_Path;

   procedure Set_Root_Iter
             (  Model : access Gtk_Columned_Store_Record'Class
             )  is
   begin
      if Model.Path = null then
         Model.Root := Null_Iter;
      else
         Model.Root := Get_Iter (Model.Reference, Model.Path);
      end if;
   end Set_Root_Iter;

   function Compose_Columned
            (  Model : access Gtk_Columned_Store_Record'Class;
               Row   : GInt
            )  return Gtk_Tree_Iter is
   begin
      if Row in 0..Model.Rows - 1 then
         return
         (  Model.Stamp,
            To_Addr (Row),
            Model.all'Address,
            Null_Address
         );
      else
         return Null_Iter;
      end if;
   end Compose_Columned;

   function Compose_Reference
            (  Model  : access Gtk_Columned_Store_Record'Class;
               Row    : GInt;
               Column : GInt
            )  return Gtk_Tree_Iter is
   begin
      if Row >= Model.Rows or else Column >= Model.Columns then
         return Null_Iter;
      else
         return
            Nth_Child
            (  Model.Reference,
               Model.Root,
               Row + Column * Model.Rows
            );
      end if;
   end Compose_Reference;

   procedure Do_Set_Root
             (  Model : access Gtk_Columned_Store_Record'Class;
                Root  : Gtk_Tree_Iter
             )  is
      Root_Path : Gtk_Tree_Path;
   begin
      if Root /= Null_Iter then
         Root_Path := Get_Path (Model.Reference, Root);
      end if;
      Model.Stamp := Model.Stamp + 1;
      Model.Path  := Root_Path;
      Set_Root_Iter (Model);
      Changed_Root  (Model);
      Emit_Root_Changed (Model);
   end Do_Set_Root;

   function Get_Position
            (  Model : access Gtk_Columned_Store_Record'Class;
               Path  : Gtk_Tree_Path
            )  return GInt is
   begin
      if Model.Reference = null then
         return -1;
      elsif Path = null then
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            "Null path in the reference model" & Where ("Get_Position")
         );
         return -1;
      end if;
      declare
         Indices : GInt_Array renames Get_Indices (Path);
      begin
         if Model.Path = null then
            if Indices'Length /= 1 then
               return - 1;
            end if;
         else
            if (  Get_Indices (Model.Path)
               /= Indices (Indices'First..Indices'Last - 1)
               )
            then
               return -1;
            end if;
         end if;
         return Indices (Indices'Last);
      end;
   end Get_Position;

   procedure Split_Columned
             (  Model : access Gtk_Columned_Store_Record'Class;
                Iter  : Gtk_Tree_Iter;
                Row   : out GInt
             )  is
   begin
      if Model.Reference = null then
         Row := -1;
      elsif Model.all'Address /= Iter.User_Data2 then
         Row := -1;
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            "Model mismatch" & Where ("Split_Columned")
         );
      elsif Model.Stamp /= Iter.Stamp then
         Row := -1;
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            "Stamp mismatch" & Where ("Split_Columned")
         );
      else
         Row := From_Addr (Iter.User_Data);
         if Row not in 0..Model.Rows - 1 then
            Row := -1;
            Log
            (  GtkAda_Contributions_Domain,
               Log_Level_Critical,
               "Illegal row in columned iterator"
            );
         end if;
      end if;
   end Split_Columned;

   procedure Split_Reference
             (  Model  : access Gtk_Columned_Store_Record'Class;
                Path   : Gtk_Tree_Path;
                Row    : out GInt;
                Column : out GInt
             )  is
   begin
      Row := Get_Position (Model, Path);
      if Row >= 0 then
         if 0 /= Model.Rows then
            Column := Row / Model.Rows;
            Row    := Row mod Model.Rows;
            if Column >= Model.Columns then
               Log
               (  GtkAda_Contributions_Domain,
                  Log_Level_Critical,
                  "Unexpected reference row" & Where ("Split_Reference")
               );
               Row    := -1;
               Column := 0;
            end if;
         end if;
      else
         Column := 0;
      end if;
   end Split_Reference;

   function From_Columned
            (  Model  : access Gtk_Columned_Store_Record;
               Iter   : Gtk_Tree_Iter;
               Column : Positive
            )  return Gtk_Tree_Iter is
      Row : GInt;
   begin
      Split_Columned (Model, Iter, Row);
      return Compose_Reference (Model, Row, GInt (Column) - 1);
   end From_Columned;

   function From_Columned
            (  Model  : access Gtk_Columned_Store_Record;
               Path   : Gtk_Tree_Path;
               Column : Positive
            )  return Gtk_Tree_Path is
      Row : Gtk_Tree_Iter :=
               From_Columned (Model, Get_Iter (Model, Path), Column);
   begin
      if Row = Null_Iter then
         return null;
      else
         return Get_Path (Model.Reference, Row);
      end if;
   end From_Columned;

   procedure Changed_Root
             (  Model : access Gtk_Columned_Store_Record
             )  is
      Path : Gtk_Tree_Path := Gtk_New_First;
   begin
      Model.Rows :=
         (  (  N_Children (Model.Reference, Model.Root)
            +  Model.Columns
            -  1
            )
         /  Model.Columns
         );
      -- Simulation of children insertion
      for Row in 0..Model.Rows - 1 loop
         Set_Path (Path, Row);
         Row_Inserted (Model, Path, Compose_Columned (Model, Row));
      end loop;
      Path_Free (Path);
   end Changed_Root;

   function Children
            (  Model  : access Gtk_Columned_Store_Record;
               Parent : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      if Parent = Null_Iter then
         return Compose_Columned (Model, 0);
      else
         return Null_Iter;
      end if;
   end Children;

   procedure Erase (Model : access Gtk_Columned_Store_Record) is
      Item_Path : Gtk_Tree_Path := Gtk_New_First;
      Last_Row  : constant GInt := Model.Rows - 1;
   begin
      for Child in reverse 0..Last_Row loop
         Model.Rows := Child;
         Set_Path (Item_Path, Child);
         Row_Deleted (Model, Item_Path);
      end loop;
      Path_Free (Item_Path);
      if Model.Path /= null then
         Path_Free (Model.Path);
         Model.Path := null;
         Model.Root := Null_Iter;
      end if;
   end Erase;

   procedure Finalize (Model : access Gtk_Columned_Store_Record) is
   begin
      if Model.Path /= null then
         Path_Free (Model.Path);
      end if;
      if Model.Reference /= null then
         Unref (Model.Reference);
      end if;
   end Finalize;

   function Get_Column_Height
            (  Model  : access Gtk_Columned_Store_Record;
               Column : Positive
            )  return Natural is
   begin
      if GInt (Column) < Model.Columns then
         return Natural (Model.Rows);
      elsif GInt (Column) > Model.Columns or else Model.Rows = 0 then
         return 0;
      end if;
      declare
         Last : constant GInt :=
                N_Children (Model.Reference, Model.Root) mod Model.Rows;
      begin
         if Last = 0 then
            return Natural (Model.Rows);
         else
            return Natural (Last);
         end if;
      end;
   end Get_Column_Height;

   function Get_Column_Type
            (  Model : access Gtk_Columned_Store_Record;
               Index : GInt
            )  return GType is
   begin
      if Model.Reference = null then
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            "Null reference model" & Where ("Get_Column_Type")
         );
         return GType_Invalid;
      else
         return
            Get_Column_Type
            (  Model.Reference,
               Index mod Get_N_Columns (Model.Reference)
            );
      end if;
   end Get_Column_Type;

   function Get_Flags (Model : access Gtk_Columned_Store_Record)
      return Tree_Model_Flags is
   begin
      if Model.Reference = null then
         return Tree_Model_List_Only;
      else
         return Get_Flags (Model.Reference) or Tree_Model_List_Only;
      end if;
   end Get_Flags;

   function Get_Iter
            (  Model : access Gtk_Columned_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Gtk_Tree_Iter is
   begin
      if Path = null or else Model.Reference = null then
         return Null_Iter;
      else
         declare
            Indices : constant GInt_Array := Get_Indices (Path);
         begin
            if Indices'Length = 1 then
               return Compose_Columned (Model, Indices (Indices'First));
            else
               return Null_Iter;
            end if;
         end;
      end if;
   end Get_Iter;

   function Get_Major_Columns
            (  Model : access Gtk_Columned_Store_Record
            )  return Positive is
   begin
      return Positive (Model.Columns);
   end Get_Major_Columns;

   function Get_N_Columns (Model : access Gtk_Columned_Store_Record)
      return GInt is
   begin
      if Model.Reference = null then
         return 0;
      else
         return Get_N_Columns (Model.Reference) * Model.Columns;
      end if;
   end Get_N_Columns;

   function Get_Path
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Gtk_Tree_Path is
      Row : GInt;
   begin
      Split_Columned (Model, Iter, Row);
      if Row >= 0 then
         declare
            Result : Gtk_Tree_Path := Gtk_New;
         begin
            Append_Index (Result, Row);
            return Result;
         end;
      else
         return null;
      end if;
   end Get_Path;

   function Get_Reference
            (  Model : access Gtk_Columned_Store_Record
            )  return Gtk_Tree_Model is
   begin
      return Model.Reference;
   end Get_Reference;

   function Get_Reference_Iter
            (  Model  : access Gtk_Columned_Store_Record;
               Row    : Positive;
               Column : Positive
            )  return Gtk_Tree_Iter is
   begin
      if Model.Reference = null then
         return Null_Iter;
      else
         return
            Compose_Reference
            (  Model,
               GInt (Row) - 1,
               GInt (Column) - 1
            );
      end if;
   end Get_Reference_Iter;

   function Get_Root
            (  Model : access Gtk_Columned_Store_Record
            )  return Gtk_Tree_Iter is
   begin
      return Model.Root;
   end Get_Root;

   function Get_Root
            (  Model : access Gtk_Columned_Store_Record
            )  return Gtk_Tree_Path is
   begin
      if Model.Reference = null then
         return null;
      else
         return Copy (Model.Path);
      end if;
   end Get_Root;

   function Get_Rows
            (  Model  : access Gtk_Columned_Store_Record;
               Filled : Boolean
            )  return Natural is
   begin
      if Filled then
         return Get_Column_Height (Model, Positive (Model.Columns));
      else
         return Natural (Model.Rows);
      end if;
   end Get_Rows;

   function Get_Row_Width
            (  Model : access Gtk_Columned_Store_Record;
               Row   : Positive
            )  return Natural is
   begin
      if Row <= Get_Column_Height (Model, Positive (Model.Columns)) then
         return Natural (Model.Columns);
      elsif GInt (Row) <= Model.Rows then
         return Natural (Model.Columns - 1);
      else
         return 0;
      end if;
   end Get_Row_Width;

   procedure Get_Value
             (  Model  : access Gtk_Columned_Store_Record;
                Iter   : Gtk_Tree_Iter;
                Column : GInt;
                Value  : out GValue
             )  is
   begin
      if Model.Reference = null then
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            "Null reference model" & Where ("Get_Value")
         );
      else
         declare
            Minors : GInt := Get_N_Columns (Model.Reference);
            Row    : Gtk_Tree_Iter :=
                        From_Columned
                        (  Model,
                           Iter,
                           Positive (Column / Minors + 1)
                        );
         begin
            if Row = Null_Iter then
               Init (Value, Get_Column_Type (Model, Column));
            else
               Get_Value
               (  Model.Reference,
                  Row,
                  Column mod Minors,
                  Value
               );
            end if;
         end;
      end if;
   end Get_Value;

   procedure Gtk_New
             (  Model     : out Gtk_Columned_Store;
                Reference : access Gtk_Tree_Model_Record'Class;
                Columns   : Positive;
                Root      : Gtk_Tree_Iter := Null_Iter
             )  is
   begin
      Model := new Gtk_Columned_Store_Record;
      Initialize (Model, Reference.all'Access, Columns, Root);
   exception
      when others =>
         Unref (Model);
         raise;
   end Gtk_New;

   procedure Gtk_New (Model : out Gtk_Columned_Store) is
   begin
      Model := new Gtk_Columned_Store_Record;
      Gtk.Tree_Model.Columned_Store.Initialize (Model);
   exception
      when others =>
         Unref (Model);
         raise;
   end Gtk_New;

   function Has_Child
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Boolean is
   begin
      return False;
   end Has_Child;

   Signals : constant Chars_Ptr_Array :=
      (0 => Interfaces.C.Strings.New_String ("root-changed"));

   procedure Initialize
             (  Model     : access Gtk_Columned_Store_Record'Class;
                Reference : access Gtk_Tree_Model_Record'Class;
                Columns   : Positive;
                Root      : Gtk_Tree_Iter
             )  is
   begin
      if GTK_Type = GType_Invalid then
         GTK_Type := Register ("GtkColumnedStore", Signals);
      end if;
      Initialize (Model, GTK_Type);
      Set_Reference (Model, Reference, Columns, Root);
   end Initialize;

   procedure Initialize
             (  Model : access Gtk_Columned_Store_Record'Class
             )  is
   begin
      if GTK_Type = GType_Invalid then
         GTK_Type := Register ("GtkColumnedStore", Signals);
      end if;
      Initialize (Model, GTK_Type);
   end Initialize;

   function Is_Ancestor
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if Model.Reference = null then
         return False;
      end if;
      declare
         Path   : Gtk_Tree_Path := Get_Path (Model.Reference, Iter);
         Result : constant Boolean := Is_Ancestor (Model.Path, Path);
      begin
         Path_Free (Path);
         return Result;
      end;
   end Is_Ancestor;

   function Is_Ancestor
            (  Model : access Gtk_Columned_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Boolean is
   begin
      return Is_Ancestor (Model.Path, Path);
   end Is_Ancestor;

   function Is_Descendant
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if Model.Reference = null then
         return False;
      end if;
      declare
         Path   : Gtk_Tree_Path := Get_Path (Model.Reference, Iter);
         Result : constant Boolean := Is_Descendant (Model.Path, Path);
      begin
         Path_Free (Path);
         return Result;
      end;
   end Is_Descendant;

   function Is_Descendant
            (  Model : access Gtk_Columned_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Boolean is
   begin
      return Is_Descendant (Model.Path, Path);
   end Is_Descendant;

   procedure Next
             (  Model : access Gtk_Columned_Store_Record;
                Iter  : in out Gtk_Tree_Iter
             )  is
      Row : GInt;
   begin
      Split_Columned (Model, Iter, Row);
      if Row >= 0 then
         Iter := Compose_Columned (Model, Row + 1);
      else
         Iter := Null_Iter;
      end if;
   end Next;

   function Nth_Child
            (  Model  : access Gtk_Columned_Store_Record;
               Parent : Gtk_Tree_Iter;
               N      : GInt
            )  return Gtk_Tree_Iter is
   begin
      return Compose_Columned (Model, N);
   end Nth_Child;

   function N_Children
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter := Null_Iter
            )  return GInt is
   begin
      if Iter = Null_Iter then
         return Model.Rows;
      else
         return 0;
      end if;
   end N_Children;

   procedure On_Changed_Row
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Columned_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Row  : GInt := Get_Position (Model, Path);
   begin
      if Row >= 0 then
         if Model.Rows > 0 then
            Row := Row mod Model.Rows;
            declare
               Path : Gtk_Tree_Path := Gtk_New_First;
            begin
               Set_Path (Path, Row);
               Row_Changed (Model, Path, Compose_Columned (Model, Row));
               Path_Free (Path);
            end;
         else
            --
            -- Changing an unknown item is treated as insertion
            --
            On_Row_Inserted (Reference, Params, Model);
         end if;
      end if;
   end On_Changed_Row;

   procedure On_Deleted_Row
             (  Reference : access Gtk_Tree_Model_Record'Class;
                Params    : GValues;
                Model     : Gtk_Columned_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Row  : GInt;
   begin
      case Compare (Model, Path, Model.Path) is
         when After =>
            --
            -- A node following the root has been deleted.  Iterator  to
            -- the root has to be requested again, anyway.
            --
            Row := Get_Position (Model, Path);
            Set_Root_Iter (Model);
            if Row >= 0 then
               declare
                  Rows_Before : constant GInt := Model.Rows;
                  Column : GInt;
                  Size   : constant GInt :=
                              N_Children (Model.Reference, Model.Root);
               begin
                  Model.Rows := -- The new number of
                     (Size + Model.Columns - 1) / Model.Columns;
                  if Rows_Before /= 0 then
                     Column := Row / Rows_Before;
                     Row := Row mod Rows_Before;
                     --
                     -- Row,  Column  is where an item was deleted. This
                     -- changes  all following items. When Column is not
                     -- the last  column  then  it  is  all  rows  which
                     -- change. Otherwise it is the rows  starting  from
                     -- Row. The last row is deleted as requred.
                     --
                     if Column < Model.Columns - 1 then
                        Row := 0;
                     end if;
                     Path := Gtk_New_First;
                     for Changed in Row..Model.Rows - 1 loop
                        Set_Path (Path, Changed);
                        Row_Changed
                        (  Model,
                           Path,
                           Compose_Columned (Model, Changed)
                        );
                     end loop;
                     for Deleted in Model.Rows..Rows_Before - 1 loop
                        Set_Path (Path, Deleted);
                        Row_Deleted (Model, Path);
                     end loop;
                     Path_Free (Path);
                  end if;
               end;
            end if;
         when Equal =>
            --
            -- The root node itself has been deleted, move to its parent
            --
            Path := Copy (Model.Path);
            if Up (Path) and then Get_Depth (Path) > 0 then
               Set_Root (Model, Get_Iter (Model.Reference, Path));
            else
               Set_Root (Model, Null_Iter);
            end if;
            Path_Free (Path);
         when Before =>
            --
            -- A  row  was deleted before the root, only the iterator to
            -- the root is evaluated again as it might get lost.
            --
            if Is_Ancestor (Path, Model.Path) then
               --
               -- A  parent  node  of  the  root was deleted. Its parent
               -- becomes new root.
               --
               Path := Copy (Path);
               if Up (Path) and then Get_Depth (Path) > 0 then
                  Set_Root (Model, Get_Iter (Model.Reference, Path));
               else
                  Set_Root (Model, Null_Iter);
               end if;
               Path_Free (Path);
            elsif Is_Sibling (Model.Reference, Path, Model.Path) then
               --
               -- A sibling node of the root was deleted which itself is
               -- before the root. The  path  of  the  root  has  to  be
               -- decremented.
               --
               if not Prev (Model.Path) then
                  Log
                  (  GtkAda_Contributions_Domain,
                     Log_Level_Critical,
                     "Inconsitent path" & Where ("On_Deleted_Row")
                  );
               end if;
               Set_Root_Iter (Model);
            else
               Set_Root_Iter (Model);
            end if;
      end case;
   end On_Deleted_Row;

   procedure On_Row_Inserted
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Columned_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Row  : GInt;
   begin
      case Compare (Model, Path, Model.Path) is
         when Before =>
            --
            -- A row was inserted before the root. The iterator to  root
            -- has to be evaluated again.
            --
            if Is_Sibling (Model.Reference, Path, Model.Path) then
               --
               -- A sibling node was insered before the root  node.  The
               -- path of has to be incremented.
               --
               Next (Model.Path);
            end if;
            Set_Root_Iter (Model);
         when Equal =>
            --
            -- A sibling node was insered before the root node. The path
            -- of has to be incremented.
            --
            Next (Model.Path);
            Set_Root_Iter (Model);
         when After =>
            --
            -- Some  other node has been inserted. Iterator the the root
            -- has to be requested again, anyway.
            --
            Row := Get_Position (Model, Path);
            Set_Root_Iter (Model);
            if Row >= 0 then
               declare
                  Rows_Before : constant GInt := Model.Rows;
                  Column : GInt;
                  Size   : constant GInt :=
                              N_Children (Model.Reference, Model.Root);
               begin
                  Model.Rows := -- The new number of
                     (Size + Model.Columns - 1) / Model.Columns;
                  Column := Row / Model.Rows;
                  Row := Row mod Model.Rows;
                  --
                  -- Row  and Column is where an item was inserted. This
                  -- changes it all following items. When it is the last
                  -- column  then  only  rows  starting  with  Row   and
                  -- involved. Otherwise it is  all  rows.  One  row  is
                  -- possibly inserted when necessary.
                  --
                  if Column < Model.Columns - 1 then
                     Row := 0;
                  end if;
                  Path := Gtk_New_First;
                  for Changed in Row..Rows_Before - 1 loop
                     Set_Path (Path, Changed);
                     Row_Changed
                     (  Model,
                        Path,
                        Compose_Columned (Model, Changed)
                     );
                  end loop;
                  for Inserted in Rows_Before..Model.Rows - 1 loop
                     Set_Path (Path, Inserted);
                     Row_Inserted
                     (  Model,
                        Path,
                        Compose_Columned (Model, Inserted)
                     );
                  end loop;
                  Path_Free (Path);
               end;
            end if;
      end case;
   end On_Row_Inserted;

   type Index_Array is array (Natural range <>) of aliased Gint;
   pragma Convention (C, Index_Array);

   package Index_Array_Pointers is
      new Interfaces.C.Pointers (Natural, GInt, Index_Array, 0);
   use Index_Array_Pointers;

   function To_Pointer is
      new Ada.Unchecked_Conversion
          (  Address,
             Index_Array_Pointers.Pointer
          );

   procedure On_Rows_Reordered
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Columned_Store
             )  is
   begin
      if Compare (Model, Convert (Get_Address (Nth (Params, 1))), Model.Path) /= Equal then
         return;
      end if;
      Set_Root_Iter (Model);
      declare
         Order : Pointer := To_Pointer (Get_Address (Nth (Params, 2)));
         Rows  : constant GInt := N_Children (Model, Null_Iter) - 1;
         List  : array (0..Model.Rows - 1) of Boolean := (others => False);
         Path  : Gtk_Tree_Path := Gtk_New_First;
      begin
         for Row in 0..Rows loop
            --
            -- Checking for permutations of  the  reference  rows.  Each
            -- moved  rows  causes  a change in the corresponding row of
            -- the columned model.
            --
            if Row /= Order.all then
               List (Row mod Model.Rows) := True;
            end if;
            Order := Order + 1;
        end loop;
        for Row in List'Range loop
           if List (Row) then
              Row_Changed (Model, Path, Compose_Columned (Model, Row));
           end if;
           Next (Path);
        end loop;
        Path_Free (Path);
      end;
   end On_Rows_Reordered;

   function Parent
            (  Model : access Gtk_Columned_Store_Record;
               Child : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      return Null_Iter;
   end Parent;

   procedure Set_Null_Reference
             (  Model : access Gtk_Columned_Store_Record;
                Root_Changed : Boolean := True
             )  is
   begin
      if Model.Reference /= null then
         -- Disconnect callbacks
         for Index in Model.Callbacks'Range loop
            Disconnect (Model.Reference, Model.Callbacks (Index));
         end loop;
         Erase (Model);
         Unref (Model.Reference);
         Model.Reference := null;
         Model.Columns   := 1;
         if Root_Changed then
            Emit_Root_Changed (Model);
         end if;
      end if;
   end Set_Null_Reference;

   procedure Set_Reference
             (  Model     : access Gtk_Columned_Store_Record;
                Reference : access Gtk_Tree_Model_Record'Class;
                Columns   : Positive;
                Root      : Gtk_Tree_Iter
             )  is
   begin
      if (  Reference.all'Unchecked_Access = Model.Reference
         and then
            GInt (Columns) = Model.Columns
         )
      then
         --
         -- This is the same model and same columns number, so  we  just
         -- change the root
         --
         Set_Root (Model, Root);
      else
         --
         -- Everything  get changed. First we reference the new model so
         -- that it will not get occasionally collected. Then we set the
         -- reference model to null.
         --
         Ref (Reference);
         Set_Null_Reference (Model, False);
         Model.Columns   := GInt (Columns);
         Model.Reference := Reference.all'Access;
         Do_Set_Root (Model, Root);
         Model.Callbacks (Changed) :=
            Tree_Handlers.Connect
            (  Reference,
               "row-changed",
               On_Changed_Row'Access,
               Model.all'Access
            );
         Model.Callbacks (Deleted) :=
            Tree_Handlers.Connect
            (  Reference,
               "row-deleted",
               On_Deleted_Row'Access,
               Model.all'Access
            );
         Model.Callbacks (Inserted) :=
            Tree_Handlers.Connect
            (  Reference,
               "row-inserted",
               On_Row_Inserted'Access,
               Model.all'Access
            );
         Model.Callbacks (Reordered) :=
            Tree_Handlers.Connect
            (  Reference,
               "rows-reordered",
               On_Rows_Reordered'Access,
               Model.all'Access
            );
      end if;
   end Set_Reference;

   procedure Set_Root
             (  Model : access Gtk_Columned_Store_Record;
                Root  : Gtk_Tree_Iter
             )  is
   begin
      if Root = Model.Root then
         return;
      end if;
      if Model.Reference = null then
         if Root /= Null_Iter then
            Log
            (  GtkAda_Contributions_Domain,
               Log_Level_Critical,
               "Wrong iterator" & Where ("Set_Root")
            );
         end if;
         return;
      end if;
      Erase (Model);
      Do_Set_Root (Model, Root);
   end Set_Root;

   procedure To_Columned
             (  Model  : access Gtk_Columned_Store_Record;
                Iter   : in out Gtk_Tree_Iter;
                Column : out Positive
             )  is
      Path : Gtk_Tree_Path := Get_Path (Model.Reference, Iter);
      Row  : GInt;
      Col  : GInt;
   begin
      Split_Reference (Model, Path, Row, Col);
      Iter := Compose_Columned (Model, Row);
      Column := Positive (Col + 1);
      if Path /= null then
         Path_Free (Path);
      end if;
   end To_Columned;

   function To_Columned
            (  Model : access Gtk_Columned_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
      Row    : Gtk_Tree_Iter := Iter;
      Column : Positive;
   begin
      To_Columned (Model, Row, Column);
      return Row;
   end To_Columned;

   function To_Columned
            (  Model : access Gtk_Columned_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Gtk_Tree_Path is
      Row    : GInt;
      Col    : GInt;
      Result : Gtk_Tree_Path;
   begin
      Split_Reference (Model, Path, Row, Col);
      if Row > 0 then
         Result := Gtk_New;
         Append_Index (Result, Row);
         return Result;
      else
         return null;
      end if;
   end To_Columned;

end Gtk.Tree_Model.Columned_Store;