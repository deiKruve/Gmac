--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Generic_Style_Button                    Luebeck            --
--  Interface                                      Spring, 2007       --
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
--
--  This  generic  package is provided to ease creation of buttons which
--  appearance  is  controlled  by the resource file. A package instance
--  corresponds to a class of button  widgets.  The  generic  parameters
--  are:
--
--  (o)  Class_Name  is name of the GTK+ class. This name appears in the
--       style  declaration  as the prefix of the corresponding property
--       name;
--  (o)  Label is the default button label when not  overridden  by  the
--       label style property;
--  (o)  Icon is the default  icon  stock  id  when  the  icon-id  style
--       property does not override it;
--  (o)  Relief is the default button relief style;
--  (o)  Size is the default icon size;
--  (o)  Tip is the default tooltip text.
--  (o)  Icon_Left is the icon location;
--
--  !!WARNING!!  This package has to  be  instantiated  at  the  library
--               level,  because  it  in  turn  instantiates the library
--  level package Gtk.Handlers.Callback.
--
with Gtk.Box;       use Gtk.Box;
with Gtk.Button;    use Gtk.Button;
with Gtk.Enums;     use Gtk.Enums;
with Gtk.Image;     use Gtk.Image;
with Gtk.Label;     use Gtk.Label;
with Gtk.Tooltips;  use Gtk.Tooltips;
with Gtk.Widget;    use Gtk.Widget;

with Ada.Finalization;
with Gtk.Handlers;

generic
   Class_Name : UTF8_String;
   Label      : UTF8_String      := "";
   Icon       : UTF8_String      := "";
   Icon_Left  : Boolean          := True;
   Size       : Gtk_Icon_Size    := Icon_Size_Small_Toolbar;
   Spacing    : GUInt            := 3;
   Tip        : UTF8_String      := "";
   Relief     : Gtk_Relief_Style := Relief_Normal;
package Gtk.Generic_Style_Button is
--
-- Class - The name of
--
   Class : String renames Class_Name;
--
-- Gtk_Style_Button_Record -- The button type
--
-- Style properties :
--
--    label        - The button label. String
--    icon-id      - The icon id. String
--    icon-size    - The icon size. Enumeration
--    icon-left    - The icon location. Boolean
--    relief-style - The button relief. Gtk.Enums.Gtk_Relief_Style
--    tip          - The tool tip
--    spacing      - Spacing between label and icon. GUInt
--
   type Gtk_Style_Button_Record is new Gtk_Button_Record with private;
   type Gtk_Style_Button is access all Gtk_Style_Button_Record'Class;
--
-- Get_Box -- Get the label box of the button
--
--    Button - The button
--
-- Returns :
--
--    The label box of the button
--
   function Get_Box
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Box;
--
-- Get_Label -- Get the label of the button
--
--    Button - The button
--
-- Returns :
--
--    The label of the button
--
   function Get_Label
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Label;
--
-- Get_Tooltips -- The tooltips group of the widget
--
--    Widget - The widget
--
-- Returns :
--
--    The tooltips group or null
--
   function Get_Tooltips
            (  Button : access Gtk_Style_Button_Record
            )  return Gtk_Tooltips;
--
-- Gtk_New -- Factory
--
--    Button   - The button (the result)
--    Tooltips - The tooltips group (optional)
--
-- The  parameter  Tooltips  specifies  the  group of tooltips which the
-- button's  one  should  belong  to. When specified as null, the button
-- will have no tip.
--
   procedure Gtk_New
             (  Button   : out Gtk_Style_Button;
                Tooltips : Gtk_Tooltips := null
             );
--
-- Initialize -- Construction
--
--    Button   - The button to initialize
--    Tooltips - The tooltips group (optional)
--
-- Each derived type is responsible to  call  this  procedure  upon  its
-- construction.
--
   procedure Initialize
             (  Button   : access Gtk_Style_Button_Record'Class;
                Tooltips : Gtk_Tooltips
             );

private
   type Tooltips_Ref is new Ada.Finalization.Controlled with record
      Ref : Gtk_Tooltips;
   end record;
   procedure Finalize (Object : in out Tooltips_Ref);

   type Gtk_Style_Button_Record is new Gtk_Button_Record with record
      Label    : Gtk_Label;
      Image    : Gtk_Image;
      Box      : Gtk_Box;
      Tooltips : Tooltips_Ref;
   end record;

   procedure Style_Set (Button : access Gtk_Style_Button_Record'Class);

   package Style_Handlers is
      new Gtk.Handlers.Callback (Gtk_Style_Button_Record);

end Gtk.Generic_Style_Button;
