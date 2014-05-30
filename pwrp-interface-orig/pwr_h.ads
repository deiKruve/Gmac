pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Extensions;

package pwr_h is


   PWR_LOADED : constant := 1;  --  pwr.h:40
   --  unsupported macro: pwr_dImport extern

   pwr_dEnvBusId : aliased constant String := "PWR_BUS_ID" & ASCII.NUL;  --  pwr.h:81
   --  unsupported macro: pwr_dPacked __attribute__ ((packed))

   pwr_dLittleEndian : constant := 1;  --  pwr.h:95
   pwr_dBigEndian : constant := 2;  --  pwr.h:96
   --  unsupported macro: pwr_dHost_byteOrder pwr_dLittleEndian
   --  arg-macro: function pwr_Bit (b)
   --    return 2**b;
   --  arg-macro: function pwr_SetByte (byte, val)
   --    return val<<(byte<<3);

   pwr_cAlignW : constant := 4;  --  pwr.h:122
   pwr_cAlignLW : constant := 4;  --  pwr.h:123
   --  arg-macro: function pwr_AlignW (offs)
   --    return ((offs) + (pwr_cAlignW-1)) and ~(pwr_cAlignW-1);
   --  arg-macro: function pwr_AlignLW (offs)
   --    return ((offs) + (pwr_cAlignLW-1)) and ~(pwr_cAlignLW-1);

   pwr_cSizObjName : constant := 31;  --  pwr.h:132
   pwr_cSizPgmName : constant := 31;  --  pwr.h:133
   pwr_cSizStructName : constant := 31;  --  pwr.h:134
   pwr_cSizGraphName : constant := 15;  --  pwr.h:135
   pwr_cSizXRef : constant := 31;  --  pwr.h:136
   pwr_cSizAttrName : constant := 31;  --  pwr.h:137
   pwr_cSizPathName : constant := 63;  --  pwr.h:138
   pwr_cSizFullName : constant := 199;  --  pwr.h:139
   pwr_cSizOName : constant := 199;  --  pwr.h:140
   pwr_cSizAName : constant := 399;  --  pwr.h:141
   pwr_cSizFileName : constant := 255;  --  pwr.h:142
   pwr_cSizCmd : constant := 255;  --  pwr.h:143
   --  unsupported macro: pwr_mAttrRef_Indirect pwr_Bit(0)
   --  unsupported macro: pwr_mAttrRef_Object pwr_Bit(1)
   --  unsupported macro: pwr_mAttrRef_ObjectAttr pwr_Bit(2)
   --  unsupported macro: pwr_mAttrRef_Array pwr_Bit(3)
   --  unsupported macro: pwr_mAttrRef_Shadowed pwr_Bit(4)
   --  unsupported macro: pwr_mAttrRef_CastAttr pwr_Bit(5)
   --  unsupported macro: pwr_mAttrRef_DisableAttr pwr_Bit(6)
   --  unsupported macro: pwr_cNSubid pwr_cNRefId
   --  unsupported macro: pwr_cNDlid pwr_cNRefId
   --  arg-macro: function MIN (a, b)
   --    return ((a)<(b))?(a):(b);
   --  arg-macro: function MAX (a, b)
   --    return ((a)>(b))?(a):(b);
   --  arg-macro: function ODD (a)
   --    return ((int)(a) and 1) /= 0;
   --  arg-macro: function EVEN (a)
   --    return ((int)(a) and 1) = 0;

   EQUAL : constant := 0;  --  pwr.h:605

   ON : constant := 1;  --  pwr.h:609

   OFF : constant := 0;  --  pwr.h:613

   TRUE : constant := 1;  --  pwr.h:617

   FALSE : constant := 0;  --  pwr.h:621

   YES : constant := 1;  --  pwr.h:625

   NO : constant := 0;  --  pwr.h:629
   --  arg-macro: function pwr_Offset (base, field)
   --    return (unsigned long)and((base).field)-(unsigned long)(base);
   --  arg-macro: procedure pwr_Field (a, n)
   --    a n;
   --  arg-macro: procedure pwr_Bits (a, n)
   --    pwr_tBit a : n;
   --  arg-macro: procedure pwr_32Bits (a00, a01, a02, struct { a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 }
   --    struct { a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31 }
   --  arg-macro: procedure pwr_Endian_32 (a00, a01, a02, a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31
   --    a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 a21 a22 a23 a24 a25 a26 a27 a28 a29 a30 a31
   --  arg-macro: procedure pwr_Endian_16 (a00, a01, a02, a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15
   --    a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 a12 a13 a14 a15
   --  arg-macro: procedure pwr_Endian_8 (a00, a01, a02, a00 a01 a02 a03 a04 a05 a06 a07
   --    a00 a01 a02 a03 a04 a05 a06 a07
   --  arg-macro: procedure pwr_Endian_4 (a00, a01, a02, a00 a01 a02 a03
   --    a00 a01 a02 a03
   --  arg-macro: procedure pwr_dStatus (sts, status, ispwr_tStatus pwr__sts_; pwr_tStatus *sts := (status = NULL) ? andpwr__sts_ : status; *sts := ists
   --    pwr_tStatus pwr__sts_; pwr_tStatus *sts := (status = NULL) ? andpwr__sts_ : status; *sts := ists
   --  arg-macro: function pwr_Status (sts, lsts)
   --    return (void*)(sts)?((*sts) := (lsts)):(lsts);
   --  arg-macro: procedure pwr_StatusBreak (a, b)
   --    {a := b; break;}
   --  arg-macro: procedure pwr_Return (a, sts, lsts)
   --    return (((void*)(sts) ? (*sts) := (lsts) : lsts), a)
   --  arg-macro: procedure pwr_ReturnVoid (sts, lsts)
   --    {((void*)(sts)?(*sts) := (lsts):lsts); return;}
   --  unsupported macro: pwr_Assert(a) ((a)?(void)0:(void)(printf("pwr assertion (%s) failed,\n    in file %s, at line %d\n", #a,__FILE__,__LINE__),exit(EXIT_FAILURE)))

   pwr_dFormatUInt64 : aliased constant String := "%llu" & ASCII.NUL;  --  pwr.h:755
   pwr_dFormatInt64 : aliased constant String := "%lld" & ASCII.NUL;  --  pwr.h:756

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

  -- pwr.h -- basic definitions for PROVIEW/R
  --  

  --! \file pwr.h
  --    \brief Basic type definitions.
  --   This include file contains the Proview basic type definitions.
  -- 

  --! \addtogroup Pwr  
  --@{ 
  -- Environment variable which MUST be defined.
  -- * eg. export PWR_BUS_ID="300"    
  --  

  -- PROVIEW/R types   
  --!< Generic pointer type.
   type pwr_tAddress is new System.Address;  -- pwr.h:145

  --!< Bit type.
   subtype pwr_tBit is unsigned;  -- pwr.h:146

  --!< Bitmask type.
   subtype pwr_tBitMask is unsigned;  -- pwr.h:147

  --_*
  --  @aref boolean Boolean
  -- 

  --!< Boolean type.
   subtype pwr_tBoolean is unsigned;  -- pwr.h:151

  --_*
  --  @aref float32 Float32
  -- 

  --!< 32-bit float.
   subtype pwr_tFloat32 is float;  -- pwr.h:155

  --_*
  --  @aref float64 Float64
  -- 

  --!< 64-big float.
   subtype pwr_tFloat64 is double;  -- pwr.h:159

  --_*
  --  @aref char Char
  -- 

  --!< Character type.
   subtype pwr_tChar is char;  -- pwr.h:163

  --_*
  --  @aref string String
  -- 

  --!< String type.
   subtype pwr_tString is Interfaces.C.char_array (size_t);  -- pwr.h:167

  --_*
  --  @aref text Text
  -- 

  --!< Text type.
   subtype pwr_tText is Interfaces.C.char_array (size_t);  -- pwr.h:171

  --_*
  --  @aref int8 Int8
  -- 

  --!< 8-bit integer type.
   subtype pwr_tInt8 is char;  -- pwr.h:175

  --_*
  --  @aref int16 Int16
  -- 

  --!< 16-bit integer type.
   subtype pwr_tInt16 is short;  -- pwr.h:179

  --_*
  --  @aref int32 Int32
  -- 

  --!< 32-bit integer type.
   subtype pwr_tInt32 is int;  -- pwr.h:183

  --! 64-bit integer type.
  --_*
  --  @aref int64 Int64
  -- 

   type uu_pwr_tInt64 is record
      low : aliased unsigned;  -- pwr.h:191
      high : aliased int;  -- pwr.h:192
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pwr_tInt64);  -- pwr.h:193

   --  skipped anonymous struct anon_0

   subtype pwr_tInt64 is uu_pwr_tInt64;

  --! 64-bit unsigned integer type.
  --_*
  --  @aref uint64 UInt64
  -- 

   type uu_pwr_tUInt64 is record
      low : aliased unsigned;  -- pwr.h:209
      high : aliased unsigned;  -- pwr.h:210
   end record;
   pragma Convention (C_Pass_By_Copy, uu_pwr_tUInt64);  -- pwr.h:211

   --  skipped anonymous struct anon_1

   subtype pwr_tUInt64 is uu_pwr_tUInt64;

  --_*
  --  @aref uint8 UInt8
  -- 

  --!< 8-bit unsigned integer type.
   subtype pwr_tUInt8 is unsigned_char;  -- pwr.h:225

  --_*
  --  @aref uint16 UInt16
  -- 

  --!< 16-bit unsigned integer type.
   subtype pwr_tUInt16 is unsigned_short;  -- pwr.h:229

  --_*
  --  @aref uint32 UInt32
  -- 

  --!< 32-bit unsigned integer type.
   subtype pwr_tUInt32 is unsigned;  -- pwr.h:233

  --_*
  --  @aref volumeid VolumeId
  -- 

  --!< Volume identity type.
   subtype pwr_tVid is unsigned;  -- pwr.h:237

  --!< Volume identity type.
   subtype pwr_tVolumeId is pwr_tVid;  -- pwr.h:238

  --!< Attribute index type.
   subtype pwr_tAix is unsigned;  -- pwr.h:239

  --_*
  --  @aref objectix ObjectIx
  -- 

  --!< Object index type.
   subtype pwr_tOix is unsigned;  -- pwr.h:243

  --!< Object index type.
   subtype pwr_tObjectIx is pwr_tOix;  -- pwr.h:244

  --_*
  --  @aref mask Mask
  -- 

  --!< Mask type.
   subtype pwr_tMask is pwr_tUInt32;  -- pwr.h:248

  --_*
  --  @aref enum Enum
  -- 

  --!< Enumeration type.
   subtype pwr_tEnum is pwr_tInt32;  -- pwr.h:252

  --_*
  --  @aref viod Void
  -- 

  --!< Void type.
   subtype pwr_tVoid is System.Address;  -- pwr.h:257

  --! Object identity type.
  --_*
  --  @aref objid Objid
  -- 

   type pwr_tOid is record
      oix : aliased pwr_tOix;  -- pwr.h:264
      vid : aliased pwr_tVid;  -- pwr.h:265
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tOid);  -- pwr.h:266

   --  skipped anonymous struct anon_2

  --!< Object identity type.
   subtype pwr_tObjid is pwr_tOid;

   subtype pwr_tObjDId is pwr_tOid;

  --_*
  --  @aref classid ClassId
  -- 

  --!< Class identity type.
   subtype pwr_tCid is unsigned;  -- pwr.h:273

  --!< Class identity type.
   subtype pwr_tClassId is pwr_tCid;  -- pwr.h:274

  --_*
  --  @aref typeid TypeId
  -- 

  --!< Type identity type.
   subtype pwr_tTid is unsigned;  -- pwr.h:278

  --!< Type identity type.
   subtype pwr_tTypeId is pwr_tTid;  -- pwr.h:279

  --_*
  --  @aref status Status
  -- 

  --!< Status type.
   subtype pwr_tStatus is int;  -- pwr.h:284

  --_*
  --  @aref netstatus NetStatus
  -- 

  --!< Network status type.
   subtype pwr_tNetStatus is int;  -- pwr.h:288

   subtype pwr_tGeneration is unsigned;  -- pwr.h:290

   subtype pwr_tBid is unsigned;  -- pwr.h:291

   subtype pwr_tVersion is unsigned;  -- pwr.h:292

   subtype pwr_tPwrVersion is unsigned;  -- pwr.h:293

   subtype pwr_tProjVersion is unsigned;  -- pwr.h:294

   subtype pwr_tUserId is unsigned;  -- pwr.h:295

   subtype pwr_tDbId is unsigned;  -- pwr.h:296

  --!< Node identity type.
   subtype pwr_tNid is pwr_tVolumeId;  -- pwr.h:297

  --!< Node identity type.
   subtype pwr_tNodeId is pwr_tNid;  -- pwr.h:298

  --!< Node index type.
   subtype pwr_tNodeIndex is pwr_tNid;  -- pwr.h:299

  --!< Server identity type.
   subtype pwr_tSid is unsigned;  -- pwr.h:300

  --_*
  --  @aref refid RefId
  -- 

   type pwr_tRid is record
      rix : aliased pwr_tUInt32;  -- pwr.h:306
      nid : aliased pwr_tNid;  -- pwr.h:307
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tRid);  -- pwr.h:308

   --  skipped anonymous struct anon_3

  --!< Reference identity type.
  --!< Reference identity type.
   subtype pwr_tRefId is pwr_tRid;

  --!< Direct link identity type.
   subtype pwr_tDlid is pwr_tRid;

  --!< Subscription identity type.
   subtype pwr_tSubid is pwr_tRid;

  --_*
  --  @aref bix Bix
  -- 

  --! Body index enumeration.
   subtype pwr_eBix is unsigned;
   pwr_eBix_u_u : constant pwr_eBix := 0;
   pwr_eBix_sys : constant pwr_eBix := 1;
   pwr_eBix_rt : constant pwr_eBix := 1;
   pwr_eBix_dev : constant pwr_eBix := 2;
   pwr_eBix_template : constant pwr_eBix := 7;
   pwr_eBix_u : constant pwr_eBix := 8;  -- pwr.h:326

  --! Vax time.
   type pwr_tVaxTime is record
      low : aliased int;  -- pwr.h:330
      high : aliased int;  -- pwr.h:331
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tVaxTime);  -- pwr.h:332

   --  skipped anonymous struct anon_5

  --! Proview version type
   type pwr_uPwrVersion;
   type anon_7 is record
      Char : aliased pwr_tChar;  -- pwr.h:341
      Major : aliased pwr_tUInt8;  -- pwr.h:342
      Minor : aliased pwr_tUInt8;  -- pwr.h:343
      Update : aliased pwr_tUInt8;  -- pwr.h:344
   end record;
   pragma Convention (C_Pass_By_Copy, anon_7);
   type pwr_uPwrVersion (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            i : aliased pwr_tPwrVersion;  -- pwr.h:336
         when others =>
            s : aliased anon_7;  -- pwr.h:354
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_uPwrVersion);
   pragma Unchecked_Union (pwr_uPwrVersion);  -- pwr.h:355

   --  skipped anonymous struct anon_6

  --! Word representation
  --_*
  --  @aref time Time
  -- 

  -- typedef struct timespec pwr_tTime;	//!< Abolute time type.
   type pwr_tTime is record
      tv_sec : aliased pwr_tInt64;  -- pwr.h:370
      tv_nsec : aliased pwr_tInt64;  -- pwr.h:371
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tTime);  -- pwr.h:372

   --  skipped anonymous struct anon_8

  --! Delta time type.
  --_*
  --  @aref deltatime DeltaTime
  -- 

   type pwr_tDeltaTime is record
      tv_sec : aliased pwr_tInt64;  -- pwr.h:379
      tv_nsec : aliased pwr_tInt64;  -- pwr.h:380
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tDeltaTime);  -- pwr.h:381

   --  skipped anonymous struct anon_9

  --_*
  --  @aref objname ObjName
  -- 

  --!< Object name type.
   subtype pwr_tObjName is Interfaces.C.char_array (0 .. 31);  -- pwr.h:386

  --_*
  --  @aref pgmname PgmName
  -- 

  --!< PgmName type.
   subtype pwr_tPgmName is Interfaces.C.char_array (0 .. 31);  -- pwr.h:390

  --_*
  --  @aref xref XRef
  -- 

  --!< XRef type.
   subtype pwr_tXRef is Interfaces.C.char_array (0 .. 31);  -- pwr.h:395

  --_*
  --  @aref graphname GraphName
  -- 

  --!< GraphName type.
   subtype pwr_tGraphName is Interfaces.C.char_array (0 .. 15);  -- pwr.h:400

  --!< StructName type.
   subtype pwr_tStructName is Interfaces.C.char_array (0 .. 31);  -- pwr.h:401

  --!< AttrName type.
   subtype pwr_tAttrName is Interfaces.C.char_array (0 .. 31);  -- pwr.h:402

  --!< PathName type.
   subtype pwr_tPathName is Interfaces.C.char_array (0 .. 63);  -- pwr.h:403

  --!< FullName type.
   subtype pwr_tFullName is Interfaces.C.char_array (0 .. 199);  -- pwr.h:404

  --!< Full Object Name type.
   subtype pwr_tOName is Interfaces.C.char_array (0 .. 199);  -- pwr.h:405

  --!< Full Aref Name type.
   subtype pwr_tAName is Interfaces.C.char_array (0 .. 399);  -- pwr.h:406

  --!< FileName type.
   subtype pwr_tFileName is Interfaces.C.char_array (0 .. 255);  -- pwr.h:407

  --!< Command string type.
   subtype pwr_tCmd is Interfaces.C.char_array (0 .. 255);  -- pwr.h:408

  --_*
  --  @aref string256 String256
  -- 

  --!< 256 byte string type.
   subtype pwr_tString256 is Interfaces.C.char_array (0 .. 255);  -- pwr.h:413

  --_*
  --  @aref string132 String132
  -- 

  --!< 132 byte string type.
   subtype pwr_tString132 is Interfaces.C.char_array (0 .. 131);  -- pwr.h:417

  --_*
  --  @aref string80 String80
  -- 

  --!< 80 byte string type.
   subtype pwr_tString80 is Interfaces.C.char_array (0 .. 79);  -- pwr.h:421

  --_*
  --  @aref string40 String40
  -- 

  --!< 40 byte string type.
   subtype pwr_tString40 is Interfaces.C.char_array (0 .. 39);  -- pwr.h:425

  --_*
  --  @aref string32 String32
  -- 

  --!< 32 byte string type.
   subtype pwr_tString32 is Interfaces.C.char_array (0 .. 31);  -- pwr.h:429

  --_*
  --  @aref string16 String16
  -- 

  --!< 16 byte string type.
   subtype pwr_tString16 is Interfaces.C.char_array (0 .. 15);  -- pwr.h:433

  --_*
  --  @aref string8 String8
  -- 

  --!< 8 byte string type.
   subtype pwr_tString8 is Interfaces.C.char_array (0 .. 7);  -- pwr.h:437

  --_*
  --  @aref string1 String1
  -- 

  --!< 1 byte string type.
   subtype pwr_tString1 is Interfaces.C.char_array (0 .. 0);  -- pwr.h:441

  --_*
  --  @aref prostring40 ProString40
  -- 

  --!< 40 byte protected string type.
   subtype pwr_tProString40 is Interfaces.C.char_array (0 .. 39);  -- pwr.h:445

  --_*
  --  @aref text256 Text256
  -- 

  --!< 256 byte text type.
   subtype pwr_tText256 is Interfaces.C.char_array (0 .. 255);  -- pwr.h:449

  --_*
  --  @aref text1024 Text1024
  -- 

  --!< 1024 byte text type.
   subtype pwr_tText1024 is Interfaces.C.char_array (0 .. 1023);  -- pwr.h:453
   
   subtype Pwr_TText8192    is Interfaces.C.char_array (0 .. 8191);
   -- 8192 byte text type.
  --_*
  --  @aref url URL
  -- 

  --!< URL type.
   subtype pwr_tURL is Interfaces.C.char_array (0 .. 159);  -- pwr.h:457

  --_*
  --  @aref castid CastId
  -- 

  --!< CastId type.
   subtype pwr_tCastId is pwr_tTypeId;  -- pwr.h:461

  --_*
  --  @aref disableattr DisableAttr
  -- 

  --!< DisableAttr type.
   subtype pwr_tDisableAttr is unsigned;  -- pwr.h:465

  --_*
  --  @aref emergbreakselectenum EmergBreakSelectEnum
  -- 

  --!< Node attribute enum.
   subtype pwr_tEmergBreakSelectEnum is pwr_tEnum;  -- pwr.h:470

  --_*
  --  @aref opsysenum OpSysEnum
  -- 

  --!< Operating system enum.
   subtype pwr_tOpSysEnum is pwr_tEnum;  -- pwr.h:475

  --_*
  --  @aref opsysenum OpSysMask
  -- 

  --!< Operating system Mask.
   subtype pwr_tOpSysMask is pwr_tMask;  -- pwr.h:480

  --_*
  --  @aref attrrefflag AttrRefFlag
  -- 

  --! Attribute reference flags type.
   type pwr_mAttrRef;
   type anon_11 is record
      Indirect : Extensions.Unsigned_1;  -- pwr.h:493
      Object : Extensions.Unsigned_1;  -- pwr.h:494
      ObjectAttr : Extensions.Unsigned_1;  -- pwr.h:495
      c_Array : Extensions.Unsigned_1;  -- pwr.h:496
      Shadowed : Extensions.Unsigned_1;  -- pwr.h:497
      CastAttr : Extensions.Unsigned_1;  -- pwr.h:498
      DisableAttr : Extensions.Unsigned_1;  -- pwr.h:499
      fill : Extensions.Unsigned_25;  -- pwr.h:501
   end record;
   pragma Convention (C_Pass_By_Copy, anon_11);
   type pwr_mAttrRef (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            m : aliased pwr_tBitMask;  -- pwr.h:488
         when others =>
            b : aliased anon_11;  -- pwr.h:516
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_mAttrRef);
   pragma Unchecked_Union (pwr_mAttrRef);  -- pwr.h:526

   --  skipped anonymous struct anon_10

  --! Bitmask representation.
  --! Attribute reference.
  --_*
  --  @aref attrref AttrRef
  -- 

  --!< Object identity.
   type pwr_sAttrRef is record
      Objid : aliased pwr_tOid;  -- pwr.h:533
      c_Body : aliased pwr_tCid;  -- pwr.h:534
      Offset : aliased pwr_tUInt32;  -- pwr.h:535
      Size : aliased pwr_tUInt32;  -- pwr.h:536
      Flags : pwr_mAttrRef;  -- pwr.h:537
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sAttrRef);  -- pwr.h:538

   --  skipped anonymous struct anon_12

  --!< Typeid of attribute, body or class.
  --!< Offset in body.
  --!< Attribute size.
  --!< Attribute flags.
   subtype pwr_tAttrRef is pwr_sAttrRef;

  --_*
  --  @aref dataref DataRef
  -- 

  --!< Private plc pointer to data object.
   type pwr_tDataRef is record
      Ptr : System.Address;  -- pwr.h:546
      Aref : aliased pwr_sAttrRef;  -- pwr.h:547
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_tDataRef);  -- pwr.h:548

   --  skipped anonymous struct anon_13

  --!< Attribute reference to data object.
  --_*
  --  @aref constants Constants
  -- 

  --! Zero attribute reference constant.
   pwr_cNAttrRef : aliased pwr_sAttrRef;  -- pwr.h:557
   pragma Import (CPP, pwr_cNAttrRef, "_ZL13pwr_cNAttrRef");

  --!< Zero object identity constant.
   pwr_cNOid : aliased pwr_tOid;  -- pwr.h:559
   pragma Import (CPP, pwr_cNOid, "_ZL9pwr_cNOid");

  --!< Zero object identity constant.
   pwr_cNObjid : aliased pwr_tObjid;  -- pwr.h:560
   pragma Import (CPP, pwr_cNObjid, "_ZL11pwr_cNObjid");

  --!< Zero reference identity constant.
   pwr_cNRefId : aliased pwr_tDlid;  -- pwr.h:561
   pragma Import (CPP, pwr_cNRefId, "_ZL11pwr_cNRefId");

  --!< Zero object index constant.
   pwr_cNOix : aliased pwr_tOix;  -- pwr.h:564
   pragma Import (CPP, pwr_cNOix, "_ZL9pwr_cNOix");

  --!< Zero object index constant.
   pwr_cNObjectIx : aliased pwr_tObjectIx;  -- pwr.h:565
   pragma Import (CPP, pwr_cNObjectIx, "_ZL14pwr_cNObjectIx");

  --!< Zero class identity constant.
   pwr_cNClassId : aliased pwr_tClassId;  -- pwr.h:566
   pragma Import (CPP, pwr_cNClassId, "_ZL13pwr_cNClassId");

  --!< Zero type identity constant.
   pwr_cNTypeId : aliased pwr_tTypeId;  -- pwr.h:567
   pragma Import (CPP, pwr_cNTypeId, "_ZL12pwr_cNTypeId");

  --!< Zero cast identity constant.
   pwr_cNCastId : aliased pwr_tCastId;  -- pwr.h:568
   pragma Import (CPP, pwr_cNCastId, "_ZL12pwr_cNCastId");

  --!< Zero disable attribute constant.
   pwr_cNDisableAttr : aliased pwr_tDisableAttr;  -- pwr.h:569
   pragma Import (CPP, pwr_cNDisableAttr, "_ZL17pwr_cNDisableAttr");

  --!< Zero volume identity constant.
   pwr_cNVolumeId : aliased pwr_tVolumeId;  -- pwr.h:570
   pragma Import (CPP, pwr_cNVolumeId, "_ZL14pwr_cNVolumeId");

  --!< Zero node identity constant.
   pwr_cNNodeId : aliased pwr_tNodeId;  -- pwr.h:571
   pragma Import (CPP, pwr_cNNodeId, "_ZL12pwr_cNNodeId");

  --!< Zero class identity constant.
   pwr_cNCid : aliased pwr_tCid;  -- pwr.h:572
   pragma Import (CPP, pwr_cNCid, "_ZL9pwr_cNCid");

  --!< Zero type identity constant.
   pwr_cNTid : aliased pwr_tTid;  -- pwr.h:573
   pragma Import (CPP, pwr_cNTid, "_ZL9pwr_cNTid");

  --!< Zero volume identity constant.
   pwr_cNVid : aliased pwr_tVid;  -- pwr.h:574
   pragma Import (CPP, pwr_cNVid, "_ZL9pwr_cNVid");

  --!< Zero node identity constant.
   pwr_cNNid : aliased pwr_tNid;  -- pwr.h:575
   pragma Import (CPP, pwr_cNNid, "_ZL9pwr_cNNid");

  --!< Zero status constant.
   pwr_cNStatus : aliased pwr_tStatus;  -- pwr.h:576
   pragma Import (CPP, pwr_cNStatus, "_ZL12pwr_cNStatus");

  --!< Zero time constant.
   pwr_cNTime : aliased pwr_tTime;  -- pwr.h:577
   pragma Import (CPP, pwr_cNTime, "_ZL10pwr_cNTime");

  --!< Zero deltatime constant.
   pwr_cNDeltaTime : aliased pwr_tDeltaTime;  -- pwr.h:578
   pragma Import (CPP, pwr_cNDeltaTime, "_ZL15pwr_cNDeltaTime");

  -- Gereral macro definitions   
  --! Return the smallest of two values
  --! Return the largest of two values
  --! Check if value is odd
  --! Check if value is even
  -- General definitions   
  --@} 
end pwr_h;
