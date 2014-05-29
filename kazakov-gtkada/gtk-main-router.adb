--                                                                    --
--  package Gtk.Main.Router         Copyright (c)  Dmitry A. Kazakov  --
--  Implementation                                 Luebeck            --
--                                                 Spring, 2006       --
--                                                                    --
--                                Last revision :  09:51 13 May 2012  --
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

with Ada.Characters.Handling;  use Ada.Characters.Handling;
with Ada.Characters.Latin_1;   use Ada.Characters.Latin_1;
with Ada.Exceptions;           use Ada.Exceptions;
with Ada.Streams;              use Ada.Streams;
with Ada.Strings.Fixed;        use Ada.Strings.Fixed;
with Ada.Task_Identification;  use Ada.Task_Identification;
with Gdk.Color.IHLS;           use Gdk.Color.IHLS;
with GLib.Messages;            use GLib.Messages;
with GLib.Values;              use GLib.Values;
with GNAT.Sockets;             use GNAT.Sockets;
with GNAT.Traceback;           use GNAT.Traceback;
with GNAT.Traceback.Symbolic;  use GNAT.Traceback.Symbolic;
with Gtk.Box;                  use Gtk.Box;
with Gtk.Check_Button;         use Gtk.Check_Button;
with Gtk.Clipboard;            use Gtk.Clipboard;
with Gtk.Image;                use Gtk.Image;
with Gtk.Image_Menu_Item;      use Gtk.Image_Menu_Item;
with Gtk.Menu;                 use Gtk.Menu;
with Gtk.Missed;               use Gtk.Missed;
with Gtk.Scrolled_Window;      use Gtk.Scrolled_Window;
with Gtk.Stock;                use Gtk.Stock;
with Gtk.Text_Buffer;          use Gtk.Text_Buffer;
with Gtk.Text_Iter;            use Gtk.Text_Iter;
with Gtk.Text_Tag;             use Gtk.Text_Tag;
with Gtk.Text_View;            use Gtk.Text_View;
with Gtk.Toggle_Button;        use Gtk.Toggle_Button;
with Gtk.Widget;               use Gtk.Widget;
with Pango.Font;               use Pango.Font;
with System;                   use System;
with System.Storage_Elements;  use System.Storage_Elements;

with Ada.Unchecked_Deallocation;
with Ada.Unchecked_Conversion;
with Gtk.Handlers;

package body Gtk.Main.Router is
--
-- Gateway_State -- The  state  of  the  protected  object   controlling
--                  interaction between the main loop task  and  an  Ada
-- task  requesting  servicing.  The following diagram illustrates state
-- transitions upon a request.
--
--        main loop                   state       task
--           :                          |           |
--           :                         Idle         |__
--        sleeping                      |              | Request_Service
--           :                         Busy <--------- |
--  timer -->|                          |    (data)  __|
--           |__                        |           :
--              | Initiate_Service      |           :
--              | Service (data)        |        waiting
--              | Complete_Service --> Ready        :
--            __|                       |           :__
--           |                          |              | Serviced
--           :                         Idle <--------- |
--        sleeping                      |           .__|
--           :                          |           |
--
   type Gateway_State is (Idle, Failed, Ready, Busy, Quitted);
   subtype Completed is Gateway_State range Idle..Ready;

   function On_Quit (Data : Address) return GBoolean;
   pragma Convention (C, On_Quit);
   type On_Quit_Ptr is access function (Data : Address) return GBoolean;
   pragma Convention (C, On_Quit_Ptr);

   GPS_Prompt   : constant String := "GPS>> ";
   GPS_Port     : Natural         := 50_000;
   Connected    : Boolean         := False;
   Main         : Task_ID         := Null_Task_ID;
   Trace_Dialog : Gtk_Dialog;
   Channel      : Socket_Type;
   Command      : Unbounded_String;

   function Where (Text : String) return String is
   begin
      return " in Gtk.Main.Router." & Text;
   end Where;

   protected Gateway is
      procedure Abort_Service (Error : Exception_Occurrence);
      procedure Complete_Service;
      entry Initiate_Service (Data : out Request_Data_Ptr);
      entry Request_Service
            (  Data        : in out Request_Data'Class;
               Synchronous : Boolean
            );
      procedure Quit;
   private
      entry Serviced
            (  Data        : in out Request_Data'Class;
               Synchronous : Boolean
            );
      Fault : Exception_Occurrence;
      State : Gateway_State := Idle;
      Call  : Boolean; -- True if active request is synchronous
      Data  : Request_Data_Ptr;
   end Gateway;
--
-- Callback -- Called from the main loop on timer events
--
   function Callback return Boolean is
      Data : Request_Data_Ptr;
   begin
      loop
         Gateway.Initiate_Service (Data);
         exit when Data = null;
         begin
            Service (Data.all);
            Gateway.Complete_Service;
         exception
            when Error : others =>
               Gateway.Abort_Service (Error);
         end;
      end loop;
      return True;
   end Callback;

   protected body Gateway is

      procedure Abort_Service (Error : Exception_Occurrence) is
      begin
         if Call then
            State := Failed;
            Save_Occurrence (Fault, Error);
         else
            State := Idle;
         end if;
      end Abort_Service;

      procedure Complete_Service is
      begin
         if Call then
            State := Ready;
         else
            State := Idle;
         end if;
      end Complete_Service;

      entry Initiate_Service
            (  Data : out Request_Data_Ptr
            )  when not (  State in Completed        -- Not before
                        and then                     -- Request_Service
                           Request_Service'Count > 0 -- when completed
                        )  is
      begin
         if State = Busy then
            Data := Gateway.Data;
         else
            Data := null;
         end if;
      end Initiate_Service;

      procedure Quit is
      begin
         State := Quitted;
      end Quit;

      entry Request_Service
            (  Data        : in out Request_Data'Class;
               Synchronous : Boolean
            )  when State = Idle or else State = Quitted is
      begin
         if State = Quitted then
            raise Quit_Error;
         end if;
         Gateway.Data := Data'Unchecked_Access;
         Call  := Synchronous;
         State := Busy;
         if Synchronous then
            requeue Serviced;
         end if;
      end Request_Service;

      entry Serviced
            (  Data        : in out Request_Data'Class;
               Synchronous : Boolean
            )  when (  State = Ready
                    or else
                       State = Failed
                    or else
                       State = Quitted
                    )  is
      begin
         if State = Quitted then
            raise Quit_Error;
         elsif State = Failed then
            State := Idle;
            Reraise_Occurrence (Fault);
         else
            State := Idle;
         end if;
      end Serviced;

   end Gateway;

   package body Generic_Message is

      procedure Free is
         new Ada.Unchecked_Deallocation
             (  Message_Data,
                Message_Data_Ptr
             );

      procedure Send
                (  Handler : Handler_Procedure;
                   Data    : User_Data;
                   Timeout : Duration := 0.5
                )  is
         Message : Message_Data_Ptr := new Message_Data;
      begin
         Message.Handler := Handler;
         Message.Data    := Data;
         if Main = Current_Task then
            Service (Message.all);
         elsif Main = Null_Task_ID then
            raise Program_Error;
         else
            select
               Gateway.Request_Service (Message.all, False);
            or delay Timeout;
               raise Busy_Error;
            end select;
         end if;
      exception
         when others =>
            Free (Message);
            raise;
      end Send;

      procedure Service (Data : in out Message_Data) is
         Message : Message_Data_Ptr := Data'Unchecked_Access;
      begin
         Message.Handler (Message.Data);
         Free (Message);
      exception
         when Error : others =>
            Log
            (  GtkAda_Contributions_Domain,
               Log_Level_Critical,
               (  Exception_Information (Error)
               &  Where ("Generic_Message.Service")
            )  );
            Free (Message);
      end Service;

   end Generic_Message;
--
-- Connect -- To the GPS
--
-- The  procedure shows a dialog box while connecting to the GPS server.
-- The  dialog box shows connection error message when connection fails.
-- Waiting for connection can be canceled by closing the box.
--
   procedure Connect is
      Dialog  : Gtk_Dialog;
      Message : Unbounded_String;
      Label   : Gtk_Label;
   begin
      Gtk_New
      (  Dialog,
         (  "GPS at "
         &  Host_Name
         &  " port"
         &  Integer'Image (GPS_Port)
         ),
         null,
         Destroy_With_Parent + Modal
      );
      Gtk_New (Label, "...connecting...");
      Set_Line_Wrap (Label, True);
      Pack_Start (Get_VBox (Dialog), Label, True, True);
      declare
         --
         -- An independent timer for a connection  task  to  communicate
         -- with  the  dialog  box.  It  must be independent because the
         -- default timer may be blocked at this point.
         --
         package Timers is new Timeout (Boolean);
         --
         -- Connect_To_GPS -- The task connecting to GPS
         --
         task Connect_To_GPS;
         task body Connect_To_GPS is
            Address : Sock_Addr_Type;
         begin
            Connected := False;
            Create_Socket (Channel);
            Address.Addr := Addresses (Get_Host_By_Name ("localhost"));
            Address.Port := Port_Type (GPS_Port);
            begin
               Connect_Socket (Channel, Address);
               Connected := True;
            exception
               when Error : Socket_Error =>
                  Append
                  (  Message,
                     (  "Check if GPS is started with the server "
                     &  "option. For example"
                     &  Character'Val (10)
                     &  "  > gps --server="
                     &  Trim
                        (  Integer'Image (GPS_Port),
                           Ada.Strings.Both
                        )
                     &  Character'Val (10)
                     &  Exception_Message (Error)
                  )  );
               when Error : others =>
                  Append (Message, Exception_Information (Error));
            end;
         end Connect_To_GPS;
         --
         -- Connect_Callback -- Timer callback
         --
         -- When the task is terminated, the callback either  shows  the
         -- error message in the dialog box, or else closes it.
         --
         function Connect_Callback (Dummy : Boolean) return Boolean is
         begin
            if Connect_To_GPS'Terminated then
               if Length (Message) = 0 then
                  Response (Dialog, Gtk_Response_OK);
               elsif Label /= null then
                  Label := null;
                  Set_Text (Label, To_String (Message));
               end if;
            end if;
            return True;
         end Connect_Callback;

         Button : Gtk_Widget;
         ID     : Timeout_Handler_ID;
      begin
         Show_All (Dialog);
         Button :=
            Add_Button (Dialog, Stock_Close, Gtk_Response_Close);
         ID := Timers.Add (Guint32 (50), Connect_Callback'Access, True);
         case Run (Dialog) is
            when Gtk_Response_OK => -- Closed on success from the task
               Timeout_Remove (ID);
            when others =>          -- Closed on error or by user
               Timeout_Remove (ID);    -- Stop polling
               Close_Socket (Channel); -- Will aboort task if active
               Connected := False;
         end case;
      end;
      Destroy (Dialog);
   end Connect;
--
-- GPS_Read -- Reading GPS connection socket until prompt it received
--
   procedure GPS_Read is
      Buffer : Stream_Element_Array (1..1);
      Byte   : Character;
      From   : Sock_Addr_Type;
      Last   : Stream_Element_Offset;
      Index  : Positive := GPS_Prompt'First;
   begin
      loop
         Receive_Socket (Channel, Buffer, Last, From);
         Byte := Character'Val (Stream_Element'Pos (Buffer (1)));
         if Byte = GPS_Prompt (Index) then
            exit when Index = GPS_Prompt'Last;
            Index := Index + 1;
         elsif Index > GPS_Prompt'First then
            Index := GPS_Prompt'First;
            if Byte = GPS_Prompt (Index) then
               Index := GPS_Prompt'First + 1;
            end if;
         end if;
      end loop;
   end GPS_Read;
--
-- GPS_Send -- Writing into GPS socket
--
--    Command - The GPS command to send
--
   procedure GPS_Send (Command : String) is
      Buffer : Stream_Element_Array (1..Command'Length);
      for Buffer'Address use Command (Command'First)'Address;
      pragma Import (Ada, Buffer);
      Last : Stream_Element_Offset;
   begin
      Send_Socket (Channel, Buffer, Last);
   end GPS_Send;

   procedure Init
             (  Period   : Duration := 0.2;
                GPS_Port : Natural  := 50_000
             )  is
   begin
      Gtk.Main.Router.GPS_Port := GPS_Port;
      if Main = Null_Task_ID then
         Main := Current_Task;
         declare
            ID : Timeout_Handler_Id;
         begin
            ID :=
               Timeout_Add
               (  Guint32 (Float (Period) * 1000.0),
                  Callback'Access
               );
         end;
         declare
            function Internal
                     (  Main_Level : GUInt;
                        Func       : On_Quit_Ptr;
                        Data       : Address
                     )  return GInt;
            pragma Import (C, Internal, "gtk_quit_add");
            ID : GInt;
         begin
            ID := Internal (0, On_Quit'Access, Null_Address);
         end;
      end if;
   end Init;

   procedure Request (Data : in out Request_Data'Class) is
   begin
      if Main = Current_Task then
         Service (Data);
      elsif Main = Null_Task_ID then
         raise Program_Error;
      else
         Gateway.Request_Service (Data, True);
      end if;
   end Request;

   package body Generic_Callback_Request is

      procedure Request
                (  Callback : Callback_Procedure;
                   Data     : access User_Data
                )  is
         Marshaler : Callback_Data (Data);
      begin
         Marshaler.Callback := Callback;
         Request (Marshaler);
      end Request;

      procedure Service (Data : in out Callback_Data) is
      begin
         Data.Callback (Data.Parameters);
      end Service;

   end Generic_Callback_Request;

   type Callback_Request_Data is new Request_Data with record
      Callback : Gtk_Callback;
   end record;
   procedure Service (Data : in out Callback_Request_Data);

   procedure Service (Data : in out Callback_Request_Data) is
   begin
      Data.Callback.all;
   end Service;

   procedure Request (Service : Gtk_Callback) is
      Marshaler : Callback_Request_Data;
   begin
      Marshaler.Callback := Service;
      Request (Marshaler);
   end Request;

   type UTF8_String_Ptr is access all UTF8_String;
   type Say_Data is record
      Message       : UTF8_String_Ptr;
      Title         : UTF8_String_Ptr;
      Dialog_Type   : Message_Dialog_Type;
      Justification : Gtk_Justification;
      Parent        : Gtk_Window;
   end record;
   package Say_Callback is new Generic_Callback_Request (Say_Data);

   procedure Say (Data : access Say_Data) is
   begin
      if (  Button_OK
         =  Message_Dialog
            (  Msg           => Data.Message.all,
               Dialog_Type   => Data.Dialog_Type,
               Buttons       => Button_OK,
               Title         => Data.Title.all,
               Justification => Data.Justification,
               Parent        => Data.Parent
         )  )
      then
         null;
      end if;
   end Say;

   procedure Say
             (  Message       : UTF8_String;
                Title         : UTF8_String         := "";
                Dialog_Type   : Message_Dialog_Type := Information;
                Justification : Gtk_Justification   := Justify_Left;
                Parent        : Gtk_Window          := null
             )  is
      Message_Text : aliased UTF8_String := Message;
      Title_Text   : aliased UTF8_String := Title;
      Data         : aliased Say_Data :=
                     (  Message       => Message_Text'Unchecked_Access,
                        Title         => Title_Text'Unchecked_Access,
                        Dialog_Type   => Dialog_Type,
                        Justification => Justification,
                        Parent        => Parent
                     );
   begin
      Say_Callback.Request (Say'Access, Data'Access);
   end Say;

   type Trace_Request (Length : Natural; Break : Boolean) is record
      Text : String (1..Length);
   end record;

   package Trace_Callback is
      new Generic_Callback_Request (Trace_Request);

   package Dialog_Handlers is
      new Gtk.Handlers.Callback (Gtk_Dialog_Record);

   package View_Handlers is
      new Gtk.Handlers.Callback (Gtk_Text_View_Record);

   package Gtk_Image_Menu_Item_Handlers is
      new Gtk.Handlers.Callback (Gtk_Image_Menu_Item_Record);

   Quit_Handler  : Quit_Handler_ID := 0;
   Messages_List : Gtk_Text_Buffer;
   Step_Button   : Gtk_Widget;
   Run_Button    : Gtk_Widget;
   View          : Gtk_Text_View;
   Break_Button  : Gtk_Check_Button;

   type Tag_Index is mod 5;
   Tags        : array (Tag_Index) of Gtk_Text_Tag;
   Current_Tag : Tag_Index := 0;
--
-- On_Go_To_Location -- Event handler
--
   procedure On_Go_To_Location
             (  Item : access Gtk_Image_Menu_Item_Record'Class
             )  is
   begin
      if not Connected then
         Connect;
      end if;
      if Connected then
         GPS_Send (To_String (Command));
         GPS_Read;
      end if;
   end On_Go_To_Location;
--
-- On_Paste_Trace -- Event handler
--
   procedure On_Paste_Trace
             (  Item : access Gtk_Image_Menu_Item_Record'Class
             )  is
      Text    : String  := Wait_For_Text (Get);
      Pointer : Integer := Text'First;
      procedure Skip is
      begin
         while Pointer < Text'Last loop
            exit when Text (Pointer) /= ' ';
            Pointer := Pointer + 1;
         end loop;
      end Skip;
      function Get_Item return Address is
         Value : Integer_Address := 0;
      begin
         if Pointer + 1 > Text'Last then
            raise Constraint_Error;
         end if;
         if Text (Pointer..Pointer + 1) /= "0x" then
            raise Constraint_Error;
         end if;
         Pointer := Pointer + 2;
         while Pointer < Text'Last loop
            case Text (Pointer) is
               when '0'..'9' =>
                  Value :=
                     (  Value * 16
                     +  Character'Pos (Text (Pointer))
                     -  Character'Pos ('0')
                     );
               when 'a'..'f' =>
                  Value :=
                     (  Value * 16
                     +  Character'Pos (Text (Pointer))
                     -  Character'Pos ('a')
                     +  10
                     );
               when 'A'..'F' =>
                  Value :=
                     (  Value * 16
                     +  Character'Pos (Text (Pointer))
                     -  Character'Pos ('A')
                     +  10
                     );
               when others =>
                  exit;
            end case;
            Pointer := Pointer + 1;
         end loop;
         if Text (Pointer - 1) = 'x' then
            raise Constraint_Error;
         end if;
         return To_Address (Value);
      end Get_Item;
      Count : Natural := 0;
   begin
      declare
         Location : Address;
      begin
         while Pointer <= Text'Last loop
            Skip;
            Location := Get_Item;
            Count    := Count + 1;
         end loop;
      exception
         when others =>
            null;
      end;
      if Count > 0 then
         declare
            TB : Tracebacks_Array (1..Count);
         begin
            Pointer := Text'First;
            for Index in TB'Range loop
               Skip;
               TB (Index) := Get_Item;
            end loop;
            Trace
            (  "Symbolic stack traceback from the clipboard:" & LF
            &  Symbolic_Traceback (TB) &  LF
            );
         end;
      end if;
   end On_Paste_Trace;
--
-- On_Populate_Popup -- Event handler
--
   procedure On_Populate_Popup
             (  Dialog : access Gtk_Text_View_Record'Class;
                Params : GValues
             )  is
      Buffer : Gtk_Text_Buffer := Get_Buffer (Dialog);
      Widget : Gtk_Widget;
      Menu   : Gtk_Menu;
      Item   : Gtk_Image_Menu_Item;
      Icon   : Gtk_Image;
      Start  : Gtk_Text_Iter;
      Stop   : Gtk_Text_Iter;
      Can_Go : Boolean := False;
   begin
      Widget := Convert (Get_Address (Nth (Params, 1)));
      if Widget /= null and then Widget.all in Gtk_Menu_Record'Class
      then
         Menu := Gtk_Menu_Record'Class (Widget.all)'Unchecked_Access;

         if Wait_Is_Text_Available (Get) then -- Paste traceback item
            Gtk_New (Item, "Paste stack traceback");
            Gtk_New (Icon, Stock_Find, Icon_Size_Menu);
            Set_Image (Item, Icon);
            Show_All (Item);
            Gtk_Image_Menu_Item_Handlers.Connect
            (  Item,
               "activate",
               On_Paste_Trace'Access
            );
            Add (Menu, Item);
         end if;
         if Main /= Null_Task_ID then -- Go to the location item
            declare
               Buffer_X : GInt;
               Buffer_Y : GInt;
               Window_X : GInt;
               Window_Y : GInt;
               Moved    : Boolean;
            begin
               Get_Pointer (Dialog, Window_X, Window_Y);
               Window_To_Buffer_Coords
               (  Dialog,
                  Text_Window_Widget,
                  Window_X,
                  Window_Y,
                  Buffer_X,
                  Buffer_Y
               );
               Get_Iter_At_Location (Dialog, Start, Buffer_X, Buffer_Y);
               Copy (Start, Stop);
               Moved := True;
               while Moved and then not Starts_Line (Start) loop
                  Backward_Cursor_Position (Start, Moved);
               end loop;
               Moved := True;
               while Moved and then not Ends_Line (Stop) loop
                  Forward_Cursor_Position (Stop, Moved);
               end loop;
            end;
            declare
               Line    : String  := Get_Text (Buffer, Start, Stop);
               Pointer : Integer := Line'Last + 1;
            begin
               if (  Line'Length < 3
                  or else
                     Line (Line'First) /= '0'
                  or else
                     Line (Line'First + 1) /= 'x'
                  )
               then
                  goto Break;
               end if;
               loop
                  if Pointer = Line'First then
                     goto Break;
                  end if;
                  Pointer := Pointer - 1;
                  exit when Line (Pointer) not in '0'..'9';
               end loop;
               if (  Pointer - 4 < Line'First
                  or else
                     Line (Pointer - 4) /= '.'
                  or else
                     To_Lower (Line (Pointer - 3)) /= 'a'
                  or else
                     To_Lower (Line (Pointer - 2)) /= 'd'
                  or else
                     Line (Pointer) /= ':'
                  )
               then
                  goto Break;
               end if;
               Line (Pointer) := ' ';
               case To_Lower (Line (Pointer - 1)) is
                  when 's' | 'b' =>
                     Pointer := Pointer - 4;
                  when others =>
                     goto Break;
               end case;
               loop
                  if Pointer - 4 < Line'First then
                     goto Break;
                  end if;
                  exit when Line (Pointer - 4..Pointer - 1) = " at ";
                  Pointer := Pointer - 1;
               end loop;
               Can_Go := True;
               Command := To_Unbounded_String ("Editor.edit ");
               Append (Command, Line (Pointer..Line'Last));
               Append (Command, Character'Val (10));
            end;
<<Break>>   Gtk_New (Item, "Go to the source location");
            Set_Sensitive (Item, Can_Go);
            Gtk_New (Icon, Stock_Jump_To, Icon_Size_Menu);
            Set_Image (Item, Icon);
            Show_All (Item);
            Gtk_Image_Menu_Item_Handlers.Connect
            (  Item,
               "activate",
               On_Go_To_Location'Access
            );
            Add (Menu, Item);
         end if;
      end if;
   end On_Populate_Popup;

   function On_Quit (Data : Address) return GBoolean is
   begin
      Gateway.Quit;
      return 0;
   end On_Quit;

   procedure On_Response
             (  Dialog   : access Gtk_Dialog_Record'Class;
                Response : Glib.Values.GValues
             )  is
   begin
      case Gtk_Response_Type (Get_Int (Nth (Response, 1))) is
         when Gtk_Response_None =>
            Trace_Dialog := null;
         when Gtk_Response_Cancel =>
            Set_Active (Break_Button, False);
         when Gtk_Response_OK =>
            Set_Active (Break_Button, True);
         when others =>
            Destroy (Trace_Dialog);
            Trace_Dialog := null;
      end case;
   end On_Response;

   procedure Trace (Data : access Trace_Request) is
      Start : Gtk_Text_Iter;
      Stop  : Gtk_Text_Iter;
   begin
      if Trace_Dialog = null then
         declare
            Scroll : Gtk_Scrolled_Window;
            Button : Gtk_Widget;
            Font   : Pango_Font_Description :=
                        From_String ("monospace 10");
         begin
            Gtk_New (Trace_Dialog, "Trace", null, Destroy_With_Parent);

            Tags := (others => null);
            Gtk_New (Messages_List);
            Gtk_New (View, Messages_List);
            Unref (Messages_List);
            Modify_Font (View, Font);
            Free (Font);
               -- Get menu
            View_Handlers.Connect
            (  View,
               "populate-popup",
               On_Populate_Popup'Access
            );
               -- Scrolled window
            Gtk_New (Scroll);
            Set_Policy (Scroll, Policy_Automatic, Policy_Automatic);
            Add (Scroll, View);
            Pack_Start (Get_VBox (Trace_Dialog), Scroll);
               -- Break button
            Gtk_New (Break_Button, "Break");
            Set_Active (Break_Button, True);
            Pack_Start
            (  Get_Action_Area (Trace_Dialog),
               Break_Button,
               False,
               False
            );
               -- Continue button
            Step_Button :=
               Add_Button
               (  Trace_Dialog,
                  Stock_Media_Next,
                  Gtk_Response_OK
               );
            Run_Button :=
               Add_Button
               (  Trace_Dialog,
                  Stock_Media_Record,
                  Gtk_Response_Cancel
               );
            Button :=
               Add_Button
               (  Trace_Dialog,
                  Stock_Quit,
                  Gtk_Response_Close
               );
            Quit_Handler := Quit_Add_Destroy (1, Trace_Dialog);
            Dialog_Handlers.Connect
            (  Trace_Dialog,
               "response",
               On_Response'Access
            );
            Set_Default_Size (Trace_Dialog, 200, 400);
            Show_All (Trace_Dialog);
         end;
      end if;
      declare
         Offset : GInt := Get_Char_Count (Messages_List);
      begin
         Get_End_Iter (Messages_List, Start);
         Insert (Messages_List, Start, Data.Text);
         Get_Iter_At_Offset (Messages_List, Start, Offset);
      end;
      if Scroll_To_Iter (View, Start, 0.25, False, 0.0, 0.0) then
         null;
      end if;
         -- Colorize new text
      if Tags (Current_Tag) = null then
         Tags (Current_Tag) := Create_Tag (Messages_List);
         Gdk.Color.Set_Property
         (  Tags (Current_Tag),
            Background_Gdk_Property,
            To_RGB
            (  Val
               (  (  Hue        => 0,
                     Luminance  => 240 * 256,
                     Saturation => 29  * 256
                  ),
                  Natural (Current_Tag),
                  Tags'Length
         )  )  );
      end if;
      declare
         Offset : GInt := Get_Char_Count (Messages_List);
      begin
         Get_Iter_At_Offset (Messages_List, Stop, Offset);
      end;
      Apply_Tag (Messages_List, Tags (Current_Tag), Start, Stop);
      Current_Tag := Current_Tag + 1;
      if not (Data.Break or else Get_Active (Break_Button)) then
         return;
      end if;
         -- Setting buttons
      Set_Sensitive (Step_Button, True);
      Set_Sensitive (Run_Button,  True);
      Set_Default (Trace_Dialog, Step_Button);
      Set_Modal (Trace_Dialog, True);
      case Run (Trace_Dialog) is
         when Gtk_Response_Cancel | Gtk_Response_OK =>
            Set_Modal (Trace_Dialog, False);
            Set_Sensitive (Step_Button, False);
            Set_Sensitive (Run_Button,  False);
         when others =>
            null;
      end case;
   end Trace;

   procedure Trace
             (  Message : UTF8_String;
                Break   : Boolean := False
             )  is
      Data : aliased Trace_Request (Message'Length + 1, Break);
   begin
      Data.Text := Message & LF;
      Trace_Callback.Request (Trace'Access, Data'Access);
   end Trace;

   procedure Trace
             (  Error : Exception_Occurrence;
                Break : Boolean := True
             )  is
   begin
      Trace (Exception_Information (Error), Break);
   end Trace;

end Gtk.Main.Router;
