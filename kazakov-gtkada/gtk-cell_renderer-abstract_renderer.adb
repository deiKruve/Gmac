--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Cell_Renderer.Abstract_Renderer         Luebeck            --
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
with Gtk.Cell_Editable;     use Gtk.Cell_Editable;
with Gtk.Missed;            use Gtk.Missed;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;

with Ada.Unchecked_Conversion;
with Ada.Unchecked_Deallocation;
with System.Address_To_Access_Conversions;

package body Gtk.Cell_Renderer.Abstract_Renderer is
   use System;

   type GtkCellRendererClass;
   type GtkCellRendererClass_Ptr is access all GtkCellRendererClass;
   pragma Convention (C, GtkCellRendererClass_Ptr);

   type C_Dispose is access procedure (Object : Address);
   pragma Convention (C, C_Dispose);

   type C_Finalize is access procedure (Object : Address);
   pragma Convention (C, C_Finalize);

   type GInt_Ptr is access all GInt;
   pragma Convention (C, GInt_Ptr);

   type Gdk_Rectangle_Ptr is access all Gdk_Rectangle;
   pragma Convention (C, Gdk_Rectangle_Ptr);

   type C_Activate is access function
        (  Cell            : Address;
	     Event           : Gdk.Event.Gdk_Event;
	     Widget          : Address;
	     Path            : Chars_Ptr;
	     Background_Area : access Gdk_Rectangle;
	     Cell_Area       : access Gdk_Rectangle;
	     Flags           : Gtk_Cell_Renderer_State
        )  return GBoolean;
   pragma Convention (C, C_Activate);

   type C_Editing_Cancelled is access procedure (Cell : Address);
   pragma Convention (C, C_Editing_Cancelled);

   type C_Editing_Started is access procedure
        (  Cell     : Address;
           Editable : Address;
           Path     : Chars_Ptr
        );
   pragma Convention (C, C_Editing_Started);

   type C_Get_Property is access procedure
        (  Object    : Address;
           Param_ID  : Property_ID;
           Value     : in out GValue;
           Param     : Param_Spec
        );
   pragma Convention (C, C_Get_Property);

   type C_Get_Size is access procedure
        (  Cell      : Address;
	     Widget    : Address;
	     Cell_Area : Gdk_Rectangle_Ptr;
	     X_Offset  : GInt_Ptr;
	     Y_Offset  : GInt_Ptr;
	     Width     : GInt_Ptr;
	     Height    : GInt_Ptr
        );
   pragma Convention (C, C_Get_Size);

   type C_Render is access procedure
        (  Cell            : Address;
           Window          : Gdk_Window;
	     Widget          : Address;
	     Background_Area : access Gdk_Rectangle;
	     Cell_Area       : access Gdk_Rectangle;
	     Expose_Area     : access Gdk_Rectangle;
	     Flags           : GUInt
        );
   pragma Convention (C, C_Render);

   type C_Set_Property is access procedure
        (  Object   : Address;
           Param_ID : Property_ID;
           Value    : GValue;
           Param    : Param_Spec
        );
   pragma Convention (C, C_Set_Property);

   type C_Start_Editing is access function
        (  Object          : Address;
           Event           : Gdk.Event.Gdk_Event;
           Widget          : Address;
           Path            : Chars_Ptr;
	   Background_Area : access Gdk_Rectangle;
	   Cell_Area       : access Gdk_Rectangle;
           Flags           : Gtk_Cell_Renderer_State
        )  return Address;
   pragma Convention (C, C_Start_Editing);

   type GTypeQuery is record
      Type_Of       : GType;
      Type_Name     : Chars_Ptr;
      Class_Size    : GUInt;
      Instance_Size : GUInt;
   end record;
   pragma Convention (C, GTypeQuery);

   procedure Type_Query (Type_Of : GType; Query : out GTypeQuery);
   pragma Import (C, Type_Query, "g_type_query");

   type Dummy is array (1..8) of Address;
   pragma Convention (C, Dummy);
   type GtkCellRendererClass is record
      G_Type                      : GType;      -- GTypeClass

      Construct_Properties        : Address;    -- GObjectClass
      Constructor                 : Address;
      Set_Property                : C_Set_Property;
      Get_Property                : C_Get_Property;
      Dispose                     : C_Dispose;
      Finalize                    : C_Finalize;
      Dispatch_Properties_Changed : Address;
      Notify                      : Address;

      P_Dummy                     : Dummy;

      Set_Arg                     : Address;    -- GtkObjectClass
      Get_Arg                     : Address;
      Destroy                     : Address;

      Get_Size                    : C_Get_Size; -- GtkCellRendererClass
      Render                      : C_Render;
      Activate                    : C_Activate;
      Start_Editing               : C_Start_Editing;
      Editing_Cancelled           : C_Editing_Cancelled;
      Editing_Started             : C_Editing_Started;
      Gtk_Reserved_1              : Address;
      Gtk_Reserved_2              : Address;

   end record;
   pragma Convention (C, GtkCellRendererClass);

   function To_Ptr is
      new Ada.Unchecked_Conversion
          (  GObject_Class,
             GtkCellRendererClass_Ptr
          );
   package Conversions is
      new System.Address_To_Access_Conversions
          (  C_Abstract_Renderer_Record
          );

   procedure Free is
      new Ada.Unchecked_Deallocation (Cell_Path, Cell_Path_Ptr);

   Parent_Class : GtkCellRendererClass_Ptr := null;

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

   function On_Activate
            (  Cell            : Address;
	       Event           : Gdk.Event.Gdk_Event;
	       Widget          : Address;
	       Path            : Chars_Ptr;
	       Background_Area : access Gdk_Rectangle;
	       Cell_Area       : access Gdk_Rectangle;
	       Flags           : Gtk_Cell_Renderer_State
            )  return GBoolean;
   pragma Convention (C, On_Activate);

   procedure On_Delete (Object : Address);
   pragma Convention (C, On_Delete);

   procedure On_Get_Property
             (  Object    : Address;
                Param_ID  : Property_ID;
                Value     : in out GValue;
                Param     : Param_Spec
             );
   pragma Convention (C, On_Get_Property);

   procedure On_Get_Size
             (  Cell      : Address;
   	        Widget    : Address;
   	        Cell_Area : Gdk_Rectangle_Ptr;
                X_Offset  : GInt_Ptr;
   	        Y_Offset  : GInt_Ptr;
   	        Width     : GInt_Ptr;
   	        Height    : GInt_Ptr
             );
   pragma Convention (C, On_Get_Size);

   procedure On_Render
             (  Cell            : Address;
                Window          : Gdk_Window;
	        Widget          : Address;
	        Background_Area : access Gdk_Rectangle;
	        Cell_Area       : access Gdk_Rectangle;
	        Expose_Area     : access Gdk_Rectangle;
	        Flags           : GUInt
             );
   pragma Convention (C, On_Render);

   procedure On_Set_Property
             (  Cell     : Address;
                Param_ID : Property_ID;
                Value    : GValue;
                Param    : Param_Spec
             );
   pragma Convention (C, On_Set_Property);

   function On_Start_Editing
            (  Cell            : Address;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : Address;
               Path            : Chars_Ptr;
	       Background_Area : access Gdk_Rectangle;
	       Cell_Area       : access Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Address;
   pragma Convention (C, On_Start_Editing);

   function Activate
            (  Cell            : access Gtk_Abstract_Renderer_Record;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : access Gtk_Widget_Record'Class;
               Path            : String;
               Background_Area : Gdk_Rectangle;
               Cell_Area       : Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Boolean is
   begin
      return False;
   end Activate;

   procedure Adjust  (Path : in out Cell_Path_Ref) is
   begin
      Path.Ref := null;
   end Adjust;

   procedure Base_Class_Init (Class : GObject_Class) is
      function Class_Peek_Parent (Class : GtkCellRendererClass_Ptr)
         return GtkCellRendererClass_Ptr;
      pragma Import (C, Class_Peek_Parent, "g_type_class_peek_parent");
      This : GtkCellRendererClass_Ptr := To_Ptr (Class);
   begin
      if Parent_Class = null then
         Parent_Class := Class_Peek_Parent (This);
      end if;
      This.Get_Property  := On_Get_Property'Access;
      This.Set_Property  := On_Set_Property'Access;
      This.Finalize      := On_Delete'Access;
      This.Get_Size      := On_Get_Size'Access;
      This.Render        := On_Render'Access;
      This.Activate      := On_Activate'Access;
      This.Start_Editing := On_Start_Editing'Access;
   end Base_Class_Init;

   procedure Commit (Cell : access Gtk_Abstract_Renderer_Record) is
      procedure Internal (Object : System.Address; Name : String);
      pragma Import (C, Internal, "ada_g_signal_emit_by_name");
   begin
      Internal (Get_Object (Cell), "commit" & ASCII.NUL);
   end Commit;

   procedure Editing_Cancelled
             (  Cell : access Gtk_Abstract_Renderer_Record
             )  is
   begin
      null;
   end Editing_Cancelled;

   procedure Finalize (Path : in out Cell_Path_Ref) is
   begin
      Free (Path.Ref);
   end Finalize;

   procedure Finalize (Cell : access Gtk_Abstract_Renderer_Record) is
   begin
      null;
   end Finalize;

   function Get_Mode (Cell : access Gtk_Abstract_Renderer_Record)
      return Gtk_Cell_Renderer_Mode is
      use Conversions;
   begin
      case To_Pointer (Get_Object (Cell)).Parent.Bits.Mode is
         when 0 => return Cell_Renderer_Mode_Inert;
         when 1 => return Cell_Renderer_Mode_Activatable;
         when 2 => return Cell_Renderer_Mode_Editable;
      end case;
   end Get_Mode;

   function Get_Path (Cell : access Gtk_Abstract_Renderer_Record)
      return String is
   begin
      if Cell.Path.Ref = null then
         return "";
      else
         return Cell.Path.Ref.Text (1..Cell.Path.Ref.Length);
      end if;
   end Get_Path;

   procedure Get_Property
             (  Cell          : access Gtk_Abstract_Renderer_Record;
                Param_ID      : Property_ID;
                Value         : out GValue;
                Property_Spec : Param_Spec
             )  is
   begin
      Parent_Class.Get_Property
      (  Get_Object (Cell),
         Param_ID,
         Value,
         Property_Spec
      );
   end Get_Property;

   function Get_X_Align (Cell : access Gtk_Abstract_Renderer_Record)
      return GFloat is
      use Conversions;
   begin
      return To_Pointer (Get_Object (Cell)).Parent.Xalign;
   end Get_X_Align;

   function Get_X_Pad (Cell : access Gtk_Abstract_Renderer_Record)
      return GUInt is
      use Conversions;
   begin
      return GUInt (To_Pointer (Get_Object (Cell)).Parent.Xpad);
   end Get_X_Pad;

   function Get_Y_Align (Cell : access Gtk_Abstract_Renderer_Record)
      return GFloat is
      use Conversions;
   begin
      return To_Pointer (Get_Object (Cell)).Parent.Yalign;
   end Get_Y_Align;

   function Get_Y_Pad (Cell : access Gtk_Abstract_Renderer_Record)
      return GUInt is
      use Conversions;
   begin
      return GUInt (To_Pointer (Get_Object (Cell)).Parent.Ypad);
   end Get_Y_Pad;

   procedure Initialize
             (  Cell    : access Gtk_Abstract_Renderer_Record'Class;
                Type_Of : GType
             )  is
      function Object_New (Typ : GType) return System.Address;
      pragma Import (C, Object_New, "ada_g_object_new");
   begin
      Set_Object (Cell, Object_New (Type_Of));
      Conversions.To_Pointer (Get_Object (Cell)).Implementation :=
         Cell.all'Unchecked_Access;
   end Initialize;

   function On_Activate
            (  Cell            : Address;
               Event           : Gdk.Event.Gdk_Event;
	       Widget          : Address;
	       Path            : Chars_Ptr;
	       Background_Area : access Gdk_Rectangle;
	       Cell_Area       : access Gdk_Rectangle;
	       Flags           : Gtk_Cell_Renderer_State
            )  return GBoolean is
   begin
      if Cell /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Cell).all;
         begin
            if (  This.Implementation /= null
               and then
                  This.Parent.Bits.Mode = 1   -- Activatable mode
               )
            then
               if Path = Null_Ptr then
                  Set (This.Implementation.Path, "");
               else
                  Set (This.Implementation.Path, Value (Path));
               end if;
               if Activate
                  (  This.Implementation,
                     Event,
                     Convert (Widget),
                     Get_Path (This.Implementation),
                     Background_Area.all,
                     Cell_Area.all,
                     Flags
                  )
               then
                  return 1;
               end if;
            end if;
         end;
      end if;
      return 0;
   end On_Activate;

   procedure On_Delete (Object : Address) is
   begin
      if Object /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
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

   procedure On_Get_Property
             (  Object   : Address;
                Param_ID : Property_ID;
                Value    : in out GValue;
                Param    : Param_Spec
             )  is
   begin
      if Object /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Object).all;
         begin
            if This.Implementation /= null then
               Get_Property
               (  This.Implementation,
                  Param_ID,
                  Value,
                  Param
               );
            end if;
         end;
      end if;
   end On_Get_Property;

   procedure On_Get_Size
             (  Cell      : Address;
                Widget    : Address;
                Cell_Area : Gdk_Rectangle_Ptr;
                X_Offset  : GInt_Ptr;
                Y_Offset  : GInt_Ptr;
   	        Width     : GInt_Ptr;
   	        Height    : GInt_Ptr
             )  is
   begin
      if Cell /= Null_Address then
         declare
            Area : Gdk_Rectangle;
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Cell).all;
         begin
            if This.Implementation /= null then
               if Cell_Area = null then
                  Area :=
                     Get_Size (This.Implementation, Convert (Widget));
               else
                  Area :=
                     Get_Size
                     (  This.Implementation,
                        Convert (Widget),
                        Cell_Area.all
                     );
               end if;
               if X_Offset /= null then
                  X_Offset.all := Area.X;
               end if;
               if Y_Offset /= null then
                  Y_Offset.all := Area.Y;
               end if;
               if Width /= null then
                  Width.all := Area.Width;
               end if;
               if Height /= null then
                  Height.all := Area.Height;
               end if;
            end if;
         end;
      end if;
   end On_Get_Size;

   procedure On_Render
             (  Cell            : Address;
                Window          : Gdk_Window;
                Widget          : Address;
	        Background_Area : access Gdk_Rectangle;
	        Cell_Area       : access Gdk_Rectangle;
	        Expose_Area     : access Gdk_Rectangle;
	        Flags           : GUInt
             )  is
   begin
      if Cell /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Cell).all;
         begin
            if This.Implementation /= null then
               Render
               (  This.Implementation,
                  Window,
                  Convert (Widget),
                  Background_Area.all,
                  Cell_Area.all,
                  Expose_Area.all,
                  Gtk_Cell_Renderer_State (Flags)
               );
            end if;
         end;
      end if;
   end On_Render;

   procedure On_Set_Property
             (  Cell     : Address;
                Param_ID : Property_ID;
                Value    : GValue;
                Param    : Param_Spec
             )  is
   begin
      if Cell /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Cell).all;
         begin
            if This.Implementation /= null then
               Set_Property
               (  This.Implementation,
                  Param_ID,
                  Value,
                  Param
               );
            end if;
         end;
      end if;
   end On_Set_Property;

   function On_Start_Editing
            (  Cell            : Address;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : Address;
               Path            : Chars_Ptr;
               Background_Area : access Gdk_Rectangle;
               Cell_Area       : access Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Address is
      function Internal (Object : Address; Interface_Type : GType)
         return Address;
      pragma Import (C, Internal, "g_type_check_instance_cast");
   begin
      if Cell /= Null_Address then
         declare
            This : C_Abstract_Renderer_Record renames
                      Conversions.To_Pointer (Cell).all;
         begin
            if This.Implementation /= null then
               if Path = Null_Ptr then
                  Set (This.Implementation.Path, "");
               else
                  Set (This.Implementation.Path, Value (Path));
               end if;
               declare
                  Editor : Gtk_Widget renames
                              Start_Editing
                              (  This.Implementation,
                                 Event,
                                 Convert (Widget),
                                 Get_Path (This.Implementation),
                                 Background_Area.all,
                                 Cell_Area.all,
                                 Flags
                              );
                  Editable : Address;
               begin
                  if Editor /= null then
                     --
                     -- Conversion  to the interface.  When failed  the
                     -- result is Null_Address
                     --
                     Editable :=
                        Internal
                        (  Get_Object (Editor),
                           Gtk.Cell_Editable.Get_Type
                        );
                     return Editable;
                  end if;
               end;
            end if;
         end;
      end if;
      return Null_Address;
   end On_Start_Editing;

   function Register
            (  Name : String;
               Init : C_Class_Init := Base_Class_Init'Access
            )  return GType is
   begin
      return Register_Type (Name => Name, Init => Init);
   end Register;

   function Register_Type
            (  Name : String;
               Size : Positive     := C_Abstract_Renderer_Record'Size;
               Init : C_Class_Init := Base_Class_Init'Access
            )  return GType is
      function Cell_Renderer_Type return GType;
      pragma Import
             (  C,
                Cell_Renderer_Type,
                "gtk_cell_renderer_get_type"
             );
      function Register_Static
               (  Parent_Type : GType;
                  Type_Name   : Char_Array;
                  Type_Info   : access GType_Info;
                  Type_Flags  : GUInt
               )  return Glib.GType;
      pragma Import (C, Register_Static, "g_type_register_static");
      function Signal_NewV
               (  Name         : Char_Array;
                  IType        : GType;
                  Signal_Flags : GUInt;
                  Closure      : Address;
                  Accumulator  : Address;
                  Accu_Data    : Address;
                  C_Marshaller : Address;
                  Return_Type  : GType;
                  N_Params     : GUInt;
                  Params       : Address
               )  return GUInt;
      pragma Import (C, Signal_NewV, "g_signal_newv");
      procedure Marshaller
                (  Closure         : Address;
                   Return_Value    : access GValue;
                   N_Param_Values  : GUInt;
                   Param_Values    : access GValue;
                   Invocation_Hint : Address;
                   Marshal_Data    : Address
                );
      pragma Import (C, Marshaller, "g_cclosure_marshal_VOID__VOID");

      Result    : GType;
      Info      : GTypeQuery;
      Commit_ID : GUInt;
      Parent    : GObject_Class :=
                     Gtk.Missed.Class_From_Type (Cell_Renderer_Type);
   begin
      Type_Query (Cell_Renderer_Type, Info);
      if GUInt (Size / Interfaces.C.Char'Size) < Info.Instance_Size then
         Raise_Exception
         (  Constraint_Error'Identity,
            (  "GTK object instance of '"
            &  Name
            &  "' is smaller than parent '"
            &  Value (Info.Type_Name)
            &  "' "
            &  Integer'Image (Size / Interfaces.C.Char'Size)
            &  " <"
            &  GUInt'Image (Info.Instance_Size)
         )  );
      end if;
      Result :=
         Register_Static
         (  Parent_Type => Cell_Renderer_Type,
            Type_Name   => To_C (Name),
            Type_Flags  => 0,
            Type_Info   =>
               new GType_Info'
                   (  Class_Size =>
                         GUInt16'Max
                         (  (  GtkCellRendererClass'Size
                            /  Interfaces.C.Char'Size
                            ),
                            GUInt16 (Info.Class_Size)
                         ),
                      Base_Init      => Null_Address,
                      Base_Finalize  => Null_Address,
                      Class_Init     => Init,
                      Class_Finalize => Null_Address,
                      Class_Data     => Null_Address,
                      Preallocs      => 0,
                      Instance_Init  => Null_Address,
                      Value_Table    => Null_Address,
                      Instance_Size  =>
                         GUInt16 (Size / Interfaces.C.Char'Size)
         )         );
      Commit_ID :=
         Signal_Newv
         (  Name         => To_C ("commit"),
            IType        => Result,
            Signal_Flags => 2, -- G_SIGNAL_RUN_LAST
            Closure      => Null_Address,
            Accumulator  => Null_Address,
            Accu_Data    => Null_Address,
            C_Marshaller => Marshaller'Address,
            Return_Type  => GType_None,
            N_Params     => 0,
            Params       => Null_Address
         );
      return Result;
   end Register_Type;

   procedure Set_Mode
             (  Cell : access Gtk_Abstract_Renderer_Record;
                Mode : Gtk_Cell_Renderer_Mode
             )  is
      This : C_Renderer_Record renames
             Conversions.To_Pointer (Get_Object (Cell)).Parent;
   begin
      case Mode is
         when Cell_Renderer_Mode_Inert       => This.Bits.Mode := 0;
         when Cell_Renderer_Mode_Activatable => This.Bits.Mode := 1;
         when Cell_Renderer_Mode_Editable    => This.Bits.Mode := 2;
      end case;
   end Set_Mode;

   procedure Set (Path : in out Cell_Path_Ref; Text : String) is
   begin
      if Path.Ref = null then
         if Text'Length > 0 then
            Path.Ref := new Cell_Path'(Text'Length, Text'Length, Text);
         end if;
      else
         if Path.Ref.Size < Text'Length then
            Free (Path.Ref);
            Path.Ref := new Cell_Path'(Text'Length, Text'Length, Text);
         else
            Path.Ref.Text (1..Text'Length) := Text;
            Path.Ref.Length := Text'Length;
         end if;
      end if;
   end Set;

   procedure Set_Property
             (  Cell          : access Gtk_Abstract_Renderer_Record;
                Param_ID      : Property_ID;
                Value         : GValue;
                Property_Spec : Param_Spec
             )  is
   begin
      Parent_Class.Set_Property
      (  Get_Object (Cell),
         Param_ID,
         Value,
         Property_Spec
      );
   end Set_Property;

   function Start_Editing
            (  Cell            : access Gtk_Abstract_Renderer_Record;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : access Gtk_Widget_Record'Class;
               Path            : String;
               Background_Area : Gdk_Rectangle;
               Cell_Area       : Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Gtk_Widget is
   begin
      return null;
   end Start_Editing;

   procedure Stop_Editing
             (  Cell      : access Gtk_Abstract_Renderer_Record;
                Cancelled : Boolean
             )  is
      procedure Internal (Cell : Address; Cancelled : GBoolean);
      pragma Import (C, Internal, "gtk_cell_renderer_stop_editing");
   begin
      if Cancelled then
         Internal (Get_Object (Cell), 1);
      else
         Internal (Get_Object (Cell), 0);
      end if;
   end Stop_Editing;

end Gtk.Cell_Renderer.Abstract_Renderer;
