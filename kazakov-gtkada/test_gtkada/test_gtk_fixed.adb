--                                                                    --
--  procedure Test_Gtk_Fixed        Copyright (c)  Dmitry A. Kazakov  --
--  Test for renderer                              Luebeck            --
--                                                 Spring, 2006       --
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

with Ada.Numerics.Float_Random;  use Ada.Numerics.Float_Random; 
with GLib;                       use GLib;
with GLib.Properties;            use GLib.Properties;
with GLib.Values;                use GLib.Values;
with Gtk.Enums;                  use Gtk.Enums;
with Gdk.Event;                  use Gdk.Event;
with Gtk.List_Store;             use Gtk.List_Store;
with Gtk.Widget;                 use Gtk.Widget;
with Gtk.Window;                 use Gtk.Window;
with Gtk.Cell_Renderer;          use Gtk.Cell_Renderer;
with Gtk.Cell_Renderer_Fixed;    use Gtk.Cell_Renderer_Fixed;
with Gtk.Cell_Renderer_Text;     use Gtk.Cell_Renderer_Text;
with Gtk.Tree_View_Column;       use Gtk.Tree_View_Column;
with Gtk.Tree_Model;             use Gtk.Tree_Model;
with Gtk.Tree_View;              use Gtk.Tree_View;
with Gtk.Scrolled_Window;        use Gtk.Scrolled_Window;

with Gtk.Handlers;
with Gtk.Main;

procedure Test_Gtk_Fixed is

   Window     : Gtk_Window;
   Table_View : Gtk_Tree_View;
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
   
   -- Committing edit
   package Commit_Handlers is
      new Gtk.Handlers.User_Callback
          (  Gtk_Cell_Renderer_Fixed_Record,
             Gtk_List_Store
          );

   procedure Commit
             (  Cell  : access Gtk_Cell_Renderer_Fixed_Record'Class;
                Store : Gtk_List_Store
             )  is
      Row   : Gtk_Tree_Iter :=
                 Get_Iter_From_String (Store, Get_Path (Cell));
      Value : GValue;
   begin
      if Row /= Null_Iter then
         Init (Value, GType_Double);
         Set_Double (Value, Get_Property (Cell, Build ("value")));
         Set_Value (Store, Row, 0, Value);
         Unset (Value);
      end if;
   end Commit;

begin
   Gtk.Main.Init;
   Gtk.Window.Gtk_New (Window);
   Set_Title (Window, "Test Fixed-Point Cell Renderer");
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
   
   -- Creating a column of numbers (list store)
   declare
      Table : Gtk_List_Store;
   begin
      Gtk_New (Table, (0 => GType_Double));
      declare
         Row    : Gtk_Tree_Iter := Null_Iter;
         Value  : GValue;
         Source : Generator;
      begin
         Init (Value, GType_Double);
         -- Filling the column with random numbers
         for Item in 1..1000 loop
            Append (Table, Row);
            Set_Double
            (  Value,
               GDouble (100.0 * (Random (Source) - 0.5))
            );
            Set_Value (Table, Row, 0, Value);
         end loop;
         -- Attaching the column store to its view
         Set_Model (Table_View, Table.all'Access);
         Unset (Value);
      end;
      -- Creating columns in the view
      declare
         Column_No : GInt;
         Column    : Gtk_Tree_View_Column;
         Numeric   : Gtk_Cell_Renderer_Fixed;
         Text      : Gtk_Cell_Renderer_Text;
      begin
         -- The first column will use the fixed-point renderer
         Gtk_New (Column);
         Set_Title (Column, "Value");
         Gtk_New (Numeric, 3);
         Set_Mode (Numeric, Cell_Renderer_Mode_Editable);
         Commit_Handlers.Connect
         (  Numeric,
            "commit",
            Commit'Access,
            Table
         );
         Pack_Start (Column, Numeric, False);
         -- Map column's renderer to the table's column 0
         Add_Attribute (Column, Numeric, "value", 0);
         Column_No := Append_Column (Table_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 0);

         -- The second column uses the standard text renderer
         Gtk_New (Column);
         Set_Title (Column, "Text");
         Gtk_New (Text);
         Pack_Start (Column, Text, True);
         -- Map column's renderer to the table's column 0
         Add_Attribute (Column, Text, "text", 0);
         Column_No := Append_Column (Table_View, Column);
         Set_Resizable (Column, True);
         Set_Sort_Column_Id (Column, 0);
      end;
   end;
   Set_Policy (Scroller, Policy_Automatic, Policy_Automatic);
   Add (Scroller, Table_View);      
   Add (Window, Scroller);

   Show (Table_View);
   Show (Scroller);
   Show (Window);
   Gtk.Main.Main;
end Test_Gtk_Fixed;
