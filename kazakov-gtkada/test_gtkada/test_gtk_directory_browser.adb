--                                                                    --
--  procedure                       Copyright (c)  Dmitry A. Kazakov  --
--     Test_Gtk_Directory_Browser                  Luebeck            --
--  Test for                                       Autumn, 2007       --
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
--  This  test  uses  Ada.Directories,  so it requires Ada 2005. It also
--  requires Strings_Edit for wildcard matching.
--
with Ada.Exceptions;            use Ada.Exceptions;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Gdk.Event;                 use Gdk.Event;
with GIO.Drive;                 use GIO.Drive;
with GIO.Mount;                 use GIO.Mount;
with GIO.Volume;                use GIO.Volume;
with GIO.Volume_Monitor;        use GIO.Volume_Monitor;
with GLib;                      use GLib;
with Glib.Object;               use Glib.Object;
with GLib.Values;               use GLib.Values;
with GtkAda.Dialogs;            use GtkAda.Dialogs;
with Gtk.Abstract_Browser;      use Gtk.Abstract_Browser;
with Gtk.Cell_Renderer_Pixbuf;  use Gtk.Cell_Renderer_Pixbuf;
with Gtk.Cell_Renderer_Text;    use Gtk.Cell_Renderer_Text;
with Gtk.Directory_Browser;     use Gtk.Directory_Browser;
with Gtk.Enums;                 use Gtk.Enums;
with Gtk.Frame;                 use Gtk.Frame;
with Gtk.GEntry;                use Gtk.GEntry;
with Gtk.Box;                   use Gtk.Box;
with Gtk.Radio_Button;          use Gtk.Radio_Button;
with Gtk.Image_Button;          use Gtk.Image_Button;
with Gtk.Label;                 use Gtk.Label;
with Gtk.Main.Router;           use Gtk.Main.Router;
with Gtk.Missed;                use Gtk.Missed;
with Gtk.Paned;                 use Gtk.Paned;
with Gtk.Separator;             use Gtk.Separator;
with Gtk.Stock;                 use Gtk.Stock;
with Gtk.Tree_Store;            use Gtk.Tree_Store;
with Gtk.Tree_View;             use Gtk.Tree_View;
with Gtk.Tree_View_Column;      use Gtk.Tree_View_Column;
with Gtk.Window;                use Gtk.Window;
with Gtk.Widget;                use Gtk.Widget;
with Gtk.Tree_Model;            use Gtk.Tree_Model;

with Gtk.Handlers;
with Gtk.Main.Router;
with Gtk.RC;

with Gtk.Wildcard_Directory_Browser;
use  Gtk.Wildcard_Directory_Browser;
--
-- Remove the following line if you do not use the GNAT Ada compiler.
--
with Gtk.Main.Router.GNAT_Stack;

procedure Test_Gtk_Directory_Browser is
   --
   -- All data are global, for the sake of  simplicity.  Otherwise,  the
   -- test were impossible to keep in  just  one  body  due  to  Ada  95
   -- restriction on controlled types.
   --
   Window  : Gtk_Window;
   Pattern : Gtk_Entry;
   Browser : Gtk_Wildcard_Directory_Browser;
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

   procedure Destroy (Widget : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end Destroy;

   procedure Refreshed (Widget : access Gtk_Widget_Record'Class) is
   begin
      Changed
      (  Get_Cache (Browser),
         Get_Current_Directory (Get_Tree_View (Browser))
      );
   end Refreshed;

   procedure Deleted (Widget : access Gtk_Widget_Record'Class) is
   begin
      if Get_Selection_Size (Get_Files_View (Browser)) = 0 then
         -- Deleting entire directory
         declare
            Name : constant String :=
                      String
                      (  Get_Current_Directory (Get_Tree_View (Browser))
                      );
         begin
            case Message_Dialog
                 (  "Do you want to delete directory " & Name,
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
               &  Name
               &  ". "
               &  Exception_Message (Error)
               );
         end;
      else
         -- Deleting files
         declare
            Selected : constant Selection :=
                          Get_Selection (Get_Files_View (Browser));
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
                     (  Get_Files_View (Browser),
                        Selected (Index)
               )  )  );
            end loop;
            case Message_Dialog
                 (  (  "Do you want to delete "
                    &  To_String (List)
                    &  " from "
                    &  String (Get_Directory (Get_Files_View (Browser)))
                    ),
                    Confirmation,
                    Button_OK or Button_Cancel,
                    Button_Cancel
                 )  is
               when Button_OK =>
                  for Index in reverse Selected'Range loop
                     Delete
                     (  Get_Cache (Browser),
                        String
                        (  Get_Path
                           (  Get_Files_View (Browser),
                              Selected (Index)
                     )  )  );
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

   procedure Filter_Changed
             (  Widget : access Gtk_Widget_Record'Class
             )  is
   begin
      Set_Pattern (Browser, Get_Text (Pattern));
   end Filter_Changed;

   procedure Selection_Mode_Set
             (  Widget : access Gtk_Widget_Record'Class
             )  is
   begin
      for Index in Selection_Mode'Range loop
         if Get_Active (Selection_Mode (Index)) then
            Set_Selection_Mode (Get_Files_View (Browser), Index);
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

   function Get_Drives return Gtk_Frame is
      use type Drive_List.Glist;
      use type Volume_List.Glist;
      Frame   : Gtk_Frame;
      View    : Gtk_Tree_View;
      List    : Gtk_Tree_Store;
      Row     : Gtk_Tree_Iter;
      Monitor : GVolume_Monitor  := Get;
      Drives  : Drive_List.Glist := Get_Connected_Drives (Monitor);
   begin
      Gtk_New (Frame);
      Set_Shadow_Type (Frame, Shadow_In);
      Gtk_New (List, (GType_Icon, GType_String));
      declare
         Item  : Drive_List.Glist := Drive_List.First (Drives);
         Icon  : GObject;
         Drive : GDrive;
         Value : GValue;
      begin
         Init (Value, GType_Icon);
         while Item /= Drive_List.Null_List loop
            Drive := Drive_List.Get_Data (Item);
            Append (List, Row, Null_Iter);
            Icon := Get_Icon (Drive);
            if Icon /= null then
               Set (Value, Icon);
               Unref (Icon);
            end if;
            Set_Value (List, Row, 0, Value);
            Set (List, Row, 1, Get_Name (Drive));
            declare
               Parent  : Gtk_Tree_Iter := Row;
               Volume  : GVolume;
               Volumes : Volume_List.Glist := Get_Volumes (Drive);
               Item    : Volume_List.Glist :=
                         Volume_List.First (Volumes);
            begin
               while Item /= Volume_List.Null_List loop
                  Volume := Volume_List.Get_Data (Item);
                  Append (List, Row, Parent);
                  Icon := Get_Icon (Volume);
                  if Icon /= null then
                     Set (Value, Icon);
                     Unref (Icon);
                  end if;
                  Set_Value (List, Row, 0, Value);
                  Set (List, Row, 1, Get_Name (Volume));
                  Unref (Volume);
               end loop;
               Volume_List.Free (Volumes);
            end;
            Unref (Drive);
            Item := Drive_List.Next (Item);
         end loop;
         Drive_List.Free (Drives);
         Unset (Value);
      end;
      Gtk_New (View);
      declare
         Column        : Gtk_Tree_View_Column;
         Column_No     : GInt;
         Name_Renderer : Gtk_Cell_Renderer_Text;
         Icon_Renderer : Gtk_Cell_Renderer_Pixbuf;
      begin
         Gtk_New (Column);
         Set_Title (Column, "Drive/volume");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 0);

         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 1);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);
      end;
      Set_Model (View, List.all'Unchecked_Access);
      Add (Frame, View);
      Unref (Monitor);
      return Frame;
   end Get_Drives;

   function Get_Volumes return Gtk_Frame is
      use type Volume_List.Glist;
      Frame   : Gtk_Frame;
      View    : Gtk_Tree_View;
      List    : Gtk_Tree_Store;
      Row     : Gtk_Tree_Iter;
      Monitor : GVolume_Monitor  := Get;
      Volumes : Volume_List.Glist := Get_Volumes (Monitor);
   begin
      Gtk_New (Frame);
      Set_Shadow_Type (Frame, Shadow_In);
      Gtk_New
      (  List,
         (GType_Icon, GType_String, GType_Icon, GType_String)
      );
      declare
         Item   : Volume_List.Glist := Volume_List.First (Volumes);
         Icon   : GObject;
         Volume : GVolume;
         Drive  : GDrive;
         Value  : GValue;
      begin
         Init (Value, GType_Icon);
         while Item /= Volume_List.Null_List loop
            Volume := Volume_List.Get_Data (Item);
            Append (List, Row, Null_Iter);
            Icon := Get_Icon (Volume);
            if Icon /= null then
               Set (Value, Icon);
               Unref (Icon);
            end if;
            Set_Value (List, Row, 0, Value);
            Set (List, Row, 1, Get_Name (Volume));

            Drive := Get_Drive (Volume);
            if Drive /= null then
               Icon := Get_Icon (Drive);
               if Icon /= null then
                  Set (Value, Icon);
                  Unref (Icon);
               end if;
               Set_Value (List, Row, 0, Value);
               Set (List, Row, 1, Get_Name (Drive));
               Unref (Drive);
            end if;

            Unref (Volume);
            Item := Volume_List.Next (Item);
         end loop;
         Volume_List.Free (Volumes);
         Unset (Value);
      end;
      Gtk_New (View);
      declare
         Column        : Gtk_Tree_View_Column;
         Column_No     : GInt;
         Name_Renderer : Gtk_Cell_Renderer_Text;
         Icon_Renderer : Gtk_Cell_Renderer_Pixbuf;
      begin
         Gtk_New (Column);
         Set_Title (Column, "Volume");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 0);

         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 1);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);

         Gtk_New (Column);
         Set_Title (Column, "Drive");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 2);

         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 3);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);
      end;
      Set_Model (View, List.all'Unchecked_Access);
      Add (Frame, View);
      Unref (Monitor);
      return Frame;
   end Get_Volumes;

   function Get_Mounts return Gtk_Frame is
      use type Mount_List.Glist;
      Frame   : Gtk_Frame;
      View    : Gtk_Tree_View;
      List    : Gtk_Tree_Store;
      Row     : Gtk_Tree_Iter;
      Monitor : GVolume_Monitor  := Get;
      Mounts  : Mount_List.Glist := Get_Mounts (Monitor);
   begin
      Gtk_New (Frame);
      Set_Shadow_Type (Frame, Shadow_In);
      Gtk_New
      (  List,
         (  GType_Icon, GType_String,
            GType_Icon, GType_String,
            GType_String,
            GType_String,
            GType_String,
            GType_String,
            GType_Icon, GType_String
      )  );
      declare
         Item  : Mount_List.Glist := Mount_List.First (Mounts);
         Icon  : GObject;
         Mount : GMount;
         Value : GValue;
      begin
         Init (Value, GType_Icon);
         while Item /= Mount_List.Null_List loop
            Mount := Mount_List.Get_Data (Item);
            Append (List, Row, Null_Iter);
            Icon := Get_Icon (Mount);
            if Icon /= null then
               Set (Value, Icon);
               Unref (Icon);
            end if;
            Set_Value (List, Row, 0, Value);
            Set (List, Row, 1, Get_Name (Mount));

            declare
               Drive : GDrive := Get_Drive (Mount);
            begin
               if Drive = null then
                  Set (List, Row, 3, "none");
               else
                  Icon := Get_Icon (Drive);
                  if Icon /= null then
                     Set (Value, Icon);
                     Unref (Icon);
                  end if;
                  Set_Value (List, Row, 2, Value);
                  Set (List, Row, 3, Get_Name (Drive));
                  Unref (Drive);
               end if;
            end;

            Set (List, Row, 4, Get_UUID (Mount));
            if Can_Unmount (Mount) then
               Set (List, Row, 5, "gtk-apply");
            else
               Set (List, Row, 5, "gtk-cancel");
            end if;
            if Can_Eject (Mount) then
               Set (List, Row, 6, "gtk-apply");
            else
               Set (List, Row, 6, "gtk-cancel");
            end if;
            Set (List, Row, 7, Get_Root (Mount));

            declare
               Volume : GVolume := Get_Volume (Mount);
            begin
               if Volume = null then
                  Set (List, Row, 9, "none");
               else
                  Icon := Get_Icon (Volume);
                  if Icon /= null then
                     Set (Value, Icon);
                     Unref (Icon);
                  end if;
                  Set_Value (List, Row, 8, Value);
                  Set (List, Row, 9, Get_Name (Volume));
                  Unref (Volume);
               end if;
            end;

            Unref (Mount);
            Item := Mount_List.Next (Item);
         end loop;
         Mount_List.Free (Mounts);
         Unset (Value);
      end;
      Gtk_New (View);
      declare
         Column        : Gtk_Tree_View_Column;
         Column_No     : GInt;
         Name_Renderer : Gtk_Cell_Renderer_Text;
         Icon_Renderer : Gtk_Cell_Renderer_Pixbuf;
      begin
         Gtk_New (Column);
         Set_Title (Column, "Mounts");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 0);

         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 1);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);

         Gtk_New (Column);
         Set_Title (Column, "Can");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "stock-id", 5);
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "stock-id", 6);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, False);

         Gtk_New (Column);
         Set_Title (Column, "Root");
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 7);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);

         Gtk_New (Column);
         Set_Title (Column, "Volume");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 8);
         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 9);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);

         Gtk_New (Column);
         Set_Title (Column, "UUID");
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 4);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);

         Gtk_New (Column);
         Set_Title (Column, "Drive");
         Gtk_New (Icon_Renderer);
         Pack_Start (Column, Icon_Renderer, False);
         Add_Attribute (Column, Icon_Renderer, "gicon", 2);
         Gtk_New (Name_Renderer);
         Pack_Start (Column, Name_Renderer, True);
         Add_Attribute (Column, Name_Renderer, "text", 3);
         Column_No := Append_Column (View, Column);
         Set_Resizable (Column, True);
      end;
      Set_Model (View, List.all'Unchecked_Access);
      Add (Frame, View);
      Unref (Monitor);
      return Frame;
   end Get_Mounts;

begin
   Gtk.Main.Init;
   Gtk.Main.Router.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test directory browser");
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
   Gtk.Main.Router.GNAT_Stack.Set_Log_Trace ("GLib-GIO");
   Gtk.Main.Router.GNAT_Stack.Set_Log_Trace ("GtkAda+");

   declare
      Box     : Gtk_Box;
      Buttons : Gtk_HBox;
      Button  : Gtk_Image_Button;
      Bang    : Gtk_Vseparator;
      Frame   : Gtk_Frame;
      Label   : Gtk_Label;
      Paned   : Gtk_Paned;
   begin
      Gtk_New_Vpaned (Paned);
      --
      -- Upper panel
      --
      Gtk_New_HBox (Box);
      Pack_Start (Box, Get_Drives);
      Pack_Start (Box, Get_Volumes);
      Pack_Start (Box, Get_Mounts);
      Pack1 (Paned, Box);
      --
      -- Lower panel
      --
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

      Gtk_New_Vseparator (Bang);
      Pack_Start (Buttons, Bang, False, False);

      Gtk_New (Label, "Filter");
      Pack_Start (Buttons, Label, False, False);

      Gtk_New (Pattern);
      Pack_Start (Buttons, Pattern, False, False);
      Handlers.Connect
      (  Pattern,
         "changed",
         Handlers.To_Marshaller (Filter_Changed'Access)
      );

      -- Packing buttons
      Pack_Start (Box, Buttons, False, False);
      -- Browser
--    Gtk_New (Browser, Tracing => not (Trace_To_Both or Trace_IO or Trace_Read_Items or Trace_Read_Directory));
      Gtk_New (Browser, Tracing => Trace_Nothing);
      Set_Editable (Get_Files_View (Browser), True);
      Set_Editable (Get_Tree_View (Browser), True);
      Gtk_New (Frame);
      Set_Shadow_Type (Frame, Shadow_In);
      Add (Frame, Browser);
      Pack_Start (Box, Frame);
      Pack2 (Paned, Box);

      Add (Window, Paned);
      Show_All (Paned);
   end;
   Show (Window);

   Gtk.Main.Main;
end Test_Gtk_Directory_Browser;
