--                                                                    --
--  procedure Test_Gtk_Color        Copyright (c)  Dmitry A. Kazakov  --
--  Test for Gdk.Color.IHLS                        Luebeck            --
--                                                 Winter, 2007       --
--                                                                    --
--                                Last revision :  10:00 13 Oct 2007  --
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

with Gdk.Event;            use Gdk.Event;
with Gdk.Color;            use Gdk.Color; 
with Gdk.Color.IHLS;       use Gdk.Color.IHLS; 
with GLib;                 use GLib;
with Gtk.Color_Selection;  use Gtk.Color_Selection;
with Gtk.Enums;            use Gtk.Enums;
with Gtk.Window;           use Gtk.Window;
with Gtk.Widget;           use Gtk.Widget;
with Gtk.Table;            use Gtk.Table;
with Gtk.Label;            use Gtk.Label;

with Gtk.Handlers;
with Gtk.Main;

procedure Test_Gtk_Color is
   Window     : Gtk_Window;
   Grid       : Gtk_Table;
   Label      : Gtk_Label;
   Hue        : Gtk_Label;
   Saturation : Gtk_Label;
   Luminance  : Gtk_Label;
   R          : Gtk_Label;
   G          : Gtk_Label;
   B          : Gtk_Label;
   Selection  : Gtk_Color_Selection;

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

   package Color_Handlers is
      new Gtk.Handlers.Callback (Gtk_Color_Selection_Record);

   procedure On_Color_Change
             (  Selection : access Gtk_Color_Selection_Record'Class
             )  is
      type D is delta 0.001 range 0.0..100.0;
      type F is delta 0.001 range 0.0..256.0;
      type H is delta 0.001 range 0.0..360.0;
      Color : Gdk_Color;
   begin
      Get_Current_Color (Selection, Color);
      declare
         Pixel : Gdk_IHLS_Color;
      begin
         Pixel := To_IHLS (Color);
         Set_Text
         (  Hue,
            H'Image
            (  H
               (  360.0
               *  Float (Pixel.Hue)
               /  Float (Gdk_Hue'Modulus)
         )  )  );
         Set_Text
         (  Saturation,
            D'Image (D (Float (Pixel.Saturation) / 655.36))
         );
         Set_Text
         (  Luminance,
            D'Image (D (Float (Pixel.Luminance) / 655.36))
         );
         Color := To_RGB (Pixel);
         Set_Text (R, F'Image (F (Float (Red   (Color)) / 256.0)));
         Set_Text (G, F'Image (F (Float (Green (Color)) / 256.0)));
         Set_Text (B, F'Image (F (Float (Blue  (Color)) / 256.0)));
      end;   
   end On_Color_Change;

begin
   Gtk.Main.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test");
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
   Gtk_New (Grid, 3, 6, False);
   Add (Window, Grid);
   Gtk_New (Selection);
   Color_Handlers.Connect
   (  Selection,
      "color_changed",
      Color_Handlers.To_Marshaller (On_Color_Change'Access)
   );
   Attach (Grid, Selection, 0, 1, 0, 6);
   
   Gtk_New (Label, "IHLS Hue:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 0, 1);
   Gtk_New (Label, "Saturation:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 1, 2);
   Gtk_New (Label, "Luminance:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 2, 3);
   Gtk_New (Label, "Red:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 3, 4);
   Gtk_New (Label, "Green:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 4, 5);
   Gtk_New (Label, "Blue:");
   Set_Alignment (Label, 1.0, 0.5);
   Attach (Grid, Label, 1, 2, 5, 6);

   Gtk_New (Hue);
   Set_Alignment (Hue, 0.0, 0.5);
   Attach (Grid, Hue,        2, 3, 0, 1);
   Gtk_New (Saturation);
   Set_Alignment (Saturation, 0.0, 0.5);
   Attach (Grid, Saturation, 2, 3, 1, 2);
   Gtk_New (Luminance);
   Set_Alignment (Luminance, 0.0, 0.5);
   Attach (Grid, Luminance,  2, 3, 2, 3);
   Gtk_New (R);
   Set_Alignment (R, 0.0, 0.5);
   Attach (Grid, R,          2, 3, 3, 4);
   Gtk_New (G);
   Set_Alignment (G, 0.0, 0.5);
   Attach (Grid, G,          2, 3, 4, 5);
   Gtk_New (B);
   Set_Alignment (B, 0.0, 0.5);
   Attach (Grid, B,          2, 3, 5, 6);

   Set_Col_Spacings (Grid, 5);

   Show_All (Grid);
   Show (Window);
   -- Enter the events processing loop
   Gtk.Main.Main;
end Test_Gtk_Color;