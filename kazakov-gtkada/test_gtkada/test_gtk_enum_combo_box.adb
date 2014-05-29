with Gtk.Enums;
with Gtk.Handlers;
with Gtk.Main;
with Gtk.Missed;  use Gtk.Missed;
with Gtk.Window;  use Gtk.Window;
with Gtk.Widget;
with Gtk.Combo_Box;
with Test_Gtk_P_Enum;

procedure Test_Gtk_Enum_Combo_Box is
   Win : Gtk_Window;
   Ecp : Test_Gtk_P_Enum.Enum_Combo.Gtk_Enum_Combo_Box;

   function On_Main_Window_Delete_Event
     (Object : access Gtk_Window_Record'Class) return Boolean;
   --  Handler for the delete_event signal

   function On_Main_Window_Delete_Event
     (Object : access Gtk_Window_Record'Class)
      return Boolean
   is
      pragma Unreferenced (Object);
   begin
      Gtk.Main.Gtk_Exit (0);
      return True;
   end On_Main_Window_Delete_Event;

   package Window_Cb is new Gtk.Handlers.Return_Callback
     (Gtk_Window_Record, Boolean);

begin
   Gtk.Main.Init;

   Gtk_New (Win, Gtk.Enums.Window_Toplevel);
   Test_Gtk_P_Enum.Enum_Combo.Gtk_New (Ecp, Capitalize_First, True);
   Add (Win, Ecp);

   Test_Gtk_P_Enum.Enum_Combo.Set_Active_Value (Ecp, Test_Gtk_P_Enum.Light_Blue);

   Window_Cb.Connect
     (Win, "delete_event",
      Window_Cb.To_Marshaller (On_Main_Window_Delete_Event'Access));

   Show_All (Win);

   Gtk.Main.Main;
end Test_Gtk_Enum_Combo_Box;
