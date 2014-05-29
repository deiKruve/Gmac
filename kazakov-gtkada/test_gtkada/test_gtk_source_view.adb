--                                                                    --
--  procedure                       Copyright (c)  Dmitry A. Kazakov  --
--     Test_Gtk_Source_View                        Luebeck            --
--  Test for Gtk.Source_View                       Summer, 2009       --
--                                                                    --
--                                Last revision :  14:21 07 Aug 2009  --
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

with Ada.Exceptions;               use Ada.Exceptions;
with Ada.Text_IO;                  use Ada.Text_IO;
with GLib;                         use GLib;
with Glib.Properties;              use Glib.Properties;
with Gdk.Event;                    use Gdk.Event;
with Gtk.Main.Router;              use Gtk.Main.Router;
with Gtk.Scrolled_Window;          use Gtk.Scrolled_Window;
with Gtk.Source_Buffer;            use Gtk.Source_Buffer;
with Gtk.Source_Language_Manager;  use Gtk.Source_Language_Manager;
with Gtk.Source_View;              use Gtk.Source_View;
with Gtk.Table;                    use Gtk.Table;
with Gtk.Text_Buffer;              use Gtk.Text_Buffer;
with Gtk.Text_Iter;                use Gtk.Text_Iter;
with Gtk.Window;                   use Gtk.Window;
with Gtk.Widget;                   use Gtk.Widget;
with Pango.Font;                   use Pango.Font;

with Gtk.Handlers;

procedure Test_Gtk_Source_View is

   Window : Gtk_Window;
   Grid   : Gtk_Table;
   Scroll : Gtk_Scrolled_Window;
   View   : Gtk_Source_View;
   Buffer : Gtk_Source_Buffer;

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
   Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Source View");

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
   Gtk_New (Grid, 1, 1, False);
   Add (Window, Grid);
   Gtk_New (Scroll);
   Attach (Grid, Scroll, 0, 1, 0, 1);

   Gtk_New (Buffer, Get_Language (Get_Default, "ada"));
   Gtk_New (View, Buffer);
   Unref (Buffer);
   Add (Scroll, View);

   -- Customizing the way the widget acts
   Set_Right_Margin_Position (View, 72);
   Set_Show_Right_Margin (View, True);
   Set_Show_Line_Numbers (View, True);
   Set_Highlight_Current_Line (View, True);
   Set_Highlight_Matching_Brackets (Buffer, True);

   -- Setting a fixed font into the widget
   declare
      Font : Pango_Font_Description :=
                From_String ("fixed,Monospace 10");
   begin
      Modify_Font (View, Font);
      Free (Font);
   end;
   --
   -- Loading   the   source  file  into  the  buffer.  Note  that  this
   -- implementation  is  simplified  with  respect to file encoding. It
   -- assumes that the file is UTF-8. Loading Latin-1  files  will cause
   -- errors.  Latin-1  file  context,  like  under  Windows  should  be
   -- transcoded into UTF-8 before inserting into the buffer.
   --
   declare
      File         : File_Type;
      Input_Buffer : UTF8_String (1..1024);
      End_Iter     : Gtk_Text_Iter;
      Input_Last   : Natural := 0;
   begin
      Open (File, In_File, "test_gtk_source_view.adb");
      loop
         Get_Line
         (  File,
            Input_Buffer (Input_Last + 1..Input_Buffer'Last),
            Input_Last
         );
         if Input_Last < Input_Buffer'Last then
            Input_Last := Input_Last + 1;
            Input_Buffer (Input_Last) := Character'Val (10);
         end if;
         if Input_Last = Input_Buffer'Last then
            Get_End_Iter (Get_Buffer (View), End_Iter);
            Insert
            (  Buffer,
               End_Iter,
               Input_Buffer (1..Input_Last)
            );
            Input_Last := 0;
         end if;
      end loop;
   exception
      when End_Error =>
         Get_End_Iter (Buffer, End_Iter);
         Insert
         (  Get_Buffer (View),
            End_Iter,
            Input_Buffer (1..Input_Last)
         );
         Close (File);
      when Error : others =>
         Close (File);
         Trace ("Cannot load file: " & Exception_Information (Error));
   end;
   Show_All (Grid);
   Show (Window);

   Gtk.Main.Main;
exception
   when Error : others =>
      Trace ("Error: " & Exception_Information (Error));
end Test_Gtk_Source_View;
