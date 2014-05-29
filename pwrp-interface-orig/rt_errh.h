/* 
 * Proview   Open Source Process Control.
 * Copyright (C) 2005-2012 SSAB EMEA AB.
 *
 * This file is part of Proview.
 *
 * This program is free software; you can redistribute it and/or 
 * modify it under the terms of the GNU General Public License as 
 * published by the Free Software Foundation, either version 2 of 
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with Proview. If not, see <http://www.gnu.org/licenses/>
 *
 * Linking Proview statically or dynamically with other modules is
 * making a combined work based on Proview. Thus, the terms and 
 * conditions of the GNU General Public License cover the whole 
 * combination.
 *
 * In addition, as a special exception, the copyright holders of
 * Proview give you permission to, from the build function in the
 * Proview Configurator, combine Proview with modules generated by the
 * Proview PLC Editor to a PLC program, regardless of the license
 * terms of these modules. You may copy and distribute the resulting
 * combined work under the terms of your choice, provided that every 
 * copy of the combined work is accompanied by a complete copy of 
 * the source code of Proview (the version used to produce the 
 * combined work), being distributed under the terms of the GNU 
 * General Public License plus this exception.
 */

#ifndef rt_errh_h
#define rt_errh_h

#ifndef pwr_h
# include "pwr.h"
#endif

#ifndef rt_qcom_h
# include "rt_qcom.h"
#endif

#ifndef rt_errl_h
# include "rt_errl.h"
#endif

#if defined __cplusplus
extern "C" {
#endif

/** @addtogroup Errh */
/*@{*/

#define OS_POSIX  // jdk

#ifndef errh_Bugcheck
# if defined OS_ELN || defined OS_VMS
#   define errh_Bugcheck(sts, str) \
	(errh_Fatal("pwr bugcheck: <%s>, in file %s, at line %d\n", (str),__FILE__,__LINE__),(lib$signal(sts)))
# elif defined OS_POSIX
#   define errh_Bugcheck(sts, str) \
	(errh_Fatal("pwr bugcheck: <%s>, in file %s, at line %d\n%m", (str),__FILE__,__LINE__, sts),(exit(sts)))
# else
#   error Platform not defined
# endif
#endif

#ifndef errh_ReturnOrBugcheck
# define errh_ReturnOrBugcheck(a, sts, lsts, str)\
         return (((long int)(sts)?((*sts)=(lsts)):(EVEN(lsts)?(errh_Bugcheck(lsts, (str)),(lsts)):(lsts))),a)
#endif

#define errh_SeveritySuccess(sts) 	(((sts) & 7) == 3)
#define errh_SeverityInfo(sts) 		(((sts) & 7) == 1)
#define errh_SeverityWarning(sts) 	(((sts) & 7) == 0)
#define errh_SeverityError(sts) 	(((sts) & 7) == 2)
#define errh_SeverityFatal(sts) 	(((sts) & 7) == 4)

/**
 * Severity enumeration
 */
typedef enum {
  errh_eSeverity_Null,
  errh_eSeverity_Success,
  errh_eSeverity_Info,
  errh_eSeverity_Warning,
  errh_eSeverity_Error,
  errh_eSeverity_Fatal
} errh_eSeverity;


#define errh_cAnix_SrvSize 40

/**
 * Application index
 */
typedef enum {
  errh_eNAnix		= 0,
  errh_eAnix_ini 	= 1,
  errh_eAnix_qmon 	= 2,
  errh_eAnix_neth 	= 3,
  errh_eAnix_neth_acp 	= 4,
  errh_eAnix_io		= 5,
  errh_eAnix_tmon 	= 6,
  errh_eAnix_emon 	= 7,
  errh_eAnix_alim 	= 8,
  errh_eAnix_bck 	= 9,
  errh_eAnix_linksup 	= 10,
  errh_eAnix_trend 	= 11,
  errh_eAnix_fast 	= 12,
  errh_eAnix_elog 	= 13,
  errh_eAnix_webmon 	= 14,
  errh_eAnix_webmonmh 	= 15,
  errh_eAnix_sysmon	= 16,
  errh_eAnix_plc 	= 17,
  errh_eAnix_remote 	= 18,
  errh_eAnix_opc_server	= 19,
  errh_eAnix_statussrv  = 20,
  errh_eAnix_post  	= 21,
  errh_eAnix_report  	= 22,
  errh_eAnix_sevhistmon = 23,
  errh_eAnix_appl1	= 41,
  errh_eAnix_appl2	= 42,
  errh_eAnix_appl3	= 43,
  errh_eAnix_appl4	= 44,
  errh_eAnix_appl5	= 45,
  errh_eAnix_appl6	= 46,
  errh_eAnix_appl7	= 47,
  errh_eAnix_appl8	= 48,
  errh_eAnix_appl9	= 49,
  errh_eAnix_appl10	= 50,
  errh_eAnix_appl11	= 51,
  errh_eAnix_appl12	= 52,
  errh_eAnix_appl13	= 53,
  errh_eAnix_appl14	= 54,
  errh_eAnix_appl15	= 55,
  errh_eAnix_appl16	= 56,
  errh_eAnix_appl17	= 57,
  errh_eAnix_appl18	= 58,
  errh_eAnix_appl19	= 59,
  errh_eAnix_appl20	= 50
} errh_eAnix;

/**
 * Message type
 */
typedef enum {
  errh_eMsgType_Log	= 1,	/**< Write to console log */
  errh_eMsgType_Status 	= 2	/**< Set application status */
} errh_eMsgType;


typedef struct {
  pwr_tBoolean send;
  qcom_sQid logQ;
  qcom_sPut put;
} errh_sLog;

typedef struct {
  long int message_type;
  pwr_tStatus sts;
  errh_eAnix anix;
  char severity;
  char str[LOG_MAX_MSG_SIZE];
} errh_sMsg;

/* NOTE! errh_Init MUST always be called before any other
	 errh-function is called.  */

pwr_tStatus	errh_Init	(const char *programName, errh_eAnix anix);
void		errh_SetStatus  (pwr_tStatus sts);
void		errh_Interactive	();
char		*errh_GetMsg	(const pwr_tStatus sts, char *buf, int bufSize);
char		*errh_GetText	(const pwr_tStatus sts, char *buf, int bufSize);
char		*errh_Log	(char *buff, char severity, const char *msg, ...);
void		errh_Fatal	(const char *msg, ...);
void		errh_Error	(const char *msg, ...);
void		errh_Warning	(const char *msg, ...);
void		errh_Info	(const char *msg, ...);
void		errh_Success	(const char *msg, ...);
void		errh_LogFatal	(errh_sLog*, const char *msg, ...);
void		errh_LogError	(errh_sLog*, const char *msg, ...);
void		errh_LogWarning	(errh_sLog*, const char *msg, ...);
void		errh_LogInfo	(errh_sLog*, const char *msg, ...);
void		errh_LogSuccess	(errh_sLog*, const char *msg, ...);
void		*errh_ErrArgMsg	(pwr_tStatus sts);
void		*errh_ErrArgAF	(char *s);
void		*errh_ErrArgL	(int val);
void		errh_CErrLog	(pwr_tStatus sts, ...);
char		*errh_Message	(char *string, char severity, char *msg, ...);
errh_eAnix	errh_Anix       ();
errh_eSeverity	errh_Severity	(pwr_tStatus);

/** @} */

#if defined __cplusplus
}
#endif

#endif





