--                                                                    --
--  package Gtk.Missed              Copyright (c)  Maxim Reznik       --
--  Interface                                      Summer, 2006       --
--                                                                    --
--                                Last revision :  15:55 10 Sep 2011  --
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

with Gdk.Color;             use Gdk.Color;
with Gdk.Cursor;            use Gdk.Cursor;
with Gdk.Rectangle;         use Gdk.Rectangle;
with Gdk.Types;             use Gdk.Types;
with Glib.Error;            use Glib.Error;
with Glib.Values;           use Glib.Values;
with Gtk.Container;         use Gtk.Container;
with Gtk.Tooltips;          use Gtk.Tooltips;
with Gtk.Tree_Model;        use Gtk.Tree_Model;
with Gtk.Tree_Store;        use Gtk.Tree_Store;
with Gtk.Tree_View;         use Gtk.Tree_View;
with Gtk.Tree_View_Column;  use Gtk.Tree_View_Column;
with Gtk.Widget;            use Gtk.Widget;
with Gtk.Window;            use Gtk.Window;

with Ada.Finalization;
with Gdk.Window;
with Glib;
with Glib.Object;
with Glib.Properties;
with Glib.Wrappers;
with Gtk.RC;

package Gtk.Missed is
   --
   -- GtkAda_Contributions_Domain -- The domain name used for the  error
   --                                log messages  coming  out  of  this
   --                                library.
   --
   GtkAda_Contributions_Domain : constant String := "GtkAda+";

   type Row_Order is (Before, Equal, After);

   type User_Directory is               -- The user's
        (  User_Directory_Desktop,      -- Desktop directory
           User_Directory_Documents,    -- Documents directory
           User_Directory_Download,     -- Downloads directory
           User_Directory_Music,        -- Music directory
           User_Directory_Pictures,     -- Pictures directory
           User_Directory_Public_Share, -- shared directory
           User_Directory_Templates,    -- Templates directory
           User_Directory_Videos        -- Movies directory
        );

   type GFileTest is new GUInt;
   File_Test_Is_Regular    : constant GFileTest := 2**0;
   File_Test_Is_Symlink    : constant GFileTest := 2**1;
   File_Test_Is_Dir        : constant GFileTest := 2**2;
   File_Test_Is_Executable : constant GFileTest := 2**3;
   File_Test_Exists        : constant GFileTest := 2**4;

   type GDir is new Glib.C_Proxy;

   procedure Add_Class_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             );

   procedure Add_Widget_Class_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             );

   procedure Add_Widget_Name_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             );
--
-- Build_Filename -- File base name
--
--    First_Element  - The prefix of a file name
--    Second_Element - The suffix of
--    Third_Element  - The suffix of the suffix
--    Fourth_Element - ...
--    Fifth_Element  - ...
--
-- This  function  creates  a  filename  from  two of elements using the
-- correct  separator  for  filenames.  On  Unix,  this function behaves
-- identically to g_build_path (G_DIR_SEPARATOR_S, first_element, ....).
-- On Windows, it takes into account that either  the  backslash  (\  or
-- slash (/) can be  used  as  separator  in  filenames,  but  otherwise
-- behaves as  on  Unix.  When  file  pathname  separators  need  to  be
-- inserted, the one that last previously  occurred  in  the  parameters
-- (reading from left to right) is used. No attempt is made to force the
-- resulting filename to be an absolute path. If the first element is  a
-- relative path, the result will be a relative path.
--
-- Returns :
--
--    The file name
--
   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String
            )  return UTF8_String;
   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String
            )  return UTF8_String;
   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String;
               Fourth_Element : UTF8_String
            )  return UTF8_String;
   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String;
               Fourth_Element : UTF8_String;
               Fifth_Element  : UTF8_String
            )  return UTF8_String;

   function Class_From_Type (Typ : GType) return GObject_Class;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Row_Order;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Row_Order;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Row_Order;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Row_Order;
--
-- Dir_Close -- Close directory opened by Dir_Open
--
--    Dir - To close
--
-- After  completion  Dir  is  set  to null. nothing happens when Dir is
-- null.
--
   procedure Dir_Close (Dir : in out GDir);
--
-- Dir_Open -- Open a directory to enumerate its entities
--
--    Path  - The directory path
--    Dir   - The result upon success
--    Error - If failed
--
-- When successful Error is set to null and Dir is  the  search  object.
-- Dir must be passed to Dir_Close when no  more  used.  Upon  an  error
-- Directory is null and Error is set according to the error. Error_Free
-- must be called on it.
--
   procedure Dir_Open
             (  Path  : UTF8_String;
                Dir   : out GDir;
                Error : out GError
             );
--
-- Dir_Read_Name -- Read directory
--
--    Dir - To read
--
-- Returns :
--
--    Name of the next directory entry
--
-- Exceptions :
--
--    End_Error - No more items in the directory
--
   function Dir_Read_Name (Dir : GDir) return UTF8_String;
--
-- Dir_Rewind -- Reset the directory
--
--    Dir - To rewind
--
-- This  procedure  resets  the  given  directory.  The  next  call   to
-- Dir_Read_Name will return the first entry again.
--
   procedure Dir_Rewind (Dir : GDir);
--
-- Erase -- Elements of the container
--
--    Container - The container
--
   procedure Erase (Container : access Gtk_Container_Record'Class);
--
-- File_Test -- Test file status
--
--    File_Name - The file name
--    Flags     - To test for
--
-- Returns :
--
--    True if any of the Flags is set
--
   function File_Test
            (  File_Name : UTF8_String;
               Flags     : GFileTest
            )  return Boolean;
--
-- File_Test -- Test file status
--
--    File_Name - The file name
--
-- This function provided for convenience it tests for status bits.
--
-- Returns :
--
--    Flags tested
--
   function File_Test (File_Name : UTF8_String) return GFileTest;
--
-- Find_Program_In_Path -- Find an executable program by name
--
--    Program - The program name
--
-- This function locates the  first  executable  named  Program  in  the
-- user's path.
--
-- Returns :
--
--    Absolute path of the program or else empty string
--
   function Find_Program_In_Path (Program : UTF8_String)
      return UTF8_String;
--
-- Is_In -- Elements of the container
--
--    Container - The container
--    Element   - Of the container
--
-- Returns :
--
--    True if the
--
   function Is_In
            (  Container : access Gtk_Container_Record'Class;
               Element   : access Gtk_Widget_Record'Class
            )  return Boolean;
--
-- Get_Application_Name -- Returns application name
--
-- Returns :
--
--    The application name in a human readable form
--
   function Get_Application_Name return UTF8_String;
--
-- Get_Current_Dir -- Returns current directory
--
-- Returns :
--
--    Current directory
--
   function Get_Current_Dir return UTF8_String;
--
-- Get_PRGName -- Returns program name
--
-- Returns :
--
--    The program name
--
   function Get_PRGName return UTF8_String;

   function Is_A (Derived, Ancestor : GType) return Boolean;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean;

   function Get_Background_Area
            (  Tree_View : access Gtk_Tree_View_Record'Class;
               Path      : Gtk_Tree_Path;
               Column    : Gtk_Tree_View_Column := null
            )  return Gdk_Rectangle;
--
-- Get_Basename -- File base name
--
--    File_Name - A file name
--
-- Gets the last component of the filename. If  file_name  ends  with  a
-- directory  separator  it gets the component before the last slash. If
-- file_name consists only of  directory  separators  (and  on  Windows,
-- possibly  a  drive  letter),  a  single  separator  is  returned.  If
-- file_name is empty, it gets ".".
--
-- Returns :
--
--    The base name
--
   function Get_Basename (File_Name : UTF8_String) return UTF8_String;
--
-- Get_Column -- Get column from a value
--
--   Value - A column value
--
-- This function can be  used  within  a  handler  to  obtain  a  column
-- parameter  from  GLib  value. The list of parameters is passed to the
-- handler as GValues. The function Nth is may  be  used  to  extract  a
-- parameter. The result is GValue to which Get_Column is then applied.
--
-- Returns :
--
--    The column
--
   function Get_Column (Value : GValue) return Gtk_Tree_View_Column;
--
-- Get_Column_No -- Get column number
--
--   Tree_View - A tree view widget
--   Column    - A column of
--
-- Returns :
--
--    The number of Column 0.. or else -1
--
   function Get_Column_No
            (  Tree_View : access Gtk_Tree_View_Record'Class;
               Column    : access Gtk_Tree_View_Column_Record'Class
            )  return GInt;
--
-- Get_Dirname -- File directory name
--
--    File_Name - A file name
--
-- Gets the directory components of a file name. If the file name has no
-- directory components "." is returned.
--
-- Returns :
--
--    The directory name
--
   function Get_Dirname (File_Name : UTF8_String) return UTF8_String;
--
-- Get_Root -- Of a file name
--
--    File_Name - A file name
--
-- This function returns the root component,of a name, i.e. the  "/"  in
-- UNIX or "C:\" under Windows.
--
-- Returns :
--
--    The file name's root component
--
-- Exceptions :
--
--    Use_Error - File_Name is not an absolute name
--
   function Get_Root (File_Name : UTF8_String) return UTF8_String;

   procedure Get_Size
             (  Window : access Gtk_Window_Record'Class;
                Width  : out Glib.Gint;
                Height : out Glib.Gint
             );
--
-- Get_Row_No -- Get row number
--
--   Tree_View   - A tree view model
--   Iter / Path - An iterator or path in the model
--
-- Returns :
--
--    The row number 0.. or else -1
--
   function Get_Row_No
            (  Model : access Gtk_Tree_Model_Record'Class;
               Path  : Gtk_Tree_Path
            )  return GInt;
   function Get_Row_No
            (  Model : access Gtk_Tree_Model_Record'Class;
               Iter  : Gtk_Tree_Iter
            )  return GInt;
--
-- GType_Icon -- Type of GIcon
--
   function GType_Icon return GType;
--
-- Get_User_Special_Dir -- Directories associated with the user
--
--    Directory - The directory
--
-- Returns :
--
--    The directory requested
--
   function Get_User_Special_Dir (Directory : User_Directory)
      return UTF8_String;

   procedure Get_Visible_Range
             (  Tree_View  : access Gtk_Tree_View_Record'Class;
                Start_Path : out Gtk_Tree_Path;
                End_Path   : out Gtk_Tree_Path
             );
--
-- Has_Tooltip -- Get has-tooltip property
--
--    Widget - The widget
--
-- Returns :
--
--    True if the property is true
--
   function Has_Tooltip
            (  Widget : access Gtk.Widget.Gtk_Widget_Record'Class
            )  return Boolean;
--
-- Is_Absolute -- File path check
--
--    File_Name - A file name
--
-- The  function returns true if the given File_Name is an absolute file
-- name, i.e. it contains a full path from the root  directory  such  as
-- "/usr/local" on UNIX or "C:\windows" on Windows systems.
--
-- Returns :
--
--    True if the name is absolute
--
   function Is_Absolute (File_Name : UTF8_String) return Boolean;

   function Keyval_To_Unicode (Key_Val : Gdk_Key_Type) return GUnichar;
--
-- Keyval_To_UTF8 -- Key to UTF8 conversion
--
--    Key_Val - A key value associated with an event
--
-- When Key_Val does not have a corresponding Unicode  character  it  is
-- treated as NUL (code position 0),
--
-- Retunrs :
--
--    The value UTF-8 encoded
--
   function Keyval_To_UTF8 (Key_Val : Gdk_Key_Type) return UTF8_String;
--
-- Remove -- Delete a file or a directory
--
--    File_Name - To delete
--
-- Exceptions :
--
--    Name_Error - File name does not specify an existing file
--    Use_Error  - The file cannot be deleted
--
   procedure Remove (File_Name : UTF8_String);
--
-- Rename -- Rename a file or a directory
--
--    Old_File_Name - To rename from
--    New_File_Name - To rename into
--
-- Exceptions :
--
--    Name_Error - Old_File_Name does not specify an existing file
--    Use_Error  - The file cannot be renamed
--
   procedure Rename (Old_File_Name, New_File_Name : UTF8_String);
--
-- RGB -- Color construction
--
--    Red, Green, Blue - Components of the color 0.0..1.0 (saturated)
--
-- Returns :
--
--    The coresponding color
--
   function RGB (Red, Green, Blue : GDouble) return Gdk_Color;

   procedure Set_Property
             (  Object : access Glib.Object.GObject_Record'Class;
                Name   : Glib.Properties.Property_Float;
                Value  : Glib.Gfloat
             );
--
-- Set_Has_Tooltip -- Set has-tooltip property
--
--    Widget      - The widget
--    Has_Tooltip - Property value
--
   procedure Set_Has_Tooltip
             (  Widget      : access Gtk.Widget.Gtk_Widget_Record'Class;
                Has_Tooltip : Boolean
             );
--
-- Set_Tip -- Remove tooltip
--
   procedure Set_Tip
             (  Tooltips : access Gtk_Tooltips_Record'Class;
                Widget   : access Gtk.Widget.Gtk_Widget_Record'Class
             );
--
-- Set -- Missing in 2.14.0, GLib.Value.Set_Object since 2.14.2
--
   procedure Set (Value : in out GValue; Object : GObject);
--
-- Skip_Root -- In a file name
--
--    File_Name - A file name
--
-- This function returns a File_Name part after the root component, i.e.
-- after the "/" in UNIX or "C:\" under Windows.
--
-- Returns :
--
--    The file name without root component
--
-- Exceptions :
--
--    Use_Error - File_Name is not an absolute name
--
   function Skip_Root (File_Name : UTF8_String) return UTF8_String;
--
-- Themed_Icon_New -- Create icon by name
--
--    Icon_Name - The icon name
--
-- Returns :
--
--    The icon or null
--
   function Themed_Icon_New (Icon_Name : UTF8_String) return GObject;
--
-- Themed_Icon_New_With_Default_Fallbacks -- Create icon by name
--
--    Icon_Name - The icon name
--
-- Returns :
--
--    The icon
--
   function Themed_Icon_New_With_Default_Fallbacks
            (  Icon_Name : UTF8_String
            )  return GObject;

   function Unicode_To_Keyval (WC : GUnichar) return Gdk_Key_Type;
--
-- Wait_Cursor -- Temporarily show wait cursor
--
--    Widget - To show wait cursor at
--
   type Wait_Cursor (Widget : access Gtk_Widget_Record'Class) is
      new Ada.Finalization.Limited_Controlled with private;
   procedure Finalize (Cursor : in out Wait_Cursor);
   procedure Initialize (Cursor : in out Wait_Cursor);
--
-- Gtk.Generic_Enum_Combo_Box styles:
--
--  Mixed_Case       - First letter of each word is capitalized
--  All_Caps         - All letters are capitalized
--  All_Small        - All letters are in lower case
--  Capitalize_First - The first letter is capitalized
--
   type Enum_Style_Type is
        (  Mixed_Case,
           All_Caps,
           All_Small,
           Capitalize_First
        );
   No_Selection : exception; -- Used in Gtk.Generic_Enum_Combo_Box

private
   pragma Inline (Is_A);
   pragma Import (C, Class_From_Type,   "gtk_type_class");
   pragma Import (C, Keyval_To_Unicode, "gdk_keyval_to_unicode");
   pragma Import (C, Unicode_To_Keyval, "gdk_unicode_to_keyval");
   pragma Import (C, Dir_Rewind,        "g_dir_rewind");
   pragma Import (C, GType_Icon,        "g_icon_get_type");
--
-- Search_Data -- To enumerate elements of a container
--
   type Search_Data is record
      Item  : Gtk_Widget;
      Found : Boolean;
   end record;
   type Search_Data_Ptr is access all Search_Data;

   package For_Test is new For_Pkg (Search_Data_Ptr);
   procedure Test
             (  Item : access Gtk_Widget_Record'Class;
                Data : in out Search_Data_Ptr
             );

   type Wait_Cursor (Widget : access Gtk_Widget_Record'Class) is
      new Ada.Finalization.Limited_Controlled with
   record
      Realized : Boolean;
      Window   : Gdk_Drawable;
   end record;

end Gtk.Missed;
