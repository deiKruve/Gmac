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
   type Move_Type is
     (None,
      Straight,
      Blendin,
      Blendout,
      Blendboth);
   
   type Posvec3_Type is tagged;
   type Posvec3_Access_Type is access  all Posvec3_Type;
   type Posvec3_Class_Access_Type is access all Posvec3_Type'Class;
   type Posvec3_Type is new Posvec_Type
     with record
	From,
	Best,
	Sweet,
	Istop  : Boolean      := False;
	Blend  : Move_Type    := Straight;
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
	A,
	B,
	C      : Posangl_Type := 0.0;  -- rotation angles
   end record;
   
   
   ---------------------------------
   -- the list item for a command --
   ---------------------------------
   type Cmd_Token_Type is
     (
      Clamp, Release,          -- digital m-functions
      Spindl, Fadein, Fadeout, -- analog M-fuctions
      Beam, Sixa, F,           -- analog values
      Fini);
   type Axis_Token_Type is  -- same layout as reader.pos_token_type
     (A, B, C, X, Y, Z);
   
   type Posvec_C_Type is tagged;
   type Posvec_C_Access_Type is access  all Posvec_C_Type;
   type Posvec_C_Type is new Posvec_Type 
     with record
   	C   : Cmd_Token_Type;
	Ax  : Axis_Token_Type;
	Val : Long_Float;
	Tr  : Boolean;
   end record;
   
   ----------------------------------------
   -- the list item for a command string --
   ----------------------------------------
   type Posvec_S_Type is tagged;
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
   
   type Dllist_Type;
   type Dllist_Access_Type is access all Dllist_Type;
     
   type Dllist_Type is tagged record
      Pos            : access Posvec_Type'Class;
      Luth           : Dllist_Access_Type       := null;
      Prev, Next,
	Mprev, Mnext : Dllist_Access_Type       := null;
   end record;

   procedure Initialize (Anchor : access Dllist_Type);
   
   protected type Program_Queue_Type is
      pragma Priority (Prog_Q_Thread_Priority);
      
      entry Finalize (Anchor : access Dllist_Type);
      entry Get_Item (N : access Dllist_Type'Class; 
		      Pos : in out Posvec_Class_Access_Type);
      entry Insert_Pv_Before (This : access Posvec_Type'Class;  
			      next : access Dllist_Type);
	--with Pre => This /= null and Next /= null;
      entry Insert_Pv_After (This : access Posvec_Type'Class;   
			     Prev : access Dllist_Type );
	--with Pre => This /= null and Prev /= null;
      entry Unlink_Dllist_Item (This : access Dllist_Type);
      -- destroy a Dllist-item in the link
      
      ------------------------
      -- 3 axis item entrys --
      ------------------------
      entry Get_Item (N : access Dllist_Type'Class; 
		      Pos : in out Posvec3_Class_Access_Type);
      entry Insert_Pv_Before (This        : access Posvec3_Type'Class;  
			      Next, Mnext : access Dllist_Type);
	--with Pre => This /= null and Next /= null and Mnext /= null;
      -- inserts 'this' before 'next' and before 'mnext'
      -- so we must know who 'mnext' is, normally the anchor
      --  i.e. the same as next
      -- only for movement records
      
      entry Insert_Pv_After (This        : access Posvec3_Type'Class;   
			     Prev, Mprev : access Dllist_Type);
	--with Pre => This /= null and Prev /= null and Mprev /= null;
      -- inserts 'this' after 'prev' and after 'mprev'
      -- so we must know who 'mprev' is, normally the anchor
      --  i.e. the same as prev
      -- only for movement records
      
      entry Unlink_Pos3_Node (This : access Dllist_Type);
      -- unlink a pos3 node from the chain
      
      -------------------
      -- 9 axis entrys --
      -------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec9_Access_Type);
      
      entry Unlink_Pos9_Node  (This : access Dllist_Type);
      
      -------------------
      -- command entry --
      -------------------
      entry Get_Item (N   : access Dllist_Type'Class; 
		      Pos : in out Posvec_C_Access_Type);
      
      entry Unlink_Pos_C_Node (This : access Dllist_Type);
      
      --------------------------
      -- command string entry --
      --------------------------
      entry Unlink_Pos_S_Node  (This : access Dllist_Type);
      
   private
      Open : Boolean := True;
   end Program_Queue_Type;

private
   
   
end Silmaril.Dll;
