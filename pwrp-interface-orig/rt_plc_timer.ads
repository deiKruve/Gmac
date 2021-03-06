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
with pwr;
--with bits_pthreadtypes_h;
--limited with rt_plc_h;

package rt_plc_timer is

   type plc_sTimer is 
      record
	 TimerFlag   : aliased pwr.pwr_tBoolean;
	 TimerNext   : access pwr.pwr_tBoolean; 
	 TimerCount  : aliased pwr.pwr_tUInt32;
	 TimerDO     : access pwr.pwr_tBoolean;  
	 TimerTime   : aliased pwr.pwr_tFloat32;
	 TimerDODum  : aliased pwr.pwr_tBoolean;
	 TimerObjDId : aliased pwr.pwr_tObjid; 
	 TimerAcc    : aliased pwr.pwr_tInt32; 
	 TimerMin    : aliased pwr.pwr_tFloat32;
	 TimerMax    : aliased pwr.pwr_tFloat32;
      end record;
   pragma Convention (C_Pass_By_Copy, plc_sTimer);  -- rt_plc_timer.h:67
   
end Rt_Plc_Timer;
