--                                                                    --
--  procedure Test_String_Streams   Copyright (c)  Dmitry A. Kazakov  --
--  Test                                           Luebeck            --
--                                                 Spring, 2000       --
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

with Ada.Exceptions;        use Ada.Exceptions;
with Ada.Streams;           use type Ada.Streams.Stream_Element_Offset;
with Ada.Text_IO;           use Ada.Text_IO;
with Strings_Edit.Streams;  use Strings_Edit.Streams;

procedure Test_String_Streams is
begin
   declare
      S : aliased String_Stream (6);
      C : Character;
   begin
      Character'Write (S'Access, 'a');
      Rewind (S);
      Character'Read (S'Access, C);
      if C /= 'a' then
         Raise_Exception (Constraint_Error'Identity, "Read error");
      end if;
   end;
   declare
      S : aliased String_Stream (6);
      C : Character;
      T : String (1..5);
   begin
      Set (S, "abcdef");
      Character'Read (S'Access, C);
      if C /= 'a' or else Get_Size (S) /= 5 then
         Raise_Exception (Constraint_Error'Identity, "Read error");
      end if;
      String'Read (S'Access, T);
      if T /= "bcdef" or else Get_Size (S) /= 0 then
         Raise_Exception (Constraint_Error'Identity, "Read error");
      end if;
      Rewind (S); -- Rewind
      Character'Write (S'Access, '1');
      String'Write (S'Access, "23456");
      if S.Data /= "123456" or else Get (S) /= "123456" then
         Raise_Exception (Constraint_Error'Identity, "Write error");
      end if;
   end;
   Put_Line ("... Done");
exception
   when Error : others =>
      Put ("Error :");
      Put_Line (Exception_Information (Error));
end Test_String_Streams;
