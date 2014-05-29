pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with pwr_h;
with rt_qcom_h;
with Interfaces.C.Strings;
with System;

package rt_errh_h is

   --  arg-macro: function errh_Bugcheck (sts, str)
   --    return errh_Fatal("pwr bugcheck: <%s>, in file %s, at line %d" & ASCII.LF & "%m", (str),__FILE__,__LINE__, sts),(exit(sts));
   --  arg-macro: procedure errh_ReturnOrBugcheck (a, sts, lsts, sreturn (((long int)(sts)?((*sts):=(lsts)):(EVEN(lsts)?(errh_Bugcheck(lsts, (str)),(lsts)):(lsts))),a)
   --    return (((long int)(sts)?((*sts):=(lsts)):(EVEN(lsts)?(errh_Bugcheck(lsts, (str)),(lsts)):(lsts))),a)
   --  arg-macro: function errh_SeveritySuccess (sts)
   --    return ((sts) and 7) = 3;
   --  arg-macro: function errh_SeverityInfo (sts)
   --    return ((sts) and 7) = 1;
   --  arg-macro: function errh_SeverityWarning (sts)
   --    return ((sts) and 7) = 0;
   --  arg-macro: function errh_SeverityError (sts)
   --    return ((sts) and 7) = 2;
   --  arg-macro: function errh_SeverityFatal (sts)
   --    return ((sts) and 7) = 4;

   errh_cAnix_SrvSize : constant := 40;  --  rt_errh.h:97

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

  --* @addtogroup Errh  
  --@{ 
  --*
  -- * Severity enumeration
  --  

   type errh_eSeverity is 
     (errh_eSeverity_Null,
      errh_eSeverity_Success,
      errh_eSeverity_Info,
      errh_eSeverity_Warning,
      errh_eSeverity_Error,
      errh_eSeverity_Fatal);
   pragma Convention (C, errh_eSeverity);  -- rt_errh.h:94

  --*
  -- * Application index
  --  

   subtype errh_eAnix is unsigned;
   errh_eNAnix : constant errh_eAnix := 0;
   errh_eAnix_ini : constant errh_eAnix := 1;
   errh_eAnix_qmon : constant errh_eAnix := 2;
   errh_eAnix_neth : constant errh_eAnix := 3;
   errh_eAnix_neth_acp : constant errh_eAnix := 4;
   errh_eAnix_io : constant errh_eAnix := 5;
   errh_eAnix_tmon : constant errh_eAnix := 6;
   errh_eAnix_emon : constant errh_eAnix := 7;
   errh_eAnix_alim : constant errh_eAnix := 8;
   errh_eAnix_bck : constant errh_eAnix := 9;
   errh_eAnix_linksup : constant errh_eAnix := 10;
   errh_eAnix_trend : constant errh_eAnix := 11;
   errh_eAnix_fast : constant errh_eAnix := 12;
   errh_eAnix_elog : constant errh_eAnix := 13;
   errh_eAnix_webmon : constant errh_eAnix := 14;
   errh_eAnix_webmonmh : constant errh_eAnix := 15;
   errh_eAnix_sysmon : constant errh_eAnix := 16;
   errh_eAnix_plc : constant errh_eAnix := 17;
   errh_eAnix_remote : constant errh_eAnix := 18;
   errh_eAnix_opc_server : constant errh_eAnix := 19;
   errh_eAnix_statussrv : constant errh_eAnix := 20;
   errh_eAnix_post : constant errh_eAnix := 21;
   errh_eAnix_report : constant errh_eAnix := 22;
   errh_eAnix_sevhistmon : constant errh_eAnix := 23;
   errh_eAnix_appl1 : constant errh_eAnix := 41;
   errh_eAnix_appl2 : constant errh_eAnix := 42;
   errh_eAnix_appl3 : constant errh_eAnix := 43;
   errh_eAnix_appl4 : constant errh_eAnix := 44;
   errh_eAnix_appl5 : constant errh_eAnix := 45;
   errh_eAnix_appl6 : constant errh_eAnix := 46;
   errh_eAnix_appl7 : constant errh_eAnix := 47;
   errh_eAnix_appl8 : constant errh_eAnix := 48;
   errh_eAnix_appl9 : constant errh_eAnix := 49;
   errh_eAnix_appl10 : constant errh_eAnix := 50;
   errh_eAnix_appl11 : constant errh_eAnix := 51;
   errh_eAnix_appl12 : constant errh_eAnix := 52;
   errh_eAnix_appl13 : constant errh_eAnix := 53;
   errh_eAnix_appl14 : constant errh_eAnix := 54;
   errh_eAnix_appl15 : constant errh_eAnix := 55;
   errh_eAnix_appl16 : constant errh_eAnix := 56;
   errh_eAnix_appl17 : constant errh_eAnix := 57;
   errh_eAnix_appl18 : constant errh_eAnix := 58;
   errh_eAnix_appl19 : constant errh_eAnix := 59;
   errh_eAnix_appl20 : constant errh_eAnix := 50;  -- rt_errh.h:147

  --*
  -- * Message type
  --  

  --*< Write to console log   
  --*< Set application status  
   subtype errh_eMsgType is unsigned;
   errh_eMsgType_Log : constant errh_eMsgType := 1;
   errh_eMsgType_Status : constant errh_eMsgType := 2;  -- rt_errh.h:155

   type errh_sLog is record
      send : aliased pwr_h.pwr_tBoolean;  -- rt_errh.h:159
      logQ : aliased rt_qcom_h.qcom_sQid;  -- rt_errh.h:160
      put : aliased rt_qcom_h.qcom_sPut;  -- rt_errh.h:161
   end record;
   pragma Convention (C_Pass_By_Copy, errh_sLog);  -- rt_errh.h:162

   --  skipped anonymous struct anon_86

   subtype errh_sMsg_str_array is Interfaces.C.char_array (0 .. 255);
   type errh_sMsg is record
      message_type : aliased long;  -- rt_errh.h:165
      sts : aliased pwr_h.pwr_tStatus;  -- rt_errh.h:166
      anix : aliased errh_eAnix;  -- rt_errh.h:167
      severity : aliased char;  -- rt_errh.h:168
      str : aliased errh_sMsg_str_array;  -- rt_errh.h:169
   end record;
   pragma Convention (C_Pass_By_Copy, errh_sMsg);  -- rt_errh.h:170

   --  skipped anonymous struct anon_87

  -- NOTE! errh_Init MUST always be called before any other
  --	 errh-function is called.   

   function errh_Init (programName : Interfaces.C.Strings.chars_ptr; anix : errh_eAnix) return pwr_h.pwr_tStatus;  -- rt_errh.h:175
   pragma Import (C, errh_Init, "errh_Init");

   procedure errh_SetStatus (sts : pwr_h.pwr_tStatus);  -- rt_errh.h:176
   pragma Import (C, errh_SetStatus, "errh_SetStatus");

   procedure errh_Interactive;  -- rt_errh.h:177
   pragma Import (C, errh_Interactive, "errh_Interactive");

   function errh_GetMsg
     (sts : pwr_h.pwr_tStatus;
      buf : Interfaces.C.Strings.chars_ptr;
      bufSize : int) return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:178
   pragma Import (C, errh_GetMsg, "errh_GetMsg");

   function errh_GetText
     (sts : pwr_h.pwr_tStatus;
      buf : Interfaces.C.Strings.chars_ptr;
      bufSize : int) return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:179
   pragma Import (C, errh_GetText, "errh_GetText");

   function errh_Log
     (buff : Interfaces.C.Strings.chars_ptr;
      severity : char;
      msg : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:180
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

   procedure errh_LogFatal (arg1 : access errh_sLog; msg : Interfaces.C.Strings.chars_ptr  -- , ...
      );  -- rt_errh.h:186
   pragma Import (C, errh_LogFatal, "errh_LogFatal");

   procedure errh_LogError (arg1 : access errh_sLog; msg : Interfaces.C.Strings.chars_ptr  -- , ...
      );  -- rt_errh.h:187
   pragma Import (C, errh_LogError, "errh_LogError");

   procedure errh_LogWarning (arg1 : access errh_sLog; msg : Interfaces.C.Strings.chars_ptr  -- , ...
      );  -- rt_errh.h:188
   pragma Import (C, errh_LogWarning, "errh_LogWarning");

   procedure errh_LogInfo (arg1 : access errh_sLog; msg : Interfaces.C.Strings.chars_ptr  -- , ...
      );  -- rt_errh.h:189
   pragma Import (C, errh_LogInfo, "errh_LogInfo");

   procedure errh_LogSuccess (arg1 : access errh_sLog; msg : Interfaces.C.Strings.chars_ptr  -- , ...
      );  -- rt_errh.h:190
   pragma Import (C, errh_LogSuccess, "errh_LogSuccess");

   function errh_ErrArgMsg (sts : pwr_h.pwr_tStatus) return System.Address;  -- rt_errh.h:191
   pragma Import (C, errh_ErrArgMsg, "errh_ErrArgMsg");

   function errh_ErrArgAF (s : Interfaces.C.Strings.chars_ptr) return System.Address;  -- rt_errh.h:192
   pragma Import (C, errh_ErrArgAF, "errh_ErrArgAF");

   function errh_ErrArgL (val : int) return System.Address;  -- rt_errh.h:193
   pragma Import (C, errh_ErrArgL, "errh_ErrArgL");

   procedure errh_CErrLog (sts : pwr_h.pwr_tStatus  -- , ...
      );  -- rt_errh.h:194
   pragma Import (C, errh_CErrLog, "errh_CErrLog");

   function errh_Message
     (string : Interfaces.C.Strings.chars_ptr;
      severity : char;
      msg : Interfaces.C.Strings.chars_ptr  -- , ...
      ) return Interfaces.C.Strings.chars_ptr;  -- rt_errh.h:195
   pragma Import (C, errh_Message, "errh_Message");

   function errh_Anix return errh_eAnix;  -- rt_errh.h:196
   pragma Import (C, errh_Anix, "errh_Anix");

   function errh_Severity (arg1 : pwr_h.pwr_tStatus) return errh_eSeverity;  -- rt_errh.h:197
   pragma Import (C, errh_Severity, "errh_Severity");

  --* @}  
end rt_errh_h;