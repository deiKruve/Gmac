--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Image_Button                            Luebeck            --
--  Implementation                                 Winter, 2007       --
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

with Gtk.Image;  use Gtk.Image;

with Gtk.Object.Checked_Destroy;

package body Gtk.Image_Button is

   function Get_Box
            (  Button : access Gtk_Image_Button_Record
            )  return Gtk_Box is
   begin
      return Button.Box;
   end Get_Box;

   function Get_Label
            (  Button : access Gtk_Image_Button_Record
            )  return Gtk_Label is
   begin
      return Button.Label;
   end Get_Label;

   procedure Gtk_New
             (  Button : out Gtk_Image_Button;
                Image  : access Gtk_Widget_Record'Class;
                Label  : UTF8_String := ""
             )  is
      Widget : Gtk_Image_Button;
   begin
      Widget := new Gtk_Image_Button_Record;
      Initialize (Widget, Image, Label);
      Button := Widget;
   exception
      when others =>
         Gtk.Object.Checked_Destroy (Gtk.Object.Gtk_Object (Widget));
         Widget := null;
         raise;
   end Gtk_New;

   procedure Gtk_New
             (  Button   : out Gtk_Image_Button;
                Stock_Id : String;
                Size     : Gtk_Icon_Size;
                Label    : UTF8_String := ""
             )  is
      Image : Gtk_Image;
   begin
      Gtk_New (Image, Stock_Id, Size);
      Gtk_New (Button, Image, Label);
   exception
      when others =>
         if Image /= null then
            Unref (Image);
            raise;
         end if;
   end Gtk_New;

   procedure Initialize
             (  Button : access Gtk_Image_Button_Record'Class;
                Image  : access Gtk_Widget_Record'Class;
                Label  : UTF8_String
             )  is
   begin
      Gtk.Button.Initialize (Button, "");
      Gtk_New (Button.Label, Label);
      Gtk_New_HBox (Button.Box, False, 0);
      Set_Border_Width (Button.Box, 0);
      Pack_Start (Button.Box, Image, False, False);
      Pack_Start (Button.Box, Button.Label, False, False);
      Show (Image);
      Show (Button.Label);
      Add (Button, Button.Box);
   end Initialize;

end Gtk.Image_Button;
