--                                                                    --
--  procedure Test_Gtk_Tracing      Copyright (c)  Dmitry A. Kazakov  --
--  Test for Gtk.Main.Router                       Luebeck            --
--                                                 Spring, 2012       --
--                                                                    --
--                                Last revision :  17:57 18 Jan 2012  --
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

with Ada.Exceptions;              use Ada.Exceptions;
with Gdk.Event;                   use Gdk.Event;
with Gtk.Box;                     use Gtk.Box;
with Gtk.Button;                  use Gtk.Button;
with Gtk.Window;                  use Gtk.Window;
with Gtk.Widget;                  use Gtk.Widget;

with Ada.Unchecked_Conversion;
with Gtk.Handlers;
with Gtk.Main.Router.GNAT_Stack;

procedure Test_Gtk_Tracing is
   Window : Gtk_Window;
   Box    : Gtk_VBox;
   Button : Gtk_Button;
   LF     : constant Character := Character'Val (10);

   -- Standard GTK stuff
   package Handlers is new Gtk.Handlers.Callback (Gtk_Widget_Record);

   -- Destroy handler is standard for GTK
   procedure Destroy (Widget : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Main_Quit;
   end Destroy;

   procedure Trace_This (Widget : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Router.Trace
      (  "   The text passed to Gtk.Main.Router.Trace appears " & LF &
         "in the trace window, which is popped as needed. " & LF &
         "When the window first appears it blocks the " & LF &
         "application. Pressing the RECORD button releases " & LF &
         "it, and further calls to Trace would not break " & LF &
         "if not explicitly required."
      );
   end Trace_This;

   procedure Trace_Stack (Widget : access Gtk_Widget_Record'Class) is
   begin
      Gtk.Main.Router.GNAT_Stack.Trace
      (  "   The text passed to Gtk.Main.Router.GNAT_Stack.Trace" & LF &
         "appears in trace window, which is popped as needed. " & LF &
         "The output is accompanied by the call stack trace."
      );
   end Trace_Stack;

   procedure Trace_Exception
             (  Widget : access Gtk_Widget_Record'Class
             )  is
      X : Integer := 0;
   begin
      X := X / X; -- Error here
   exception
      when Error : others =>
         Gtk.Main.Router.Trace
         (  "   Gtk.Main.Router.GNAT_Stack.Trace can be called " & LF &
            "with an exception occurence, which traces the " & LF &
            "exception stack"
         );
         Gtk.Main.Router.GNAT_Stack.Trace (Error);
   end Trace_Exception;

begin
   Gtk.Main.Init;
   Gtk.Main.Router.Init; -- This must be called once
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Tracing");
   Handlers.Connect
   (  Window,
      "destroy",
      Handlers.To_Marshaller (Destroy'Access)
   );
   Gtk_New_VBox (Box);
   Add (Window, Box);

   Gtk_New (Button, "Trace this");
   Handlers.Connect
   (  Button,
      "clicked",
      Handlers.To_Marshaller (Trace_This'Access)
   );
   Pack_Start (Box, Button);

   Gtk_New (Button, "Trace stack");
   Handlers.Connect
   (  Button,
      "clicked",
      Handlers.To_Marshaller (Trace_Stack'Access)
   );
   Pack_Start (Box, Button);

   Gtk_New (Button, "Trace exception");
   Handlers.Connect
   (  Button,
      "clicked",
      Handlers.To_Marshaller (Trace_Exception'Access)
   );
   Pack_Start (Box, Button);

   Gtk.Main.Router.Trace
   (  "   This is the trace window which contains the output " & LF &
      "produced by Gtk.Main.Router.Trace calls. Press the " & LF &
      "RECORD button to release the application."
   );
   Gtk.Main.Router.Trace
   (  "   Note how separate calls to Trace cause the output of " & LF &
      "different colors."
   );
   Gtk.Main.Router.Trace
   (  "   When the project is opened in the GPS studio and the " & LF &
      "studio was called with the switch:"  & LF & LF &
      "   gps --server=50000" & LF & LF &
      "(in the server mode), you will be able to navigate " & LF &
      "the symbolic traceback using the right click mouse " & LF &
      "menu dropped down when the corresponding line of " & LF &
      "the traceback is clicked on."
   );

   Show_All (Window);
   Gtk.Main.Main;
end Test_Gtk_Tracing;
