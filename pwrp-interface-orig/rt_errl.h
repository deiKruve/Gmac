/* 
 * Proview   Open Source Process Control.
 * Copyright (C) 2005-2014 SSAB EMEA AB.
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

#ifndef rt_errl_h
#define rt_errl_h

#ifndef pwr_h
# include "pwr.h"
#endif

#include <unistd.h>
#if defined OS_LYNX
# define LOG_QUEUE_NAME "/pwrlogqueue"
#elif defined OS_POSIX
# if defined OS_FREEBSD || defined OS_MACOS
#  define LOG_QUEUE_NAME "/tmp/pwrlogqueue"
# elif defined _POSIX_MESSAGE_PASSING
#  define LOG_QUEUE_NAME "/pwrlogqueue"
# else
#  define LOG_QUEUE_NAME "/tmp/pwrlogqueue"
# endif
#elif defined OS_ELN
#endif

#define LOG_MAX_MSG_SIZE  256           /* length of logstring */

pwr_tStatus	errl_Exit	();
void		errl_Init	(const char *termname,
				 void (*log_cb)( void *, char *, char, pwr_tStatus, int, int),
				 void *userdata);
void		errl_SetTerm	(const char *termname);
void		errl_SetFile	(const char *filename);

#if defined OS_POSIX
void		errl_Unlink	();
#endif

#endif