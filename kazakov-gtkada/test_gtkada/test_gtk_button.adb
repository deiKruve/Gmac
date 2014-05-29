--                                                                    --
--  procedure Test_Gtk_Button       Copyright (c)  Dmitry A. Kazakov  --
--  Test for                                       Luebeck            --
--      Gtk.Generic_Style_Button                   Spring, 2007       --
--                                                                    --
--                                Last revision :  09:12 29 Jun 2008  --
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

with Gdk.Event;               use Gdk.Event;
with Gtk.Window;              use Gtk.Window;
with Gtk.Widget;              use Gtk.Widget;
with Gtk.Table;               use Gtk.Table;
with Gtk.Tooltips;            use Gtk.Tooltips;
with Test_Gtk_Custom_Button;  use Test_Gtk_Custom_Button;

with Gtk.Handlers;
with Gtk.Main;
with Gtk.RC;

procedure Test_Gtk_Button is
   --
   -- All data are global, for the sake of  simplicity.  Otherwise,  the
   -- test were impossible to keep in  just  one  body  due  to  Ada  95
   -- restriction on controlled types.
   --
   Window  : Gtk_Window;
   Tooltip : Gtk_Tooltips;
   Grid    : Gtk_Table;
   Button  : Gtk_Style_Button;

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
   Gtk.RC.Parse ("test_gtk_button.rc");
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Style Buttons");

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
   Gtk_New (Grid, 1, 2, False);
   Add (Window, Grid);
   Gtk_New (Tooltip);
   Gtk_New (Button, Tooltip);
   Set_Name (Button, "Button1");
   Attach (Grid, Button, 0, 1, 0, 1);
   Show (Button);

   Gtk_New (Button, Tooltip);
   Set_Name (Button, "Button2");
   Attach (Grid, Button, 0, 1, 1, 2);
   Show (Button);

   Show (Grid);
   Show (Window);

   Gtk.Main.Main;
end Test_Gtk_Button;
