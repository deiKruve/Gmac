--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Image_Button                            Luebeck            --
--  Implementation                                 Autumn, 2007       --
--                                                                    --
--                                Last revision :  21:44 01 Oct 2011  --
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

with Gdk.Types.Keysyms;  use Gdk.Types.Keysyms;
with GLib.Properties;    use GLib.Properties;
with Gtk.Event_Box;      use Gtk.Event_Box;
with GtkAda.Types;       use GtkAda.Types;

with GtkAda.Handlers;
with Gtk.Object.Checked_Destroy;
with Interfaces.C.Strings;

package body Gtk.Slat is

   Class_Name   : constant String := "GtkSlat";
   Signals      : constant Chars_Ptr_Array :=
                     (  Interfaces.C.Strings.New_String ("expanded"),
                        Interfaces.C.Strings.New_String ("shrunk"),
                        Interfaces.C.Strings.New_String ("expand"),
                        Interfaces.C.Strings.New_String ("shrink")
                     );
   Class_Record : GObject_Class := Uninitialized_Class;

   procedure Add
             (  Container : access Gtk_Slat_Record;
                Widget    : access Gtk_Widget_Record'Class
             )  is
   begin
      if Widget /= Get (Container.Child) then
         if Container.Expanded then
            if Is_Valid (Container.Child) then
               Remove (Container, Get (Container.Child));
            end if;
            Pack_Start (Container.Content, Widget, True, True);
            case Container.Mode is
               when Side_Bottom | Side_Right =>
                  Reorder_Child (Container.Content, Widget, 0);
               when Side_Top | Side_Left =>
                  null;
            end case;
         end if;
      end if;
      Container.Child := Ref (Widget);
   end Add;

   function Button_Press
            (  Widget : access Gtk_Widget_Record'Class;
               Event  : Gdk_Event;
               Slat   : Gtk_Slat
            )  return Boolean is
   begin
      case Get_Event_Type (Event) is
         when Button_Press =>
            null;
         when Key_Press =>
            case Get_Key_Val (Event) is
               when GDK_Return | GDK_KP_Enter | GDK_ISO_Enter =>
                  null;
               when others =>
                  return False;
               end case;
         when others =>
            return False;
      end case;
      Set_Expanded (Slat, not Slat.Expanded);
      return False;
   end Button_Press;

   procedure Expand
             (  Widget : access Gtk_Widget_Record'Class;
                Slat   : Gtk_Slat
             )  is
   begin
      Set_Expanded (Slat, True);
   end Expand;

   function Get
            (  Container : access Gtk_Slat_Record
            )  return Gtk_Widget is
   begin
      if Is_Valid (Container.Child) then
         return Get (Container.Child).all'Access;
      else
         raise Constraint_Error;
      end if;
   end Get;

   function Get_Children
            (  Container : access Gtk_Slat_Record
            )  return Widget_List.Glist is
      use Widget_List;
      Result : GList := Null_List;
   begin
      if Is_Valid (Container.Child) then
         Append (Result, Get (Container.Child).all'Access);
      end if;
      return Result;
   end Get_Children;

   function Get_Bar
            (  Container : access Gtk_Slat_Record
            )  return Gtk_Box is
   begin
      return Container.Bar_Box;
   end Get_Bar;

   function Get_Spacing
            (  Container : access Gtk_Slat_Record
            )  return GInt is
   begin
      return
         Get_Spacing (Gtk_Box_Record (Container.Content.all)'Access);
   end Get_Spacing;

   function Get_Type return Gtk_Type is
   begin
      if Class_Record = Uninitialized_Class then
         declare
            This : Gtk_Slat;
         begin
            Gtk_New (This, Side_Top);
            Gtk.Object.Checked_Destroy (This);
         end;
      end if;
      return Type_From_Class (Class_Record);
   end Get_Type;

   procedure Gtk_New
             (  Container : out Gtk_Slat;
                Location  : Gtk_Side_Type
             )  is
   begin
      Container := new Gtk_Slat_Record;
      Initialize (Container, Location);
   exception
      when others =>
         Gtk.Object.Checked_Destroy (Container);
         Container := null;
         raise;
   end Gtk_New;

   procedure Initialize
             (  Container : access Gtk_Slat_Record'Class;
                Location  : Gtk_Side_Type
             )  is
      Events  : Gtk_Event_Box;
   begin
      Container.Mode := Location;
      case Location is
         when Side_Top | Side_Bottom =>
            Gtk.Frame.Initialize (Container);
            Initialize_Class_Record
            (  Container,
               Signals,
               Class_Record,
               Class_Name
            );
            Gtk_New_VBox (Container.Content);
            Gtk_New_HBox (Container.Handle_Box);
            Gtk_New_HBox (Container.Bar_Box);
            Gtk_New (Container.Handle, Arrow_Right, Shadow_Etched_In);
         when Side_Left | Side_Right =>
            Gtk.Frame.Initialize (Container);
            Initialize_Class_Record
            (  Container,
               Signals,
               Class_Record,
               Class_Name
            );
            Gtk_New_HBox (Container.Content);
            Gtk_New_VBox (Container.Handle_Box);
            Gtk_New_VBox (Container.Bar_Box);
            Gtk_New (Container.Handle, Arrow_Down, Shadow_Etched_In);
      end case;
      Gtk.Frame.Add
      (  Gtk_Frame_Record (Container.all)'Access,
         Container.Content
      );
      Pack_Start
      (  Container.Content,
         Container.Handle_Box,
         False,
         False
      );

      Gtk_New (Events);
      Add (Events, Container.Handle);
      Set_Property (Events, Can_Focus_Property, True);
      Add_Events
      (  Events,
         Key_Press_Mask or Button_Press_Mask
      );
      Event_Handlers.Connect
      (  Events,
         "button_press_event",
         Event_Handlers.To_Marshaller (Button_Press'Access),
         Container.all'Access
      );
      Event_Handlers.Connect
      (  Events,
         "key_press_event",
         Event_Handlers.To_Marshaller (Button_Press'Access),
         Container.all'Access
      );
      Pack_Start (Container.Handle_Box, Events, False, False);

      Pack_Start
      (  Container.Handle_Box,
         Container.Bar_Box,
         False,
         False
      );

      Action_Handlers.Connect
      (  Container,
         "expand",
         Action_Handlers.To_Marshaller (Expand'Access),
         Container.all'Access
      );
      Action_Handlers.Connect
      (  Container,
         "shrink",
         Action_Handlers.To_Marshaller (Shrink'Access),
         Container.all'Access
      );
      Show_All (Container.Content);

   end Initialize;

   function Is_Expanded
            (  Container : access Gtk_Slat_Record
            )  return Boolean is
   begin
      return Container.Expanded;
   end Is_Expanded;

   procedure Remove
             (  Container : access Gtk_Slat_Record;
                Widget    : access Gtk_Widget_Record'Class
             )  is
   begin
      if Widget = Get (Container.Child) then
         if Container.Expanded then
            Remove
            (  Gtk_Box_Record (Container.Content.all)'Access,
               Widget
            );
         end if;
         Invalidate (Container.Child);
      end if;
   end Remove;

   procedure Set_Expanded
             (  Container : access Gtk_Slat_Record;
                Expanded  : Boolean
             )  is
      Child : Gtk_Widget;
   begin
      if Container.Expanded then
         if not Expanded then
            Container.Expanded := False;
            if Is_Valid (Container.Child) then
               Remove
               (  Gtk_Box_Record (Container.Content.all)'Access,
                  Get (Container.Child)
               );
            end if;
            case Container.Mode is
               when Side_Left | Side_Right =>
                  Set (Container.Handle, Arrow_Down, Shadow_Etched_In);
               when Side_Top | Side_Bottom =>
                  Set (Container.Handle, Arrow_Right, Shadow_Etched_In);
            end case;
--Ref (Container.Handle_Box);
--Remove (Gtk_Frame_Record (Container.all)'Access, Container.Content);
--Gtk_New_VBox (Container.Content);
--Pack_Start (Container.Content, Container.Handle_Box, False, False);
--Add (Gtk_Frame_Record (Container.all)'Access, Container.Content);
--            Set_Size_Request (Container, 10, 20);
--declare
--Size : Gtk_Allocation;
--begin
--Size.X := Get_Allocation_X (Container);
--Size.Y := Get_Allocation_Y (Container);
--Size.Height := 5;
--Size.Width  := 5;
--Size_Allocate (Container, Size);
--end;
            GtkAda.Handlers.Widget_Callback.Emit_By_Name
            (  Container,
               "shrunk"
            );
         end if;
      else
         if Expanded then
            Container.Expanded := True;
            if Is_Valid (Container.Child) then
               case Container.Mode is
                  when Side_Left =>
                     Set
                     (  Container.Handle,
                        Arrow_Right,
                        Shadow_Etched_In
                      );
                  when Side_Right =>
                     Set
                     (  Container.Handle,
                        Arrow_Left,
                        Shadow_Etched_In
                     );
                  when Side_Top =>
                     Set
                     (  Container.Handle,
                        Arrow_Down,
                        Shadow_Etched_In
                     );
                  when Side_Bottom =>
                     Set
                     (  Container.Handle,
                        Arrow_Up,
                        Shadow_Etched_In
                     );
               end case;
               Child := Get (Container.Child).all'Access;
               Pack_Start (Container.Content, Child, True, True);
               case Container.Mode is
                  when Side_Top | Side_Left =>
                     null;
                  when Side_Bottom | Side_Right =>
                     Reorder_Child (Container.Content, Child, 0);
               end case;
               Show_All (Child);
               GtkAda.Handlers.Widget_Callback.Emit_By_Name
               (  Container,
                  "expanded"
               );
            end if;
         end if;
      end if;
   end Set_Expanded;

   procedure Set_Spacing
             (  Container : access Gtk_Slat_Record;
                Spacing   : GInt
             )  is
   begin
      Set_Spacing
      (  Gtk_Box_Record (Container.Content.all)'Access,
         Spacing
      );
   end Set_Spacing;

   procedure Shrink
             (  Widget : access Gtk_Widget_Record'Class;
                Slat   : Gtk_Slat
             )  is
   begin
      Set_Expanded (Slat, False);
   end Shrink;

end Gtk.Slat;
