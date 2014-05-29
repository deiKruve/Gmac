--                                                                    --
--  procedure Test_Gtk_Slat         Copyright (c)  Dmitry A. Kazakov  --
--  Test for                                       Luebeck            --
--      Gtk.Slat                                   Autumn, 2007       --
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

with Gdk.Event;   use Gdk.Event;
with Gtk.Enums;   use Gtk.Enums;
with Gtk.Box;     use Gtk.Box;
with Gtk.Window;  use Gtk.Window;
with Gtk.Widget;  use Gtk.Widget;
with Gtk.Slat;    use Gtk.Slat;
with Gtk.Label;   use Gtk.Label;

with Gtk.Handlers;
with Gtk.Main;
with Gtk.RC;

procedure Test_Gtk_Slat is
   --
   -- All data are global, for the sake of  simplicity.  Otherwise,  the
   -- test were impossible to keep in  just  one  body  due  to  Ada  95
   -- restriction on controlled types.
   --
   Window  : Gtk_Window;
   Label   : Gtk_Label;
   Box     : Gtk_Box;
   Slat    : array (1..4) of Gtk_Slat;

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
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Slat");
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

   Gtk_New (Slat (1), Side_Top);
   Add (Window, Slat (1));

   Gtk_New_VBox (Box);
   Add (Slat (1), Box);

   Gtk_New (Label, "Slat with side top");
   Pack_Start (Box, Label);
   Gtk_New (Slat (2), Side_Bottom);
   Pack_Start (Box, Slat (2));

   Gtk_New (Slat (3), Side_Left);
   Add (Slat (2), Slat (3));

   Gtk_New_VBox (Box);
   Add (Slat (3), Box);
   Gtk_New (Label, "Slat with side left");
   Pack_Start (Box, Label);

   Gtk_New (Slat (4), Side_Right);
   Add (Box, Slat (4));

   Gtk_New (Label, "Some text");
   Add (Slat (4), Label);

   Show_All (Slat (1));
   Set_Expanded (Slat (1), True);
   Show (Window);

   Gtk.Main.Main;
end Test_Gtk_Slat;
