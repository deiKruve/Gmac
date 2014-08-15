------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                     E A R E N D I L . N A M E _ S E R V E R              --
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
--                 Earendil is maintained by J de Kruijf Engineers          --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------
--
--with Ada.Text_Io;

with Ada.Unchecked_Deallocation;

package body Earendil.Name_Server is
   --package Tio renames Ada.Text_Io;
   
    -- Dynamic binding to remote operations is achieved
    -- using the access-to-limited-class-wide Despatch_P_Type
    type Handler_Name_Access_Type is access all String;
    
    type Dentry_Type;
    type Dentry_Access_Type is access all Dentry_Type;
    type Dentry_Type is
       record
	  Next : Dentry_Access_Type;
	  Name : Handler_Name_Access_Type;
	  Addr : E_Obj_Msg_Access_Type;
       end record;
    
    Anchor : Dentry_Access_Type := new Dentry_Type;
    
    
    function Find (Name : String) return E_Obj_Msg_Access_Type
    is
       Dentry : Dentry_Access_Type := Anchor;
    begin
       --Tio.Put_Line ("name : " & Name);
       while Dentry.Next /= null loop
	  Dentry := Dentry.Next;
	  --Tio.Put_Line ("Dentry.name : " & Dentry.Name.all);
	  if Name = Dentry.Name.all then
	     --Tio.Put_Line (Name & " found");
	     return Dentry.Addr;
	  end if;
       end loop;
       --Tio.Put_Line (Name & " not found");
       return null;
    end Find;
    
    
    procedure Register (Name : in String; T : in E_Obj_Msg_Access_Type)
    is
       Dn     : Handler_Name_Access_Type := new String'(Name);
       Dentry : Dentry_Access_Type       := new Dentry_Type;
    begin
       Dentry.Name := Dn;
       Dentry.Addr := T;
       Dentry.Next := Anchor.Next;
       Anchor.Next := Dentry;
       --Tio.Put_Line (Name & " registered");
    end Register;
    
    
    procedure Remove   (T : in E_Obj_Msg_Access_Type)
    is
       procedure Free is
	  new Ada.Unchecked_Deallocation (Dentry_Type, Dentry_Access_Type);
       Dentry,
       Dentry_Pr: Dentry_Access_Type := Anchor;
    begin
       while Dentry.Next /= null loop
	  Dentry_Pr := Dentry;
	  Dentry := Dentry.Next;
	  if T = Dentry.Addr then
	     Dentry_Pr.Next := Dentry.Next;
	     Free (Dentry);
	     exit;
	  end if;
       end loop;
    end Remove;
    
begin
   Anchor.Next := null;
end Earendil.Name_Server;


