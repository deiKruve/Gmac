--                                                                    --
--  package                         Copyright (c)  Dmitry A. Kazakov  --
--     Gtk.Slat                                    Luebeck            --
--  Interface                                      Autumn, 2007       --
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

with Gdk.Event;      use Gdk.Event;
with Gtk.Arrow;      use Gtk.Arrow;
with Gtk.Box;        use Gtk.Box;
with Gtk.Bin;        use Gtk.Bin;
with Gtk.Container;  use Gtk.Container;
with Gtk.Enums;      use Gtk.Enums;
with Gtk.Frame;      use Gtk.Frame;
with Gtk.Widget;     use Gtk.Widget;

with GLib.Object.Strong_References;
with Gtk.Handlers;

package Gtk.Slat is
--
-- Gtk_Slat_Record -- The widget expanding its child
--
-- Signals :
--
--    expand   - Emitted to expand the child
--    expanded - Emitted when the child has been expanded
--    shrink   - Emitted to shrink the child
--    shrunk   - Emitted when the child has been shrunk
--
   type Gtk_Slat_Record is new Gtk_Bin_Record with private;
   type Gtk_Slat is access all Gtk_Slat_Record'Class;
--
-- Add -- A child to the container
--
--    Container - The slat container
--    Widget    - The child to add
--
-- The  container  can  contain  only  one child. When a second child is
-- added it supersedes then first one.
--
   procedure Add
             (  Container : access Gtk_Slat_Record;
                Widget    : access Gtk_Widget_Record'Class
             );
--
-- Get -- The child
--
--    Container - The slat container
--
-- Returns :
--
--    The child of (can be null)
--
   function Get
            (  Container : access Gtk_Slat_Record
            )  return Gtk_Widget;
--
-- Get_Bar -- The container's bar
--
--    Container - The slat container
--
-- The  container has a part which is always visible. This part contains
-- a box which may be filled with other widgets.
--
-- Returns :
--
--    The box
--
   function Get_Bar
            (  Container : access Gtk_Slat_Record
            )  return Gtk_Box;
--
-- Get_Children -- The children
--
--    Container - The slat container
--
-- Returns :
--
--    The list of children, shall be freed by the caller
--
   function Get_Children
            (  Container : access Gtk_Slat_Record
            )  return Widget_List.Glist;
--
-- Get_Spacing -- Between the child and the handle
--
--    Container - The slat container
--
--  Returns :
--
--    The spacing
--
   function Get_Spacing
            (  Container : access Gtk_Slat_Record
            )  return GInt;
--
-- Get_Type -- The widget type
--
--  Returns :
--
--    The type
--
   function Get_Type return Gtk_Type;
--
-- Gtk_New -- Factory
--
--    Container - The slat container (result)
--    Location  - Of the handle
--
-- The parameter Location determines where the handle is located:
--
--    Side_Bottom - Under the child
--    Side_Left   - Left of the child
--    Side_Right  - Right of the child
--    Side_Top    - Above the child
--
   procedure Gtk_New
             (  Container : out Gtk_Slat;
                Location  : Gtk_Side_Type
             );
--
-- Is_Expanded -- The container
--
--    Container - The slat container
--
-- Returns :
--
--    True if the child is visible
--
   function Is_Expanded (Container : access Gtk_Slat_Record)
      return Boolean;
--
-- Remove -- The child
--
--    Container - The slat container
--    Widget - The child to remove
--
-- Nothing happens if Widget is not a child of Container
--
   procedure Remove
             (  Container : access Gtk_Slat_Record;
                Widget    : access Gtk_Widget_Record'Class
             );
--
-- Set_Expanded -- The container
--
--    Container - The slat container
--    Expanded  - The new state
--
   procedure Set_Expanded
             (  Container : access Gtk_Slat_Record;
                Expanded  : Boolean
             );
--
-- Set_Spacing -- Between the child and the handle
--
--    Container - The slat container
--    Spacing   - To set
--
   procedure Set_Spacing
             (  Container : access Gtk_Slat_Record;
                Spacing   : GInt
             );
--
-- Initialize -- Construction
--
--    Container - The slat container (result)
--    Location  - Of the handle
--
-- Each derived type is responsible to  call  this  procedure  upon  its
-- construction.
--
   procedure Initialize
             (  Container : access Gtk_Slat_Record'Class;
                Location  : Gtk_Side_Type
             );

private
   package Widget_References is
      new GLib.Object.Strong_References (Gtk_Widget_Record);
   use Widget_References;

   type Gtk_Slat_Record is new Gtk_Frame_Record with record
      Handle     : Gtk_Arrow;
      Content    : Gtk_Box;
      Handle_Box : Gtk_Box;
      Bar_Box    : Gtk_Box;
      Child      : Widget_References.Strong_Reference;
      Mode       : Gtk_Side_Type;
      Expanded   : Boolean := False;
   end record;

   function Button_Press
            (  Widget : access Gtk_Widget_Record'Class;
               Event  : Gdk_Event;
               Slat   : Gtk_Slat
            )  return Boolean;

   procedure Expand
             (  Widget : access Gtk_Widget_Record'Class;
                Slat   : Gtk_Slat
             );

   procedure Shrink
             (  Widget : access Gtk_Widget_Record'Class;
                Slat   : Gtk_Slat
             );

   package Event_Handlers is
      new Gtk.Handlers.User_Return_Callback
          (  Gtk_Widget_Record,
             Boolean,
             Gtk_Slat
          );
   package Action_Handlers is
      new Gtk.Handlers.User_Callback
          (  Gtk_Widget_Record,
             Gtk_Slat
          );

end Gtk.Slat;
