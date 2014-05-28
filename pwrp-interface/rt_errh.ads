-- 
-- * Proview   Open Source Process Control.
-- * Copyright (C) 2005-2012 SSAB EMEA AB.
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
with rt_qcom;
with Interfaces.C.Strings;
with System;

package rt_errh is
   
   errh_cAnix_SrvSize : constant := 40;  --  rt_errh.h:97
   
   type errh_eSeverity is 
     (errh_eSeverity_Null,
      errh_eSeverity_Success,
      errh_eSeverity_Info,
      errh_eSeverity_Warning,
      errh_eSeverity_Error,
      errh_eSeverity_Fatal);
   -- Severity enumeration
   pragma Convention (C, errh_eSeverity);  -- rt_errh.h:94
   
   subtype errh_eAnix is unsigned;
   -- Application index
   Errh_ENAnix           : constant errh_eAnix := 0;
   Errh_EAnix_Ini        : constant errh_eAnix := 1;
   Errh_EAnix_Qmon       : constant errh_eAnix := 2;
   Errh_EAnix_Neth       : constant errh_eAnix := 3;
   errh_eAnix_neth_acp   : constant errh_eAnix := 4;
   Errh_EAnix_Io         : constant errh_eAnix := 5;
   Errh_EAnix_Tmon       : constant errh_eAnix := 6;
   Errh_EAnix_Emon       : constant errh_eAnix := 7;
   errh_eAnix_alim       : constant errh_eAnix := 8;
   errh_eAnix_bck        : constant errh_eAnix := 9;
   errh_eAnix_linksup    : constant errh_eAnix := 10;
   Errh_EAnix_Trend      : constant errh_eAnix := 11;
   errh_eAnix_fast       : constant errh_eAnix := 12;
   errh_eAnix_elog       : constant errh_eAnix := 13;
   errh_eAnix_webmon     : constant errh_eAnix := 14;
   errh_eAnix_webmonmh   : constant errh_eAnix := 15;
   Errh_EAnix_Sysmon     : constant errh_eAnix := 16;
   Errh_EAnix_Plc        : constant errh_eAnix := 17;
   errh_eAnix_remote     : constant errh_eAnix := 18;
   errh_eAnix_opc_server : constant errh_eAnix := 19;
   errh_eAnix_statussrv  : constant errh_eAnix := 20;
   Errh_EAnix_Post       : constant errh_eAnix := 21;
   errh_eAnix_report     : constant errh_eAnix := 22;
   errh_eAnix_sevhistmon : constant errh_eAnix := 23;
   Errh_EAnix_Appl1      : constant errh_eAnix := 41;
   errh_eAnix_appl2      : constant errh_eAnix := 42;
   errh_eAnix_appl3      : constant errh_eAnix := 43;
   errh_eAnix_appl4      : constant errh_eAnix := 44;
   errh_eAnix_appl5      : constant errh_eAnix := 45;
   errh_eAnix_appl6      : constant errh_eAnix := 46;
   errh_eAnix_appl7      : constant errh_eAnix := 47;
   errh_eAnix_appl8      : constant errh_eAnix := 48;
   errh_eAnix_appl9      : constant errh_eAnix := 49;
   errh_eAnix_appl10     : constant errh_eAnix := 50;
   errh_eAnix_appl11     : constant errh_eAnix := 51;
   errh_eAnix_appl12     : constant errh_eAnix := 52;
   errh_eAnix_appl13     : constant errh_eAnix := 53;
   errh_eAnix_appl14     : constant errh_eAnix := 54;
   errh_eAnix_appl15     : constant errh_eAnix := 55;
   errh_eAnix_appl16     : constant errh_eAnix := 56;
   errh_eAnix_appl17     : constant errh_eAnix := 57;
   errh_eAnix_appl18     : constant errh_eAnix := 58;
   errh_eAnix_appl19     : constant errh_eAnix := 59;
   errh_eAnix_appl20     : constant errh_eAnix := 50;  -- rt_errh.h:147

   subtype errh_eMsgType is unsigned;
   -- Message type
   Errh_EMsgType_Log     : constant errh_eMsgType := 1;
   -- Write to console log  
   Errh_EMsgType_Status  : constant errh_eMsgType := 2;  
   -- Set application status  //rt_errh.h:155
   
   type errh_sLog        is 
      record
	 send : aliased pwr.pwr_tBoolean; 
	 logQ : aliased rt_qcom.qcom_sQid;
	 put  : aliased rt_qcom.qcom_sPut;
      end record;
   pragma Convention (C_Pass_By_Copy, errh_sLog);  -- rt_errh.h:162

   subtype errh_sMsg_str_array is Interfaces.C.char_array (0 .. 255);
   type errh_sMsg           is 
      record
	 message_type : aliased long;
	 sts          : aliased pwr.pwr_tStatus; 
	 Anix         : aliased errh_eAnix; 
	 severity     : aliased char;
	 str          : aliased errh_sMsg_str_array;
      end record;
   pragma Convention (C_Pass_By_Copy, errh_sMsg);  -- rt_errh.h:170
   
   function errh_Init (programName : Interfaces.C.Strings.chars_ptr; 
		       anix : errh_eAnix) 
		      return pwr.pwr_tStatus;  -- rt_errh.h:175
   pragma Import (C, errh_Init, "errh_Init");
   -- NOTE! errh_Init MUST always be called before any other
   --	 errh-function is called.   
   
   procedure errh_SetStatus (sts : pwr.pwr_tStatus);  -- rt_errh.h:176
   pragma Import (C, errh_SetStatus, "errh_SetStatus");
   
   procedure errh_Interactive;  -- rt_errh.h:177
   pragma Import (C, errh_Interactive, "errh_Interactive");
   
   function errh_GetMsg (sts     : pwr.pwr_tStatus;
			 Buf     : Interfaces.C.Strings.chars_ptr;
			 bufSize : int) 
			return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:178
   pragma Import (C, errh_GetMsg, "errh_GetMsg");
   
   function errh_GetText (sts : pwr.pwr_tStatus;
			  buf : Interfaces.C.Strings.chars_ptr;
			  bufSize : int) 
			 return Interfaces.C.Strings.chars_ptr; -- rt_errh.h:179
   pragma Import (C, errh_GetText, "errh_GetText");
   
   function errh_Log (buff     : Interfaces.C.Strings.chars_ptr;
		      severity : char;
		      msg      : Interfaces.C.Strings.chars_ptr  -- , ...
		     ) 
		     return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:180
   pragma Import (C, errh_Log, "errh_Log");
   
   procedure errh_Fatal (msg : Interfaces.C.Strings.chars_ptr  -- , ...
			);  -- rt_errh.h:181
   pragma Import (C, errh_Fatal, "errh_Fatal");
   
   procedure errh_Error (msg : Interfaces.C.Strings.chars_ptr  -- , ...
			);  -- rt_errh.h:182
   pragma Import (C, errh_Error, "errh_Error");
   
   procedure errh_Warning (msg : Interfaces.C.Strings.chars_ptr  -- , ...
			  );  -- rt_errh.h:183
   pragma Import (C, errh_Warning, "errh_Warning");
   
   procedure errh_Info (msg : Interfaces.C.Strings.chars_ptr  -- , ...
		       );  -- rt_errh.h:184
   pragma Import (C, errh_Info, "errh_Info");
   
   procedure errh_Success (msg : Interfaces.C.Strings.chars_ptr  -- , ...
			  );  -- rt_errh.h:185
   pragma Import (C, errh_Success, "errh_Success");
   
   procedure errh_LogFatal (arg1 : access errh_sLog; 
			    Msg  : Interfaces.C.Strings.chars_ptr  -- , ...
			   );  -- rt_errh.h:186
   pragma Import (C, errh_LogFatal, "errh_LogFatal");
   
   procedure errh_LogError (arg1 : access errh_sLog; 
			    Msg  : Interfaces.C.Strings.chars_ptr  -- , ...
			   );  -- rt_errh.h:187
   pragma Import (C, errh_LogError, "errh_LogError");
   
   procedure errh_LogWarning (arg1 : access errh_sLog; 
			      Msg  : Interfaces.C.Strings.chars_ptr  -- , ...
			     );  -- rt_errh.h:188
   pragma Import (C, errh_LogWarning, "errh_LogWarning");
   
   procedure errh_LogInfo (arg1 : access errh_sLog; 
			   Msg  : Interfaces.C.Strings.chars_ptr  -- , ...
			  );  -- rt_errh.h:189
   pragma Import (C, errh_LogInfo, "errh_LogInfo");
   
   procedure errh_LogSuccess (arg1 : access errh_sLog; 
			      Msg  : Interfaces.C.Strings.chars_ptr  -- , ...
			     );  -- rt_errh.h:190
   pragma Import (C, errh_LogSuccess, "errh_LogSuccess");
   
   function errh_ErrArgMsg (sts : pwr.pwr_tStatus) 
			   return System.Address;  -- rt_errh.h:191
   pragma Import (C, errh_ErrArgMsg, "errh_ErrArgMsg");
   
   function errh_Message (String   : Interfaces.C.Strings.chars_ptr;
			  severity : char;
			  Msg      : Interfaces.C.Strings.chars_ptr  -- , ...
			 ) 
			 return Interfaces.C.Strings.chars_ptr; -- rt_errh.h:195
   pragma Import (C, errh_Message, "errh_Message");

   function errh_Anix return errh_eAnix;  -- rt_errh.h:196
   pragma Import (C, errh_Anix, "errh_Anix");

   function errh_Severity (arg1 : pwr.pwr_tStatus) 
			  return errh_eSeverity;  -- rt_errh.h:197
   pragma Import (C, errh_Severity, "errh_Severity");

   
end Rt_Errh;

