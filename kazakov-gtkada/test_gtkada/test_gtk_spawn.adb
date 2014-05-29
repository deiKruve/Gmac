--                                                                    --
--  procedure Test_Gtk_Spawn        Copyright (c)  Dmitry A. Kazakov  --
--  Test for Gtk.Spawn                             Luebeck            --
--                                                 Spring, 2009       --
--                                                                    --
--                                Last revision :  18:24 09 May 2009  --
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

with Interfaces.C.Strings;  use Interfaces.C.Strings;
with Gdk.Event;             use Gdk.Event;
with Glib.Error;            use Glib.Error;
with GLib.Spawn;            use GLib.Spawn;
with Gtk.Button;            use Gtk.Button;
with Gtk.Enums;             use Gtk.Enums;
with Gtk.Enums;             use Gtk.Enums;
with Gtk.GEntry;            use Gtk.GEntry;
with Gtk.Table;             use Gtk.Table;
with Gtk.Window;            use Gtk.Window;
with Gtk.Widget;            use Gtk.Widget;
with Gtk.Label;             use Gtk.Label;

with Gtk.Handlers;
with Gtk.Main;
with Gtk.RC;

procedure Test_Gtk_Spawn is
   --
   -- All data are global, for the sake of  simplicity.  Otherwise,  the
   -- test were impossible to keep in  just  one  body  due  to  Ada  95
   -- restriction on controlled types.
   --
   Window  : Gtk_Window;
   Label   : Gtk_Label;
   Command : Gtk_GEntry;
   Output  : Gtk_GEntry;
   Error   : Gtk_GEntry;
   Grid    : Gtk_Table;
   Run     : Gtk_Button;

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

   procedure Do_Run (Widget : access Gtk_Widget_Record'Class) is
   begin
      declare
         Result : Sync_Result := Command_Line_Sync (Get_Text (Command));
      begin
         if Result.Executed then
            Set_Text (Output, Value (Result.Standard_Output));
            Set_Text (Error,  Value (Result.Standard_Error));
            Free (Result.Standard_Output);
            Free (Result.Standard_Error);
         else
            Set_Text (Output, "");
            Set_Text (Error, Get_Message (Result.Error));
            Error_Free (Result.Error);
         end if;
      end;
   end Do_Run;

begin
   Gtk.Main.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Spawn");
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

   Gtk_New (Grid, 3, 3, False);
   Add (Window, Grid);

   Gtk_New (Label, "Command:");
   Attach (Grid, Label, 0, 1, 0, 1, XOptions => Fill);
   Gtk_New (Command);
   Attach (Grid, Command, 1, 2, 0, 1);
   Gtk_New (Run, "Run");
   Attach (Grid, Run, 2, 3, 0, 1, XOptions => Shrink);

   Gtk_New (Label, "Output:");
   Attach (Grid, Label, 0, 1, 1, 2, XOptions => Fill);
   Gtk_New (Output);
   Attach (Grid, Output, 1, 3, 1, 2);

   Gtk_New (Label, "Error:");
   Attach (Grid, Label, 0, 1, 2, 3, XOptions => Fill);
   Gtk_New (Error);
   Attach (Grid, Error, 1, 3, 2, 3);

   Handlers.Connect
   (  Run,
      "clicked",
      Handlers.To_Marshaller (Do_Run'Access)
   );

   Show_All (Grid);
   Show (Window);

   Gtk.Main.Main;
end Test_Gtk_Spawn;
