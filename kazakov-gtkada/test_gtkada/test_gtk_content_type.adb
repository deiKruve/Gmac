--                                                                    --
--  procedure                       Copyright (c)  Dmitry A. Kazakov  --
--     Test_Gtk_Content_Type                       Luebeck            --
--  Test for renderer                              Summer, 2010       --
--                                                                    --
--                                Last revision :  19:56 19 Jul 2010  --
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

with Ada.IO_Exceptions;         use Ada.IO_Exceptions;
with GIO.Content_Type;          use GIO.Content_Type;
with GLib;                      use GLib;
with GLib.Object;               use GLib.Object;
with GLib.Properties;           use GLib.Properties;
with GLib.Error;                use GLib.Error;
with GLib.Values;               use GLib.Values;
with Gtk.Enums;                 use Gtk.Enums;
with Gdk.Event;                 use Gdk.Event;
with Gtk.List_Store;            use Gtk.List_Store;
with Gtk.Main.Router;           use Gtk.Main.Router;
with Gtk.Missed;                use Gtk.Missed;
with Gtk.Widget;                use Gtk.Widget;
with Gtk.Window;                use Gtk.Window;
with Gtk.Cell_Renderer;         use Gtk.Cell_Renderer;
with Gtk.Cell_Renderer_Pixbuf;  use Gtk.Cell_Renderer_Pixbuf;
with Gtk.Cell_Renderer_Text;    use Gtk.Cell_Renderer_Text;
with Gtk.Tree_View_Column;      use Gtk.Tree_View_Column;
with Gtk.Tree_Model;            use Gtk.Tree_Model;
with Gtk.Tree_View;             use Gtk.Tree_View;
with Gtk.Scrolled_Window;       use Gtk.Scrolled_Window;

with Gtk.Handlers;
with Gtk.Main;

procedure Test_Gtk_Content_Type is

   Window     : Gtk_Window;
   Files_View : Gtk_Tree_View;
   Scroller   : Gtk_Scrolled_Window;

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

begin
   Gtk.Main.Init;
   Gtk.Main.Router.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test content type");
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

   Gtk_New (Scroller);
   Gtk_New (Files_View);

   declare
      Files : Gtk_List_Store;
   begin
      Gtk_New
      (  Files,
         (  GType_String, GType_String, GType_String,
            GType_String, GType_Icon
      )  );
      declare
         Row   : Gtk_Tree_Iter := Null_Iter;
         Dir   : GDir;
         Error : GError;
      begin
         Dir_Open (".", Dir, Error);
         if Error /= null then
            Say
            (  "Failed to read corrent directory: "
            &  Get_Message (Error)
            );
            return;
         end if;
         -- Filling the column with random numbers
         loop
            declare
               Name    : UTF8_String := Dir_Read_Name (Dir);
               Content : UTF8_String := Guess (Name);
               Icon    : GObject     := Get_Icon (Content);
               Value   : GValue;
            begin
               Append (Files, Row);
               Set (Files, Row, 0, Name);
               Set (Files, Row, 1, Get_MIME_Type (Content));
               Set (Files, Row, 2, Get_Description (Content));
               Set (Files, Row, 3, Content);
               Init (Value, GType_Icon);
               Set_Object (Value, Icon);
               Set_Value (Files, Row, 4, Value);
               Unref (Icon);
               Unset (Value);
            end;
         end loop;
      exception
         when End_Error =>
            Dir_Close (Dir);
            -- Attaching the column store to its view
            Set_Model (Files_View, Files.all'Access);
            Unref (Files);
      end;
      -- Creating columns in the view
      declare
         Column_No : GInt;
         Column    : Gtk_Tree_View_Column;
         Text      : Gtk_Cell_Renderer_Text;
         Icon      : Gtk_Cell_Renderer_Pixbuf;
      begin
            -- The first column
         Gtk_New (Column);
         Set_Title (Column, "File");
         Gtk_New (Icon);
         Pack_Start (Column, Icon, False);
         Add_Attribute (Column, Icon, "gicon", 4);
         Gtk_New (Text);
         Pack_Start (Column, Text, True);
         Add_Attribute (Column, Text, "text", 0);
         Column_No := Append_Column (Files_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 0);
            -- The second column
         Gtk_New (Column);
         Set_Title (Column, "MIME type");
         Gtk_New (Text);
         Pack_Start (Column, Text, True);
         Add_Attribute (Column, Text, "text", 1);
         Column_No := Append_Column (Files_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 1);
            -- The third column
         Gtk_New (Column);
         Set_Title (Column, "Description");
         Gtk_New (Text);
         Pack_Start (Column, Text, True);
         Add_Attribute (Column, Text, "text", 2);
         Column_No := Append_Column (Files_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 2);
            -- The fourth column
         Gtk_New (Column);
         Set_Title (Column, "Content type");
         Gtk_New (Text);
         Pack_Start (Column, Text, True);
         Add_Attribute (Column, Text, "text", 3);
         Column_No := Append_Column (Files_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 3);
      end;
   end;
   Set_Policy (Scroller, Policy_Automatic, Policy_Automatic);
   Add (Scroller, Files_View);
   Add (Window, Scroller);

   Show (Files_View);
   Show (Scroller);
   Show (Window);
   Gtk.Main.Main;
end Test_Gtk_Content_Type;