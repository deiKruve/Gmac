-- 
-- * Proview   Open Source Process Control.
-- * Copyright (C) 2005-2014 SSAB EMEA AB.
-- *
-- * This file is part of Proview.
-- *
-- * This program is free software; you can redistribute it and/or 
-- * modify it under the terms of the GNU General Public License as 
-- * published by the Free Software Foundation, either version 2 of 
-- * the License, or (at your option) any later version.
-- *
-- * This program is distributed in the hope that it will be useful 
-- * but WITHOUT ANY WARRANTY; without even the implied warranty of 
-- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
-- * GNU General Public License for more details.
-- *
-- * You should have received a copy of the GNU General Public License 
-- * along with Proview. If not, see <http://www.gnu.org/licenses/>
-- *
-- * Linking Proview statically or dynamically with other modules is
-- * making a combined work based on Proview. Thus, the terms and 
-- * conditions of the GNU General Public License cover the whole 
-- * combination.
-- *
-- * In addition, as a special exception, the copyright holders of
-- * Proview give you permission to, from the build function in the
-- * Proview Configurator, combine Proview with modules generated by the
-- * Proview PLC Editor to a PLC program, regardless of the license
-- * terms of these modules. You may copy and distribute the resulting
-- * combined work under the terms of your choice, provided that every 
-- * copy of the combined work is accompanied by a complete copy of 
-- * the source code of Proview (the version used to produce the 
-- * combined work), being distributed under the terms of the GNU 
-- * General Public License plus this exception.
--  
--   Ada binding by Jan de Kruijf (jan.de.kruyf@hotmail.com)
--

pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with pwr;
with pwr_class;
limited with pwr_baseclasses;
with rt_io_supervise;

package rt_io_base is


   io_cLibDummy          : constant := -9999;  --  rt_io_base.h:74
   IO_CHANLIST_SIZE      : constant := 250;  --  rt_io_base.h:75

   FIXOUT                : constant := 2;  --  rt_io_base.h:77
   IO_REBOOT             : constant := 1;  --  rt_io_base.h:78
   
   type io_tCtx         is new System.Address;  -- rt_io_base.h:59

   io_writeerr           : aliased pwr.pwr_tBoolean;  -- rt_io_base.h:80
   pragma Import (C, io_writeerr, "io_writeerr");

   io_readerr            : aliased pwr.pwr_tBoolean;  -- rt_io_base.h:81
   pragma Import (C, io_readerr, "io_readerr");

   io_fatal_error        : aliased pwr.pwr_tBoolean;  -- rt_io_base.h:82
   pragma Import (C, io_fatal_error, "io_fatal_error");

   type io_eType is 
     (io_eType_Node,
      io_eType_Agent,
      io_eType_Rack,
      io_eType_Card);
   pragma Convention (C, io_eType);  -- rt_io_base.h:90
   
   subtype io_mAction   is unsigned;
   io_mAction_None       : constant io_mAction := 0;
   io_mAction_Read       : constant io_mAction := 1;
   io_mAction_Write      : constant io_mAction := 2;
   io_mAction_Swap       : constant io_mAction := 4;  -- rt_io_base.h:97

   subtype io_mProcess  is unsigned;
   io_mProcess_None      : constant io_mProcess := 0;
   io_mProcess_Plc       : constant io_mProcess := 1;
   io_mProcess_IoComm    : constant io_mProcess := 2;
   io_mProcess_Profibus  : constant io_mProcess := 4;
   io_mProcess_User      : constant io_mProcess := 8;
   io_mProcess_User2     : constant io_mProcess := 16;
   io_mProcess_User3     : constant io_mProcess := 32;
   io_mProcess_User4     : constant io_mProcess := 64;
   io_mProcess_Powerlink : constant io_mProcess := 128;
   io_mProcess_All       : constant io_mProcess := -1;  -- rt_io_base.h:110

   type io_eEvent       is 
     (io_eEvent_EmergencyBreak,
      io_eEvent_IoCommEmergencyBreak,
      io_eEvent_IoCommSwapInit,
      io_eEvent_IoCommSwap);
   pragma Convention (C, io_eEvent);  -- rt_io_base.h:117

  -- Pointer to channel object  
   type io_sChannel     is 
      record
	 cop              : System.Address; 
	 ChanDlid         : aliased pwr.pwr_tDlid;
	 ChanAref         : aliased pwr.pwr_sAttrRef;
	 sop              : System.Address;
	 SigDlid          : aliased pwr.pwr_tDlid;
	 SigAref          : aliased pwr.pwr_sAttrRef;
	 vbp              : System.Address; 
	 abs_vbp          : System.Address; 
	 ChanClass        : aliased pwr.pwr_tClassId;
	 SigClass         : aliased pwr.pwr_tClassId;
	 size             : aliased pwr.pwr_tUInt32; 
	 offset           : aliased pwr.pwr_tUInt32; 
	 mask             : aliased pwr.pwr_tUInt32; 
	 SigType          : aliased pwr_class.pwr_eType;
	 SigElem          : aliased pwr.pwr_tUInt32; 
	 SigStrSize       : aliased pwr.pwr_tUInt32; 
	 udata            : aliased pwr.pwr_tUInt32;
      end record;
   pragma Convention (C_Pass_By_Copy, io_sChannel);  -- rt_io_base.h:137

   type s_Card           is 
      record
	 Class            : aliased pwr.pwr_tClassId;
	 Objid            : aliased pwr.pwr_tObjid;
	 Name             : aliased pwr.pwr_tOName;
	 Action           : aliased io_mAction; 
	 Process          : aliased io_mProcess;
	 Init             : access function return pwr.pwr_tStatus;
	 Close            : access function return pwr.pwr_tStatus;
	 Read             : access function return pwr.pwr_tStatus;
	 Write            : access function return pwr.pwr_tStatus;
	 Swap             : access function return pwr.pwr_tStatus;
	 op               : System.Address;
	 Dlid             : aliased pwr.pwr_tDlid;  
	 size             : aliased pwr.pwr_tUInt32;
	 offset           : aliased pwr.pwr_tUInt32;
	 Scan_Interval    : aliased int;  
	 scan_interval_cnt : aliased int; 
	 AgentControlled  : aliased int;  
	 ChanListSize     : aliased int;  
	 chanlist         : access io_sChannel;
	 Local            : System.Address;
	 MethodDisabled   : aliased int; 
	 next             : access s_Card;
      end record;
   pragma Convention (C_Pass_By_Copy, s_Card);  -- rt_io_base.h:140
   
   subtype io_sCard      is s_Card;
   
   type s_Rack           is 
      record
	 Class            : aliased pwr.pwr_tClassId;
	 Objid            : aliased pwr.pwr_tObjid;  
	 Name             : aliased pwr.pwr_tOName;  
	 Action           : aliased io_mAction;  
	 Process          : aliased io_mProcess; 
	 Init             : access function return pwr.pwr_tStatus;
	 Close            : access function return pwr.pwr_tStatus;
	 Read             : access function return pwr.pwr_tStatus;
	 Write            : access function return pwr.pwr_tStatus;
	 Swap             : access function return pwr.pwr_tStatus;
	 op               : System.Address;
	 Dlid             : aliased pwr.pwr_tDlid;  
	 size             : aliased pwr.pwr_tUInt32;
	 offset           : aliased pwr.pwr_tUInt32;
	 scan_interval    : aliased int; 
	 scan_interval_cnt : aliased int;
	 AgentControlled  : aliased int; 
	 cardlist         : access io_sCard;
	 Local            : System.Address; 
	 MethodDisabled   : aliased int;  
	 next             : access s_Rack;
      end record;
   pragma Convention (C_Pass_By_Copy, s_Rack);  -- rt_io_base.h:165
   
   subtype io_sRack      is s_Rack;
   
   type s_Agent          is 
      record
	 Class            : aliased pwr.pwr_tClassId;
	 Objid            : aliased pwr.pwr_tObjid; 
	 Name             : aliased pwr.pwr_tOName; 
	 Action           : aliased io_mAction;  
	 Process          : aliased io_mProcess; 
	 Init             : access function return pwr.pwr_tStatus;
	 Close            : access function return pwr.pwr_tStatus;
	 Read             : access function return pwr.pwr_tStatus;
	 Write            : access function return pwr.pwr_tStatus;
	 Swap             : access function return pwr.pwr_tStatus;
	 op               : System.Address; 
	 Dlid             : aliased pwr.pwr_tDlid;
	 scan_interval    : aliased int; 
	 scan_interval_cnt : aliased int;
	 racklist         : access io_sRack;
	 Local            : System.Address; 
	 next             : access s_Agent; 
      end record;
   pragma Convention (C_Pass_By_Copy, s_Agent);  -- rt_io_base.h:189
   
   subtype io_sAgent     is s_Agent;
   
   type io_sCtx          is 
      record
	 agentlist        : access io_sAgent; 
	 Process          : aliased io_mProcess;
	 Thread           : aliased pwr.pwr_tObjid; 
	 RelativVector    : aliased int;
	 Node             : access pwr_class.pwr_sNode; 
	 IOHandler        : access pwr_baseclasses.pwr_sClass_IOHandler; 
	 ScanTime         : aliased float;
	 SupCtx           : rt_io_supervise.io_tSupCtx;
      end record;
   pragma Convention (C_Pass_By_Copy, io_sCtx);  -- rt_io_base.h:209
   
   
   --------------------
   --  Io functions  --
   --------------------
   
   procedure io_DiUnpackWord (cp    : access io_sCard;
			      Data  : pwr.pwr_tUInt16;
			      Mask  : pwr.pwr_tUInt16;
			      index : int);  -- rt_io_base.h:224
   pragma Import (C, io_DiUnpackWord, "io_DiUnpackWord");

   procedure io_DoPackWord (cp    : access io_sCard;
			    Data  : access pwr.pwr_tUInt16;
			    index : int);  -- rt_io_base.h:231
   pragma Import (C, io_DoPackWord, "io_DoPackWord");

   function io_init (process        : io_mProcess;
		     thread         : pwr.pwr_tObjid;
		     ctx            : System.Address;
		     relativ_vector : int;
		     scan_time      : float) 
		    return pwr.pwr_tStatus;  -- rt_io_base.h:237
   pragma Import (C, io_init, "io_init");

   function io_init_swap (process        : io_mProcess;
			  thread         : pwr.pwr_tObjid;
			  ctx            : System.Address;
			  relativ_vector : int;
			  scan_time      : float) 
			 return pwr.pwr_tStatus;  -- rt_io_base.h:245
   pragma Import (C, io_init_swap, "io_init_swap");
   
   function io_read (ctx : io_tCtx) 
		    return pwr.pwr_tStatus;  -- rt_io_base.h:253
   pragma Import (C, io_read, "io_read");

   function io_write (ctx : io_tCtx) 
		     return pwr.pwr_tStatus;  -- rt_io_base.h:257
   pragma Import (C, io_write, "io_write");

   function io_swap (ctx : io_tCtx; event : io_eEvent) 
		    return pwr.pwr_tStatus;  -- rt_io_base.h:261
   pragma Import (C, io_swap, "io_swap");

   function io_close (ctx : io_tCtx) 
		     return pwr.pwr_tStatus;  -- rt_io_base.h:266
   pragma Import (C, io_close, "io_close");

   function io_AiRangeToCoef (chanp : access io_sChannel) 
			     return pwr.pwr_tStatus;  -- rt_io_base.h:270
   pragma Import (C, io_AiRangeToCoef, "io_AiRangeToCoef");

   function io_BiRangeToCoef (chanp : access io_sChannel) 
			     return pwr.pwr_tStatus;  -- rt_io_base.h:274
   pragma Import (C, io_BiRangeToCoef, "io_BiRangeToCoef");

   function io_AoRangeToCoef (chanp : access io_sChannel) 
			     return pwr.pwr_tStatus;  -- rt_io_base.h:278
   pragma Import (C, io_AoRangeToCoef, "io_AoRangeToCoef");
   
   function io_BoRangeToCoef (chanp : access io_sChannel) 
			     return pwr.pwr_tStatus;  -- rt_io_base.h:282
   pragma Import (C, io_BoRangeToCoef, "io_BoRangeToCoef");

   procedure io_ConvertAi (cop       : access pwr_baseclasses.pwr_sClass_ChanAi;
			   rawvalue   : pwr.pwr_tInt16;
			   actvalue_p : access pwr.pwr_tFloat32);  
   -- rt_io_base.h:286
   pragma Import (C, io_ConvertAi, "io_ConvertAi");

   procedure Io_ConvertAi32 (cop     : access pwr_baseclasses.pwr_sClass_ChanAi;
			     rawvalue   : pwr.pwr_tInt32;
			     actvalue_p : access pwr.pwr_tFloat32);  
   -- rt_io_base.h:292
   pragma Import (C, io_ConvertAi32, "io_ConvertAi32");

   procedure io_ConvertAit (cop     : access pwr_baseclasses.pwr_sClass_ChanAit;
			    rawvalue   : pwr.pwr_tInt16;
			    actvalue_p : access pwr.pwr_tFloat32);  
   -- rt_io_base.h:298
   pragma Import (C, io_ConvertAit, "io_ConvertAit");

   function io_init_signals 
     return pwr.pwr_tStatus;  -- rt_io_base.h:304
   pragma Import (C, io_init_signals, "io_init_signals");

   function io_get_iohandler_object (ObjPtr : System.Address; 
				     oid    : access pwr.pwr_tObjid) 
				    return pwr.pwr_tStatus;-- rt_io_base.h:308
   pragma Import (C, io_get_iohandler_object, "io_get_iohandler_object");
   
   function io_GetIoTypeClasses (c_type  : io_eType;
				 classes : System.Address;
				 size    : access int) 
				return pwr.pwr_tStatus;  -- rt_io_base.h:313
   pragma Import (C, io_GetIoTypeClasses, "io_GetIoTypeClasses");

   function io_CheckClassIoType (c_type : io_eType; 
				 cid    : pwr.pwr_tCid) 
				return int;  -- rt_io_base.h:319
   pragma Import (C, io_CheckClassIoType, "io_CheckClassIoType");

   procedure io_methods_print;  -- rt_io_base.h:324
   pragma Import (C, io_methods_print, "io_methods_print");
   
end Rt_Io_Base;
