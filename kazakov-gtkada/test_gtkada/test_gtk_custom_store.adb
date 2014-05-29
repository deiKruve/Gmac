--                                                                    --
--  procedure                       Copyright (c)  Dmitry A. Kazakov  --
--     Test_Gtk_Custom_Store                       Luebeck            --
--  Test                                           Winter, 2007       --
--  (for Gtk.Tree_Model.Custom_Store)                                 --
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

with Ada.Calendar;                 use Ada.Calendar;
with GLib;                         use GLib;
with Gtk.Enums;                    use Gtk.Enums;
with Gdk.Event;                    use Gdk.Event;
with Gtk.Tree_Model.Custom_Store;  use Gtk.Tree_Model.Custom_Store;
with Gtk.Widget;                   use Gtk.Widget;
with Gtk.Window;                   use Gtk.Window;
with Gtk.Cell_Renderer_Fixed;      use Gtk.Cell_Renderer_Fixed;
with Gtk.Cell_Renderer_Text;       use Gtk.Cell_Renderer_Text;
with Gtk.Tree_View_Column;         use Gtk.Tree_View_Column;
with Gtk.Tree_Model;               use Gtk.Tree_Model;
with Gtk.Tree_View;                use Gtk.Tree_View;
with Gtk.Scrolled_Window;          use Gtk.Scrolled_Window;

with Ada.Unchecked_Conversion;
with Gtk.Handlers;
with Gtk.Main;

procedure Test_Gtk_Custom_Store is

   Window     : Gtk_Window;
   Table_View : Gtk_Tree_View;
   Data       : Gtk_Transaction_Store;
   Scroller   : Gtk_Scrolled_Window;
   ID         : Gtk.Main.Timeout_Handler_Id;
   Kid_Count  : Natural := 0;

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

   -- Circumvention of access rules, don't do it, it is here only to
   -- simplify the test 
   type Local_Callback is access function return Boolean;
   function "+" is
      new Ada.Unchecked_Conversion
          (  Local_Callback,
             Gtk.Main.Timeout_Callback
          );

   function Add_Kids return Boolean is
   begin
      Kid_Count := Kid_Count + 1;
      case Kid_Count is
         when 1 => Insert (Data, 45, "Huey, Duck",  1.00, Clock);
         when 2 => Insert (Data, 46, "Louie, Duck", 1.00, Clock);
         when 3 => Insert (Data, 47, "Dewey, Duck", 1.00, Clock);
         when 4 => Insert (Data, 48, "Webby, Duck", 1.00, Clock);
         when others => return False;
      end case;
      return True;
   end Add_Kids;

begin
   Gtk.Main.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Custom Store");
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
   Gtk_New (Table_View);
   
   -- Creating the store with some initial records
   Gtk_New (Data);
   Insert (Data,  22, "Donald, Duck",   10.00, Clock);
   Insert (Data,   3, "Mrs. Beakley",   35.00, Clock);
   Insert (Data, 100, "Scrooge, Duck", 100.00, Clock);

   -- Attaching the column store to its view
   Set_Model (Table_View, Data.all'Access);

   -- Creating columns in the view
   declare
      Column_No : GInt;
      Column    : Gtk_Tree_View_Column;
      Numeric   : Gtk_Cell_Renderer_Fixed;
      Text      : Gtk_Cell_Renderer_Text;
   begin
      Gtk_New (Column);
      Set_Title (Column, "Account");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 0);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "User");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 1);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Amount");
      Gtk_New (Numeric, 2);
      Pack_Start (Column, Numeric, False);
      Add_Attribute (Column, Numeric, "value", 2);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);
      
      Gtk_New (Column);
      Set_Title (Column, "Year");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 3);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Month");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 4);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Day");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 5);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Hour");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 6);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Minute");
      Gtk_New (Text);
      Pack_Start (Column, Text, True);
      Add_Attribute (Column, Text, "text", 7);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);

      Gtk_New (Column);
      Set_Title (Column, "Seconds");
      Gtk_New (Numeric, 3);
      Pack_Start (Column, Numeric, False);
      Add_Attribute (Column, Numeric, "value", 8);
      Column_No := Append_Column (Table_View, Column);
      Set_Resizable (Column, True);
   end;
   Set_Policy (Scroller, Policy_Automatic, Policy_Automatic);
   Add (Scroller, Table_View);      
   Add (Window, Scroller);

   Show (Table_View);
   Show (Scroller);
   Show (Window);
   ID := Gtk.Main.Timeout_Add (2000, +Add_Kids'Access);
   Gtk.Main.Main;

end Test_Gtk_Custom_Store;
