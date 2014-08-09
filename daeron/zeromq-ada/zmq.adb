-------------------------------------------------------------------------------
--                                                                           --
--                             0MQ Ada-binding                               --
--                                                                           --
--                                   Z M Q                                   --
--                                                                           --
--                                  B o d y                                  --
--                                                                           --
--            Copyright (C) 2013-2020, per.s.sandberg@bahnhof.se             --
--                                                                           --
--  Permission is hereby granted, free of charge, to any person obtaining a  --
--  copy of this software and associated documentation files                 --
--  (the "Software"), to deal in the Software without restriction, including --
--  without limitation the rights to use, copy, modify, merge, publish,      --
--  distribute, sublicense, and / or sell copies of the Software, and to     --
--  permit persons to whom the Software is furnished to do so, subject to    --
--  the following conditions :                                               --
--                                                                           --
--  The above copyright notice and this permission notice shall be included  --
--  in all copies or substantial portions of the Software.                   --
--                                                                           --
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  --
--  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               --
--  MERCHANTABILITY,                                                         --
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL  --
--  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR     --
--  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,    --
--  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR    --
--  OTHER DEALINGS IN THE SOFTWARE.                                          --
-------------------------------------------------------------------------------


with Interfaces.C.Strings;
with ZMQ.Low_Level;
with Ada.Assertions;
package body ZMQ is
   use Interfaces.C;
   -------------------
   -- Error_Message --
   -------------------

   function Error_Message (No : Integer) return String is
      s : constant String := No'Img;
   begin
      return "[" &  s (s'First + 1 .. s'Last) & "] " &
        Interfaces.C.Strings.Value (Low_Level.zmq_strerror (int (No)));
   end Error_Message;

   function Library_Version return Version_Type is
      Major : aliased int;
      Minor : aliased int;
      Patch : aliased int;
   begin
      return ret : Version_Type do
         Low_Level.zmq_version (Major'Access,
                                Minor'Access,
                                Patch'Access);
         ret := (Natural (Major), Natural (Minor), Natural (Patch));
      end return;
   end Library_Version;

   function Image (Item : Version_Type) return String is
      s1 : constant String := Item.Major'Img;
      s2 : constant String := Item.Minor'Img;
      s3 : constant String := Item.Patch'Img;
   begin
      return s1 (s1'First + 1 .. s1'Last) & "." &
        s2 (s2'First + 1 .. s2'Last) & "." &
        s3 (s3'First + 1 .. s3'Last);
   end Image;

   procedure Validate_Library_Version is
      Lib_Version : constant Version_Type :=  Library_Version;
   begin
      Ada.Assertions.Assert
        ((Binding_Version.Major = Lib_Version.Major) and
             (Binding_Version.Minor = Lib_Version.Minor),
         "Incompatible libzmq found: " & Image (Lib_Version) &
           ", expected: " & Image (Binding_Version));
   end Validate_Library_Version;

   function errno return Integer is
   begin
      return Integer (Low_Level.zmq_errno);
   end errno;

end ZMQ;
