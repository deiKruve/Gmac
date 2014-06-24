pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with pwr_h;
limited with pwr_baseclasses_h;
limited with rt_plc_timer_h;
with System;

package rt_io_supervise_h is

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

  -- rt_io_supervise.h -- Runtime environment - I/O supervise  
   type s_ASupLstLink;
   subtype sASupLstLink is s_ASupLstLink;

   type s_DSupLstLink;
   subtype sDSupLstLink is s_DSupLstLink;

   type io_sSupCtx_u is record
      TimerLstP : access sASupLstLink;  -- rt_io_supervise.h:58
      ASupAnaLstP : access sASupLstLink;  -- rt_io_supervise.h:59
      DSupDigLstP : access sDSupLstLink;  -- rt_io_supervise.h:60
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- rt_io_supervise.h:61
   end record;
   pragma Convention (C_Pass_By_Copy, io_sSupCtx_u);  -- rt_io_supervise.h:57

   type io_tSupCtx is access all io_sSupCtx_u;  -- rt_io_supervise.h:62

   type s_ASupLstLink is record
      NextP : access sASupLstLink;  -- rt_io_supervise.h:69
      NextTimerP : access sASupLstLink;  -- rt_io_supervise.h:70
      SupP : access pwr_baseclasses_h.pwr_sClass_ASup;  -- rt_io_supervise.h:71
      ValueP : access pwr_h.pwr_tFloat32;  -- rt_io_supervise.h:72
      TimerP : access rt_plc_timer_h.plc_sTimer;  -- rt_io_supervise.h:73
   end record;
   pragma Convention (C_Pass_By_Copy, s_ASupLstLink);  -- rt_io_supervise.h:68

   type s_DSupLstLink is record
      NextP : access sDSupLstLink;  -- rt_io_supervise.h:77
      NextTimerP : access sDSupLstLink;  -- rt_io_supervise.h:78
      SupP : access pwr_baseclasses_h.pwr_sClass_DSup;  -- rt_io_supervise.h:79
      ValueP : access pwr_h.pwr_tBoolean;  -- rt_io_supervise.h:80
      TimerP : access rt_plc_timer_h.plc_sTimer;  -- rt_io_supervise.h:81
   end record;
   pragma Convention (C_Pass_By_Copy, s_DSupLstLink);  -- rt_io_supervise.h:76

   function io_ConnectToSupLst
     (Ctx : io_tSupCtx;
      Class : pwr_h.pwr_tClassId;
      ObjId : pwr_h.pwr_tObjid;
      ObjP : pwr_h.pwr_tAddress) return pwr_h.pwr_tStatus;  -- rt_io_supervise.h:84
   pragma Import (CPP, io_ConnectToSupLst, "_Z18io_ConnectToSupLstP11io_sSupCtx_j8pwr_tOidPv");

  -- Pointer to the object  
  -- Initialize sup lists  
   function io_InitSupLst (Ctx : System.Address; CycleTime : pwr_h.pwr_tFloat32) return pwr_h.pwr_tStatus;  -- rt_io_supervise.h:93
   pragma Import (CPP, io_InitSupLst, "_Z13io_InitSupLstPP11io_sSupCtx_f");

  -- Scan bus connected analog in- and outputs ASup list.   
   function io_ScanSupLst (Ctx : io_tSupCtx) return pwr_h.pwr_tStatus;  -- rt_io_supervise.h:100
   pragma Import (CPP, io_ScanSupLst, "_Z13io_ScanSupLstP11io_sSupCtx_");

  -- Scan bus connected analog in- and outputs ASup timer list.   
   function io_ScanSupTimerLst (Ctx : io_tSupCtx) return pwr_h.pwr_tStatus;  -- rt_io_supervise.h:106
   pragma Import (CPP, io_ScanSupTimerLst, "_Z18io_ScanSupTimerLstP11io_sSupCtx_");

  -- Clear digital and analog lists  
   function io_ClearSupLst (Ctx : io_tSupCtx) return pwr_h.pwr_tStatus;  -- rt_io_supervise.h:112
   pragma Import (CPP, io_ClearSupLst, "_Z14io_ClearSupLstP11io_sSupCtx_");

end rt_io_supervise_h;