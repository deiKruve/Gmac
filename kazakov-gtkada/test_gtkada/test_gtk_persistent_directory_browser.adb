--                                                                    --
--  procedure                       Copyright (c)  Dmitry A. Kazakov  --
--     Test_Gtk_Persistent_Directory_Browser       Luebeck            --
--  Test for                                       Winter, 2008       --
--                                                                    --
--                                Last revision :  18:56 10 Feb 2008  --
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
--  This test uses Simple Components and GNADE ODBC bindings.
--
with Ada.Characters.Latin_1;  use Ada.Characters.Latin_1;
with Ada.Exceptions;          use Ada.Exceptions;
with Ada.Strings.Unbounded;   use Ada.Strings.Unbounded;
with Gdk.Event;               use Gdk.Event;
with GLib;                    use GLib;
with GLib.Messages;           use GLib.Messages;
with GLib.Values;             use GLib.Values;
with GtkAda.Dialogs;          use GtkAda.Dialogs;
with Gtk.Abstract_Browser;    use Gtk.Abstract_Browser;
with Gtk.Enums;               use Gtk.Enums;
with Gtk.GEntry;              use Gtk.GEntry;
with Gtk.Box;                 use Gtk.Box;
with Gtk.Radio_Button;        use Gtk.Radio_Button;
with Gtk.Image_Button;        use Gtk.Image_Button;
with Gtk.Label;               use Gtk.Label;
with Gtk.Main.Router;         use Gtk.Main.Router;
with Gtk.Paned;               use Gtk.Paned;
with Gtk.Stock;               use Gtk.Stock;
with Gtk.Window;              use Gtk.Window;
with Gtk.Widget;              use Gtk.Widget;
with Gtk.Text_Iter;           use Gtk.Text_Iter;
with Gtk.Tree_Model;          use Gtk.Tree_Model;
with Persistent.Handle;       use Persistent.Handle;

with Gtk.Handlers;
with Gtk.Main.Router;
with Gtk.RC;
with Gtk.Persistent_Storage_Credentials_Dialog.ODBC;

with Gtk.Persistent_Storage_Browser;
use  Gtk.Persistent_Storage_Browser;
--
-- Remove the following line if you do not use the GNAT Ada compiler.
--
with Gtk.Main.Router.GNAT_Stack;

procedure Test_Gtk_Persistent_Directory_Browser is
   --
   -- All data are global, for the sake of  simplicity.  Otherwise,  the
   -- test were impossible to keep in  just  one  body  due  to  Ada  95
   -- restriction on controlled types.
   --
   Window  : Gtk_Window;
   Browser : Gtk_Persistent_Storage_Browser;
   Errors  : Gtk_Label;
   Selection_Mode : array (Gtk_Selection_Mode) of Gtk_Radio_Button;

   -- Standard GTK stuff
   package Handlers is new Gtk.Handlers.Callback (Gtk_Widget_Record);

   package Return_Handlers is
      new Gtk.Handlers.Return_Callback
          (  Widget_Type => Gtk_Widget_Record,
             Return_Type => Boolean
          );
   function Delete_Event
            (  Widget : access Gtk_Widget_Record'Class;
               Event  : Gdk_Event
            )  return Boolean is
   begin
      return False;
   end Delete_Event;
   -- Destroy handler is standard for GTK.
   procedure Destroy (Widget : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end Destroy;

   procedure Add (Widget : access Gtk_Widget_Record'Class) is
      Storage : Storage_Handle;
   begin
      Add_Storage (Get_Cache (Browser), Storage);
   end Add;

   procedure Refreshed (Widget : access Gtk_Widget_Record'Class) is
   begin
      Changed
      (  Get_Cache (Browser),
         Get_Current_Directory (Get_Tree_View (Browser))
      );
   end Refreshed;

   procedure Deleted (Widget : access Gtk_Widget_Record'Class) is
   begin
      if Get_Selection_Size (Get_Items_View (Browser)) = 0 then
         -- Deleting entire directory
         declare
            Name : Item_Path renames
                      Get_Current_Directory (Get_Tree_View (Browser));
         begin
            case Message_Dialog
                 (  "Do you want to delete directory " & String (Name),
                    Confirmation,
                    Button_OK or Button_Cancel,
                    Button_Cancel
                 )  is
               when Button_OK =>
                  Delete (Get_Cache (Browser), Name);
               when others =>
                  null;
            end case;
         exception
            when Error : others =>
               Say
               (  "Cannot delete "
               &  String (Name)
               &  ". "
               &  Exception_Message (Error)
               );
         end;
      else
         -- Deleting files
         declare
            Selected : constant Selection :=
                          Get_Selection (Get_Items_View (Browser));
            List : Unbounded_String;
         begin
            for Index in Selected'Range loop
               if Index /= 1 then
                  Append (List, ", ");
               end if;
               Append
               (  List,
                  String
                  (  Get_Name
                     (  Get_Items_View (Browser),
                        Selected (Index)
               )  )  );
            end loop;
            case Message_Dialog
                 (  (  "Do you want to delete "
                    &  To_String (List)
                    &  " from "
                    &  String (Get_Directory (Get_Items_View (Browser)))
                    ),
                    Confirmation,
                    Button_OK or Button_Cancel,
                    Button_Cancel
                 )  is
               when Button_OK =>
                  for Index in reverse Selected'Range loop
                     Delete
                     (  Get_Cache (Browser),
                        Get_Path
                        (  Get_Items_View (Browser),
                           Selected (Index)
                     )  );
                  end loop;
               when others =>
                   null;
            end case;
         exception
            when Error : others =>
               Say
               (  "Cannot delete some of the files. "
               &  Exception_Message (Error)
               );
         end;
      end if;
   end Deleted;

   procedure Selection_Mode_Set
             (  Widget : access Gtk_Widget_Record'Class
             )  is
   begin
      for Index in Selection_Mode'Range loop
         if Get_Active (Selection_Mode (Index)) then
            Set_Selection_Mode (Get_Items_View (Browser), Index);
            return;
         end if;
      end loop;
   end Selection_Mode_Set;

   function Mode_Label (Mode : Gtk_Selection_Mode) return String is
   begin
      case Mode is
         when Selection_None     => return "None";
         when Selection_Single   => return "Single";
         when Selection_Browse   => return "Browse";
         when Selection_Multiple => return "Multiple";
      end case;
   end Mode_Label;

   -- Handler for error messages from the tree store
   package Error_Handlers is
      new Gtk.Handlers.Callback (Gtk_Tree_Model_Record);

   procedure Error
             (  Store  : access Gtk_Tree_Model_Record'Class;
                Params : GValues
             )  is
      Text   : String  := Get_String (Nth (Params, 1));
      Where  : String  := Get_String (Nth (Params, 2));
   begin
      Set_Text (Errors, Text & " (while reading '" & Where & "')");
   end Error;

begin
   Gtk.Main.Init;
   Gtk.Main.Router.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test columned store");
   Return_Handlers.Connect
   (  Window,
      "delete_event",
      Return_Handlers.To_Marshaller (Delete_Event'Access)
   );
   Handlers.Connect
   (  Window,
      "destroy",
      Handlers.To_Marshaller (Destroy'Access)
   );
   --
   -- The following lines are meant for debugging under GNAT. They cause
   -- stack  tracing upon errors in the libraries specified. Remove them
   -- if you are using another compiler.
   --
   Gtk.Main.Router.GNAT_Stack.Set_Log_Trace ("Gtk");
   Gtk.Main.Router.GNAT_Stack.Set_Log_Trace ("GLib-GObject");
   Gtk.Main.Router.GNAT_Stack.Set_Log_Trace ("GtkAda+");

   declare
      Box     : Gtk_VBox;
      Buttons : Gtk_HBox;
      Button  : Gtk_Image_Button;
   begin
      Gtk_New_VBox (Box);
      -- Buttons
      Gtk_New_HBox (Buttons);

      Gtk_New (Button, Stock_Refresh, Icon_Size_Small_Toolbar);
      Handlers.Connect
      (  Button,
         "clicked",
         Handlers.To_Marshaller (Refreshed'Access)
      );
      Pack_Start (Buttons, Button, False, False);

      Gtk_New (Button, Stock_New, Icon_Size_Small_Toolbar);
      Handlers.Connect
      (  Button,
         "clicked",
         Handlers.To_Marshaller (Add'Access)
      );
      Pack_Start (Buttons, Button, False, False);

      Gtk_New (Button, Stock_Delete, Icon_Size_Small_Toolbar);
      Handlers.Connect
      (  Button,
         "clicked",
         Handlers.To_Marshaller (Deleted'Access)
      );
      Pack_Start (Buttons, Button, False, False);
      -- Radio buttons
      for Index in Selection_Mode'Range loop
         if Index = Gtk_Selection_Mode'First then
            Gtk_New
            (  Selection_Mode (Index),
               Label => Mode_Label (Index)
            );
         else
            Gtk_New
            (  Selection_Mode (Index),
               Get_Group (Selection_Mode (Gtk_Selection_Mode'First)),
               Mode_Label (Index)
            );
         end if;
         Pack_Start (Buttons, Selection_Mode (Index), False, False);
      end loop;
      Set_Active (Selection_Mode (Selection_Multiple), True);
      for Index in Selection_Mode'Range loop
         Handlers.Connect
         (  Selection_Mode (Index),
            "clicked",
            Handlers.To_Marshaller (Selection_Mode_Set'Access)
         );
      end loop;

      -- Packing buttons
      Pack_Start (Box, Buttons, False, False);
      -- Browser
      Gtk_New
      (  Browser,
         Gtk.Persistent_Storage_Credentials_Dialog.ODBC.Create
      );
      Set_Editable (Get_Items_View (Browser), True);
      Set_Editable (Get_Tree_View (Browser), True);
      Pack_Start (Box, Browser);
      -- Messages
      Gtk_New (Errors);
      Set_Justify (Errors, Justify_Left);
      Set_Alignment (Errors, 0.0, 0.5);
      Pack_Start (Box, Errors, False, False);

      Error_Handlers.Connect
      (  Get_Cache (Browser),
         "rewind-error",
         Error'Access
      );
      Error_Handlers.Connect
      (  Get_Cache (Browser),
         "read-error",
         Error'Access
      );

      Add (Window, Box);
      Show_All (Box);
   end;
   Show (Window);

   Gtk.Main.Main;
end Test_Gtk_Persistent_Directory_Browser;
