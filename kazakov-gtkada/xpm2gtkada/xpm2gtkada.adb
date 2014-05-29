--                                                                    --
--  procedure XPM2GtkAda            Copyright (c)  Dmitry A. Kazakov  --
--     XPM to GtkAda converter                     Luebeck            --
--                                                 Summer, 2006       --
--  Implementation                                                    --
--                                Last revision :  20:45 23 Jun 2010  --
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
--  XPM  to  GtkAda converter is a small utility which reads an XPM file
--  from  the  standard input and creates Ada packages for embedding the
--  image into a GtkAda application. The generated files are named after
--  the  XPM  image  name  stored in the XPM file. Each XPM file usually
--  starts as:
--
--      /* XPM */
--      static char * <name> [] = {
--
--  1. RGB. When this option is selected in the command line,  then  The
--     files created will be named as:
--
--     <name>.ads       -- Contains the image pixels and the mask
--     <name>-image.ads -- Contains a child package to get a Gtk_Image
--     <name>-image.adb -- The implementation of
--
--     The package <name>.ads will look like:
--
--        package <name> is
--           X_Size : constant GInt := ...
--           Y_Size : constant GInt := ...
--           type RGB_Image is array (Natural range ...) of GUChar;
--           pragma Convention (C, RGB_Image);
--           Pixels : constant RGB_Image := ...
--           procedure Draw_Pixels
--                     (  Drawable  : Gdk_Drawable;
--                        GC        : Gdk_GC;
--                        X         : GInt := 0;
--                        Y         : GInt := 0;
--                        Width     : GInt := X_Size;
--                        Height    : GInt := Y_Size;
--                        Dith      : Gdk_Rgb_Dither := Dither_None;
--                        Rgb_Buf   : Rgb_Image := Pixels;
--                        Rowstride : GInt := ...
--                     );
--
--     Here  X_Size and Y_Size are the image width and height. Pixels is
--     the array of image pixels. The procedure Draw_Pixels can be  used
--     to render it on a Drawable, such as Gtk_Window.
--
--     The following section of the file is optional.  It  appears  only
--     when  the  image has transparent pixels. Then it defines the mask
--     and a procedure to render it:
--
--        type Gray_Mask is array (Natural range ...) of GUChar;
--        pragma Convention (C, Gray_Mask);
--        Mask : constant Gray_Mask := ...
--        procedure Draw_Mask
--                  (  Drawable  : Gdk_Drawable;
--                     GC        : Gdk_GC;
--                     X         : GInt := 0;
--                     Y         : GInt := 0;
--                     Width     : GInt := X_Size;
--                     Height    : GInt := Y_Size;
--                     Dith      : Gdk_Rgb_Dither := Dither_None;
--                     Rgb_Buf   : Gray_Mask := Mask;
--                     Rowstride : GInt := ...
--                  );
--
--     The  child  function  <name>-image.ads  provides  an  easy way to
--     create an image object on demand:
--
--        function <name>.Image return Gtk_Image;
--
--     It  creates  and  returns a Gtk_Image object corresponding to the
--     image.
--
--  2. Pixbuf. When this option is selected in the command line,
--     the file created will be named as:
--
--     <name>.ads       -- Contains pixels and pixbuf creation function
--     <name>-image.ads -- Contains a child package to get a Gtk_Image
--     <name>-image.adb -- The implementation of
--
--     The package <name>.ads will look like:
--
--     package <name> is
--        X_Size : constant GInt := ...
--        Y_Size : constant GInt := ...
--        type Pixbuf_Image is array (Natural range ...) of GUChar;
--        pragma Convention (C, Pixbuf_Image);
--        Pixels : constant Pixbuf_Image := ...
--        function Get_Pixbuf ...
--           return Gdk_Pixbuf;
--
--     The  function  Pixbuf  can be used to the image in Pixbuf format.
--     The  result  object  references  to the data in the array Pixels.
--     Basically, it is a just a reference.
--
--     The  child  function  <name>-image.ads  provides  an  easy way to
--     create an image object on demand:
--
--        function <name>.Image return Gtk_Image;
--
--     It  creates  and  returns a Gtk_Image object corresponding to the
--     image.
--
with Ada.Command_Line;         use Ada.Command_Line;
with Ada.Characters.Handling;  use Ada.Characters.Handling;
with Ada.Exceptions;           use Ada.Exceptions;
with Ada.Text_IO;              use Ada.Text_IO;
with Strings_Edit;             use Strings_Edit;
with Strings_Edit.Integers;    use Strings_Edit.Integers;

with Parsers.Multiline_Source.XPM;
use  Parsers.Multiline_Source.XPM;

with Parsers.Multiline_Source.Standard_Input;
use  Parsers.Multiline_Source.Standard_Input;

procedure XPM2GtkAda is
   procedure Create_RGB
             (  Header  : Descriptor;
                Picture : Pixel_Buffer
             )  is
      Output  : File_Type;
      Mask    : Boolean := False;
      Pointer : Integer := 1;
      Triplet : Natural := 0;
      RGB     : Integer;
      Line    : String (1..72);
   begin
      Create (Output, Out_File, Header.Name & ".ads");
      Put_Line (Output, "with Gdk.Drawable;  use Gdk.Drawable;");
      Put_Line (Output, "with Gdk.GC;        use Gdk.GC;");
      Put_Line (Output, "with Gdk.RGB;       use Gdk.RGB;");
      Put_Line (Output, "with GLib;          use GLib;");
      New_Line (Output);
      Put_Line (Output, "package " & Header.Name & " is");
      Put_Line
      (  Output,
         "   X_Size : constant GInt := "
      &  Image (Header.Width)
      &  ";"
      );
      Put_Line
      (  Output,
         "   Y_Size : constant GInt := "
      &  Image (Header.Height)
      &  ";"
      );
      Put_Line
      (  Output,
         (  "   type RGB_Image is array (Natural range 0.."
         &  Image (Header.Height * Header.Width * 3 - 1)
         &  ") of GUChar;"
      )  );
      Put_Line (Output, "   pragma Convention (C, RGB_Image);");
      Put_Line (Output, "   Pixels : constant RGB_Image :=");
      Put (Line, Pointer, "   (  ");
      for Row in Picture'Range (1) loop
         for Column in Picture'Range (2) loop
            Triplet := Triplet + 1;
            RGB     := Integer (Picture (Row, Column));
            if RGB > 16#FFFFFF# then
               Put (Line, Pointer, "255,255,255");
               Mask := True;
            else
               Put
               (  Line,
                  Pointer,
                  RGB / 16#10000#,
                  Field   => 3,
                  Justify => Right
               );
               Put (Line, Pointer, ",");
               Put
               (  Line,
                  Pointer,
                  (RGB mod 16#10000#) / 16#100#,
                  Field   => 3,
                  Justify => Right
               );
               Put (Line, Pointer, ",");
               Put
               (  Line,
                  Pointer,
                  RGB mod 16#100#,
                  Field   => 3,
                  Justify => Right
               );
            end if;
            if (  Row /= Picture'Last (1)
               or else
                  Column /= Picture'Last (2)
               )  then
               Put (Line, Pointer, ",");
            end if;
            if Triplet = 5 then
               Put_Line (Output, Line (1..Pointer - 1));
               Triplet := 0;
               Pointer := 1;
               Put (Line, Pointer, "      ");
            end if;
         end loop;
      end loop;
      if Triplet > 0 then
         Put_Line (Output, Line (1..Pointer - 1));
      end if;
      Put_Line (Output, "   );");
      Put_Line (Output, "   procedure Draw_Pixels");
      Put_Line (Output, "             (  Drawable  : Gdk_Drawable;");
      Put_Line (Output, "                GC        : Gdk_GC;");
      Put_Line (Output, "                X         : GInt := 0;");
      Put_Line (Output, "                Y         : GInt := 0;");
      Put_Line (Output, "                Width     : GInt := X_Size;");
      Put_Line (Output, "                Height    : GInt := Y_Size;");
      Put_Line (Output, "                Dith      : Gdk_Rgb_Dither"
                                            & " := Dither_None;");
      Put_Line (Output, "                Rgb_Buf   : Rgb_Image"
                                            & " := Pixels;");
      Put_Line (Output, "                Rowstride : GInt := "
                                            & Image (Header.Width * 3));
      Put_Line (Output, "             );");
      Put_Line
      (  Output,
         "   pragma Import (C, Draw_Pixels, ""gdk_draw_rgb_image"");"
      );
      if Mask then
         New_Line (Output);
         Put_Line
         (  Output,
            (  "   type Gray_Mask is array (Natural range 0.."
            &  Image (Header.Height * Header.Width - 1)
            &  ") of GUChar;"
         )  );
         Put_Line (Output, "   pragma Convention (C, Gray_Mask);");
         Put_Line (Output, "   Mask : constant Gray_Mask :=");
         Pointer := 1;
         Put (Line, Pointer, "   (  ");
         for Row in Picture'Range (1) loop
            for Column in Picture'Range (2) loop
               Triplet := Triplet + 1;
               RGB     := Integer (Picture (Row, Column));
               if RGB > 16#FFFFFF# then
                  Put (Line, Pointer, "  0");
               else
                  Put (Line, Pointer, "255");
               end if;
               if (  Row /= Picture'Last (1)
                  or else
                     Column /= Picture'Last (2)
                  )  then
                  Put (Line, Pointer, ",");
               end if;
               if Triplet = 16 then
                  Put_Line (Output, Line (1..Pointer - 1));
                  Triplet := 0;
                  Pointer := 1;
                  Put (Line, Pointer, "      ");
               end if;
            end loop;
         end loop;
         if Triplet > 0 then
            Put_Line (Output, Line (1..Pointer - 1));
         end if;
         Put_Line (Output, "   );");
         Put_Line (Output, "   procedure Draw_Mask");
         Put_Line (Output, "             (  Drawable  : Gdk_Drawable;");
         Put_Line (Output, "                GC        : Gdk_GC;");
         Put_Line (Output, "                X         : GInt := 0;");
         Put_Line (Output, "                Y         : GInt := 0;");
         Put_Line (Output, "                Width     : GInt := X_Size;");
         Put_Line (Output, "                Height    : GInt := Y_Size;");
         Put_Line (Output, "                Dith      : Gdk_Rgb_Dither"
                                                 & " := Dither_None;");
         Put_Line (Output, "                Rgb_Buf   : Gray_Mask"
                                                 & " := Mask;");
         Put_Line (Output, "                Rowstride : GInt := "
                                                 & Image (Header.Width));
         Put_Line (Output, "             );");
         Put_Line
         (  Output,
            "   pragma Import (C, Draw_Mask, ""gdk_draw_gray_image"");"
         );
      end if;
      Put_Line (Output, "end " & Header.Name & ";");
      Close (Output);

      Create (Output, Out_File, Header.Name & "-image.ads");
      Put_Line (Output, "with Gdk;        use Gdk;");
      Put_Line (Output, "with Gtk.Image;  use Gtk.Image;");
      New_Line (Output);
      Put_Line (Output, "function " & Header.Name & ".Image");
      Put_Line (Output, "   return Gtk_Image;");
      Close (Output);

      Create (Output, Out_File, Header.Name & "-image.adb");
      Put_Line (Output, "with Gdk.Pixmap;");
      Put_Line (Output, "with Gdk.Bitmap;");               if not Mask then
      Put_Line (Output, "with Gdk.Color;");                end if;
      New_Line (Output);
      Put_Line (Output, "function " & Header.Name & ".Image");
      Put_Line (Output, "   return Gtk_Image is");
      Put_Line (Output, "   Pic    : Gdk.Gdk_Pixmap;");
      Put_Line (Output, "   Msk    : Gdk.Gdk_Bitmap;");
      Put_Line (Output, "   GC     : Gdk.Gdk_GC;");
      Put_Line (Output, "   Result : Gtk_Image;");
      Put_Line (Output, "   function Get_System");
      Put_Line (Output, "      return Gdk_Colormap;");
      Put_Line (Output, "   pragma Import (C, Get_System, "
                                   & """gdk_colormap_get_system"");");
      Put_Line (Output, "begin");
      Put_Line (Output, "   Pixmap.Gdk_New (Pic, null, "
                                   & "X_Size, Y_Size, 24);");
      Put_Line (Output, "   Set_Colormap (Pic, Get_System);");
      Put_Line (Output, "   Gdk_New (GC, Pic);");
      Put_Line (Output, "   Draw_Pixels (Pic, GC);");
      Put_Line (Output, "   Unref (GC);");
      Put_Line (Output, "   Bitmap.Gdk_New (Msk, null, "
                                   & "X_Size, Y_Size);");
      Put_Line (Output, "   Set_Colormap (Msk, Get_System);");
      Put_Line (Output, "   Gdk_New (GC, Msk);");          if Mask then
      Put_Line (Output, "   Draw_Mask (Msk, GC);");        else
      Put_Line (Output, "   Set_Foreground (GC, "
                                   &  "Gdk.Color.White (Get_System));");
      Put_Line (Output, "   Draw_Rectangle (Msk, GC, True, 0, 0, "
                                   &  "X_Size, Y_Size);"); end if;
      Put_Line (Output, "   Unref (GC);");
      Put_Line (Output, "   Gtk_New (Result, Pic, Msk);");
      Put_Line (Output, "   Unref (Pic);");
      Put_Line (Output, "   Unref (Msk);");
      Put_Line (Output, "   return Result;");
      Put_Line (Output, "end " & Header.Name & ".Image;");
      Close (Output);
   end Create_RGB;

   procedure Create_Pixbuf
             (  Header  : Descriptor;
                Picture : Pixel_Buffer
             )  is
      Output  : File_Type;
      Bytes   : Integer := 3;
      Pointer : Integer := 1;
      Pixel   : Natural := 0;
      RGB     : Integer;
      Line    : String (1..72);
   begin
      Create (Output, Out_File, Header.Name & ".ads");
      for Row in Picture'Range (1) loop
         for Column in Picture'Range (2) loop
            if Picture (Row, Column) = Transparent then
               Bytes := 4;
               exit;
            end if;
         end loop;
      end loop;
      Put_Line (Output, "with Gdk.Pixbuf;    use Gdk.Pixbuf;");
      Put_Line (Output, "with GLib;          use GLib;");
      Put_Line (Output, "with Interfaces.C;  use Interfaces.C;");
      Put_Line (Output, "with System;        use System;");
      New_Line (Output);
      Put_Line (Output, "package " & Header.Name & " is");
      Put_Line
      (  Output,
         "   X_Size : constant GInt := "
      &  Image (Header.Width)
      &  ";"
      );
      Put_Line
      (  Output,
         "   Y_Size : constant GInt := "
      &  Image (Header.Height)
      &  ";"
      );
      Put_Line
      (  Output,
         (  "   type Pixbuf_Image is array (Natural range 0.."
         &  Image (Header.Height * Header.Width * Bytes - 1)
         &  ") of GUChar;"
      )  );
      Put_Line (Output, "   pragma Convention (C, Pixbuf_Image);");
      Put_Line (Output, "   Pixels : constant Pixbuf_Image :=");
      Put (Line, Pointer, "   (  ");
      if Bytes = 4 then
         for Row in Picture'Range (1) loop
            for Column in Picture'Range (2) loop
               Pixel := Pixel + 1;
               RGB   := Integer (Picture (Row, Column));
               if RGB > 16#FFFFFF# then
                  Put (Line, Pointer, "255,255,255,  0");
               else
                  Put
                  (  Line,
                     Pointer,
                     RGB / 16#10000#,
                     Field   => 3,
                     Justify => Right
                  );
                  Put (Line, Pointer, ",");
                  Put
                  (  Line,
                     Pointer,
                     (RGB mod 16#10000#) / 16#100#,
                     Field   => 3,
                     Justify => Right
                  );
                  Put (Line, Pointer, ",");
                  Put
                  (  Line,
                     Pointer,
                     RGB mod 16#100#,
                     Field   => 3,
                     Justify => Right
                  );
                  Put (Line, Pointer, ",255");
               end if;
               if (  Row /= Picture'Last (1)
                  or else
                     Column /= Picture'Last (2)
                  )  then
                  Put (Line, Pointer, ",");
               end if;
               if Pixel = 4 then
                  Put_Line (Output, Line (1..Pointer - 1));
                  Pixel := 0;
                  Pointer := 1;
                  Put (Line, Pointer, "      ");
               end if;
            end loop;
         end loop;
      else
         for Row in Picture'Range (1) loop
            for Column in Picture'Range (2) loop
               Pixel := Pixel + 1;
               RGB   := Integer (Picture (Row, Column));
               Put
               (  Line,
                  Pointer,
                  RGB / 16#10000#,
                  Field   => 3,
                  Justify => Right
               );
               Put (Line, Pointer, ",");
               Put
               (  Line,
                  Pointer,
                  (RGB mod 16#10000#) / 16#100#,
                  Field   => 3,
                  Justify => Right
               );
               Put (Line, Pointer, ",");
               Put
               (  Line,
                  Pointer,
                  RGB mod 16#100#,
                  Field   => 3,
                  Justify => Right
               );
               if (  Row /= Picture'Last (1)
                  or else
                     Column /= Picture'Last (2)
                  )  then
                  Put (Line, Pointer, ",");
               end if;
               if Pixel = 5 then
                  Put_Line (Output, Line (1..Pointer - 1));
                  Pixel := 0;
                  Pointer := 1;
                  Put (Line, Pointer, "      ");
               end if;
            end loop;
         end loop;
      end if;
      if Pixel > 0 then
         Put_Line (Output, Line (1..Pointer - 1));
      end if;
      Put_Line (Output, "   );");
      Put_Line (Output, "   function Get_Pixbuf return Gdk_Pixbuf;");
      Put_Line (Output, "end " & Header.Name & ";");
      Close (Output);

      Create (Output, Out_File, Header.Name & ".adb");
      Put_Line (Output, "with Gdk.Pixbuf.Conversions;");
      Put_Line (Output, "package body " & Header.Name & " is");
      Put_Line (Output, "   function Get_Pixbuf return Gdk_Pixbuf is");
      Put_Line (Output, "      function Internal");
      Put_Line (Output, "               (  Data       : Pixbuf_Image;");
      Put_Line
      (  Output,
         "                  Colorspace : Gdk_Colorspace;"
      );
      Put_Line (Output, "                  Has_Alpha  : GBoolean;");
      Put_Line (Output, "                  Bits       : Int;");
      Put_Line (Output, "                  Width      : Int;");
      Put_Line (Output, "                  Height     : Int;");
      Put_Line (Output, "                  Rowstride  : Int;");
      Put_Line (Output, "                  Fn         : Address;");
      Put_Line (Output, "                  Fn_Data    : Address");
      Put_Line (Output, "               )  return Address;");
      Put_Line
      (  Output,
         (  "      pragma Import (C, Internal, "
         &  """gdk_pixbuf_new_from_data"");"
      )  );
      Put_Line (Output, "   begin");
      Put_Line (Output, "      return Gdk.Pixbuf.Conversions."
                                  &  "From_Address");
      Put_Line (Output, "             (  Internal");
      Put_Line (Output, "                (  Pixels,");
      Put_Line (Output, "                   Colorspace_RGB,");
      if Bytes = 4 then
         Put_Line (Output, "                   1,");
      else
         Put_Line (Output, "                   0,");
      end if;
      Put_Line (Output, "                   8,");
      Put_Line (Output, "                   Int (X_Size),");
      Put_Line (Output, "                   Int (Y_Size),");
      Put_Line (Output, "                   "
                                  & Image (Header.Width * Bytes) & ",");
      Put_Line (Output, "                   Null_Address,");
      Put_Line (Output, "                   Null_Address");
      Put_Line (Output, "             )  );");
      Put_Line (Output, "   end Get_Pixbuf;");
      Put_Line (Output, "end " & Header.Name & ";");
      Close (Output);

      Create (Output, Out_File, Header.Name & "-image.ads");
      Put_Line (Output, "with Gtk.Image;  use Gtk.Image;");
      New_Line (Output);
      Put_Line (Output, "function " & Header.Name & ".Image");
      Put_Line (Output, "   return Gtk_Image;");
      Close (Output);

      Create (Output, Out_File, Header.Name & "-image.adb");
      Put_Line (Output, "function " & Header.Name & ".Image");
      Put_Line (Output, "   return Gtk_Image is");
      Put_Line (Output, "   Pic    : Gdk_Pixbuf := Get_Pixbuf;");
      Put_Line (Output, "   Result : Gtk_Image;");
      Put_Line (Output, "begin");
      Put_Line (Output, "   Gtk_New (Result, Pic);");
      Put_Line (Output, "   Unref (Pic);");
      Put_Line (Output, "   return Result;");
      Put_Line (Output, "end " & Header.Name & ".Image;");
      Close (Output);

   end Create_Pixbuf;

   type Action is (Error, RGB, Pixbuf);
   To_Do : Action;
begin
   case Argument_Count is
      when 0 =>
         To_Do := Pixbuf;
      when 1 =>
         declare
            Command : String := To_Lower (Argument (1));
         begin
            if Command = "pixbuf" then
               To_Do := Pixbuf;
            elsif Command = "rgb" then
               To_Do := RGB;
            else
               To_Do := Error;
            end if;
         end;
      when others =>
         To_Do := Error;
   end case;
   if To_Do = Error then
      Put_Line (Standard_Error, "Use: xpm2ada [Pixbuf|RGB] < <input>");
      Set_Exit_Status (Failure);
      return;
   end if;
   declare
      Input   : aliased Source;
      Header  : Descriptor         := Get (Input'Access);
      Map     : Color_Tables.Table := Get (Input'Access, Header);
      Picture : Pixel_Buffer       := Get (Input'Access, Header, Map);
   begin
      if To_Do = RGB then
         Create_RGB (Header, Picture);
      else
         Create_Pixbuf (Header, Picture);
      end if;
   end;
   Set_Exit_Status (Success);
exception
   when Error : others =>
      Put_Line (Standard_Error, Exception_Message (Error));
      Set_Exit_Status (Failure);
end XPM2GtkAda;
