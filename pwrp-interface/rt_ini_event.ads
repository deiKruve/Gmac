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
with Interfaces.C.Extensions;
with pwr;

package rt_ini_event is


   ini_mEvent_u_u     : constant := 0;  --  rt_ini_event.h:81

   type ini_mEvent;
   type anon_15 is record
      swapInit        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      rebuildInit     : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      newPlcInit      : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      newPlcInitDone  : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      newPlcStart     : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      newPlcStartDone : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      oldPlcStop      : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      oldPlcStopDone  : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      swapDone        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      c_terminate     : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      simLoadStart    : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      simLoadDone     : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc1        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc2        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc3        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc4        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc5        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc6        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc7        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc8        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc9        : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc10       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc11       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc12       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc13       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc14       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc15       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc16       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc17       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc18       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc19       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
      plcProc20       : Extensions.Unsigned_1;  -- rt_ini_event.h:44
   end record;
   pragma Convention (C_Pass_By_Copy, anon_15);
   type ini_mEvent (discr : unsigned := 0) is 
      record
	 case discr is
	    when 0 =>
	       m : aliased pwr.pwr_tBitMask;  -- rt_ini_event.h:43
	    when others =>
	       b : aliased anon_15;  -- rt_ini_event.h:79
	 end case;
      end record;
   pragma Convention (C_Pass_By_Copy, ini_mEvent);
   pragma Unchecked_Union (ini_mEvent);  -- rt_ini_event.h:115

end rt_ini_event;