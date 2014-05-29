--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Tree_Model.Abstract_Store               Luebeck            --
--  Implementation                                 Summer, 2006       --
--                                                                    --
--                                Last revision :  17:51 10 Aug 2012  --
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

with Ada.Exceptions;        use Ada.Exceptions;
with GLib;                  use GLib;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;

with System.Address_To_Access_Conversions;

package body Gtk.Tree_Model.Abstract_Store is
   use System;

   type GObjectClass;
   type GObjectClass_Ptr is access all GObjectClass;
   pragma Convention (C, GObjectClass_Ptr);

   type C_Dispose is access procedure (Object : Address);
   pragma Convention (C, C_Dispose);

   type C_Finalize is access procedure (Object : Address);
   pragma Convention (C, C_Finalize);

   type GObjectClass is record
      G_Type                      : GType;    -- GTypeClass

      Construct_Properties        : Address;  -- GObjectClass
      Constructor                 : Address;
      Set_Property                : Address;
      Get_Property                : Address;
      Dispose                     : C_Dispose;
      Finalize                    : C_Finalize;
      Dispatch_Properties_Changed : Address;
      Notify                      : Address;
   end record;
   pragma Convention (C, GObjectClass);

   Parent_Class : GObjectClass_Ptr := null;

   type C_Class_Init is access
      procedure (Class : GObjectClass_Ptr);
   pragma Convention (C, C_Class_Init);

   type C_Interface_Init is access
      procedure (  Iface      : Address;
                   Iface_Data : Address
                );
   pragma Convention (C, C_Interface_Init);

   type GType_Info is record
      Class_Size     : GUInt16;
      Base_Init      : Address;
      Base_Finalize  : Address;
      Class_Init     : C_Class_Init;
      Class_Finalize : Address;
      Class_Data     : Address;
      Instance_Size  : GUInt16;
      Preallocs      : GUInt16;
      Instance_Init  : Address;
      Value_Table    : Address;
   end record;
   pragma Convention (C, GType_Info);

   type GTypeQuery is record
      Type_Of       : GType;
      Type_Name     : Interfaces.C.Strings.Chars_Ptr;
      Class_Size    : GUInt;
      Instance_Size : GUInt;
   end record;
   pragma Convention (C, GTypeQuery);

   procedure Type_Query (Type_Of : GType; Query : out GTypeQuery);
   pragma Import (C, Type_Query, "g_type_query");

   type Gtk_Tree_Iter_Ptr is access all Gtk_Tree_Iter;
   pragma Convention (C, Gtk_Tree_Iter_Ptr);

   type GInterface_Info is record
      Init : C_Interface_Init;
      Fin  : C_Interface_Init;
      Data : Address;
   end record;
   pragma Convention (C, GInterface_Info);

   type GType_Interface is record
      G_Type          : GType;
      G_Instance_Type : GType;
   end record;
   pragma Convention (C, GType_Interface);

   type Proc_Table is array (Positive range <>) of Address;
   pragma Convention (C, Proc_Table);

   type Gtk_Tree_Model_Interface is record
      G_Iface : GType_Interface;
      Virtual : Proc_Table (1..19);
   end record;
   pragma Convention (C, Gtk_Tree_Model_Interface);

   type Gtk_Tree_Model_Interface_Ptr is
      access all Gtk_Tree_Model_Interface;

   procedure Initialize_Tree_Interface
             (  Iface      : Address;
                Iface_Data : Address
             );
   pragma Convention (C, Initialize_Tree_Interface);

   function C_Get_Flags
            (  Model : C_Model_Record_Ptr
            )  return Tree_Model_Flags;
   pragma Convention (C, C_Get_Flags);

   function C_Get_N_Columns (Model : C_Model_Record_Ptr)
      return GInt;
   pragma Convention (C, C_Get_N_Columns);

   function C_Get_Column_Type
            (  Model : C_Model_Record_Ptr;
               Index : GInt
            )  return GType;
   pragma Convention (C, C_Get_Column_Type);

   function C_Get_Iter
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter;
               Path  : Gtk_Tree_Path
            )  return GBoolean;
   pragma Convention (C, C_Get_Iter);

   function C_Get_Path
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return Gtk_Tree_Path;
   pragma Convention (C, C_Get_Path);

   procedure C_Get_Value
             (  Model  : C_Model_Record_Ptr;
                Iter   : access Gtk_Tree_Iter;
                Column : Gint;
                Value  : access GValue
             );
   pragma Convention (C, C_Get_Value);

   function C_Next
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return GBoolean;
   pragma Convention (C, C_Next);

   function C_Children
            (  Model  : C_Model_Record_Ptr;
               Iter   : access Gtk_Tree_Iter;
               Parent : Gtk_Tree_Iter_Ptr
            )  return GBoolean;
   pragma Convention (C, C_Children);

   function C_Has_Child
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return GBoolean;
   pragma Convention (C, C_Has_Child);

   function C_N_Children
            (  Model : C_Model_Record_Ptr;
               Iter  : Gtk_Tree_Iter_Ptr
            )  return Gint;
   pragma Convention (C, C_N_Children);

   function C_Nth_Child
            (  Model  : C_Model_Record_Ptr;
               Iter   : access Gtk_Tree_Iter;
               Parent : Gtk_Tree_Iter_Ptr;
               N      : GInt
            )  return Gboolean;
   pragma Convention (C, C_Nth_Child);

   function C_Parent
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter;
               Child : access Gtk_Tree_Iter
            )  return GBoolean;
   pragma Convention (C, C_Parent);

   procedure C_Ref_Node
             (  Model : C_Model_Record_Ptr;
                Iter  : access Gtk_Tree_Iter
             );
   pragma Convention (C, C_Ref_Node);

   procedure C_Unref_Node
             (  Model : C_Model_Record_Ptr;
                Iter  : access Gtk_Tree_Iter
             );
   pragma Convention (C, C_Unref_Node);

   procedure Initialize_Tree_Interface
             (  Iface      : Address;
                Iface_Data : Address
             )  is
      package Conversions is
         new System.Address_To_Access_Conversions
             (Gtk_Tree_Model_Interface);
      This : Gtk_Tree_Model_Interface renames
                Conversions.To_Pointer (Iface).all;
   begin
      This.Virtual (6)  := C_Get_Flags'Address;
      This.Virtual (7)  := C_Get_N_Columns'Address;
      This.Virtual (8)  := C_Get_Column_Type'Address;
      This.Virtual (9)  := C_Get_Iter'Address;
      This.Virtual (10) := C_Get_Path'Address;
      This.Virtual (11) := C_Get_Value'Address;
      This.Virtual (12) := C_Next'Address;
      This.Virtual (13) := C_Children'Address;
      This.Virtual (14) := C_Has_Child'Address;
      This.Virtual (15) := C_N_Children'Address;
      This.Virtual (16) := C_Nth_Child'Address;
      This.Virtual (17) := C_Parent'Address;
      This.Virtual (18) := C_Ref_Node'Address;
      This.Virtual (19) := C_Unref_Node'Address;
   end Initialize_Tree_Interface;

   procedure On_Delete (Object : Address);
   pragma Convention (C, On_Delete);

   procedure On_Delete (Object : Address) is
      package Conversions is
         new System.Address_To_Access_Conversions (C_Model_Record);
   begin
      if Object /= Null_Address then
         declare
            This : C_Model_Record renames
                      Conversions.To_Pointer (Object).all;
         begin
            if This.Implementation /= null then
               Finalize (This.Implementation);
            end if;
         end;
      end if;
      if Parent_Class.Finalize /= null then
         Parent_Class.Finalize (Object);
      end if;
   end On_Delete;

   procedure Initialize
             (  Model   : access Gtk_Abstract_Model_Record'Class;
                Type_Of : GType
             )  is
      function Object_New (Typ : GType) return System.Address;
      pragma Import (C, Object_New, "ada_g_object_new");
      package Conversions is
         new System.Address_To_Access_Conversions (C_Model_Record);
   begin
      Set_Object (Model, Object_New (Type_Of));
      Conversions.To_Pointer (Get_Object (Model)).Implementation :=
         Model.all'Unchecked_Access;
   end Initialize;

   procedure Class_Init (Class : GObjectClass_Ptr);
   pragma Convention (C, Class_Init);

   procedure Class_Init (Class : GObjectClass_Ptr) is
      function Class_Peek_Parent (Class : GObjectClass_Ptr)
         return GObjectClass_Ptr;
      pragma Import (C, Class_Peek_Parent, "g_type_class_peek_parent");
   begin
      if Parent_Class = null then
         Parent_Class := Class_Peek_Parent (Class);
      end if;
      Class.Finalize := On_Delete'Access;
   end Class_Init;

   function Register
            (  Name       : String;
               Signals    : GtkAda.Types.Chars_Ptr_Array := Null_Array;
               Parameters : Signal_Parameter_Types :=
                               Null_Parameter_Types
            )  return GType is
   begin
      return
         Register_Type
         (  Name       => Name,
            Signals    => Signals,
            Parameters => Parameters
         );
   end Register;

   function Register_Type
            (  Name       : String;
               Size       : Positive := C_Model_Record'Size;
               Signals    : GtkAda.Types.Chars_Ptr_Array := Null_Array;
               Parameters : Signal_Parameter_Types :=
                               Null_Parameter_Types
            )  return GType is
      function Register_Static
               (  Parent_Type : GType;
                  Type_Name   : Char_Array;
                  Type_Info   : access GType_Info;
                  Type_Flags  : GUInt
               )  return Glib.GType;
      pragma Import (C, Register_Static, "g_type_register_static");
      procedure Add_Interface_Static
                (  Instance_Type  : GType;
                   Interface_Type : GType;
                   Info           : access GInterface_Info
                );
      pragma Import
             (C, Add_Interface_Static, "g_type_add_interface_static");
      procedure Marshaller
                (  Closure         : Address;
                   Return_Value    : access GValue;
                   N_Param_Values  : GUInt;
                   Param_Values    : access GValue;
                   Invocation_Hint : Address;
                   Marshal_Data    : Address
                );
      pragma Import (C, Marshaller, "g_cclosure_marshal_VOID__VOID");
      function Signal_NewV
               (  Name         : GtkAda.Types.Chars_Ptr;
                  IType        : GType;
                  Signal_Flags : GUInt;
                  Closure      : Address;
                  Accumulator  : Address;
                  Accu_Data    : Address;
                  C_Marshaller : Address;
                  Return_Type  : GType;
                  N_Params     : GUInt;
                  Params       : access GType
               )  return GUInt;
      pragma Import (C, Signal_NewV, "g_signal_newv");
      type Parameter_List is array (Natural range <>) of aliased GType;
      pragma Convention (C, Parameter_List);

      Result : GType;
      Info   : GTypeQuery;
      ID     : GUInt;
   begin
      if Parameters /= Null_Parameter_Types then
         if Signals'Length /= Parameters'Length (1) then
            Raise_Exception
            (  Constraint_Error'Identity,
               "Signal and their parameter lists have different sizes" &
               Integer'Image (Signals'Length) & " and" &
               Integer'Image (Parameters'Length (1))
            );
         end if;
      end if;
      Type_Query (GType_Object, Info);
      if GUInt (Size / Interfaces.C.Char'Size) < Info.Instance_Size then
         Raise_Exception
         (  Constraint_Error'Identity,
            (  "GTK object instance of '"
            &  Name
            &  "' is smaller than parent '"
            &  Value (Info.Type_Name)
            &  "' "
            &  Integer'Image (Size / Interfaces.C.Char'Size)
            &  "<"
            &  GUInt'Image (Info.Instance_Size)
         )  );
      end if;
      Result :=
         Register_Static
         (  Parent_Type => GType_Object,
            Type_Name   => To_C (Name),
            Type_Flags  => 0,
            Type_Info   =>
               new GType_Info'
               (  Class_Size     =>
                     GUInt16'Max
                     (  GObjectClass_Ptr'Size / Interfaces.C.Char'Size,
                        GUInt16 (Info.Class_Size)
                     ),
                  Base_Init      => Null_Address,
                  Base_Finalize  => Null_Address,
                  Class_Init     => Class_Init'Access,
                  Class_Finalize => Null_Address,
                  Class_Data     => Null_Address,
                  Preallocs      => 0,
                  Instance_Init  => Null_Address,
                  Value_Table    => Null_Address,
                  Instance_Size  =>
                     GUInt16 (Size / Interfaces.C.Char'Size)
         )     );
      Add_Interface_Static
      (  Instance_Type  => Result,
         Interface_Type => Gtk.Tree_Model.Get_Type,
         Info           =>
            new GInterface_Info'
                (  Initialize_Tree_Interface'Access,
                   null,
                   Null_Address
      )         );
      if Parameters = Null_Parameter_Types then
         for Index in Signals'Range loop
            ID :=
               Signal_Newv
               (  Name         => Signals (Index),
                  IType        => Result,
                  Signal_Flags => 2, -- G_SIGNAL_RUN_LAST
                  Closure      => Null_Address,
                  Accumulator  => Null_Address,
                  Accu_Data    => Null_Address,
                  C_Marshaller => Marshaller'Address,
                  Return_Type  => GType_None,
                  N_Params     => 0,
                  Params       => null
               );
         end loop;
      else
         for Index in Signals'Range loop
            declare
               Count : Natural := 0;
               I     : Natural := Natural (Index - Signals'First) +
                                  Parameters'First (1);
            begin
               for J in Parameters'Range (2) loop
                  exit when Parameters (I, J) = GType_None;
                  Count := Count + 1;
               end loop;
               declare
                  List : Parameter_List (1..Count);
               begin
                  for J in List'Range loop
                     List (J) :=
                        Parameters
                        (  I,
                           J - List'First + Parameters'First (2)
                        );
                  end loop;
                  ID :=
                     Signal_Newv
                     (  Name         => Signals (Index),
                        IType        => Result,
                        Signal_Flags => 2, -- G_SIGNAL_RUN_LAST
                        Closure      => Null_Address,
                        Accumulator  => Null_Address,
                        Accu_Data    => Null_Address,
                        C_Marshaller => Marshaller'Address,
                        Return_Type  => GType_None,
                        N_Params     => GUInt (Count),
                        Params       => List (1)'Access
                    );
               end;
            end;
         end loop;
      end if;
      return Result;
   end Register_Type;

   function C_Get_Flags
            (  Model : C_Model_Record_Ptr
            )  return Tree_Model_Flags is
   begin
      return Get_Flags (Model.Implementation);
   end C_Get_Flags;

   function C_Get_N_Columns (Model : C_Model_Record_Ptr)
      return GInt is
   begin
      return Get_N_Columns (Model.Implementation);
   end C_Get_N_Columns;

   function C_Get_Column_Type
            (  Model : C_Model_Record_Ptr;
               Index : GInt
            )  return GType is
   begin
      return Get_Column_Type (Model.Implementation, Index);
   end C_Get_Column_Type;

   function C_Get_Iter
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter;
               Path  : Gtk_Tree_Path
            )  return GBoolean is
      Result : Gtk_Tree_Iter := Get_Iter (Model.Implementation, Path);
   begin
      if Result = Null_Iter then
         return 0;
      else
         Iter.all := Result;
         return 1;
      end if;
   end C_Get_Iter;

   function C_Get_Path
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return Gtk_Tree_Path is
   begin
      return Get_Path (Model.Implementation, Iter.all);
   end C_Get_Path;

   procedure C_Get_Value
             (  Model  : C_Model_Record_Ptr;
                Iter   : access Gtk_Tree_Iter;
                Column : GInt;
                Value  : access GValue
             )  is
   begin
      Get_Value (Model.Implementation, Iter.all, Column, Value.all);
   end C_Get_Value;

   function C_Children
            (  Model  : C_Model_Record_Ptr;
               Iter   : access Gtk_Tree_Iter;
               Parent : Gtk_Tree_Iter_Ptr
            )  return GBoolean is
   begin
      if Parent = null then
         Iter.all := Children (Model.Implementation, Null_Iter);
      else
         Iter.all := Children (Model.Implementation, Parent.all);
      end if;
      if Iter.all = Null_Iter then
         return 0;
      else
         return 1;
      end if;
   end C_Children;

   function C_Has_Child
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return GBoolean is
   begin
      if Has_Child (Model.Implementation, Iter.all) then
         return 1;
      else
         return 0;
      end if;
   end C_Has_Child;

   function C_Next
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter
            )  return GBoolean is
      Result : Gtk_Tree_Iter := Iter.all;
   begin
      Next (Model.Implementation, Result);
      if Result = Null_Iter then
         return 0;
      else
         Iter.all := Result;
         return 1;
      end if;
   end C_Next;

   function C_N_Children
            (  Model : C_Model_Record_Ptr;
               Iter  : Gtk_Tree_Iter_Ptr
            )  return GInt is
   begin
      if Iter = null then
         return N_Children (Model.Implementation, Null_Iter);
      else
         return N_Children (Model.Implementation, Iter.all);
      end if;
   end C_N_Children;

   function C_Nth_Child
            (  Model  : C_Model_Record_Ptr;
               Iter   : access Gtk_Tree_Iter;
               Parent : Gtk_Tree_Iter_Ptr;
               N      : GInt
            )  return GBoolean is
      Result : Gtk_Tree_Iter;
   begin
      if Parent = null then
         Result := Nth_Child (Model.Implementation, Null_Iter, N);
      else
         Result := Nth_Child (Model.Implementation, Parent.all, N);
      end if;
      if Result = Null_Iter then
         return 0;
      else
         Iter.all := Result;
         return 1;
      end if;
   end C_Nth_Child;

   function C_Parent
            (  Model : C_Model_Record_Ptr;
               Iter  : access Gtk_Tree_Iter;
               Child : access Gtk_Tree_Iter
            )  return GBoolean is
      Result : Gtk_Tree_Iter :=
         Parent (Model.Implementation, Child.all);
   begin
      if Result = Null_Iter then
         return 0;
      else
         Iter.all := Result;
         return 1;
      end if;
   end C_Parent;

   procedure C_Ref_Node
             (  Model : C_Model_Record_Ptr;
                Iter  : access Gtk_Tree_Iter
             )  is
   begin
      Ref_Node (Model.Implementation, Iter.all);
   end C_Ref_Node;

   procedure C_Unref_Node
             (  Model : C_Model_Record_Ptr;
                Iter  : access Gtk_Tree_Iter
             )  is
   begin
      Unref_Node (Model.Implementation, Iter.all);
   end C_Unref_Node;

   procedure Finalize (Model : access Gtk_Abstract_Model_Record) is
   begin
      null;
   end Finalize;

   procedure Ref_Node
             (  Model : access Gtk_Abstract_Model_Record;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      null;
   end Ref_Node;

   procedure Unref_Node
             (  Model : access Gtk_Abstract_Model_Record;
                Iter  : Gtk_Tree_Iter
             )  is
   begin
      null;
   end Unref_Node;

end Gtk.Tree_Model.Abstract_Store;
