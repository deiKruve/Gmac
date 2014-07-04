------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                S I L M A R I L . F I L E _ S E L E C T O R               --
--                                                                          --
--                                  B o d y                                 --
--                                                                          --
--                     Copyright (C) 2014, Jan de Kruyf                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.                                               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
--                Silmaril is maintained by J de Kruijf Engineers           --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
-- its a dummy nomore
-- this is being replaced with the proper file selector


pragma Ada_2005;

with Glib.Object;
with Glib.Error; 
with Gtk.Main;
with Gtk.Builder;
with Gtkada.Builder;
with Gtk.Widget; 
with Gtk.Status_Bar;
with Gtk.Dialog;
with Gtk.Message_Dialog;
with Gtk.About_Dialog;
with Gtk.Window;
with Gtk.Text_View;
with Gtk.Text_Buffer;
with Gtk.Text_Iter;
with Gtk.Clipboard;
with Gtkada.File_Selection;
with Ada.Text_IO;
-- with Ada.Direct_IO;
with Ada.Tags;
with Ada.Unchecked_Deallocation;
-- with Ada.Strings.Unbounded;
with Ada.Directories;
with GNAT.Strings;
with POSIX;
with POSIX.IO;
with POSIX.Memory_Mapping;
with System.Storage_Elements;
-- with Interfaces.C.Strings;
-- with Silmaril.Reader;

---------------------
package body Test1 is

   
   ------------
   -- types  --
   ------------
   --type File_Name_String_S is new String;
   type File_Name_Ptr is access all String;
   type Ed_Record is new Glib.Object.GObject_Record with
      record
	 Window               : Gtk.Window.Gtk_Window;
	 Statusbar            : Gtk.Widget.Gtk_Widget;
	 Text_View            : Gtk.Widget.Gtk_Widget;
	 Statusbar_Context_Id : Gtk.Status_Bar.Context_Id;
	 File_Name            : access string;
      end record;
   type Ed_RecordPtr is access all Ed_Record;
   
   
   --------------
   -- globals  --
   --------------
   Builder      : Gtkada.Builder.Gtkada_Builder; 
   Editor       : access Ed_Record'Class;
   Errflag      : Boolean := False;
   
   
   -------------------------
   -- about box constants --
   -------------------------
   Author1s      : aliased  String := "Jan de Kruyf    (Ada Version)";
   Author2s      : aliased  String := "Micha Carrick  (original C version)";
   Comments      : constant String := "File Selector for Gmac";
   Copyrights    : constant String := "Copyright (c) 2007 Micah Carrick,"
     & ASCII.LF
     & "           (c) 2013 Jan de Kruyf";
   Versions      : constant String := "0.3";
   Program_Names : constant String := "Gmac Text Editor and File Selector";
   Icon_Names    : constant String := "gtk-edit";
   
   
   ------------------------------------
   -- save and open dialog constants --
   ------------------------------------
   Savemsg          : constant String := 
     "Do you want to save the changes you have made?";
   Savetitle        : constant String := "Save?";
   
   Save_Name_Prompt : constant String := "Select File name to save to:";
   Open_Name_Prompt : constant String := "Select File name to open:";
   
   
   ----------------------
   -- noname file name --
   ----------------------
   No_Name      : aliased String := "(UNTITLED)";
   
   
   ---------------
   -- utilities --
   ---------------
   procedure Free_Editor is new Ada.Unchecked_Deallocation
     (Object => Ed_Record, Name => Ed_RecordPtr);
   
   procedure Free_Name is new Ada.Unchecked_Deallocation
     (Object => String, Name => File_Name_Ptr);
   
   
   ------------------------------
   -- dislay error message box --
   ------------------------------
   procedure Error_Message (Message : String) 
   is
      Dialog  : Gtk.Message_Dialog.Gtk_Message_Dialog := null;
      function "or" (Left, Right: Gtk.Dialog.Gtk_Dialog_Flags) 
		    return Gtk.Dialog.Gtk_Dialog_Flags 
	renames Gtk.Dialog."or";
      X  : Gtk.Dialog.Gtk_Response_Type := 0;
   begin
      Ada.Text_IO.Put_Line (Message);
      Gtk.Message_Dialog.Gtk_New
	(Dialog    => Dialog,
	 Parent    => Editor.Window,
	 Flags     => Gtk.Dialog.Modal or Gtk.Dialog.Destroy_With_Parent,
	 Typ       => Gtk.Message_Dialog.Message_Error,
	 Buttons   => Gtk.Message_Dialog.Buttons_Close,
	 Message   => Message);
      X := Gtk.Dialog.Run
	(Dialog    => Gtk.Dialog.Gtk_Dialog (Dialog));
      Gtk.Widget.Destroy (Gtk.Widget.Gtk_Widget (Dialog));  
      Errflag := True;
   end Error_Message;
   
   
   ------------------------------
   -- display info message box --
   ------------------------------
   procedure Info_Message (Message : String) 
   is
      Dialog  : Gtk.Message_Dialog.Gtk_Message_Dialog;
      function "or" (Left, Right: Gtk.Dialog.Gtk_Dialog_Flags) 
		    return Gtk.Dialog.Gtk_Dialog_Flags 
	renames Gtk.Dialog."or";
      X  : Gtk.Dialog.Gtk_Response_Type := 0;
   begin
      Ada.Text_IO.Put_Line (Message);
      Gtk.Message_Dialog.Gtk_New
      	(Dialog    => Dialog,
	 Parent    => Editor.Window,
      	 Flags     => Gtk.Dialog.Modal or Gtk.Dialog.Destroy_With_Parent,
      	 Typ       => Gtk.Message_Dialog.Message_Info,
      	 Buttons   => Gtk.Message_Dialog.Buttons_Close,
	 Message   => Message);
      X := Gtk.Dialog.Run
      	(Dialog    => Gtk.Dialog.Gtk_Dialog (Dialog));
      Gtk.Widget.Destroy (Gtk.Widget.Gtk_Widget (Dialog)); 
   end Info_Message;
   
   
   --------------------------------
   -- reset the mini text editor --
   --------------------------------
   procedure Reset_Default_Status (Editor : access Ed_Record'Class) 
   is
      Mid : Gtk.Status_Bar.Message_Id;
   begin
      Gtk.Status_Bar.Pop
	(Statusbar   => Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context     => Editor.Statusbar_Context_Id);
      if Editor.File_Name = null then
	 Mid := Gtk.Status_Bar.Push 
	   (Statusbar	=> Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	    Context         => Editor.Statusbar_Context_Id,
	    Text            => "File: " & No_Name);
      else
	 Mid := Gtk.Status_Bar.Push 
	   (Statusbar	=> Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	    Context         => Editor.Statusbar_Context_Id,
	    Text            => "File: " & 
	      Ada.Directories.Base_Name (Editor.File_Name.all));
      end if;
   end Reset_Default_Status;
   
   
   -------------------------------------
   -- checks if anything needs saving --
   -------------------------------------
   
   -- textview must be passed as user data
   function Check_For_Save (User_Data : access Glib.Object.GObject_Record'Class) 
			   return Boolean 
   is
      Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
      function "or" (Left, Right: Gtk.Dialog.Gtk_Dialog_Flags) 
		    return Gtk.Dialog.Gtk_Dialog_Flags 
	renames Gtk.Dialog."or";
      Resp    : Gtk.Dialog.Gtk_Response_Type := Gtk.Dialog.Gtk_Response_None;
      B       : Boolean := False;
   begin
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View  => Gtk.Text_View.Gtk_Text_View (Editor.Text_View));
      if Gtk.Text_Buffer.Get_Modified (Buffer => Buffer) = True then
	 declare
	    Dialog : Gtk.Message_Dialog.Gtk_Message_Dialog;
	 begin
	    Gtk.Message_Dialog.Gtk_New 
	      (Dialog      => Dialog,
	       Parent      => Editor.Window,
	       Flags       => Gtk.Dialog.Modal or Gtk.Dialog.Destroy_With_Parent,
	       Typ         => Gtk.Message_Dialog.Message_Question,
	       Buttons     => Gtk.Message_Dialog.Buttons_Yes_No,
	       Message     => Savemsg);
	    Gtk.Window.Set_Title 
	      (Window	  => Gtk.Window.Gtk_Window (Dialog),
	       Title       => Savetitle);
	    Resp := Gtk.Dialog.Run (Dialog =>  Gtk.Dialog.Gtk_Dialog (Dialog));
	    case Resp is
	       when Gtk.Dialog.Gtk_Response_Yes =>
		  B := True;
	       when Gtk.Dialog.Gtk_Response_No  =>
		  B := False;
	       when others                      =>
		  Error_Message ("Programming error in Check_For_Save!");
	    end case;
	    Gtk.Widget.Destroy 
	      (Object  => Gtk.Widget.Gtk_Widget(Dialog));
	 end; 
      end if;
      return B;
   end Check_For_Save;
   
   
   ----------------------------
   -- file selection dialogs --
   ----------------------------
   function Get_Save_Filename (Editor : access Ed_Record'Class) return String 
   is
   begin
      return Gtkada.File_Selection.File_Selection_Dialog
	(Title     => Save_Name_Prompt);
   end Get_Save_Filename;
   
   
   function Get_Open_Filename (Editor : access Ed_Record'Class) return String 
   is
   begin
      return Gtkada.File_Selection.File_Selection_Dialog
	(Title     => Open_Name_Prompt);
   end Get_Open_Filename;   
   
   
   ----------------------------------------------------
   -- write the file in the mini text editor to disk --
   ----------------------------------------------------
   procedure Write_File (Editor : access Ed_Record'Class; 
			 Name : access String := null) 
   is
      Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Start : Gtk.Text_Iter.Gtk_Text_Iter;
      The_End : Gtk.Text_Iter.Gtk_Text_Iter;	
      Mid : Gtk.Status_Bar.Message_Id;
      Dead : Boolean; 
   begin
      -- set up editor filename
      if Name /= null then
	 if Editor.File_Name /= null then
	    Free_Name (File_Name_Ptr (Editor.File_Name));
	 end if;
	 Editor.File_Name := new String'(Name.all);
      end if;
      -- rename the old file, if any
      declare
      begin
	 if Ada.Directories.Exists (Editor.File_Name.all) then
	    if Ada.Directories.Exists (Editor.File_Name.all & "#") then
	       Ada.Directories.Delete_File (Editor.File_Name.all & "#");
	    end if;
	    Ada.Directories.Rename 
	      (Editor.File_Name.all, Editor.File_Name.all & "#");
	 end if;
      exception
	 when Ada.Directories.Name_Error =>
	    Error_Message ("Name does not identify an existing file.");
	 when Ada.Directories.Use_Error  =>
	    Error_Message ("Cannot delete or rename existing file.");
	 when others                     =>
	    M_Report_Error ("Silmaril.File_selector: device or status error");
	    Error_Message ("there was a device or status error"
			     & "renaming the old file.");
      end;
      -- set up status bar
      Mid := Gtk.Status_Bar.Push 
	(Statusbar	=> Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context        => Editor.Statusbar_Context_Id,
	 Text           => "Saving " & Editor.File_Name.all & ". . .");
      while Gtk.Main.Events_Pending loop
	 Dead := Gtk.Main.Main_Iteration;
      end loop;
      -- disable text view and get contents of buffer, and write it
      Gtk.Widget.Set_Sensitive
	(Widget         => Editor.Text_View,
	 Sensitive      => False);
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View      => Gtk.Text_View.Gtk_Text_View (Editor.Text_View));
      Gtk.Text_Buffer.Get_Bounds
	(Buffer         => Buffer,
	 Start          => Start,
	 The_End        => The_End);
      declare
	 S : aliased String := Gtk.Text_Buffer.Get_Text
	   (Buffer               => Buffer,
	    Start                => Start,
	    The_End              => The_End,
	    Include_Hidden_Chars => True);
	 File : Ada.Text_IO.File_Type;
      begin
	 Ada.Text_IO.Create
	   (File    => File,
	    Name    => Editor.File_Name.all);
	 Ada.Text_IO.Put 
	   (File    => File,
	    Item    => S);
	 Ada.Text_IO.Close (File => File);
      exception
	 when others =>
	    M_Report_Error ("Silmaril.File_selector: Error writing file.");
	    Error_Message ("There was an error writing the file.");
      end;
      -- pop the write status and enable the edit window again
      Gtk.Text_Buffer.Set_Modified
	(Buffer      => Buffer,
	 Setting     => False);
      Gtk.Widget.Set_Sensitive
	(Widget      => Editor.Text_View,
	 Sensitive   => True);
      Gtk.Status_Bar.Pop
	(Statusbar   => Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context     => Editor.Statusbar_Context_Id);
      Reset_Default_Status (Editor   => Editor);
   end Write_File;
   
   
   ----------------------------------------
   -- open a file in the minitext editor --
   ----------------------------------------
   procedure Open_File (Editor : access Ed_Record'Class; 
			Name : access String := null) 
   is
      Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Mid : Gtk.Status_Bar.Message_Id;
      Dead : Boolean; 
   begin
      -- set up status bar
      Mid := Gtk.Status_Bar.Push 
	(Statusbar	=> Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context        => Editor.Statusbar_Context_Id,
	 Text           => "Opening " & Name.all & ". . .");
      while Gtk.Main.Events_Pending loop
	 Dead := Gtk.Main.Main_Iteration;
      end loop;
      -- get file content
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View      => Gtk.Text_View.Gtk_Text_View (Editor.Text_View));
      Gtk.Widget.Set_Sensitive
	(Widget      => Editor.Text_View,
	 Sensitive   => False);      
      declare
	 Text_File    : POSIX.IO.File_Descriptor;
	 Text_Size    : System.Storage_Elements.Storage_Offset;
	 Text_Address : System.Address;
      begin
	 Text_File := POSIX.IO.Open 
	   (Name => POSIX.To_POSIX_String (Str => Name.all),
	    Mode => POSIX.IO.Read_Only);
	 Text_Size    := System.Storage_Elements.Storage_Offset (POSIX.IO.File_Size (Text_File));
	 Text_Address := POSIX.Memory_Mapping.Map_Memory 
	   (Length     => Text_Size,
	    Protection => POSIX.Memory_Mapping.Allow_Read,
	    Mapping    => POSIX.Memory_Mapping.Map_Shared,
	    File       => Text_File,
	    Offset     => 0);
	 declare
	    Text : String (1 .. Natural (Text_Size));
	    for Text'Address use Text_Address;
	 begin
	    Gtk.Text_Buffer.Set_Text
	      (Buffer	=> Buffer,
	       Text     => Text);
	 end;
	 POSIX.Memory_Mapping.Unmap_Memory 
	   (First  => Text_Address,
	    Length => Text_Size);
	 POSIX.IO.Close (File => Text_File);
      exception
      	 when POSIX.POSIX_Error  =>
	    M_Report_Error ("Silmaril.File_selector: could not read the program.");
	    Error_Message ("POSIX Error on Open: " & 
			     POSIX.Image (POSIX.Get_Error_Code));
      	 when others             =>
	    M_Report_Error ("Silmaril.File_selector: could not read the program.");
      	    Error_Message ("Open: an error occured");
      end;    

   Gtk.Text_Buffer.Set_Modified
	(Buffer      => Buffer,
	 Setting     => False);
      Gtk.Widget.Set_Sensitive
	(Widget      => Editor.Text_View,
	 Sensitive   => True);
      if Editor.File_Name /= null then
	 Free_Name (File_Name_Ptr (Editor.File_Name));
      end if;
      Editor.File_Name := new String'(Name.all);
      Gtk.Status_Bar.Pop
	(Statusbar   => Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context     => Editor.Statusbar_Context_Id);
      Reset_Default_Status (Editor   => Editor);
   end Open_File;
   
   
   ---------------------------------------------------
   -- send a selected file for execution to the CNC --
   ---------------------------------------------------
   procedure Execute_File (Editor : access Ed_Record'Class; 
			   Name   : access String := null)
   is
      Buffer  : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Start   : Gtk.Text_Iter.Gtk_Text_Iter;
      The_End : Gtk.Text_Iter.Gtk_Text_Iter;	
      Mid     : Gtk.Status_Bar.Message_Id;
      Dead    : Boolean;
   begin
      -- set up status bar
      Mid := Gtk.Status_Bar.Push 
	(Statusbar	=> Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context        => Editor.Statusbar_Context_Id,
	 Text           => "Transfering " & Editor.File_Name.all & ". . .");
      while Gtk.Main.Events_Pending loop
	 Dead := Gtk.Main.Main_Iteration;
      end loop;
      -- disable text view and get contents of buffer, and process it
      Gtk.Widget.Set_Sensitive
	(Widget         => Editor.Text_View,
	 Sensitive      => False);
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View      => Gtk.Text_View.Gtk_Text_View (Editor.Text_View));
      Gtk.Text_Buffer.Get_Bounds
	(Buffer         => Buffer,
	 Start          => Start,
	 The_End        => The_End);
      declare
	 S : aliased String := Gtk.Text_Buffer.Get_Text
	   (Buffer               => Buffer,
	    Start                => Start,
	    The_End              => The_End,
	    Include_Hidden_Chars => True);
	 File : Ada.Text_IO.File_Type;
      begin
	 -- call the text scanner here.
	 Reading_Result := Silmaril.Reader.Start_Reading (S);
	 if not Reading_Result then
	    M_Report_Error ("Silmaril.Reader: could not interpret the program");
	    Error_Message ("syntax error in the program.");
	 end if;
	 null;
      exception
	 when others =>
	    M_Report_Error ("Silmaril.Reader: could not interpret the program");
	    Error_Message ("There was an error preparing the file for execution");
      end;
      -- pop the write status and enable the edit window again
      Gtk.Text_Buffer.Set_Modified
	(Buffer      => Buffer,
	 Setting     => False);
      Gtk.Widget.Set_Sensitive
	(Widget      => Editor.Text_View,
	 Sensitive   => True);
      Gtk.Status_Bar.Pop
	(Statusbar   => Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context     => Editor.Statusbar_Context_Id);
      Reset_Default_Status (Editor   => Editor);
      Errflag := False;
   exception
      when others => 
	 Error_Message ("There was no file name");
   end Execute_File;
   
   
   ----------------
   -- callbacks  --
   ----------------
   -- file menu  --
   ----------------
   
   --textview must be passed as user data
   procedure On_Save_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
   begin
      if Editor.File_Name = null then
	 declare 
	    N : aliased String := Get_Save_Filename (Editor  => Editor);
	    File_Name : access String := N'Access;
	 begin
	    if N /= "" then
	       Write_File
		 (Editor  => Editor,
		  Name    => File_Name);
	    end if;
	 end;
      else -- there is a filename
	 Write_File
	   (Editor  => Editor,
	    Name    => null);
      end if;
   end On_Save_Menu_Item_Activate;
   
   
   procedure On_Save_As_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      N         : aliased String := Get_Save_Filename (Editor  => Editor);
      File_Name : access String := N'Access;
   begin
      if N /= "" then
	 Write_File
	   (Editor  => Editor,
	    Name    => File_Name);
      end if;
   end On_Save_As_Menu_Item_Activate;
   
   
   --the window must be passed as user data
   procedure On_Quit_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
   begin
      if Check_For_Save (Editor.Text_View) = True then
	 On_Save_Menu_Item_Activate (Editor.Text_View);
      end if;
      Gtk.Widget.Destroy 
	(Object  => Gtk.Widget.Gtk_Widget(User_Data));
      Free_Editor (Ed_RecordPtr (Editor));
      Gtk.Main.Main_Quit;
   end On_Quit_Menu_Item_Activate;
   
   
   --textview must be passed as user data
   procedure On_Open_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
   begin
      if Check_For_Save (User_Data) = True then
	 On_Save_Menu_Item_Activate (User_Data);
      end if;
      if Editor.File_Name /= null then
	 Free_Name (File_Name_Ptr (Editor.File_Name));
      end if;
      Editor.File_Name := null;
      declare 
	 N : aliased String := Get_Open_Filename (Editor  => Editor);
	 File_Name : access String := N'Access;
      begin
	 if N /= "" then
	    Open_File
	      (Editor  => Editor,
	       Name    => File_Name);
	 end if;
      end;
   end On_Open_Menu_Item_Activate;
   
   
   --textview must be passed as user data
   procedure On_New_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      function "=" (Left, Right: Ada.Tags.Tag) return Boolean renames Ada.Tags."=";
      Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
   begin
      if User_Data'Tag = Editor.Text_View'Tag then
	 Info_Message ("Bulls eye!");
	 null;
      end if;
      if Check_For_Save (User_Data) = True then
	 On_Save_Menu_Item_Activate (User_Data);
      end if;
      if Editor.File_Name /= null then
	 Free_Name (File_Name_Ptr (Editor.File_Name));
      end if;
      Editor.File_Name := null;
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View         => Gtk.Text_View.Gtk_Text_View (User_Data));
      Gtk.Text_Buffer.Set_Text
	(Buffer	=> Buffer,
	 Text          => "");
      Gtk.Text_Buffer.Set_Modified
	(Buffer      => Buffer,
	 Setting     => False);
      Reset_Default_Status (Editor);
   end On_New_Menu_Item_Activate;
   
   
   -------------------
   -- edit menu
   -------------------
   
   --textview must be passed as user data
   procedure On_Cut_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      Buffer    : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Clipboard : Gtk.Clipboard.Gtk_Clipboard;
   begin
      Clipboard := Gtk.Clipboard.Get;
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View         => Gtk.Text_View.Gtk_Text_View (User_Data));
      Gtk.Text_Buffer.Cut_Clipboard
	(Buffer            => Buffer,
	 Clipboard         => Clipboard,
	 Default_Editable  => True);
   end On_Cut_Menu_Item_Activate;
   
   
   --textview must be passed as user data
   procedure On_Copy_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      Buffer    : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Clipboard : Gtk.Clipboard.Gtk_Clipboard;
   begin
      Clipboard := Gtk.Clipboard.Get;
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View  => Gtk.Text_View.Gtk_Text_View (User_Data));
      Gtk.Text_Buffer.Copy_Clipboard
	(Buffer            => Buffer,
	 Clipboard         => Clipboard);
   end On_Copy_Menu_Item_Activate;
   
   
   --textview must be passed as user data
   procedure On_Paste_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      Buffer    : Gtk.Text_Buffer.Gtk_Text_Buffer;
      Clipboard : Gtk.Clipboard.Gtk_Clipboard;
   begin
      Clipboard := Gtk.Clipboard.Get;
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View  => Gtk.Text_View.Gtk_Text_View (User_Data));
      Gtk.Text_Buffer.Paste_Clipboard
	(Buffer            => Buffer,
	 Clipboard         => Clipboard,
	 Override_Location => null,
	 Default_Editable  => True);
      null;
   end On_Paste_Menu_Item_Activate;
   
   
   --textview must be passed as user data
   procedure On_Delete_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
      X      : Boolean;
   begin
      Buffer := Gtk.Text_View.Get_Buffer 
	(Text_View  => Gtk.Text_View.Gtk_Text_View (User_Data));
      X := Gtk.Text_Buffer.Delete_Selection
	(Buffer            => Buffer,
	 Interactive       => False,
	 Default_Editable  => True);
   end On_Delete_Menu_Item_Activate;
   
   
   -------------------
   -- Machine Menu  --
   -------------------
   
   procedure On_Execute_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
   begin
      if Editor.File_Name = null then
	 declare 
	    N : aliased String := Get_Save_Filename (Editor  => Editor);
	    File_Name : access String := N'Access;
	 begin
	    if N /= "" then
	       Write_File
		 (Editor  => Editor,
		  Name    => File_Name);
	    end if;
	    Execute_File (Editor  => Editor,
			  Name    => File_Name);
	 end;
      else -- there is a filename
	 Execute_File (Editor  => Editor,
		       Name    => Editor.File_Name);
      end if;
   end On_Execute_Menu_Item_Activate;
   
   
   ---------------
   -- Help menu --
   ---------------
   
   procedure On_About_Menu_Item_Activate 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
      About   : Gtk.About_Dialog.Gtk_About_Dialog;
      Authors : GNAT.Strings.String_List := (Author1s'Access,
					     Author2s'Access);
      X       : Gtk.Dialog.Gtk_Response_Type := 0;
   begin
      Gtk.About_Dialog.Gtk_New (About  => About);
      
      Gtk.Window.Set_Transient_For
	(Window    => Gtk.Window.Gtk_Window (About),
	 Parent    => Gtk.Window.Gtk_Window (Editor.Window));
      Gtk.Window.Set_Destroy_With_Parent 
	(Window    => Gtk.Window.Gtk_Window (About), 
	 Setting   => True);
      Gtk.Window.Set_Modal 
	(Window    => Gtk.Window.Gtk_Window (About), 
	 Modal     => True);
      
      Gtk.About_Dialog.Set_Authors
	(About     => About,
	 Authors   => Authors);
      Gtk.About_Dialog.Set_Comments 
	(About     => About,
	 Comments  => Comments);
      Gtk.About_Dialog.Set_Copyright
	(About     => About,
	 Copyright =>  Copyrights);
      Gtk.About_Dialog.Set_Version
	(About     => About,
	 Version   => Versions);
      Gtk.About_Dialog.Set_Program_Name
	(About     => About,
	 Name      => Program_Names);
      Gtk.About_Dialog.Set_Logo_Icon_Name
	(About     => About,
	 Icon_Name => Icon_Names);
      
      --Gtk.Window.Present 
      --(Window    => Gtk.Window.Gtk_Window (About));
      X := Gtk.Dialog.Run
      	(Dialog    => Gtk.Dialog.Gtk_Dialog (About));
      Gtk.Widget.Destroy 
	(Object  => Gtk.Widget.Gtk_Widget(About));
   end On_About_Menu_Item_Activate;
   
   
   ---------------------------
   -- window manager events --
   ---------------------------
   
   --window must be passed as user data
   function On_Window_Delete_Event 
     (User_Data : access Glib.Object.GObject_Record'Class) return Boolean 
   is
   begin
      if Check_For_Save (User_Data) = True then
	 On_Save_Menu_Item_Activate (User_Data);
      end if;
      return False; --propagate event
   end On_Window_Delete_Event;
   
   
   --window must be passed as user data
   function On_Window_Destroy_Event 
     (User_Data : access Glib.Object.GObject_Record'Class) return Boolean 
   is
   begin
      return False; --propagate event
   end On_Window_Destroy_Event;
   

   --window must be passed as user data
   procedure On_Window_Destroy 
     (User_Data : access Glib.Object.GObject_Record'Class) 
   is
   begin
      Gtk.Widget.Destroy 
	(Object  => Gtk.Widget.Gtk_Widget(User_Data)); --Editor.Window));
      Free_Editor (Ed_RecordPtr (Editor));
      Gtk.Main.Main_Quit;
   end On_Window_Destroy;
   
   
   -----------------------------
   --          Main           --
   -- startup of this program --
   -----------------------------
   procedure Main 
   is
      function "=" (Left, Right: Gtk.Widget.Gtk_Widget) return Boolean 
	renames Gtk.Widget."=";
      function "=" (Left, Right: Gtk.Window.Gtk_Window) return Boolean 
	renames Gtk.Window."=";
      Error        : Glib.Error.GError;
      function "=" (Left, Right: Glib.Error.GError) return Boolean 
	renames Glib.Error."=";
   begin
      Editor := new Ed_Record;
      Gtk.Main.Init;
      Gtkada.Builder.Gtk_New (Builder);
      Error := Gtk.Builder.Add_From_File (Gtk.Builder.Gtk_Builder (Builder), 
					  "file1.glade");
      if Error /= null then
	 Error_Message (Glib.Error.Get_Message (Error));
	 Glib.Error.Error_Free (Error);
	 return;
      end if;
      Editor.Window    := Gtk.Window.Gtk_Window 
	(Gtk.Builder.Get_Widget 
	   (Builder       => Gtk.Builder.Gtk_Builder (Builder),
	    Name          => "window"));
      if Editor.Window = null then
	 Error_Message ("window gadget is not to be found");
	 return;
      end if;
      Editor.Statusbar := Gtk.Builder.Get_Widget 
	(Builder       => Gtk.Builder.Gtk_Builder (Builder),
	 Name          => "statusbar");
      if Editor.Statusbar = null then
	 Error_Message ("statusbar gadget is not to be found");
	 return;
      end if;
      Editor.Statusbar_Context_Id := Gtk.Status_Bar.Get_Context_Id
	(Statusbar    => Gtk.Status_Bar.Gtk_Status_Bar (Editor.Statusbar),
	 Context_Description => "My Text Editor");
      Editor.Text_View := Gtk.Builder.Get_Widget 
	(Builder       => Gtk.Builder.Gtk_Builder (Builder),
	 Name          => "textview");
      if Editor.Text_View = null then
	 Error_Message ("textview gadget is not to be found");
	 return;
      end if;
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_new_menu_item_activate", 
	 Handler      => On_New_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_open_menu_item_activate", 
	 Handler      => On_Open_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_save_menu_item_activate", 
	 Handler      => On_Save_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_save_as_menu_item_activate", 
	 Handler      => On_Save_As_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_quit_menu_item_activate", 
	 Handler      => On_Quit_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_cut_menu_item_activate", 
	 Handler      => On_Cut_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_copy_menu_item_activate", 
	 Handler      => On_Copy_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_paste_menu_item_activate", 
	 Handler      => On_Paste_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_delete_menu_item_activate", 
	 Handler      => On_Delete_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_execute_menu_item_activate", 
	 Handler      => On_Execute_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_about_menu_item_activate", 
	 Handler      => On_About_Menu_Item_Activate'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_window_delete_event", 
	 Handler      => On_Window_Delete_Event'Access);
      Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_window_destroy_event", 
	 Handler      => On_Window_Destroy_Event'Access);
       Gtkada.Builder.Register_Handler 
	(Builder      => Builder,
	 Handler_Name => "on_window_destroy", 
	 Handler      => On_Window_Destroy'Access);
     Gtkada.Builder.Do_Connect
	(Builder      => Builder);
      Glib.Object.Unref (Glib.Object.GObject (Builder));
      Reset_Default_Status (Editor);
      Editor.File_Name := null;
      Gtk.Main.Main;
   end Main;
   
   
   -------------------------
   -- Main Entry point to --
   -- this program        --
   -------------------------
   function Start return Boolean 
   is
   begin
      Main;
      return Errflag;
   end Start;
   
end Test1;

--------------------------------------------------------------
-- from here:
-- http://rosettacode.org/wiki/Read_entire_file
--------------------------------------------------------------
-- read a file with Ada.Direct_IO
-- Using Ada.Directories to first ask for the file size 
-- and then Ada.Direct_IO to read the whole file in one chunk: 
--------------------------------------------------------------
      --  declare
      --  	 File_Size : Natural := Natural (Ada.Directories.Size (Name.all));
      --  	 subtype File_String    is String (1 .. File_Size);
      --  	 package File_String_IO is new Ada.Direct_IO (File_String);
      --  	 File     : File_String_IO.File_Type;
      --  	 Contents : File_String;	 
      --  begin
      --  	 File_String_IO.Open  
      --  	   (File        => File, 
      --  	    Mode        => File_String_IO.In_File,
      --  	    Name        => Name.all);
      --  	 File_String_IO.Read  
      --  	   (File        => File, 
      --  	    Item        => Contents);
      --  	 File_String_IO.Close (File  => File);
      --  	 Gtk.Text_Buffer.Set_Text
      --  	   (Buffer	=> Buffer,
      --  	    Text        => Contents);
      --  exception
      --  	 when File_String_IO.Name_Error                            =>
      --  	    Error_Message ("Open: No File of That Name");
      --  	 when File_String_IO.Data_Error | File_String_IO.End_Error =>
      --  	    Error_Message ("Open: corrupt data");
      --  	 when others                                               =>
      --  	    Error_Message ("Open: an error occured");
      --  end;      

-----------------------------------------------------------------------
-- read a file with POSIX 
-- Mapping the whole file into the address space of your process 
-- and then overlaying the file with a String object. 
------------------------------------------------------------------------
      --  declare
      --  	 Text_File    : POSIX.IO.File_Descriptor;
      --  	 Text_Size    : System.Storage_Elements.Storage_Offset;
      --  	 Text_Address : System.Address;
      --  begin
      --  	 Text_File := POSIX.IO.Open 
      --  	   (Name => POSIX.To_POSIX_String (Str => Name.all),
      --  	    Mode => POSIX.IO.Read_Only);
      --  	 Text_Size    := System.Storage_Elements.Storage_Offset (POSIX.IO.File_Size (Text_File));
      --  	 Text_Address := POSIX.Memory_Mapping.Map_Memory 
      --  	   (Length     => Text_Size,
      --  	    Protection => POSIX.Memory_Mapping.Allow_Read,
      --  	    Mapping    => POSIX.Memory_Mapping.Map_Shared,
      --  	    File       => Text_File,
      --  	    Offset     => 0);
      --  	 declare
      --  	    Text : String (1 .. Natural (Text_Size));
      --  	    for Text'Address use Text_Address;
      --  	 begin
      --  	    Gtk.Text_Buffer.Set_Text  -- copy the text into some editor buffer
      --  	      (Buffer	=> Buffer,
      --  	       Text     => Text);
      --  	 end;
      --  	 POSIX.Memory_Mapping.Unmap_Memory 
      --  	   (First  => Text_Address,
      --  	    Length => Text_Size);
      --  	 POSIX.IO.Close (File => Text_File);
      --  exception
      --  	 when POSIX.POSIX_Error  =>
      --  	    Error_Message ("POSIX Error on Open: " & POSIX.Image (POSIX.Get_Error_Code));
      --  	 when others             =>
      --  	    Error_Message ("Open: an error occured");
      --  end;    
