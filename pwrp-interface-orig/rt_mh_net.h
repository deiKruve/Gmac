/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#ifndef _RT_MH_NET_H_RPCGEN
#define _RT_MH_NET_H_RPCGEN

#include <rpc/rpc.h>


#ifdef __cplusplus
extern "C" {
#endif

/* 
 * Proview   $Id: rt_mh_net.x,v 1.5 2008-01-24 09:58:41 claes Exp $
 * Copyright (C) 2005 SSAB Oxel�sund AB.
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
 * along with the program, if not, write to the Free Software 
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#ifndef rt_mh_net_h
#define rt_mh_net_h

#if !defined(__rpc_rpc_h) && !defined(__RPC__RPC_H) && !defined(__RPC_HEADER__)
# include <rpc/rpc.h>
#endif

#ifndef co_xdr_h
# include "co_xdr.h"
#endif

#ifndef rt_net_h
#include "rt_net.h"
#endif

#ifndef rt_mh_h
# include "rt_mh.h"
#endif

#ifndef rt_qcom_h
# include "rt_qcom.h"
#endif

#define mh_cMsgClass 201
#define mh_cVersion 4
#define mh_cProcHandler 111
#define mh_cProcAllHandlers qcom_cQmhAllHandlers
#define mh_cProcAllOutunits qcom_cQmhAllOutunits
#define mh_cSendRcvTmo 200

/* Bit masks */

#define mh_mEventStatus_NotRet (1 << 0)
#define mh_mEventStatus_NotAck (1 << 1)
#define mh_mEventStatus_Block (1 << 2)


typedef pwr_tUInt32 mh_mEventStatus;
/** 
 * @ingroup MSGH_DS
 * @brief Type of event that the message handler recognizes.
 */

enum mh_eEvent {
	mh_eEvent__ = 0,
	mh_eEvent_Ack = 1,
	mh_eEvent_Block = 2,
	mh_eEvent_Cancel = 3,
	mh_eEvent_CancelBlock = 4,
	mh_eEvent_Missing = 5,
	mh_eEvent_Reblock = 6,
	mh_eEvent_Return = 7,
	mh_eEvent_Unblock = 8,
	mh_eEvent_Info = 32,
	mh_eEvent_Alarm = 64,
	mh_eEvent_ = 65,
};
typedef enum mh_eEvent mh_eEvent;
/** 
 * @ingroup MSGH_DS
 * @brief Event prio
 *
 * This enumeration defines the priority of the event. 
 * This affects how the message handler treats the generated message. 
 * For A and B priorities the alarm window displays number of alarms, 
 * number of unacknowledged alarms, identities of the alarms, and associated 
 * message texts. For C and D priorities, only number of alarms and number of 
 * unacknowledged alarms are shown. 
 * @param mh_eEventPrio_A Priority A, the highest priority. 
 * Alarm messages of this priority are shown in the upper part of the alarm window. 
 * @param mh_eEventPrio_B Priority B. 
 * These messages are shown in the lower part of the alarm window. 
 * @param mh_eEventPrio_C Priority C. 
 * @param mh_eEventPrio_D Priority D. This is the lowest priority. 
 */

enum mh_eEventPrio {
	mh_eEventPrio__ = 0,
	mh_eEventPrio_A = 67,
	mh_eEventPrio_B = 66,
	mh_eEventPrio_C = 65,
	mh_eEventPrio_D = 64,
	mh_eEventPrio_ = 63,
};
typedef enum mh_eEventPrio mh_eEventPrio;
/** 
 * @ingroup MSGH_DS
 * @brief Type of supervision data.
 * 
 * This enumeration is used to indicate what kind of data is supplied 
 * in an application message (See mh_sApplMessage).
 * @param  mh_eSupType_Digital Digital supervision data
 * @param  mh_eSupType_Analog Analog supervision data 
 * @param  mh_eSupType_Link   ZZZ
 * @param  mh_eSupType_Cycle  ZZZ
 */

enum mh_eSupType {
	mh_eSupType__ = 0,
	mh_eSupType_Digital = 1,
	mh_eSupType_Analog = 2,
	mh_eSupType_None = 3,
	mh_eSupType_Link = 4,
	mh_eSupType_Cycle = 4,
	mh_eSupType_ = 5,
};
typedef enum mh_eSupType mh_eSupType;

enum mh_eMsg {
	mh_eMsg__ = 0,
	mh_eMsg_ApplConnect = 1,
	mh_eMsg_ApplDisconnect = 2,
	mh_eMsg_ApplGetMsgInfo = 3,
	mh_eMsg_ApplMessage = 4,
	mh_eMsg_ApplReply = 5,
	mh_eMsg_ApplReturn = 6,
	mh_eMsg_Event = 8,
	mh_eMsg_HandlerDisconnect = 10,
	mh_eMsg_HandlerHello = 11,
	mh_eMsg_HandlerSync = 12,
	mh_eMsg_OutunitAck = 15,
	mh_eMsg_OutunitBlock = 16,
	mh_eMsg_OutunitDisconnect = 18,
	mh_eMsg_OutunitHello = 19,
	mh_eMsg_OutunitInfo = 20,
	mh_eMsg_OutunitSync = 21,
	mh_eMsg_OutunitClear = 22,
	mh_eMsg_ProcDown = 24,
	mh_eMsg_StopScanSup = 25,
	mh_eMsg_StartScanSup = 26,
	mh_eMsg_Sync = 27,
	mh_eMsg_ = 28,
};
typedef enum mh_eMsg mh_eMsg;

enum mh_eOutunitType {
	mh_eOutunitType__ = 0,
	mh_eOutunitType_Operator = 1,
	mh_eOutunitType_Printer = 2,
	mh_eOutunitType_File = 3,
	mh_eOutunitType_Terminal = 4,
	mh_eOutunitType_Logger = 5,
	mh_eOutunitType_Post = 6,
	mh_eOutunitType_SevHistEvents = 7,
	mh_eOutunitType_ = 8,
};
typedef enum mh_eOutunitType mh_eOutunitType;

enum mh_eSource {
	mh_eSource__ = 0,
	mh_eSource_Scanner = 1,
	mh_eSource_Application = 2,
	mh_eSource_Handler = 3,
	mh_eSource_Outunit = 4,
	mh_eSource_Self = 5,
	mh_eSource_Pcm = 6,
	mh_eSource_ = 7,
};
typedef enum mh_eSource mh_eSource;
/**
 * @ingroup MSGH_DS
 * @brief Defines a bit pattern. 
 *
 * @param mh_mEventFlags_Return Setting this flag enables a return message 
 * associated with this message to be shown in the event list. 
 * @param mh_mEventFlags_Ack Setting this flag enables an acknowledgement message 
 * associated with this message to be shown in the event list. 
 * @param mh_mEventFlags_Bell
 * @param mh_mEventFlags_Force
 * @param mh_mEventFlags_InfoWindow
 * @param mh_mEventFlags_Returned
 * @param mh_mEventFlags_NoObject
 */

enum mh_mEventFlags {
	mh_mEventFlags_Return = 0x01,
	mh_mEventFlags_Ack = 0x02,
	mh_mEventFlags_Bell = 0x04,
	mh_mEventFlags_Force = 0x08,
	mh_mEventFlags_InfoWindow = 0x10,
	mh_mEventFlags_Returned = 0x20,
	mh_mEventFlags_NoObject = 0x40,
};
typedef enum mh_mEventFlags mh_mEventFlags;
/**
 * @ingroup MSGH_DS
 * @brief Data describing supervision of an analog value 
 *
 * @param ActualValue The value of the supervised attribute at the 
 *                    time when the message was generated. 
 * @param CtrlLimit   The limit, at which a message will be generated. 
 * @param Hysteres    How much the supervised value will have to change before 
 *                    a return message will be issued. 
 * @param High        Indicates whether the message will be generated when the 
 *		       limit is exceeded (TRUE) or the value falls below it (FALSE).
 * @param Unit        A string representing the unit of the value. 
 */

struct mh_sASupInfo {
	pwr_tFloat32 ActualValue;
	pwr_tFloat32 CtrlLimit;
	pwr_tFloat32 Hysteres;
	pwr_tBoolean High;
	pwr_tString16 Unit;
};
typedef struct mh_sASupInfo mh_sASupInfo;
/**
 * @ingroup MSGH_DS
 *
 * @brief Data describing supervision of a digital value 
 *
 * @param ActualValue The value of the supervised attribute at the time 
 *                    when the message was generated.
 * @param High        Indicates whether a high or a low value generates a message.
 */

struct mh_sDSupInfo {
	pwr_tBoolean ActualValue;
	pwr_tBoolean High;
};
typedef struct mh_sDSupInfo mh_sDSupInfo;
/**
 * @ingroup MSGH_DS 
 * @brief Data describing supervision data.
 * @param mh_uSubInfo_u Union that contains either mh_sASupInfo or mh_sDSupInfo.
 * @param mh_sASupInfo
 * @param mh_sDSupInfo
 */
struct mh_uSupInfo {
 mh_eSupType SupType;
 union { mh_sASupInfo A;
 mh_sDSupInfo D;
 } mh_uSupInfo_u;
};

typedef struct mh_uSupInfo mh_uSupInfo;
bool_t xdr_mh_uSupInfo();


struct mh_sHead {
	pwr_tBoolean xdr;
	co_sPlatform platform;
	pwr_tUInt32 ver;
	mh_eSource source;
	net_sTime birthTime;
	mh_eMsg type;
	qcom_sQid qid;
	pwr_tNodeIndex nix;
	pwr_tObjid outunit;
	pwr_tObjid aid;
	pwr_tUInt32 ackGen;
	pwr_tUInt32 blockGen;
	pwr_tUInt32 selGen;
	pwr_tUInt32 eventGen;
	pwr_tUInt32 eventIdx;
};
typedef struct mh_sHead mh_sHead;

struct mh_sOutunitAck {
	pwr_tUInt32 ackGen;
	pwr_tUInt32 targetIdx;
};
typedef struct mh_sOutunitAck mh_sOutunitAck;

struct mh_sOutunitBlock {
	pwr_tUInt32 blockGen;
	pwr_tObjid object;
	pwr_tObjid outunit;
	mh_eEventPrio prio;
	net_sTime time;
};
typedef struct mh_sOutunitBlock mh_sOutunitBlock;

struct mh_sSelL {
	pwr_tString80 objName;
	pwr_tUInt32 len;
};
typedef struct mh_sSelL mh_sSelL;

struct mh_sEventId {
	pwr_tNodeIndex Nix;
	net_sTime BirthTime;
	pwr_tUInt32 Idx;
};
typedef struct mh_sEventId mh_sEventId;

struct mh_sMsgInfo {
	mh_sEventId Id;
	pwr_tObjid Object_V3;
	pwr_tObjid Outunit;
	pwr_tObjid SupObject_V3;
	mh_mEventFlags EventFlags;
	net_sTime EventTime;
	pwr_tString80 EventName_V3;
	mh_eEvent EventType;
	mh_eEventPrio EventPrio;
};
typedef struct mh_sMsgInfo mh_sMsgInfo;

struct mh_sAck {
	mh_sMsgInfo Info;
	mh_sEventId TargetId;
	net_sTime DetectTime;
	pwr_tObjid Outunit;
	mh_uSupInfo SupInfo;
	pwr_sAttrRef Object;
	pwr_sAttrRef SupObject;
	pwr_tAName EventName;
};
typedef struct mh_sAck mh_sAck;

struct mh_sBlock {
	mh_sMsgInfo Info;
	mh_sEventId TargetId;
	net_sTime DetectTime;
	pwr_tObjid Outunit;
	mh_mEventStatus Status;
	pwr_sAttrRef Object;
	pwr_sAttrRef SupObject;
	pwr_tAName EventName;
};
typedef struct mh_sBlock mh_sBlock;

struct mh_sMessage {
	mh_sMsgInfo Info;
	pwr_tString80 EventText;
	mh_mEventStatus Status;
	mh_uSupInfo SupInfo;
	pwr_sAttrRef EventSound;
	pwr_tString256 EventMoreText;
	pwr_sAttrRef Object;
	pwr_sAttrRef SupObject;
	pwr_tAName EventName;
	pwr_tString40 Receiver;
};
typedef struct mh_sMessage mh_sMessage;

struct mh_sReturn {
	mh_sMsgInfo Info;
	pwr_tString80 EventText;
	mh_sEventId TargetId;
	net_sTime DetectTime;
	mh_uSupInfo SupInfo;
	pwr_sAttrRef Object;
	pwr_sAttrRef SupObject;
	pwr_tAName EventName;
};
typedef struct mh_sReturn mh_sReturn;
struct mh_sOutunitInfo {
 mh_eOutunitType type;
 pwr_tUInt32 selGen;
 pwr_tUInt32 selSize;
 /* Here comes select list if needed */
};
typedef struct mh_sOutunitInfo mh_sOutunitInfo;

bool_t xdr_mh_sOutunitInfo();


/* Prototypes */

pwr_tStatus
mh_NetSendMessage(
 qcom_sQid *qid,
 co_sPlatform *recPlatform,
 int prio,
 int subtype,
 mh_sHead *hp,
 unsigned int size
);

pwr_tStatus
mh_NetXdrMessage(
 XDR *xdrs,
 int subtype,
 mh_sHead *hp
);


#endif

/* the xdr functions */

#if defined(__STDC__) || defined(__cplusplus)
extern  bool_t xdr_mh_mEventStatus (XDR *, mh_mEventStatus*);
extern  bool_t xdr_mh_eEvent (XDR *, mh_eEvent*);
extern  bool_t xdr_mh_eEventPrio (XDR *, mh_eEventPrio*);
extern  bool_t xdr_mh_eSupType (XDR *, mh_eSupType*);
extern  bool_t xdr_mh_eMsg (XDR *, mh_eMsg*);
extern  bool_t xdr_mh_eOutunitType (XDR *, mh_eOutunitType*);
extern  bool_t xdr_mh_eSource (XDR *, mh_eSource*);
extern  bool_t xdr_mh_mEventFlags (XDR *, mh_mEventFlags*);
extern  bool_t xdr_mh_sASupInfo (XDR *, mh_sASupInfo*);
extern  bool_t xdr_mh_sDSupInfo (XDR *, mh_sDSupInfo*);
extern  bool_t xdr_mh_sHead (XDR *, mh_sHead*);
extern  bool_t xdr_mh_sOutunitAck (XDR *, mh_sOutunitAck*);
extern  bool_t xdr_mh_sOutunitBlock (XDR *, mh_sOutunitBlock*);
extern  bool_t xdr_mh_sSelL (XDR *, mh_sSelL*);
extern  bool_t xdr_mh_sEventId (XDR *, mh_sEventId*);
extern  bool_t xdr_mh_sMsgInfo (XDR *, mh_sMsgInfo*);
extern  bool_t xdr_mh_sAck (XDR *, mh_sAck*);
extern  bool_t xdr_mh_sBlock (XDR *, mh_sBlock*);
extern  bool_t xdr_mh_sMessage (XDR *, mh_sMessage*);
extern  bool_t xdr_mh_sReturn (XDR *, mh_sReturn*);

#else /* K&R C */
extern bool_t xdr_mh_mEventStatus ();
extern bool_t xdr_mh_eEvent ();
extern bool_t xdr_mh_eEventPrio ();
extern bool_t xdr_mh_eSupType ();
extern bool_t xdr_mh_eMsg ();
extern bool_t xdr_mh_eOutunitType ();
extern bool_t xdr_mh_eSource ();
extern bool_t xdr_mh_mEventFlags ();
extern bool_t xdr_mh_sASupInfo ();
extern bool_t xdr_mh_sDSupInfo ();
extern bool_t xdr_mh_sHead ();
extern bool_t xdr_mh_sOutunitAck ();
extern bool_t xdr_mh_sOutunitBlock ();
extern bool_t xdr_mh_sSelL ();
extern bool_t xdr_mh_sEventId ();
extern bool_t xdr_mh_sMsgInfo ();
extern bool_t xdr_mh_sAck ();
extern bool_t xdr_mh_sBlock ();
extern bool_t xdr_mh_sMessage ();
extern bool_t xdr_mh_sReturn ();

#endif /* K&R C */

#ifdef __cplusplus
}
#endif

#endif /* !_RT_MH_NET_H_RPCGEN */
