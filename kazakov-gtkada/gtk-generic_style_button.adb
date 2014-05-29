--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Generic_Style_Button                    Luebeck            --
--  Implementation                                 Spring, 2007       --
--                                                                    --
--                                Last revision :  21:24 10 Nov 2009  --
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

with GLib.Properties.Creation;     use GLib.Properties.Creation;
with GLib.Properties.Icon_Size;    use GLib.Properties.Icon_Size;
with GtkAda.Types;                 use GtkAda.Types;
with Gtk.Image;                    use Gtk.Image;
with Gtk.Widget.Styles;            use Gtk.Widget.Styles;
with Gtk.Widget.Styles.Icon_Size;  use Gtk.Widget.Styles.Icon_Size;

with GLib.Properties.Relief_Style;
with Gtk.Widget.Styles.Relief_Style;

package body Gtk.Generic_Style_Button is

   Class_Record : GObject_Class := Uninitialized_Class;

   procedure Finalize (Object : in out Tooltips_Ref) is
   begin
      if Object.Ref /= null then
         Unref (Object.Ref);
         Object.Ref := null;
      end if;
   end Finalize;

   function Get_Box
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Box is
   begin
      return Button.Box;
   end Get_Box;

   function Get_Label
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Label is
   begin
      return Button.Label;
   end Get_Label;

   function Get_Tooltips
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Tooltips is
   begin
      return Button.Tooltips.Ref;
   end Get_Tooltips;

   procedure Gtk_New
             (  Button   : out Gtk_Style_Button;
                Tooltips : Gtk_Tooltips := null
             )  is
      Widget : Gtk_Style_Button;
   begin
      Widget := new Gtk_Style_Button_Record;
      Gtk.Generic_Style_Button.Initialize (Widget, Tooltips);
      Button := Widget;
   exception
      when others =>
         if Widget /= null then
            Unref (Widget);
            raise;
         end if;
   end Gtk_New;

   procedure Initialize
             (  Button   : access Gtk_Style_Button_Record'Class;
                Tooltips : Gtk_Tooltips
             )  is
      To_Install : constant Boolean :=
         Class_Record = Uninitialized_Class;
   begin
      Initialize (Button, ""); -- Parent's initialization
      Initialize_Class_Record
      (  Button,
         Null_Array,
         Class_Record,
         Class_Name
      );
      if To_Install then
         Class_Install_Style_Property
         (  Class_Record,
            Gnew_Boolean
            (  Name    => "icon-left",
               Nick    => "Left",
               Blurb   => "Button icon located left of the label",
               Default => Icon_Left
         )  );
         Class_Install_Style_Property
         (  Class_Record,
            Gnew_String
            (  Name    => "icon-id",
               Nick    => "Icon",
               Blurb   => "Button icon (stock id)",
               Default => Icon
         )  );
         Install_Style
         (  Class_Record,
            GLib.Properties.Icon_Size.Property.Gnew_Enum
            (  Name    => "icon-size",
               Nick    => "Size",
               Blurb   => "Button icon size",
               Default => Gtk_Icon_Size_Enum'Val (Size)
         )  );
         Class_Install_Style_Property
         (  Class_Record,
            Gnew_String
            (  Name    => "label",
               Nick    => "Label",
               Blurb   => "Button label",
               Default => Label
         )  );
         Install_Style
         (  Class_Record,
            GLib.Properties.Relief_Style.Property.Gnew_Enum
            (  Name    => "relief-style",
               Nick    => "Relief",
               Blurb   => "Button relief style",
               Default => Relief
         )  );
         Class_Install_Style_Property
         (  Class_Record,
            Gnew_UInt
            (  Name    => "spacing",
               Nick    => "Spacing",
               Blurb   => "Spacing between icon and label",
               Minimum => 0,
               Maximum => GUInt (GInt'Last),
               Default => Spacing
         )  );
         Class_Install_Style_Property
         (  Class_Record,
            Gnew_String
            (  Name    => "tip",
               Nick    => "Tip",
               Blurb   => "Button tip",
               Default => Tip
         )  );
      end if;
      if Tooltips /= null then
         Button.Tooltips.Ref := Tooltips;
         Ref (Tooltips);
      end if;
      Gtk_New_HBox (Button.Box, False, 0);
      Set_Border_Width (Button.Box, 0);
      Add (Button, Button.Box);
      Style_Handlers.Connect
      (  Button,
         "style-set",
         Style_Handlers.To_Marshaller (Style_Set'Access)
      );
   end Initialize;

   procedure Style_Set
             (  Button : access Gtk_Style_Button_Record'Class
             )  is
      use Gtk.Widget.Styles.Relief_Style;
      Text : constant String := Style_Get (Button, "label");
   begin
      Set_Relief (Button, Style_Get (Button, "relief-style"));
      if Text'Length = 0 then
         if Button.Label /= null then
            Remove (Button.Box, Button.Label);
            Button.Label := null;
         end if;
      else
         if Button.Label = null then
            Gtk_New (Button.Label, Text);
            Ref (Button.Label);
         else
            Ref (Button.Label);
            Remove (Button.Box, Button.Label);
            Set_Text (Button.Label, Text);
         end if;
      end if;
      if Button.Tooltips.Ref /= null then
         Set_Tip
         (  Button.Tooltips.Ref,
            Button,
            Style_Get (Button, "tip")
         );
      end if;
      if Button.Image /= null then
         Remove (Button.Box, Button.Image);
      end if;
      Gtk_New
      (  Button.Image,
         Style_Get (Button, "icon-id"),
         Gtk_Icon_Size_Enum'Pos (Style_Get (Button, "icon-size"))
      );
      if Style_Get (Button, "icon-left") then
         Pack_Start (Button.Box, Button.Image, False, False);
         if Button.Label /= null then
            Pack_Start (Button.Box, Button.Label, False, False);
            Unref (Button.Label);
         end if;
      else
         if Button.Label /= null then
            Pack_Start (Button.Box, Button.Label, False, False);
            Unref (Button.Label);
         end if;
         Pack_Start (Button.Box, Button.Image, False, False);
      end if;
      Set_Spacing
      (  Button.Box,
         GInt (GUInt'(Style_Get (Button, "spacing")))
      );
      Show_All (Button.Box);
   end Style_Set;

end Gtk.Generic_Style_Button;
