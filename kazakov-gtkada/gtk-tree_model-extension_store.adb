--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Tree_Model.Extension_Store              Luebeck            --
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

with Glib.Messages;  use Glib.Messages;
with Gtk.Missed;     use Gtk.Missed;
with System;         use System;

with Ada.Unchecked_Deallocation;
with Ada.Unchecked_Conversion;
with System.Address_To_Access_Conversions;

package body Gtk.Tree_Model.Extension_Store is

   GTK_Type : GType := GType_Invalid;

   function Where (Text : String) return String is
   begin
      return " in Gtk.Tree_Model.Extension_Store." & Text;
   end Where;

   procedure Free is
      new Ada.Unchecked_Deallocation
          (  Gtk_Extension_Store_Record'Class,
             Gtk_Extension_Store
          );

   subtype Flat_GInt_Array is GInt_Array (Natural'Range);
   package Address_To_GInt_Array is
      new System.Address_To_Access_Conversions (Flat_GInt_Array);

   function From_Extension
            (  Model : access Gtk_Extension_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      if Iter = Null_Iter then
         return Null_Iter;
      else
         declare
            Path   : Gtk_Tree_Path := Get_Path (Model.Columns, Iter);
            Result : Gtk_Tree_Iter;
         begin
            if Path = null then
               Log
               (  GtkAda_Contributions_Domain,
                  Log_Level_Critical,
                  "Invalid iterator" & Where ("From_Extension")
               );
               return Null_Iter;
            else
               Result := Get_Iter (Model.Reference, Path);
               if Result = Null_Iter then
                  Log
                  (  GtkAda_Contributions_Domain,
                     Log_Level_Critical,
                     (  "Path "
                     &  To_String (Path)
                     &  " has no iterator"
                     &  Where ("From_Extension")
                  )  );
               end if;
               Path_Free (Path);
               return Result;
            end if;
         end;
      end if;
   end From_Extension;

   function From_Extension
            (  Model : access Gtk_Extension_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Gtk_Tree_Path is
   begin
      if Path = null then
         return null;
      else
         return Copy (Path);
      end if;
   end From_Extension;

   procedure Changed
             (  Model : access Gtk_Extension_Store_Record;
                Path  : Gtk_Tree_Path;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      Row_Changed (Model, Path, Get_Iter (Model.Columns, Path));
   end Changed;

   function Children
            (  Model  : access Gtk_Extension_Store_Record;
               Parent : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      return Children (Model.Columns, Parent);
   end Children;

   procedure Deleted
             (  Model : access Gtk_Extension_Store_Record;
                Path  : Gtk_Tree_Path
             )  is
   begin
      Row_Deleted (Model, Path);
   end Deleted;

   procedure Deleting
             (  Model : access Gtk_Extension_Store_Record;
                Path  : Gtk_Tree_Path;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      null;
   end Deleting;

   procedure Erase (Model : access Gtk_Extension_Store_Record'Class) is
      Path : Gtk_Tree_Path := Gtk_New;

      procedure Remove (Row : Gtk_Tree_Iter) is
      begin
         for Count in reverse 0..N_Children (Model.Columns, Row) - 1
         loop
            Append_Index (Path, Count);
            Remove (Nth_Child (Model.Columns, Row, Count));
            if Up (Path) then
               null;
            end if;
         end loop;
         if Row /= Null_Iter then
            declare
               Removed : Gtk_Tree_Iter := Row;
            begin
               Deleting (Model, Path, Row);
               Remove (Model.Columns, Removed);
               Row_Deleted (Model, Path);
            end;
         end if;
      end Remove;
   begin
      Remove (Null_Iter);
      Path_Free (Path);
   end Erase;

   procedure Finalize (Model : access Gtk_Extension_Store_Record) is
   begin
      Unref (Model.Reference);
      Unref (Model.Columns);
   end Finalize;

   function Get_Column_Type
            (  Model : access Gtk_Extension_Store_Record;
               Index : GInt
            )  return GType is
   begin
      if Index < Model.Offset then
         return Get_Column_Type (Model.Reference, Index);
      else
         return Get_Column_Type (Model.Columns, Index - Model.Offset);
      end if;
   end Get_Column_Type;

   function Get_Extension_Types
            (  Model : access Gtk_Extension_Store_Record
            )  return GType_Array is
      Length : constant GInt := Get_N_Columns (Model.Columns);
   begin
      if Length = 0 then
         return (1..0 => GType_Invalid);
      else
         declare
            Result : GType_Array
                     (  GUInt (Model.Offset)
                     .. GUInt (Model.Offset + Length - 1)
                     );
         begin
            for Index in Result'Range loop
               Result (Index) :=
                  Get_Column_Type
                  (  Model.Columns,
                     GInt (Index) - Model.Offset
                  );
            end loop;
            return Result;
         end;
      end if;
   end Get_Extension_Types;

   function Get_Flags (Model : access Gtk_Extension_Store_Record)
      return Tree_Model_Flags is
   begin
      return Get_Flags (Model.Reference);
   end Get_Flags;

   function Get_Iter
            (  Model : access Gtk_Extension_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Gtk_Tree_Iter is
   begin
      return Get_Iter (Model.Columns, Path);
   end Get_Iter;

   function Get_N_Columns (Model : access Gtk_Extension_Store_Record)
      return GInt is
   begin
      return Get_N_Columns (Model.Columns) + Model.Offset;
   end Get_N_Columns;

   function Get_Path
            (  Model : access Gtk_Extension_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Gtk_Tree_Path is
   begin
      return Get_Path (Model.Columns, Iter);
   end Get_Path;

   function Get_Reference
            (  Model : access Gtk_Extension_Store_Record
            )  return Gtk_Tree_Model is
   begin
      return Model.Reference;
   end Get_Reference;

   procedure Get_Value
             (  Model  : access Gtk_Extension_Store_Record;
                Iter   : Gtk_Tree_Iter;
                Column : GInt;
                Value  : out GValue
             )  is
   begin
      if Iter = Null_Iter then
         Log
         (  GtkAda_Contributions_Domain,
            Log_Level_Critical,
            (  "Null extension model iterator"
            &  GInt'Image (Column)
            &  Where ("Get_Value")
         )  );
      elsif Column < Model.Offset then
         declare
            Row : Gtk_Tree_Iter := From_Extension (Model, Iter);
         begin
            if Row = Null_Iter then
               Log
               (  GtkAda_Contributions_Domain,
                  Log_Level_Critical,
                  (  "Null iterator of the reference column"
                  &  GInt'Image (Column)
                  &  Where ("Get_Value")
               )  );
               Init (Value, GType_Invalid);
            else
               Get_Value (Model.Reference, Row, Column, Value);
            end if;
         end;
      else
         Get_Value (Model.Columns, Iter, Column - Model.Offset, Value);
      end if;
   end Get_Value;

   procedure Gtk_New
             (  Model     : out Gtk_Extension_Store;
                Reference : access Gtk_Tree_Model_Record'Class;
                Types     : GType_Array
             )  is
   begin
      Model := new Gtk_Extension_Store_Record;
      Initialize (Model, Reference, Types);
   exception
      when others =>
         Free (Model);
         raise;
   end Gtk_New;

   procedure Gtk_New
             (  Model : out Gtk_Extension_Store;
                Types : GType_Array
             )  is
   begin
      Model := new Gtk_Extension_Store_Record;
      Gtk.Tree_Model.Extension_Store.Initialize (Model, Types);
   exception
      when others =>
         Free (Model);
         raise;
   end Gtk_New;

   function Has_Child
            (  Model : access Gtk_Extension_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Boolean is
   begin
      return Has_Child (Model.Columns, Iter);
   end Has_Child;

   procedure Initial_Sync
             (  Model      : access Gtk_Extension_Store_Record'Class;
                Ref_Parent : Gtk_Tree_Iter;
                Ext_Parent : Gtk_Tree_Iter
             )  is
      Ref_Child : Gtk_Tree_Iter;
      Ext_Child : Gtk_Tree_Iter;
      Position  : GInt := 0;
   begin
      if Ref_Parent = Null_Iter then
         Ref_Child := Get_Iter_First (Model.Reference);
      else
         Ref_Child := Children (Model.Reference, Ref_Parent);
      end if;
      while Ref_Child /= Null_Iter loop
         Insert (Model.Columns, Ext_Child, Ext_Parent, Position);
         Position := Position + 1;
         Initial_Sync (Model, Ref_Child, Ext_Child);
         Next (Model.Reference, Ref_Child);
      end loop;
   end Initial_Sync;

   procedure Initialize
             (  Model     : access Gtk_Extension_Store_Record'Class;
                Reference : access Gtk_Tree_Model_Record'Class;
                Types     : GType_Array
             )  is
   begin
      Initialize (Model, Types);
      Set_Reference (Model, Reference);
   end Initialize;

   procedure Initialize
             (  Model : access Gtk_Extension_Store_Record'Class;
                Types : GType_Array
             )  is
   begin
      if GTK_Type = GType_Invalid then
         GTK_Type := Register ("GtkExtensionStore");
      end if;
      Initialize (Model, GTK_Type);
      Gtk_New (Model.Columns, Types);
      Tree_Handlers.Connect
      (  Model.Columns,
         "rows-reordered",
         On_Rows_Reordered'Access,
         Model.all'Access
      );
   end Initialize;

   procedure Inserted
             (  Model : access Gtk_Extension_Store_Record;
                Path  : Gtk_Tree_Path;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      Row_Inserted (Model, Path, Iter);
   end Inserted;

   procedure Next
             (  Model : access Gtk_Extension_Store_Record;
                Iter  : in out Gtk_Tree_Iter
             )  is
   begin
      Next (Model.Columns, Iter);
   end Next;

   function Nth_Child
            (  Model  : access Gtk_Extension_Store_Record;
               Parent : Gtk_Tree_Iter;
               N      : GInt
            )  return Gtk_Tree_Iter is
   begin
      return Nth_Child (Model.Columns, Parent, N);
   end Nth_Child;

   function N_Children
            (  Model : access Gtk_Extension_Store_Record;
               Iter  : Gtk_Tree_Iter := Null_Iter
            )  return GInt is
   begin
      return N_Children (Model.Columns, Iter);
   end N_Children;

   procedure On_Changed_Row
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Extension_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Row  : Gtk_Tree_Iter := Get_Iter (Model.Columns, Path);
   begin
      if Row = Null_Iter then
         On_Row_Inserted (Reference, Params, Model);
      end if;
      Changed (Model, Path, Row);
   end On_Changed_Row;

   procedure On_Deleted_Row
             (  Reference : access Gtk_Tree_Model_Record'Class;
                Params    : GValues;
                Model     : Gtk_Extension_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Row  : Gtk_Tree_Iter := Get_Iter (Model.Columns, Path);
   begin
      if Row /= Null_Iter then
         Deleting (Model, Path, Row);
         Remove (Model.Columns, Row);
         Row_Deleted (Model, Path);
      end if;
   end On_Deleted_Row;

   procedure On_Row_Has_Child_Toggled
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Extension_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
   begin
      Row_Has_Child_Toggled
      (  Model,
         Path,
         Get_Iter (Model.Columns, Path)
      );
   end On_Row_Has_Child_Toggled;

   procedure On_Row_Inserted
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Extension_Store
             )  is
      Path : Gtk_Tree_Path := Convert (Get_Address  (Nth (Params, 1)));
      No   : constant GInt :=
                GInt'Max (0, Get_Row_No (Model.Columns, Path));
      This : Gtk_Tree_Path := Copy (Path);
      Row  : Gtk_Tree_Iter;
   begin
      if Up (This) and then Get_Depth (This) > 0 then
         Insert
         (  Model.Columns,
            Row,
            Get_Iter (Model.Columns, This),
            No
         );
      else
         Insert (Model.Columns, Row, Null_Iter, No);
      end if;
      if This /= null then
         Path_Free (This);
      end if;
      Inserted (Model, Path, Row);
   end On_Row_Inserted;

   procedure On_Rows_Reordered
             (  Reference  : access Gtk_Tree_Model_Record'Class;
                Params     : GValues;
                Model      : Gtk_Extension_Store
             )  is
      use Address_To_GInt_Array;
      Path    : Gtk_Tree_Path := Convert (Get_Address (Nth (Params, 1)));
      Indices : GInt_Array renames
                   To_Pointer (Get_Address (Nth (Params, 3))).all;
   begin
      Reorder
      (  Model.Columns,
         Get_Iter (Model.Columns, Path),
         Indices
      );
   end On_Rows_Reordered;

   function Parent
            (  Model : access Gtk_Extension_Store_Record;
               Child : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      return Parent (Model.Columns, Child);
   end Parent;

   procedure Ref_Node
             (  Model : access Gtk_Extension_Store_Record;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      Ref_Node (Model.Reference, From_Extension (Model, Iter));
      Ref_Node (Model.Reference, Iter);
   end Ref_Node;

   procedure Set_Null_Reference
             (  Model : access Gtk_Extension_Store_Record
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
      end if;
   end Set_Null_Reference;

   procedure Set_Reference
             (  Model     : access Gtk_Extension_Store_Record;
                Reference : access Gtk_Tree_Model_Record'Class
             )  is
   begin
      Ref (Reference);
      Set_Null_Reference (Model);
      Model.Offset := Get_N_Columns (Reference);
      Model.Reference := Reference.all'Access;
      Initial_Sync (Model, Null_Iter, Null_Iter);
      Model.Callbacks (Changed) :=
         Tree_Handlers.Connect
         (  Reference,
            "row-changed",
            On_Changed_Row'Access,
            Model.all'Access,
            True
         );
      Model.Callbacks (Deleted) :=
         Tree_Handlers.Connect
         (  Reference,
            "row-deleted",
            On_Deleted_Row'Access,
            Model.all'Access,
            True
         );
      Model.Callbacks (Inserted) :=
         Tree_Handlers.Connect
         (  Reference,
            "row-inserted",
            On_Row_Inserted'Access,
            Model.all'Access,
            True
         );
   exception
      when others =>
         Model.Reference := null;
         Unref (Reference);
         raise;
   end Set_Reference;

   procedure Unref_Node
             (  Model : access Gtk_Extension_Store_Record;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      Unref_Node (Model.Reference, From_Extension (Model, Iter));
      Unref_Node (Model.Columns,   Iter);
   end Unref_Node;

   function To_Extension
            (  Model : access Gtk_Extension_Store_Record;
               Iter  : Gtk_Tree_Iter
            )  return Gtk_Tree_Iter is
   begin
      if Iter = Null_Iter then
         return Null_Iter;
      else
         declare
            Path   : Gtk_Tree_Path := Get_Path (Model.Reference, Iter);
            Result : Gtk_Tree_Iter := Null_Iter;
         begin
            if Path /= null then
               Result := Get_Iter (Model.Columns, Path);
               Path_Free (Path);
            end if;
            return Result;
         end;
      end if;
   end To_Extension;

   function To_Extension
            (  Model : access Gtk_Extension_Store_Record;
               Path  : Gtk_Tree_Path
            )  return Gtk_Tree_Path is
   begin
      if Path = null then
         return null;
      else
         return Copy (Path);
      end if;
   end To_Extension;

   procedure Set_Extension
             (  Model  : access Gtk_Extension_Store_Record'Class;
                Iter   : Gtk_Tree_Iter;
                Column : Positive;
                Value  : Boolean
             )  is
   begin
      Set (Model.Columns, Iter, GInt (Column) - 1, Value);
   end Set_Extension;

   procedure Set_Extension
             (  Model  : access Gtk_Extension_Store_Record'Class;
                Iter   : Gtk_Tree_Iter;
                Column : Positive;
                Value  : GInt
             )  is
   begin
      Set (Model.Columns, Iter, GInt (Column) - 1, Value);
   end Set_Extension;

   procedure Set_Extension
             (  Model  : access Gtk_Extension_Store_Record'Class;
                Iter   : Gtk_Tree_Iter;
                Column : Positive;
                Value  : UTF8_String
             )  is
   begin
      Set (Model.Columns, Iter, GInt (Column) - 1, Value);
   end Set_Extension;

   procedure Set_Extension
             (  Model  : access Gtk_Extension_Store_Record'Class;
                Iter   : Gtk_Tree_Iter;
                Column : Positive;
                Value  : GValue
             )  is
   begin
      Set_Value (Model.Columns, Iter, GInt (Column) - 1, Value);
   end Set_Extension;

end Gtk.Tree_Model.Extension_Store;
