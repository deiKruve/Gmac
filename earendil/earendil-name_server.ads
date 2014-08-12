------------------------------------------------------------------------------
--                                                                          --
--                             EARENDIL COMPONENTS                          --
--                                                                          --
--                     E A R E N D I L . N A M E _ S E R V E R              --
--                                                                          --
--                                  S p e c                                 --
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




--with Earendil.Despatcher;
package Earendil.Name_Server with Remote_Call_Interface is

    -- Dynamic binding to remote operations is achieved
    -- using the access-to-limited-class-wide Despatch_P_Type
    
    --type Despatcher_Access_Type is access all Despatch'Class;
    -- The following statically bound remote operations
    -- allow for a name-server capability in this example
    
    --type Despatcher_Access_Type is access function (Msg : String) return String;
    type E_Obj_Msg_Access_Type is access all E_Obj_Msg_Type'Class;
    
    --function  Find     (Name : String) return Despatcher_Access_Type;
    function Find (Name : String) return E_Obj_Msg_Access_Type;
    
    --procedure Register (Name : in String; T : in Despatcher_Access_Type);
    procedure Register (Name : in String; T : in E_Obj_Msg_Access_Type);
    
    --procedure Remove   (T : in Despatcher_Access_Type);
    procedure Remove   (T : in E_Obj_Msg_Access_Type);
    
end Earendil.Name_Server;


