------------------------------------------------------------------------------
--                                                                          --
--                            SILMARIL COMPONENTS                           --
--                                                                          --
--                          S I L M A R I L . D L L                         --
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
--                Silmaril is maintained by J de Kruijf Engineers           --
--                     (email: jan.de.kruyf@hotmail.com)                    --
--                                                                          --
------------------------------------------------------------------------------

-- implementation of a protected doubly linked list
--

package Silmaril.Dll is
   
   -- anything distance --
   subtype Posvec1_Type is Long_Float;
   -- anything angle    --
   subtype Posangl_Type is Long_Float;
   
   
   -- the base of all machining records --
   type Posvec_Type is abstract tagged;
   type Posvec_Class_Access_Type is access all Posvec_Type'Class;
   type Posvec_Type is abstract tagged record
      null;
   end record;
   
   --------------------------------------
   -- the list item for a 3 axis entry --
   --------------------------------------
   type Posvec3_Type is tagged;
   type Posvec3_Access_Type is access  all Posvec3_Type;
   type Posvec3_Class_Access_Type is access all Posvec3_Type'Class;
   type Posvec3_Type is new Posvec_Type
     with record
	From,
	Istop  : Boolean := False;
	Fedrat : Posvec1_Type := 0.0;
	D3d    : Posangl_Type := 0.0;  -- space angle between segments
	Tightness : Long_Float;
	X      : Posvec1_Type;
	Y      : Posvec1_Type;
	Z      : Posvec1_Type;
   end record;
   
   --------------------------------------
   -- the list item for a 9 axis entry --
   --------------------------------------
   type Posvec9_Type;
   type Posvec9_Access_Type is access  all Posvec9_Type;
   type Posvec9_Type is new Posvec3_Type 
     with record
	I,
	J,
	K      : Posvec1_Type := 0.0;  -- rotation vector
	Xr,
	Yr,
	Zr     : Posvec1_Type := 0.0;  -- new xyz, to be modified.
	A,
	B,
	C      : Posangl_Type := 0.0;  -- rotation angles
   end record;
   
   ----------------------------------------
   -- the list item for a command string --
   ----------------------------------------
   type Posvec_S_Type;
   type Posvec_S_Access_Type is access  all Posvec_S_Type;
   type Posvec_S_Type is new Posvec_Type 
     with record
   	Sa : access String;
   end record;
   
    
   -- the list construction
   -- it has forward and backward connections for
   -- 2 lists that are interwoven.
   -- prev and next link all records, but
   -- mprevand mnext only the movement records.
   type Dllist_Type is tagged private;
   type Dllist_Access_Type is access all Dllist_Type;
   protected type Program_Que is
      procedure Initialize;
      --entry Add_Item (N : access Dllist_Type'Class);
      --entry Available ();
      entry Get_Item (N : access Dllist_Type'Class; 
		      Pos : in out Posvec_Class_Access_Type);
      entry Insert_Pv_Before (This : access Posvec_Type'Class;  
			      next : access Dllist_Type)
	with Pre => This /= null and Next /= null;
      entry Insert_Pv_After (This : access Posvec_Type'Class;   
			     Prev : access Dllist_Type )
	with Pre => This /= null and Prev /= null;
      entry Unlink_Dllist_Item (This : access Dllist_Type);
	--with Pre => This.Pos = null;
      -- destroy a Dllist-item in the link
      
      ------------------------
      -- 3 axis item entrys --
      ------------------------
      entry Get_Item (N : access Dllist_Type'Class; 
		      Pos : in out Posvec3_Class_Access_Type);
      entry Insert_Pv_Before (This        : access Posvec3_Type'Class;  
			      Next, Mnext : access Dllist_Type)
	with Pre => This /= null and Next /= null and Mnext /= null;
      -- inserts 'this' before 'next' and before 'mnext'
      -- so we must know who 'mnext' is, normally the anchor
      --  i.e. the same as next
      -- only for movement records
      
      entry Insert_Pv_After (This        : access Posvec3_Type'Class;   
			     Prev, Mprev : access Dllist_Type)
	with Pre => This /= null and Prev /= null and Mprev /= null;
      -- inserts 'this' after 'prev' and after 'mprev'
      -- so we must know who 'mprev' is, normally the anchor
      --  i.e. the same as prev
      -- only for movement records
      
      entry Unlink_Pos3_Node (This : access Dllist_Type);
      -- unlink a pos3 node from the chain
      
      ------------------
      -- 9 axis entry --
      ------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec9_Access_Type);
      
      entry Unlink_Pos9_Node  (This : access Dllist_Type);
      
      --------------------------
      -- command string entry --
      --------------------------
      entry Unlink_Pos_S_Node  (This : access Dllist_Type);
      
   private
      Anchor : aliased Dllist_Access_Type := new Dllist_Type;
      Open : Boolean := False;
   end Program_Que;

private
   
   
  
   type Dllist_Type is tagged record
      Pos            : Posvec_Class_Access_Type := null;
      Prev, Next,
	Mprev, Mnext : Dllist_Access_Type       := null;
   end record;
end Silmaril.Dll;
