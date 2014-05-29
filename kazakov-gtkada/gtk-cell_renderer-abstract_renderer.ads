--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Cell_Renderer.Abstract_Renderer         Luebeck            --
--  Interface                                      Summer, 2006       --
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
--
--  This  package  provides  an  abstract  base  type for GTK+ tree view
--  column  renderers.  The  GTK+  virtual  functions  are  mapped  onto
--  primitive operations of the type. A derived type  override  them  to
--  provide renderer's implementation.
--
with Gdk.Rectangle;             use Gdk.Rectangle;
with GLib.Object;               use GLib.Object;
with GLib.Values;               use GLib.Values;
with GLib.Properties.Creation;  use GLib.Properties.Creation;
with Gtk.Widget;                use Gtk.Widget;

with Ada.Finalization;

package Gtk.Cell_Renderer.Abstract_Renderer is
--
-- Gtk_Abstract_Renderer_Record -- Abstract  base  for user-defined cell
--                                 renderers
--
-- Signals :
--
--    commit - The signal can be emitted by  the  implementation  of  an
--             activatable  or  editable  cell  renderer upon successful
--             editing.  Note  that  the  renderer  does  not change the
--             store. It is the responsibility of the corresponding tree
--             view  widget. For this the widget connects to this signal
--             and  updates  the  store upon notification. The handler's
--             signature:
--
--                 procedure (Cell : access Renderer_Record'Class);
--
--             The type Renderer_Record is a descendant of the  abstract
--             renderer. From  the  handler  Get_Path  can  be  used  to
--             identify the tree path. Use Get_Iter_From_String  of  the
--             tree model to obtain a tree iterator to the cell's row.
--
   type Gtk_Abstract_Renderer_Record is
      abstract new Gtk_Cell_Renderer_Record with private;
--
-- C_Class_Init -- GTK class initializer
--
   type C_Class_Init is access procedure (Class : GObject_Class);
   pragma Convention (C, C_Class_Init);
--
-- Activate -- Notification
--
--    Renderer        - The object
--    Event           - The event
--    Widget          - The widget where rendering happens
--    Path            - String representation of event location
--    Background_Area - The area around the cell
--    Cell_Area       - The drawing area of the cell
--    Flags           - Drawing flags
--
-- This  function  is  called for activatable cells upon activation. The
-- default implementation returns False.
--
-- Returns :
--
--    True if the cell has been activated
--
   function Activate
            (  Cell            : access Gtk_Abstract_Renderer_Record;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : access Gtk_Widget_Record'Class;
               Path            : String;
               Background_Area : Gdk_Rectangle;
               Cell_Area       : Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Boolean;
--
-- Base_Class_Init -- GTK+ class initialization
--
--    Class - The cell renderer class
--
-- This procedure is passed as a parameter to Register. If  some  custom
-- initialization  is  required,  for  example to install additional GTK
-- class properties, a user-provided  procedure  is  passed  instead  of
-- Base_Class_Init. In this case the procedure must call Base_Class_Init
-- from its body, before applying any customizing changes to the class.
--
   procedure Base_Class_Init (Class : GObject_Class);
   pragma Convention (C, Base_Class_Init);
--
-- Commit -- Commit editing
--
--    Cell - The renderer
--
-- This  procedure  emits  commit  signal.  The tree view object usually
-- connects  to this signal to store the changes made in the activatable
-- / editable cell into the store. The procedure Get_Path can be used in
-- the handler to identify the edited cell.
--
   procedure Commit (Cell : access Gtk_Abstract_Renderer_Record);
--
-- Finalize -- Custom finalization
--
--    Cell - The renderer
--
-- This  procedure  is  called upon object destruction. The override, if
-- any, shall call the parent's version.
--
   procedure Finalize (Cell : access Gtk_Abstract_Renderer_Record);
--
-- Initialize -- Construction
--
--    Cell    - A pointer to a newly allocated object
--    Type_Of - The type obtained by a call to Register
--
-- This procedure has to be called  by  any  derived  type  upon  object
-- construction. Normally it is the first call of its Initialize,  which
-- in  turn  is  called  from a Gtk_New. The parameter Type_Of must be a
-- value  returned by Register called with the name assigned to the GTK+
-- type of the derived type. Note that Register  shall  be  called  only
-- once.  So  its  result  must  be stored somewhere in the package that
-- derives the type.
--
   procedure Initialize
             (  Cell    : access Gtk_Abstract_Renderer_Record'Class;
                Type_Of : GType
             );
--
-- Get_Mode -- Get mode (inert, activatable, editable)
--
--    Cell - The renderer
--
-- Returns :
--
--    The current mode
--
   function Get_Mode (Cell : access Gtk_Abstract_Renderer_Record)
      return Gtk_Cell_Renderer_Mode;
--
-- Get_Path -- Get the cell path being edited
--
--    Cell - The renderer
--
-- The result is empty string if no Activate or Start_Editing  happenend
-- prior to the call.
--
-- Returns :
--
--    The path as specified in the last Activate or Start_Editing
--
   function Get_Path (Cell : access Gtk_Abstract_Renderer_Record)
      return String;
--
-- Get_Property -- Property value request
--
--    Cell          - The renderer
--    Param_ID      - The identifier of the property
--    Value         - The result
--    Property_Spec - Specification
--
-- The default implementation calls Get_Property of the parent class.
--
   procedure Get_Property
             (  Cell          : access Gtk_Abstract_Renderer_Record;
                Param_ID      : Property_ID;
                Value         : out GValue;
                Property_Spec : Param_Spec
             );
--
-- Get_Size -- Obtain the width and height needed to render the cell
--
--    Cell        - The renderer
--    Widget      - The for renderering to
--  [ Cell_Area ] - The area for the cell
--
-- When Cell_Area is omitted, X and Y must be set to 0, Width and Height
-- are  set  to indicate the desired size of the cell. When Cell_Area is
-- specified, Width and Height are calculated as above, then XPad*2  and
-- YPad*2 (obtained from Widget) should be added to the result. X and  Y
-- are  set  according  to  XAlign  and  YAlign  of Widget. For this the
-- rectangle  (0,  0,  Width,  Height)  is aligned within Cell_Area. The
-- appropriate  formulae  are  XAlign*(Cell_Area.Width-Width)  for X and
-- YAlign*(Cell_Area.Height-Height) for Y.
--
-- Returns :
--
--    The expected size
--
   function Get_Size
            (  Cell      : access Gtk_Abstract_Renderer_Record;
               Widget    : access Gtk.Widget.Gtk_Widget_Record'Class;
               Cell_Area : Gdk_Rectangle
            )  return Gdk_Rectangle is abstract;
   function Get_Size
            (  Cell      : access Gtk_Abstract_Renderer_Record;
               Widget    : access Gtk.Widget.Gtk_Widget_Record'Class
            )  return Gdk_Rectangle is abstract;
--
-- Get_X_Pad -- Quick access to some properties of the renderer
-- Get_Y_Pad
-- Get_X_Align
-- Get_Y_Align
--
--    Cell - The renderer
--
-- Returns :
--
--    The property of
--
   function Get_X_Align (Cell : access Gtk_Abstract_Renderer_Record)
      return GFloat;
   function Get_X_Pad (Cell : access Gtk_Abstract_Renderer_Record)
      return GUInt;
   function Get_Y_Align (Cell : access Gtk_Abstract_Renderer_Record)
      return GFloat;
   function Get_Y_Pad (Cell : access Gtk_Abstract_Renderer_Record)
      return GUInt;
--
-- Register -- GTK type and interface registration
--
--    Name - Of the type
--    Init - GTK class initialization callback
--
-- For each non-abstract derived  type  of  Gtk_Abstract_Renderer_Record
-- this  function  shall  be  called  once  before creation of the first
-- object of.
--
--    My_Renderer_Type : GType := GType_Invalid;
--    ...
--    function Get_Type return Gtk_Type is
--    begin
--      if My_Renderer_Type = GType_Invalid then
--         My_Renderer_Type := Register ("MyRenderer");
--         --
--         -- Place any GTK class initialization here, if necessary
--         --
--      end if;
--      return My_Renderer_Type;
--    end Get_Type;
--
--    procedure Initialize (Cell : access My_Renderer_Record'Class) is
--    begin
--       Initialize (Cell, Get_Type);
--       ...
--    end Initialize;
--
-- The parameter Init can be used to add some customized  initialization
-- to the GTK class. See Base_Class_Init.
--
-- Returns :
--
--    The GTK type corresponding to the Ada type
--
   function Register
            (  Name : String;
               Init : C_Class_Init := Base_Class_Init'Access
            )  return GType;
--
-- Render -- Do the job
--
--    Renderer        - The object
--    Widget          - The widget where rendering happens
--    Background_Area - The area around the cell
--    Cell_Area       - To draw
--    Expose_Area     - The clip rectangle
--    Flags           - Drawing flags
--
-- Implementation  of  the  virtual render function called to render the
-- cell.  The  three  passed-in  rectangles  are  areas  of Window. Most
-- renderers will draw within Cell_Area; the Xalign, Yalign,  Xpad,  and
-- Ypad  fields  of  should  be  honored  with  respect  to   Cell_Area.
-- Background_Area  includes  the  blank space around the cell, and also
-- the  area  containing  the  tree  expander;  so  the  Background_Area
-- rectangles for all cells tile to cover the entire Window. Expose_Area
-- is a clip rectangle.
--
   procedure Render
             (  Cell            : access Gtk_Abstract_Renderer_Record;
                Window          : Gdk_Window;
                Widget          : access Gtk_Widget_Record'Class;
                Background_Area : Gdk_Rectangle;
                Cell_Area       : Gdk_Rectangle;
                Expose_Area     : Gdk_Rectangle;
                Flags           : Gtk_Cell_Renderer_State
             )  is abstract;
--
-- Set_Mode -- Set mode (inert, activatable, editable)
--
--    Cell - The renderer
--    Mode - The property value
--
-- This procedure sets the renderer's mode property. The renderer can be
-- inert, activatable or editable.
--
   procedure Set_Mode
             (  Cell : access Gtk_Abstract_Renderer_Record;
                Mode : Gtk_Cell_Renderer_Mode
             );
--
-- Set_Property -- Property value request
--
--    Cell          - The renderer
--    Param_ID      - The identifier of the property
--    Value         - The value of the property to set
--    Property_Spec - Specification
--
-- The default implementation call Set_Property of the parent.
--
   procedure Set_Property
             (  Cell          : access Gtk_Abstract_Renderer_Record;
                Param_ID      : Property_ID;
                Value         : GValue;
                Property_Spec : Param_Spec
             );
--
-- Start_Editing -- Editing initiation notification
--
--    Renderer        - The object
--    Event           - The event
--    Widget          - The widget where rendering happens
--    Path            - String representation of event location
--    Background_Area - The area around the cell
--    Cell_Area       - The drawing area of the cell
--    Flags           - Drawing flags
--
-- This function is called for editable cells upon  start  editing.  The
-- implementation  returns a widget responsible for editing or null. The
-- widget  returned  should  implement  the Gtk_Cell_Editable interface.
-- Otherwise, the behaviour of the renderer will be as if  Start_Editing
-- would return null. The caller is responsible to Ref the result it get
-- and to Unref where appropriate. The  default  implementation  returns
-- null. A  typical  implementation  would  create  a  Gtk_Cell_Editable
-- widget,  like  Gtk_Entry,  initialize  it with the current renderer's
-- value, connect to the editing_done and focus_out_event signals of the
-- widget and return the widget as the result.
--
-- Returns :
--
--    Editable widget (editor) or null
--
   function Start_Editing
            (  Cell            : access Gtk_Abstract_Renderer_Record;
               Event           : Gdk.Event.Gdk_Event;
               Widget          : access Gtk_Widget_Record'Class;
               Path            : String;
               Background_Area : Gdk_Rectangle;
               Cell_Area       : Gdk_Rectangle;
               Flags           : Gtk_Cell_Renderer_State
            )  return Gtk_Widget;
--
-- Stop_Editing -- Stop editing
--
--    Renderer  - The object
--    Cancelled - Flag
--
-- This procedure informs the cell renderer that the editing is stopped.
-- The  parameter  Cancelled  indicates whether it is being cancelled or
-- completed  normally.  When  overridden, the implementation shall call
-- this  procedure from its body. Typical use of Stop_Editing is to call
-- it from  editing-done  handler  of  the  editor  widget  returned  in
-- Start_Editing.  Before  calling  Stop_Editing with Cancelled = False,
-- one  should also set the new value into the renderer and then call to
-- Commit to notify the tree view about the changes made.
--
   procedure Stop_Editing
             (  Cell      : access Gtk_Abstract_Renderer_Record;
                Cancelled : Boolean
             );
private
   type Cell_Path (Size : Natural) is record
      Length : Natural;
      Text   : String (1..Size);
   end record;
   type Cell_Path_Ptr is access Cell_Path;
   type Cell_Path_Ref is new Ada.Finalization.Controlled with record
      Ref : Cell_Path_Ptr;
   end record;
   procedure Adjust (Path : in out Cell_Path_Ref);
   procedure Finalize (Path : in out Cell_Path_Ref);
   procedure Set (Path : in out Cell_Path_Ref; Text : String);

   type Gtk_Abstract_Renderer_Record is
      abstract new Gtk_Cell_Renderer_Record with
   record
      Path : Cell_Path_Ref;
   end record;
   type Gtk_Abstract_Renderer_Record_Ptr is
      access all Gtk_Abstract_Renderer_Record'Class;

   type Renderer_Mode is mod 3;
   for Renderer_Mode'Size use 2;
--
-- C_Renderer_Record -- Gtk object associated with the renderer
--
-- All C interface functions deal with an instance of this type. It  can
-- also be obtained using Get_Object. The object extends GTK C structure
-- GtkCellRenderer.
--
   type C_Renderer_Bits is record
      Mode                : Renderer_Mode;
      Visible             : Boolean;
      Is_Expander         : Boolean;
      Is_Expanded         : Boolean;
      Cell_Background_Set : Boolean;
      Sensitive           : Boolean;
      Editing             : Boolean;
   end record;
   pragma Pack (C_Renderer_Bits);
   pragma Convention (C, C_Renderer_Bits);

   type C_GObject_Record is record -- GObject
      G_Type_Instance : System.Address;
      Ref_Count       : GUInt;
      QData           : System.Address;
   end record;
   pragma Convention (C, C_GObject_Record);

   type C_GtkObject_Record is record -- GtkObject
      Parent : C_GObject_Record;
      Flags  : GUInt32;
   end record;
   pragma Convention (C, C_GtkObject_Record);

   type C_Renderer_Record is record -- GtkCellRenderer
      Parent : C_GtkObject_Record;
      Xalign : GFloat;
      Yalign : GFloat;
      Width  : GInt;
      Height : GInt;
      XPad   : GUInt16;
      YPad   : GUInt16;
      Bits   : C_Renderer_Bits;
   end record;
   pragma Convention (C, C_Renderer_Record);

   type C_Abstract_Renderer_Record is record -- GtkCellRenderer
      Parent         : C_Renderer_Record;
      Implementation : Gtk_Abstract_Renderer_Record_Ptr;
   end record;
   pragma Convention (C, C_Abstract_Renderer_Record);
   type C_Renderer_Record_Ptr is access all C_Abstract_Renderer_Record;
   pragma Convention (C, C_Renderer_Record_Ptr);
--
-- Register_Type -- GTK type and interface registration
--
--    Name - Of the type
--    Size - Of C instance
--    Init - GTK class initialization callback
--
-- This function can be used to  register  a  derived  type  instead  of
-- public  Register,  if  C_Model_Record  is extended. In fact, Register
-- calls to this function.
--
-- Returns :
--
--    The GTK type corresponding to the Ada type
--
   function Register_Type
            (  Name : String;
               Size : Positive     := C_Abstract_Renderer_Record'Size;
               Init : C_Class_Init := Base_Class_Init'Access
            )  return GType;

end Gtk.Cell_Renderer.Abstract_Renderer;
