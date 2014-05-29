--                                                                    --
--  procedure Test_Gtk_Missed       Copyright (c)  Dmitry A. Kazakov  --
--  Test for Gtk.Missed                            Luebeck            --
--                                                 Summer, 2006       --
--                                                                    --
--                                Last revision :  17:51 10 Aug 2012  --
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

with Ada.Characters.Latin_1;  use Ada.Characters.Latin_1;
with Ada.Exceptions;          use Ada.Exceptions;
with Gdk.Event;               use Gdk.Event;
with GLib;                    use GLib;
with Gtk.Missed;              use Gtk.Missed;
with Gtk.Main.Router;         use Gtk.Main.Router;
with Gtk.Window;              use Gtk.Window;
with Gtk.Widget;              use Gtk.Widget;
with Gtk.Table;               use Gtk.Table;
with Gtk.Label;               use Gtk.Label;

with Ada.Unchecked_Conversion;
with Gtk.Handlers;

procedure Test_Gtk_Missed is
   Window  : Gtk_Window;
   Grid    : Gtk_Table;
   Label   : Gtk_Label;
   Counter : Integer;

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

   type Local_Callback is access procedure;
   function "+" is
      new Ada.Unchecked_Conversion (Local_Callback, Gtk_Callback);

   task type Process;

   procedure Update is
      X      : GInt;
      Y      : GInt;
      Width  : GInt;
      Height : GInt;
   begin
      Get_Position (Window, X, Y);
      Width  := Get_Allocation_Width (Window);
      Height := Get_Allocation_Height (Window);
      Set_Text
      (  Label,
         (  "Move and resize it until ""Success"" appears"
         &  LF
         &  LF
         &  "Position X ="
         &  GInt'Image (X)
         &  " Y =" & GInt'Image (Y)
         &  LF
         &  "Size Width ="
         &  GInt'Image (Width)
         &  " Height ="
         &  GInt'Image (Height)
      )  );
   end Update;

   procedure Done is
   begin
      Set_Text (Label, "Success");
   end Done;

   -- The task that calls to Update
   task body Process is
   begin
      for Index in 1..100 loop
         Counter := Index;
         Request (+Update'Access); -- Request execution of Update
         delay 0.2;
      end loop;
      Request (+Done'Access);
   exception
      when Error : others =>
         Say (Exception_Information (Error)); -- This is safe
   end Process;

begin
   Gtk.Main.Init;
   Gtk.Main.Router.Init; -- This must be called once
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Missed Stuff");
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
   Gtk_New (Label, "label");
   Attach (Grid, Label, 0, 1, 0, 1);

   Show (Label);
   Show (Grid);
   Show (Window);
   declare
      Worker : Process; -- Now the task is on
   begin
      -- Enter the events processing loop
      Gtk.Main.Main;
   end;
exception
   when Error : others =>
      Say (Exception_Information (Error)); -- This is safe
end Test_Gtk_Missed;
