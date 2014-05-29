--                                                                    --
--  package Gtk.Missed              Copyright (c)  Maxim Reznik       --
--  Implementation                                 Summer, 2006       --
--                                                                    --
--                                 Last revision : 12:32 10 Jun 2003  --
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
with Ada.IO_Exceptions;     use Ada.IO_Exceptions;
with Gdk.Cursor;            use Gdk.Cursor;
with Gdk.Window;            use Gdk.Window;
with GLib.Unicode;          use GLib.Unicode;
with Gtk.Main;              use Gtk.Main;
with Gtk.Tree_Model;        use Gtk.Tree_Model;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;
with System;                use System;

with Gtk.Adjustment;
with Gtk.Widget;

package body Gtk.Missed is

   procedure G_Free (Border : Interfaces.C.Strings.Chars_Ptr);
   pragma Import (C, G_Free, "g_free");

   procedure Add_Class_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             )  is
      procedure Internal
                (  RC_Style : System.Address;
                   Pattern  : UTF8_String
                );
      pragma Import (C, Internal, "gtk_rc_add_class_style");
   begin
      Internal (Get_Object (Style), Pattern & ASCII.NUL);
   end Add_Class_Style;

   procedure Add_Widget_Class_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             )  is
      procedure Internal
                (  RC_Style : System.Address;
                   Pattern  : UTF8_String
                );
      pragma Import (C, Internal, "gtk_rc_add_widget_class_style");
   begin
      Internal (Get_Object (Style), Pattern & ASCII.NUL);
   end Add_Widget_Class_Style;

   procedure Add_Widget_Name_Style
             (  Style   : Gtk.RC.Gtk_RC_Style;
                Pattern : UTF8_String
             )  is
      procedure Internal
                (  RC_Style : System.Address;
                   Pattern  : UTF8_String
                );
      pragma Import (C, Internal, "gtk_rc_add_widget_name_style");
   begin
      Internal (Get_Object (Style), Pattern & ASCII.NUL);
   end Add_Widget_Name_Style;

   function Build_Filename (First_Element, Second_Element : UTF8_String)
      return UTF8_String is
      function Internal (Args : Chars_Ptr_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_build_filenamev");
      First  : aliased Char_Array := To_C (First_Element);
      Second : aliased Char_Array := To_C (Second_Element);
      Ptr    : Chars_Ptr :=
                  Internal
                  (  (  0 => To_Chars_Ptr (First'Unchecked_Access),
                        1 => To_Chars_Ptr (Second'Unchecked_Access),
                        2 => Null_Ptr
                  )  );
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Build_Filename;

   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String
            )  return UTF8_String is
      function Internal (Args : Chars_Ptr_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_build_filenamev");
      First  : aliased Char_Array := To_C (First_Element);
      Second : aliased Char_Array := To_C (Second_Element);
      Third  : aliased Char_Array := To_C (Third_Element);
      Ptr    : Chars_Ptr :=
                  Internal
                  (  (  0 => To_Chars_Ptr (First'Unchecked_Access),
                        1 => To_Chars_Ptr (Second'Unchecked_Access),
                        2 => To_Chars_Ptr (Third'Unchecked_Access),
                        3 => Null_Ptr
                  )  );
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Build_Filename;

   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String;
               Fourth_Element : UTF8_String
            )  return UTF8_String is
      function Internal (Args : Chars_Ptr_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_build_filenamev");
      First  : aliased Char_Array := To_C (First_Element);
      Second : aliased Char_Array := To_C (Second_Element);
      Third  : aliased Char_Array := To_C (Third_Element);
      Fourth : aliased Char_Array := To_C (Fourth_Element);
      Ptr    : Chars_Ptr :=
                  Internal
                  (  (  0 => To_Chars_Ptr (First'Unchecked_Access),
                        1 => To_Chars_Ptr (Second'Unchecked_Access),
                        2 => To_Chars_Ptr (Third'Unchecked_Access),
                        3 => To_Chars_Ptr (Fourth'Unchecked_Access),
                        4 => Null_Ptr
                  )  );
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Build_Filename;

   function Build_Filename
            (  First_Element  : UTF8_String;
               Second_Element : UTF8_String;
               Third_Element  : UTF8_String;
               Fourth_Element : UTF8_String;
               Fifth_Element  : UTF8_String
            )  return UTF8_String is
      function Internal (Args : Chars_Ptr_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_build_filenamev");
      First  : aliased Char_Array := To_C (First_Element);
      Second : aliased Char_Array := To_C (Second_Element);
      Third  : aliased Char_Array := To_C (Third_Element);
      Fourth : aliased Char_Array := To_C (Fourth_Element);
      Fifth  : aliased Char_Array := To_C (Fifth_Element);
      Ptr    : Chars_Ptr :=
                  Internal
                  (  (  0 => To_Chars_Ptr (First'Unchecked_Access),
                        1 => To_Chars_Ptr (Second'Unchecked_Access),
                        2 => To_Chars_Ptr (Third'Unchecked_Access),
                        3 => To_Chars_Ptr (Fourth'Unchecked_Access),
                        4 => To_Chars_Ptr (Fifth'Unchecked_Access),
                        5 => Null_Ptr
                  )  );
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Build_Filename;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Row_Order is
   begin
      if A = null then
         if B = null then
            return Equal;
         else
            return Before;
         end if;
      else
         if B = null then
            return After;
         else
            case Compare (A, B) is
               when GInt'First..-1 => return Before;
               when 0              => return Equal;
               when 1..GInt'Last   => return After;
            end case;
         end if;
      end if;
   end Compare;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Row_Order is
   begin
      if A = Null_Iter then
         if B = null then
            return Equal;
         else
            return Before;
         end if;
      else
         declare
            First  : Gtk_Tree_Path := Get_Path (Model, A);
            Result : Row_Order     := Compare (Model, First, B);
         begin
            Path_Free (First);
            return Result;
         end;
      end if;
   end Compare;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Row_Order is
   begin
      if B = Null_Iter then
         if A = null then
            return Equal;
         else
            return After;
         end if;
      else
         declare
            Second : Gtk_Tree_Path := Get_Path (Model, B);
            Result : Row_Order     := Compare (Model, A, Second);
         begin
            Path_Free (Second);
            return Result;
         end;
      end if;
   end Compare;

   function Compare
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Row_Order is
   begin
      if A = Null_Iter then
         if B = Null_Iter then
            return Equal;
         else
            return Before;
         end if;
      else
         if B = Null_Iter then
            return After;
         else
            declare
               First  : Gtk_Tree_Path := Get_Path (Model, A);
               Second : Gtk_Tree_Path := Get_Path (Model, B);
               Result : Row_Order     := Compare (Model, First, Second);
            begin
               Path_Free (First);
               Path_Free (Second);
               return Result;
            end;
         end if;
      end if;
   end Compare;

   procedure Dir_Close (Dir : in out GDir) is
      procedure Internal (Dir : GDir);
      pragma Import (C, Internal, "g_dir_close");
   begin
      if Dir /= null then
         Internal (Dir);
         Dir := null;
      end if;
   end Dir_Close;

   function G_Dir_Open
            (  Path  : Char_Array;
               Flags : GUInt;
               Error : access GError
            )  return GDir;
   pragma Import (C, G_Dir_Open, "g_dir_open_utf8");

   procedure Dir_Open
             (  Path  : UTF8_String;
                Dir   : out GDir;
                Error : out GError
             )  is
      Code : aliased GError;
   begin
      Dir := G_Dir_Open (To_C (Path), 0, Code'Access);
      if Dir = null then
         Error := Code;
      else
         Error := null;
      end if;
   end Dir_Open;

   function G_Dir_Read_Name (Dir : GDir) return Chars_Ptr;
   pragma Import (C, G_Dir_Read_Name, "g_dir_read_name_utf8");

   function Dir_Read_Name (Dir : GDir) return UTF8_String is
      Ptr : Chars_Ptr := G_Dir_Read_Name (Dir);
   begin
      if Ptr = Null_Ptr then
         raise End_Error;
      else
         return Value (Ptr);
      end if;
   end Dir_Read_Name;

   procedure Erase (Container : access Gtk_Container_Record'Class) is
      use Gtk.Widget.Widget_List;
      List : GList := Get_Children (Container);
      This : GList := First (List);
   begin
      while This /= Null_List loop
         Remove (Container, Get_Data (This));
         This := Next (This);
      end loop;
      Free (List);
   end Erase;

   function G_Find_Program_In_Path_UTF8 (Program : Char_Array)
      return Chars_Ptr;
   pragma Import
          (  C,
             G_Find_Program_In_Path_UTF8,
             "g_find_program_in_path_utf8"
          );

   function Find_Program_In_Path (Program : UTF8_String)
      return UTF8_String is
      Ptr : Chars_Ptr;
   begin
      Ptr := G_Find_Program_In_Path_UTF8 (To_C (Program));
      if Ptr = Null_Ptr then
         return "";
      else
         declare
            Result : constant UTF8_String := Value (Ptr);
         begin
            G_Free (Ptr);
            return Result;
         end;
      end if;
   end Find_Program_In_Path;

   function G_File_Test
            (  File_Name : Char_Array;
               Test      : GFileTest
            )  return GBoolean;
   pragma Import (C, G_File_Test, "g_file_test_utf8");

   function File_Test
            (  File_Name : UTF8_String;
               Flags     : GFileTest
            )  return Boolean is
   begin
      return 0 /= G_File_Test (To_C (File_Name), Flags);
   end File_Test;

   function File_Test (File_Name : UTF8_String) return GFileTest is
      Name : Char_Array := To_C (File_Name);
   begin
      if 0 = G_File_Test (Name, File_Test_Exists) then
         return 0;
      elsif 0 /= G_File_Test (Name, File_Test_Is_Dir) then
         return File_Test_Exists or File_Test_Is_Dir;
      elsif 0 /= G_File_Test (Name, File_Test_Is_Executable) then
         return File_Test_Exists or File_Test_Is_Executable;
      elsif 0 /= G_File_Test (Name, File_Test_Is_Symlink) then
         return File_Test_Exists or File_Test_Is_Symlink;
      else
         return File_Test_Exists or File_Test_Is_Regular;
      end if;
   end File_Test;

   Wait_Cursors_Count : Natural := 0;

   procedure Finalize (Cursor : in out Wait_Cursor) is
   begin
      if Cursor.Realized then
         Wait_Cursors_Count := Wait_Cursors_Count - 1;
         if Wait_Cursors_Count = 0 then
            Set_Cursor (Cursor.Window, null);
            Unref (Cursor.Window);
         end if;
      end if;
   end Finalize;

   function Get_Application_Name return UTF8_String is
      function Internal return Interfaces.C.Strings.Chars_Ptr;
      pragma Import (C, Internal, "g_get_application_name");
   begin
      return Interfaces.C.Strings.Value (Internal);
   end Get_Application_Name;

   function G_Get_Current_Dir_UTF8
      return Interfaces.C.Strings.Chars_Ptr;
   pragma Import (C, G_Get_Current_Dir_UTF8, "g_get_current_dir_utf8");

   function Get_Current_Dir return UTF8_String is
      Ptr : Chars_Ptr;
   begin
      Ptr := G_Get_Current_Dir_UTF8;
      declare
         Result : UTF8_String := Value (Ptr);
      begin
         G_Free (Ptr);
         return Result;
      end;
   end Get_Current_Dir;

   function Get_PRGName return UTF8_String is
      function Internal return Interfaces.C.Strings.Chars_Ptr;
      pragma Import (C, Internal, "g_get_prgname");
   begin
      return Interfaces.C.Strings.Value (Internal);
   end Get_PRGName;

   function Get_Background_Area
            (  Tree_View : access Gtk_Tree_View_Record'Class;
               Path      : Gtk_Tree_Path;
               Column    : Gtk_Tree_View_Column := null
            )  return Gdk_Rectangle is
      procedure Internal
                (  Tree_View : Address;
                   Path      : Gtk_Tree_Path;
                   Column    : Address;
                   Rect      : out Gdk_Rectangle
                );
      pragma Import (C, Internal, "gtk_tree_view_get_background_area");
      Result : Gdk_Rectangle;
   begin
      if Column = null then
         Internal
         (  Get_Object (Tree_View),
            Path,
            Null_Address,
            Result
         );
      else
         Internal
         (  Get_Object (Tree_View),
            Path,
            Get_Object (Column),
            Result
         );
      end if;
      return Result;
   end Get_Background_Area;

   function Get_Basename (File_Name : UTF8_String) return UTF8_String is
      function Internal (File_Name : Char_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_path_get_basename");
      Ptr    : Chars_Ptr   := Internal (To_C (File_Name));
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Get_Basename;

   function Get_Column (Value : GValue) return Gtk_Tree_View_Column is
      use System;
      Stub : Gtk_Tree_View_Column_Record;
      Data : Address := Get_Address (Value);
   begin
      if Data = Null_Address then
         return null;
      else
         return Gtk_Tree_View_Column (Get_User_Data_Fast (Data, Stub));
      end if;
   end Get_Column;

   function Get_Column_No
            (  Tree_View : access Gtk_Tree_View_Record'Class;
               Column    : access Gtk_Tree_View_Column_Record'Class
            )  return GInt is
      This : Gtk_Tree_View_Column;
      That : Address := Get_Object (Column);
   begin
      for Index in 0..GInt'Last loop
         This := Get_Column (Tree_View, Index);
         exit when This = null;
         if Get_Object (This) = That then
            return Index;
         end if;
      end loop;
      return -1;
   end Get_Column_No;

   function Get_Dirname (File_Name : UTF8_String) return UTF8_String is
      function Internal (File_Name : Char_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_path_get_dirname");
      Ptr    : Chars_Ptr   := Internal (To_C (File_Name));
      Result : UTF8_String := Value (Ptr);
   begin
      G_Free (Ptr);
      return Result;
   end Get_Dirname;

   ------------------
   -- Get_Position --
   ------------------
   procedure Get_Position
             (  Window : access Gtk_Window_Record'Class;
                Root_X : out Glib.Gint;
                Root_Y : out Glib.Gint
             )  is
      procedure Internal
                (  Window : Address;
                   X      : out Glib.Gint;
                   Y      : out Glib.Gint
                );
      pragma Import (C, Internal, "gtk_window_get_position");
   begin
      Internal (Get_Object (Window), Root_X, Root_Y);
   end Get_Position;

   function Get_Root (File_Name : UTF8_String) return UTF8_String is
      function Internal (File_Name : Char_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_path_skip_root");
      Name : Char_Array := To_C (File_Name);
      Ptr  : Chars_Ptr  := Internal (Name);
   begin
      if Ptr = Null_Ptr then
         raise Use_Error;
      else
         declare
            Length : constant Size_T := strlen (Ptr);
         begin
            if Length > 0 then
               Name (Name'Last - Length) := NUL;
               return To_Ada (Name);
            else
               return File_Name;
            end if;
         end;
      end if;
   end Get_Root;

   function Get_Row_No
            (  Model : access Gtk_Tree_Model_Record'Class;
               Path  : Gtk_Tree_Path
            )  return GInt is
   begin
      if Path = null then
         return -1;
      else
         declare
            Indices : GInt_Array renames Get_Indices (Path);
         begin
            if Indices'Length > 0 then
               return Indices (Indices'Last);
            else
               return -1;
            end if;
         end;
      end if;
   end Get_Row_No;

   function Get_Row_No
            (  Model : access Gtk_Tree_Model_Record'Class;
               Iter  : Gtk_Tree_Iter
            )  return GInt is
      Path : Gtk_Tree_Path := Get_Path (Model, Iter);
   begin
      if Path = null then
         return -1;
      else
         declare
            Indices : GInt_Array renames Get_Indices (Path);
            Result  : GInt;
         begin
            if Indices'Length > 0 then
               Result := Indices (Indices'Last);
            else
               Result := -1;
            end if;
            Path_Free (Path);
            return Result;
         end;
      end if;
   end Get_Row_No;

   function Get_User_Special_Dir (Directory : User_Directory)
      return UTF8_String is
      function Internal (Directory : Int) return Chars_Ptr;
      pragma Import (C, Internal, "g_get_user_special_dir");
   begin
      return Value (Internal (User_Directory'Pos (Directory)));
   end Get_User_Special_Dir;

   procedure Get_Visible_Range
             (  Tree_View  : access Gtk_Tree_View_Record'Class;
                Start_Path : out Gtk_Tree_Path;
                End_Path   : out Gtk_Tree_Path
             )  is
      function Internal
               (  Tree_View : Address;
                  From_Path : access Gtk_Tree_Path;
                  To_Path   : access Gtk_Tree_Path
               )  return GBoolean;
      pragma Import (C, Internal, "gtk_tree_view_get_visible_range");
      From_Path : aliased Gtk_Tree_Path;
      To_Path   : aliased Gtk_Tree_Path;
   begin
      if (  not Gtk.Widget.Realized_Is_Set (Tree_View)
         or else
            (  0
            /= Internal
               (  Get_Object (Tree_View),
                  From_Path'Access,
                  To_Path'Access
         )  )  )
      then
         Start_Path := From_Path;
         End_Path   := To_Path;
      else
         Start_Path := null;
         End_Path   := null;
      end if;
   end Get_Visible_Range;

   --------------
   -- Get_Size --
   --------------
   procedure Get_Size
     (Window : access Gtk_Window_Record'Class;
      Width  :    out Glib.Gint;
      Height :    out Glib.Gint)
   is
      procedure Internal
        (Window : Address;
         X      : out Glib.Gint;
         Y      : out Glib.Gint);

      pragma Import (C, Internal, "gtk_window_get_size");
   begin
      Internal (Get_Object (Window), Width, Height);
   end Get_Size;

   function Has_Tooltip
            (  Widget : access Gtk.Widget.Gtk_Widget_Record'Class
            )  return Boolean is
      function Internal (Widget : Address) return GBoolean;
      pragma Import (C, Internal, "gtk_widget_get_has_tooltip");
   begin
      return Internal (Get_Object (Widget)) /= 0;
   end Has_Tooltip;

   procedure Initialize (Cursor : in out Wait_Cursor) is
      Clock  : Gdk_Cursor;
      Active : Boolean;
   begin
      Cursor.Realized := Realized_Is_Set (Cursor.Widget);
      if Cursor.Realized then
         if Wait_Cursors_Count = 0 then
            Cursor.Window := Get_Window (Cursor.Widget);
            Ref (Cursor.Window);
            Gdk_New (Clock, Watch);
            Set_Cursor (Cursor.Window, Clock);
            Unref (Clock);
            while Events_Pending loop -- Pump the events queue
               Active := Main_Iteration;
            end loop;
         end if;
         Wait_Cursors_Count := Wait_Cursors_Count + 1;
      end if;
   end Initialize;

   function Is_A (Derived, Ancestor : GType) return Boolean is
      function Internal (Derived, Ancestor : GType) return GBoolean;
      pragma Import (C, Internal, "g_type_is_a");
   begin
      return Internal (Derived, Ancestor) /= 0;
   end Is_A;

   function Is_In
            (  Container : access Gtk_Container_Record'Class;
               Element   : access Gtk_Widget_Record'Class
            )  return Boolean is
      Data : aliased Search_Data :=
                (Element.all'Unchecked_Access, False);
   begin
      For_Test.Foreach
      (  Gtk_Container_Record (Container.all)'Unchecked_Access,
         Test'Access,
         Data'Unchecked_Access
      );
      return Data.Found;
   end Is_In;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if A = null then
         return False;
      elsif B = null then
         return True;
      else
         return Is_Descendant (A, B);
      end if;
   end Is_In;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if A = Null_Iter then
         return False;
      elsif B = Null_Iter then
         return True;
      else
         declare
            First  : Gtk_Tree_Path := Get_Path (Model, A);
            Second : Gtk_Tree_Path := Get_Path (Model, B);
            Result : Boolean := Is_Descendant (First, Second);
         begin
            Path_Free (First);
            Path_Free (Second);
            return Result;
         end;
      end if;
   end Is_In;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if A = Null_Iter then
         return False;
      elsif B = null then
         return True;
      else
         declare
            First  : Gtk_Tree_Path := Get_Path (Model, A);
            Result : Boolean := Is_Descendant (First, B);
         begin
            Path_Free (First);
            return Result;
         end;
      end if;
   end Is_In;

   function Is_In
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if A = null then
         return False;
      elsif B = Null_Iter then
         return True;
      else
         declare
            Second : Gtk_Tree_Path := Get_Path (Model, B);
            Result : Boolean := Is_Descendant (A, Second);
         begin
            Path_Free (Second);
            return Result;
         end;
      end if;
   end Is_In;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if B = null then
         return False;
      elsif A = null then
         return Get_Indices (B)'Length = 1;
      end if;
      declare
         A_Indices : GInt_Array renames Get_Indices (A);
         B_Indices : GInt_Array renames Get_Indices (B);
      begin
         return
         (  A_Indices'Length + 1 = B_Indices'Length
         and then
            (  A_Indices'Length = 0
            or else
               (  A_Indices
               =  B_Indices (B_Indices'First..B_Indices'Last - 1)
         )  )  );
      end;
   end Is_Parent;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if B = null then
         return False;
      elsif A = Null_Iter then
         return Get_Indices (B)'Length = 1;
      end if;
      declare
         A_Path : Gtk_Tree_Path := Get_Path (Model, A);
         Result : Boolean := Is_Parent (Model, A_Path, B);
      begin
         Path_Free (A_Path);
         return Result;
      end;
   end Is_Parent;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if B = Null_Iter then
         return False;
      elsif A = null then
         return Parent (Model, B) = Null_Iter;
      end if;
      declare
         B_Path : Gtk_Tree_Path := Get_Path (Model, B);
         Result : Boolean := Is_Parent (Model, A, B_Path);
      begin
         Path_Free (B_Path);
         return Result;
      end;
   end Is_Parent;

   function Is_Parent
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if B = Null_Iter then
         return False;
      elsif A = Null_Iter then
         return True;
      else
         return Parent (Model, B) = A;
      end if;
   end Is_Parent;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if B = null then
         return A = null;
      elsif A = null then
         return False;
      end if;
      declare
         A_Indices : GInt_Array renames Get_Indices (A);
         B_Indices : GInt_Array renames Get_Indices (B);
      begin
         return
         (  A_Indices'Length = B_Indices'Length
         and then
            (  A_Indices'Length < 2
            or else
               (  A_Indices (A_Indices'First..A_Indices'Last - 1)
               =  B_Indices (B_Indices'First..B_Indices'Last - 1)
         )  )  );
      end;
   end Is_Sibling;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Path
            )  return Boolean is
   begin
      if B = null then
         return A = Null_Iter;
      elsif A = Null_Iter then
         return False;
      end if;
      declare
         A_Path : Gtk_Tree_Path := Get_Path (Model, A);
         Result : Boolean := Is_Sibling (Model, A_Path, B);
      begin
         Path_Free (A_Path);
         return Result;
      end;
   end Is_Sibling;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Path;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if B = Null_Iter then
         return A = null;
      elsif A = null then
         return False;
      end if;
      declare
         B_Path : Gtk_Tree_Path := Get_Path (Model, B);
         Result : Boolean := Is_Sibling (Model, A, B_Path);
      begin
         Path_Free (B_Path);
         return Result;
      end;
   end Is_Sibling;

   function Is_Sibling
            (  Model : access Gtk_Tree_Model_Record'Class;
               A     : Gtk_Tree_Iter;
               B     : Gtk_Tree_Iter
            )  return Boolean is
   begin
      if B = Null_Iter then
         return A = Null_Iter;
      elsif A = Null_Iter then
         return False;
      else
         return Parent (Model, B) = Parent (Model, A);
      end if;
   end Is_Sibling;

   function Keyval_To_UTF8 (Key_Val : Gdk.Types.Gdk_Key_Type)
      return UTF8_String is
      Result : UTF8_String (1..8);
      Last   : Natural;
   begin
      Unichar_To_UTF8 (Keyval_To_Unicode (Key_Val), Result, Last);
      return Result (1..Last);
   end Keyval_To_UTF8;

   function Is_Absolute (File_Name : UTF8_String) return Boolean is
      function Internal (File_Name : Char_Array) return GBoolean;
      pragma Import (C, Internal, "g_path_is_absolute");
   begin
      return Internal (To_C (File_Name)) /= 0;
   end Is_Absolute;

   procedure Remove (File_Name : UTF8_String) is
      function Internal (File_Name : Char_Array) return Int;
      pragma Import (C, Internal, "g_remove");
   begin
      if 0 /= Internal (To_C (File_Name)) then
         if File_Test (File_Name, File_Test_Exists) then
            Raise_Exception
            (  Use_Error'Identity,
               "File cannot be deleted"
            );
         end if;
      end if;
   end Remove;

   procedure Rename (Old_File_Name, New_File_Name : UTF8_String) is
      function Internal (Old_File_Name, New_File_Name : Char_Array)
         return Int;
      pragma Import (C, Internal, "g_rename");
   begin
      if 0 /= Internal (To_C (Old_File_Name), To_C (New_File_Name)) then
         if File_Test (Old_File_Name, File_Test_Exists) then
            Raise_Exception
            (  Use_Error'Identity,
               "File cannot be renamed"
            );
         else
            Raise_Exception
            (  Name_Error'Identity,
               "File does not exist"
            );
         end if;
      end if;
   end Rename;

   function RGB (Red, Green, Blue : GDouble) return Gdk_Color is
      Result  : Gdk_Color;
      function "+" (Value : GDouble) return GUInt16 is
      begin
         if Value < 0.0 then
            return 0;
         elsif Value > 1.0 then
            return GUInt16'Last;
         else
            return GUInt16 (Value * GDouble (GUInt16'Last));
         end if;
      end "+";
   begin
      Set_RGB (Result, +Red, +Green, +Blue);
      return Result;
   end RGB;

   procedure Set (Value : in out GValue; Object : GObject) is
      procedure Internal (Value : in out GValue; Object : Address);
      pragma Import (C, Internal, "g_value_set_object");
   begin
      Internal (Value, Convert (Object));
   end Set;

   procedure Set_Has_Tooltip
             (  Widget      : access Gtk.Widget.Gtk_Widget_Record'Class;
                Has_Tooltip : Boolean
             )  is
      procedure Internal
                (  Widget      : Address;
                   Has_Tooltip : GBoolean
                );
      pragma Import (C, Internal, "gtk_widget_set_has_tooltip");
   begin
      if Has_Tooltip then
         Internal (Get_Object (Widget), 0);
      else
         Internal (Get_Object (Widget), 1);
      end if;
   end Set_Has_Tooltip;

   ------------------
   -- Set_Property --
   ------------------

   procedure Set_Property
             (  Object : access Glib.Object.GObject_Record'Class;
                Name   : Glib.Properties.Property_Float;
                Value  : Glib.Gfloat
             )  is
      use Glib.Values;

      procedure Internal
        (Object : in     Address;
         Name   : in     Glib.Property;
         Value  : in out GValue);
      pragma Import (C, Internal, "g_object_set_property");

      Val : GValue;
   begin
      Init (Val, Glib.GType_Float);
      Set_Float (Val, Value);
      Internal
      (  Glib.Object.Get_Object (Object),
         Glib.Property (Name),
         Val
      );
   end Set_Property;

   procedure Set_Tip
             (  Tooltips : access Gtk_Tooltips_Record'Class;
                Widget   : access Gtk.Widget.Gtk_Widget_Record'Class
             )  is
      procedure Internal
                (  Tooltips    : System.Address;
                   Widget      : System.Address;
                   Tip_Text    : System.Address := Null_Address;
                   Tip_Private : System.Address := Null_Address
                );
      pragma Import (C, Internal, "gtk_tooltips_set_tip");
   begin
      Internal (Get_Object (Tooltips), Get_Object (Widget));
   end Set_Tip;

   function Skip_Root (File_Name : UTF8_String) return UTF8_String is
      function Internal (File_Name : Char_Array) return Chars_Ptr;
      pragma Import (C, Internal, "g_path_skip_root");
      Name : Char_Array := To_C (File_Name);
      Ptr  : Chars_Ptr  := Internal (Name);
   begin
      if Ptr = Null_Ptr then
         raise Use_Error;
      else
         return Value (Ptr);
      end if;
   end Skip_Root;

   function Themed_Icon_New (Icon_Name : UTF8_String) return GObject is
      function Internal (Name : Char_Array) return Address;
      pragma Import (C, Internal, "g_themed_icon_new");
   begin
      return Convert (Internal (To_C (Icon_Name)));
   end Themed_Icon_New;

   function Themed_Icon_New_With_Default_Fallbacks
            (  Icon_Name : UTF8_String
            )  return GObject is
      function Internal (Name : Char_Array) return Address;
      pragma Import
             (  C,
                Internal,
                "g_themed_icon_new_with_default_fallbacks"
             );
   begin
      return Convert (Internal (To_C (Icon_Name)));
   end Themed_Icon_New_With_Default_Fallbacks;

   procedure Test
             (  Item : access Gtk_Widget_Record'Class;
                Data : in out Search_Data_Ptr
             )  is
   begin
      if Data.Item = Item.all'Access then
         Data.Found := True;
      end if;
   end Test;

end Gtk.Missed;