pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with pwr_h;
with System;
with pwr_class_h;
with Interfaces.C.Strings;
with stddef_h;

package co_cdh_h is

   --  arg-macro: function co_max (Dragon, Eagle)
   --    return (Dragon) > (Eagle) ? (Dragon) : (Eagle);
   --  arg-macro: function co_min (Dragon, Eagle)
   --    return (Dragon) < (Eagle) ? (Dragon) : (Eagle);

   cdh_cMaxVidGroup : constant := 255;  --  co_cdh.h:81
   cdh_cMaxCix : constant := 4095;  --  co_cdh.h:82
   cdh_cMaxBix : constant := 7;  --  co_cdh.h:83
   cdh_cMaxTix : constant := 2047;  --  co_cdh.h:84
   cdh_cMaxTyg : constant := 1;  --  co_cdh.h:85
   --  unsupported macro: cdh_cMaxOix UINT_MAX
   --  unsupported macro: cdh_cIoConnectVolume (0 + ((pwr_tVolumeId)254 << 24) + (254 << 16) + (254 << 8) + 249)
   --  unsupported macro: cdh_cRtVolume (0 + ((pwr_tVolumeId)254 << 24) + (254 << 16) + (254 << 8) + 245)
   --  arg-macro: function cdh_CidToVid (cid)
   --    return (cid) >> 16;
   --  arg-macro: function cdh_TidToVid (tid)
   --    return (tid) >> 16;
   --  arg-macro: function cdh_cixToCid (Vid, Cix)
   --    return 0 + ((Vid) << 16) + ((Cix) << 3);
   --  arg-macro: function cdh_cidToCix (Cid)
   --    return ((Cid) >> 3) and 16#fff#;
   --  arg-macro: function cdh_tixToTid (Vid, Tyg, Tix)
   --    return 0 + ((Vid) << 16) + (2 ** 15) + ((Tyg) << 11) + (Tix);
   --  arg-macro: function cdh_cixToOix (Cix, Bix, Aix)
   --    return 0 + (2 ** 31) + ((Cix) << 18) + ((Bix) << 15) + (Aix);
   --  arg-macro: function cdh_tixToOix (Tyg, Tix)
   --    return 0 + (2 ** 31) + (2 ** 30) + ((Tyg) << 26) + ((Tix) << 15);
   --  arg-macro: function cdh_oixToBix (Oix)
   --    return (pwr_eBix)(((Oix) >> 15) and 7);
   --  arg-macro: function cdh_oixToCix (Oix)
   --    return ((Oix) >> 18) and 16#fff#;
   --  arg-macro: function cdh_oixToAix (Oix)
   --    return (Oix) and 16#fff#;
   --  arg-macro: function cdh_cidToBid (Cid, Bix)
   --    return (Cid) and (Bix);
   --  arg-macro: function cdh_bidToBix (Bid)
   --    return (Bid) and 7;
   --  arg-macro: function cdh_tidIsCid (Tid)
   --    return ((Tid) and (2 ** 15)) = 0;
   --  unsupported macro: cdh_cUserVolMin (0 + ((pwr_tVolumeId)0 << 24) + (1 << 16) + (1 << 8) + 1)
   --  unsupported macro: cdh_cUserVolMax (0 + ((pwr_tVolumeId)0 << 24) + (254 << 16) + (254 << 8) + 254)
   --  unsupported macro: cdh_cManufactClassVolMin (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (250 << 8) + 0)
   --  unsupported macro: cdh_cManufactClassVolMax (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (254 << 8) + 254)
   --  unsupported macro: cdh_cUserClassVolMin (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (2 << 8) + 1)
   --  unsupported macro: cdh_cUserClassVolMax (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (249 << 8) + 254)
   --  unsupported macro: cdh_cSystemClassVolMin (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (0 << 8) + 1)
   --  unsupported macro: cdh_cSystemClassVolMax (0 + ((pwr_tVolumeId)0 << 24) + (0 << 16) + (1 << 8) + 254)
   --  arg-macro: function cdh_isClassVolumeClass (Cid)
   --    return (Cid) = pwr_eClass_ClassVolume  or else  (Cid) = pwr_eClass_DetachedClassVolume;

   cdh_mParseName_u_u : constant := 0;  --  co_cdh.h:458
   --  unsupported macro: cdh_mParseName_ascii_7 pwr_Bit(0)
   --  unsupported macro: cdh_mParseName_ (~cdh_mParseName__)

   cdh_mNName : constant := 0;  --  co_cdh.h:624
   cdh_mName_u_u : constant := 0;  --  co_cdh.h:625
   --  unsupported macro: cdh_mName_volume pwr_Bit(0)
   --  unsupported macro: cdh_mName_path pwr_Bit(1)
   --  unsupported macro: cdh_mName_object pwr_Bit(2)
   --  unsupported macro: cdh_mName_bodyId pwr_Bit(3)
   --  unsupported macro: cdh_mName_bodyName pwr_Bit(4)
   --  unsupported macro: cdh_mName_attribute pwr_Bit(5)
   --  unsupported macro: cdh_mName_index pwr_Bit(6)
   --  unsupported macro: cdh_mName_escapeGMS pwr_Bit(7)
   --  unsupported macro: cdh_mName_separator pwr_Bit(8)
   --  unsupported macro: cdh_mName_idString pwr_Bit(9)
   --  unsupported macro: cdh_mName_parent pwr_Bit(10)
   --  unsupported macro: cdh_mName_ref pwr_Bit(11)
   --  unsupported macro: cdh_mName_trueAttr pwr_Bit(12)
   --  unsupported macro: cdh_mName_ (~cdh_mName__)

   cdh_mName_eForm_std : constant := 1;  --  co_cdh.h:641
   cdh_mName_eForm_root : constant := 2;  --  co_cdh.h:642
   cdh_mName_eForm_id : constant := 3;  --  co_cdh.h:643
   --  unsupported macro: cdh_mName_form_std pwr_SetByte(2, cdh_mName_eForm_std)
   --  unsupported macro: cdh_mName_form_root pwr_SetByte(2, cdh_mName_eForm_root)
   --  unsupported macro: cdh_mName_form_id pwr_SetByte(2, cdh_mName_eForm_id)

   cdh_mName_eFallback_bestTry : constant := 1;  --  co_cdh.h:649
   cdh_mName_eFallback_strict : constant := 2;  --  co_cdh.h:650
   cdh_mName_eFallback_export : constant := 3;  --  co_cdh.h:651
   cdh_mName_eFallback_volumeDump : constant := 4;  --  co_cdh.h:652
   --  unsupported macro: cdh_mName_fallback_bestTry pwr_SetByte(3, cdh_mName_eFallback_bestTry)
   --  unsupported macro: cdh_mName_fallback_strict pwr_SetByte(3, cdh_mName_eFallback_strict)
   --  unsupported macro: cdh_mName_fallback_export pwr_SetByte(3, cdh_mName_eFallback_export)
   --  unsupported macro: cdh_mName_fallback_volumeDump pwr_SetByte(3, cdh_mName_eFallback_volumeDump)
   --  unsupported macro: cdh_mName_pathBestTry (cdh_mName_path | cdh_mName_object |cdh_mName_attribute | cdh_mName_index | cdh_mName_form_std | cdh_mName_Fallback_bestTry)
   --  unsupported macro: cdh_mName_volumeBestTry (cdh_mName_volume | cdh_mName_path | cdh_mName_object |cdh_mName_attribute | cdh_mName_index | cdh_mName_form_std | cdh_mName_fallback_bestTry)
   --  unsupported macro: cdh_mName_pathStrict (cdh_mName_path | cdh_mName_object |cdh_mName_attribute | cdh_mName_index | cdh_mName_form_std | cdh_mName_fallback_strict)
   --  unsupported macro: cdh_mName_volumeStrict (cdh_mName_volume | cdh_mName_path | cdh_mName_object |cdh_mName_attribute | cdh_mName_index | cdh_mName_form_std | cdh_mName_fallback_strict)

  --* 
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
  -- * 

  -- co_cdh.h -- class definition handler
  --   This include file contains definitions and function prototypes
  --   needed to use CDH.   

  --! \file co_cdh.h
  --    \brief Class definition handler.
  --   This include file contains definitions and function prototypes
  --   needed to use CDH.
  -- 

  --! \defgroup Cdh_DS Cdh Data Structures
  --    \ingroup Cdh
  -- 

  --! \addtogroup Cdh_DS  
  --@{ 
   subtype cdh_eVId3 is unsigned;
   cdh_eVid3_local : constant cdh_eVId3 := 1;
   cdh_eVid3_subid : constant cdh_eVId3 := 128;
   cdh_eVid3_dlid : constant cdh_eVId3 := 129;
   cdh_eVid3_qid : constant cdh_eVId3 := 130;  -- co_cdh.h:93

  --! Get volme identity for class identity.
  --! Get volume identity for type identity.
  --! Get class identity for class index
  --! Get class index from class identity.
  --! Get type identity for type index.
  --! Get object index for class index.
  --! Get object index for type index.
  --! Get object index for body index.
  --! Get class index for object index.
  --! Get attribute index for object index.
  --! Get bodyid from classid.
  --! Get bix from bodyid.
  --! Check if type id is a class id
  --! Smallest value of volume identity for user volumes
  --! Largest value of volume identity for user volumes
  --! Smallest value of volume identity for manufacturer classvolumes
  --! Largest value of volume identity for manufacturer classvolumes
  --! Smallest value of volume identity for user classvolumes
  --! Largest value of volume identity for user classvolumes
  --! Smallest value of volume identity for system classvolumes
  --! Largest value of volume identity for system classvolumes
  --! Internal representatin of object identity.
  --! Object index.
   type cdh_mOid is record
      oix : aliased unsigned;  -- co_cdh.h:146
      vid_0 : aliased unsigned_char;  -- co_cdh.h:157
      vid_1 : aliased unsigned_char;  -- co_cdh.h:158
      vid_2 : aliased unsigned_char;  -- co_cdh.h:159
      vid_3 : aliased unsigned_char;  -- co_cdh.h:160
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mOid);  -- co_cdh.h:163

   --  skipped anonymous struct anon_51

  --!< Internal representation of object identity.
   subtype cdh_mObjid is cdh_mOid;

  --! Internal representation of reference identity.
   type cdh_mRid is record
      rix : aliased unsigned;  -- co_cdh.h:168
      vid_0 : aliased unsigned_char;  -- co_cdh.h:179
      vid_1 : aliased unsigned_char;  -- co_cdh.h:180
      vid_2 : aliased unsigned_char;  -- co_cdh.h:181
      vid_3 : aliased unsigned_char;  -- co_cdh.h:182
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mRid);  -- co_cdh.h:185

   --  skipped anonymous struct anon_52

  --!< Internal representation of reference identity.
   subtype cdh_mRefId is cdh_mRid;

  --! Internal representations of volume identity.
   type cdh_mVid is record
      vid_0 : aliased unsigned_char;  -- co_cdh.h:199
      vid_1 : aliased unsigned_char;  -- co_cdh.h:200
      vid_2 : aliased unsigned_char;  -- co_cdh.h:201
      vid_3 : aliased unsigned_char;  -- co_cdh.h:202
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mVid);  -- co_cdh.h:205

   --  skipped anonymous struct anon_53

  --!< Internal representation of volume identity.
   subtype cdh_mVolumeId is cdh_mVid;

  --! Internal representation of node identity.
   type cdh_mNid is record
      nid_0 : aliased unsigned_char;  -- co_cdh.h:219
      nid_1 : aliased unsigned_char;  -- co_cdh.h:220
      nid_2 : aliased unsigned_char;  -- co_cdh.h:221
      nid_3 : aliased unsigned_char;  -- co_cdh.h:222
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mNid);  -- co_cdh.h:225

   --  skipped anonymous struct anon_54

  --!< Internal representation of node identity.
   subtype cdh_mNodeId is cdh_mNid;

  --! Internal representation of $ClassDef object identity.
   type cdh_mClassObjid is record
      aix : Extensions.Unsigned_12;  -- co_cdh.h:245
      reserved : Extensions.Unsigned_3;  -- co_cdh.h:246
      bix : Extensions.Unsigned_3;  -- co_cdh.h:247
      cix : Extensions.Unsigned_12;  -- co_cdh.h:248
      must_be_two : Extensions.Unsigned_2;  -- co_cdh.h:249
      vid_0 : aliased unsigned_char;  -- co_cdh.h:251
      vid_1 : aliased unsigned_char;  -- co_cdh.h:252
      vid_2 : aliased unsigned_char;  -- co_cdh.h:253
      vid_3 : aliased unsigned_char;  -- co_cdh.h:254
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mClassObjid);
   pragma Pack (cdh_mClassObjid);  -- co_cdh.h:257

   --  skipped anonymous struct anon_55

  --! Internal represention of class identity.
   type cdh_mCid is record
      bix : Extensions.Unsigned_3;  -- co_cdh.h:272
      cix : Extensions.Unsigned_12;  -- co_cdh.h:273
      must_be_zero : Extensions.Unsigned_1;  -- co_cdh.h:274
      vid_0 : aliased unsigned_char;  -- co_cdh.h:276
      vid_1 : aliased unsigned_char;  -- co_cdh.h:277
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mCid);
   pragma Pack (cdh_mCid);  -- co_cdh.h:280

   --  skipped anonymous struct anon_56

  --!< Internal representation of class identity.
   subtype cdh_mClassId is cdh_mCid;

  --! Internal representation of $TypeDef object identity.
   type cdh_mTypeObjid is record
      aix : Extensions.Unsigned_12;  -- co_cdh.h:300
      reserved : Extensions.Unsigned_3;  -- co_cdh.h:301
      tix : Extensions.Unsigned_11;  -- co_cdh.h:302
      tyg : Extensions.Unsigned_4;  -- co_cdh.h:303
      must_be_three : Extensions.Unsigned_2;  -- co_cdh.h:304
      vid_0 : aliased unsigned_char;  -- co_cdh.h:306
      vid_1 : aliased unsigned_char;  -- co_cdh.h:307
      vid_2 : aliased unsigned_char;  -- co_cdh.h:308
      vid_3 : aliased unsigned_char;  -- co_cdh.h:309
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mTypeObjid);
   pragma Pack (cdh_mTypeObjid);  -- co_cdh.h:312

   --  skipped anonymous struct anon_57

  --! Internal representation of type identity.
   type cdh_mTid is record
      tix : Extensions.Unsigned_11;  -- co_cdh.h:327
      tyg : Extensions.Unsigned_4;  -- co_cdh.h:328
      must_be_one : Extensions.Unsigned_1;  -- co_cdh.h:329
      vid_0 : aliased unsigned_char;  -- co_cdh.h:331
      vid_1 : aliased unsigned_char;  -- co_cdh.h:332
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mTid);
   pragma Pack (cdh_mTid);  -- co_cdh.h:335

   --  skipped anonymous struct anon_58

  --!< Internal representation of type identity.
   subtype cdh_mTypeId is cdh_mTid;

  --! Type for representions of object identity.
  --!< Extern representation.
   type cdh_uOid (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            pwr : aliased pwr_h.pwr_tOid;  -- co_cdh.h:340
         when 1 =>
            o : aliased cdh_mObjid;  -- co_cdh.h:341
         when 2 =>
            c : aliased cdh_mClassObjid;  -- co_cdh.h:342
         when others =>
            t : aliased cdh_mTypeObjid;  -- co_cdh.h:343
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uOid);
   pragma Unchecked_Union (cdh_uOid);  -- co_cdh.h:344

   --  skipped anonymous struct anon_59

  --!< Common object representation.
  --!< ClassDef object representation.
  --!< TypeDef object representation.
  --!< Type for representations of object identity. 
   subtype cdh_uObjid is cdh_uOid;

  --! Type for representations of reference identity.
  --!< Extern representation.
   type cdh_uRid (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            pwr : aliased pwr_h.pwr_tRid;  -- co_cdh.h:349
         when others =>
            r : aliased cdh_mRid;  -- co_cdh.h:350
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uRid);
   pragma Unchecked_Union (cdh_uRid);  -- co_cdh.h:351

   --  skipped anonymous struct anon_60

  --!< Intern representation
  --!< Type for representation of reference identity.
   subtype cdh_uRefId is cdh_uRid;

  --! Type for representation of type identity.
  --!< Extern representation.
   type cdh_uTid (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            pwr : aliased pwr_h.pwr_tCid;  -- co_cdh.h:356
         when 1 =>
            c : aliased cdh_mCid;  -- co_cdh.h:357
         when others =>
            t : aliased cdh_mTid;  -- co_cdh.h:358
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uTid);
   pragma Unchecked_Union (cdh_uTid);  -- co_cdh.h:359

   --  skipped anonymous struct anon_61

  --!< Class identity representation.
  --!< Type identity representation.
  --!< Type for representation of type identity.
   subtype cdh_uTypeId is cdh_uTid;

  --! Type for representation of volume identity.
  --!< Extern representation.
   type cdh_uVid (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            pwr : aliased pwr_h.pwr_tVid;  -- co_cdh.h:364
         when others =>
            v : aliased cdh_mVid;  -- co_cdh.h:365
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uVid);
   pragma Unchecked_Union (cdh_uVid);  -- co_cdh.h:366

   --  skipped anonymous struct anon_62

  --!< Intern representation.
  --!< Type for represenation of volume identity.
   subtype cdh_uVolumeId is cdh_uVid;

  --! Type for representation of node identity.
  --!< Extern representation.
   type cdh_uNid (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            pwr : aliased pwr_h.pwr_tNid;  -- co_cdh.h:371
         when others =>
            n : aliased cdh_mNid;  -- co_cdh.h:372
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uNid);
   pragma Unchecked_Union (cdh_uNid);  -- co_cdh.h:373

   --  skipped anonymous struct anon_63

  --!< Intern representation.
  --!< Type for representation of node idenity.
   subtype cdh_uNodeId is cdh_uNid;

  --! Enumeration for identities.
  --!< Object index.
  --!< Object identity.
  --!< Class identity.
  --!< Volume identity.
  --!< Type identity.
  --!< Subscription identity.
  --!< Direct link identity.
  --!< Attribute reference.
   type cdh_eId is 
     (cdh_eId_u_u,
      cdh_eId_objectIx,
      cdh_eId_objid,
      cdh_eId_classId,
      cdh_eId_volumeId,
      cdh_eId_typeId,
      cdh_eId_subid,
      cdh_eId_dlid,
      cdh_eId_aref,
      cdh_eId_u);
   pragma Convention (C, cdh_eId);  -- co_cdh.h:388

  --! Union for identities.
   type cdh_uId (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            oix : aliased pwr_h.pwr_tOix;  -- co_cdh.h:392
         when 1 =>
            oid : aliased pwr_h.pwr_tOid;  -- co_cdh.h:393
         when 2 =>
            cid : aliased pwr_h.pwr_tCid;  -- co_cdh.h:394
         when 3 =>
            vid : aliased pwr_h.pwr_tVid;  -- co_cdh.h:395
         when 4 =>
            tid : aliased pwr_h.pwr_tTid;  -- co_cdh.h:396
         when 5 =>
            sid : aliased pwr_h.pwr_tSubid;  -- co_cdh.h:397
         when 6 =>
            did : aliased pwr_h.pwr_tDlid;  -- co_cdh.h:398
         when others =>
            aref : aliased pwr_h.pwr_sAttrRef;  -- co_cdh.h:399
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uId);
   pragma Unchecked_Union (cdh_uId);  -- co_cdh.h:400

   --  skipped anonymous struct anon_65

  --! Pack name
   type cdh_uPackName;
   type anon_67 is record
      len : aliased pwr_h.pwr_tUInt8;  -- co_cdh.h:416
      hash : aliased pwr_h.pwr_tUInt8;  -- co_cdh.h:417
      first : aliased char;  -- co_cdh.h:418
      last : aliased char;  -- co_cdh.h:419
   end record;
   pragma Convention (C_Pass_By_Copy, anon_67);
   type cdh_uPackName (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            key : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:404
         when others =>
            c : aliased anon_67;  -- co_cdh.h:422
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_uPackName);
   pragma Unchecked_Union (cdh_uPackName);  -- co_cdh.h:423

   --  skipped anonymous struct anon_66

  --! Name structure
  --! Object name struct
   type cdh_sObjName is record
      orig : aliased pwr_h.pwr_tObjName;  -- co_cdh.h:427
      norm : aliased pwr_h.pwr_tObjName;  -- co_cdh.h:428
      pack : cdh_uPackName;  -- co_cdh.h:429
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_sObjName);  -- co_cdh.h:430

   --  skipped anonymous struct anon_68

  --! Family struct.
   type cdh_sFamily is record
      name : aliased cdh_sObjName;  -- co_cdh.h:434
      poid : aliased pwr_h.pwr_tOid;  -- co_cdh.h:435
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_sFamily);  -- co_cdh.h:436

   --  skipped anonymous struct anon_69

  --! Parse name mask
  --! Bitmask representation.
   type cdh_mParseName;
   type anon_71 is record
      ascii_7 : Extensions.Unsigned_1;  -- co_cdh.h:450
      fill : Extensions.Unsigned_31;  -- co_cdh.h:452
   end record;
   pragma Convention (C_Pass_By_Copy, anon_71);
   type cdh_mParseName (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            b : aliased anon_71;  -- co_cdh.h:455
         when others =>
            m : aliased pwr_h.pwr_tBitMask;  -- co_cdh.h:456
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mParseName);
   pragma Unchecked_Union (cdh_mParseName);  -- co_cdh.h:461

   --  skipped anonymous struct anon_70

  --! Name string format description.
  --!
  --  Bitmask that denotes an object or attriubte name string, i.e. which components of the
  --  name that is included in the string.<br>
  --  Some common examples are
  --  <b>cdh_mName_object</b> Object.<br>
  --  <b>cdh_mName_object | cdh_mName_attribute</b> Object and attribute.<br>
  --  <b>cdh_mName_pathStrict</b>          Path, object and attribute<br>
  --  <b>cdh_mName_volumeStrict</b>       Volume, path, object and attribute.
  --   Let us assume we have an object of class Ai.
  --   The object has an attribute called FilterAttribute.
  ---   Object name:	Eobj
  ---   Object id  : 1234567890
  ---   Class name :	pwrb:Class-Ai
  ---   Class id   : 0.2:34
  ---   Volume name:	Avol
  ---   Volume id  : 0.123.34.63
  ---   Parents    : Bobj, Cobj, Dobj
  ---   Attribute  : FilterAttribute
  ---   Index      : 2
  ---   Offset     : 60
  ---   Size	      : 4
  ---   Body name  :	pwrb:Class-Ai-RtBody
  ---   Body id    : 0.2:0.34.1
  --   The name of this object can be written in different ways.
  --   The type cdh_mName is used to define the way an object is named.
  ---   V P O B B A I E S  I   Form  Fallback        String
  ---   o a b o o t n s e  d   
  ---   l t j d d t d c p  T 
  ---   u h e y y r e a a  y 
  ---   m   c I N i x p r  p 
  ---   e   t d a b   e a  e 
  ---           m u   G t    
  ---           e t   M o    
  ---             e   S r    
  ---   1 * * * * * * * 0  1   Id    *               _V0.123.34.63
  ---   1 * * * * * * * 1  1   Id    *               _V0.123.34.63:
  ---   1 * * * * * * * 0  0   Id    *                 0.123.34.63
  ---   1 * * * * * * * 1  0   Id    *                 0.123.34.63:
  ---   0 * 1 * * * * * *  1   Id    *               _O0.123.34.63:1234567890
  ---   0 * 1 * * * * * *  0   Id    *                 0.123.34.63:1234567890
  ---   0 * 0 1 * 1 0 * *  *   Id    *               _A0.123.34.63:1234567890(_T0.2:0.34.1)
  ---   0 * 0 1 * 1 1 * *  *   Id    *               _A0.123.34.63:1234567890(_T0.2:0.34.1)[60.4]
  ---   1 * * * * * * * *  *   Std   Export          _V0.123.34.63:
  ---   0 0 0 * * 1 * * *  *   Std   Export          _O0.123.34.63:1234567890
  ---   0 0 0 0 1 1 * * *  *   Std   Export          _A0.123.34.63:1234567890(pwrb:Class-Ai-RtBody)FilterAttribute[2]
  ---   1 1 1 0 0 1 1 0 *  *   Std   Strict          Avol:Bobj-Cobj-Dobj-Eobj.FilterAttribute[2]
  ---   0 1 1 0 0 1 1 0 *  *   Std   Strict               Bobj-Cobj-Dobj-Eobj.FilterAttribute[2]
  ---   0 0 1 0 0 1 1 0 *  *   Std   Strict                              Eobj.FilterAttribute[2]
  ---   0 0 0 0 0 1 1 0 0  *   Std   Strict                                   FilterAttribute[2]
  ---   0 0 0 0 0 1 1 0 1  *   Std   Strict                                  .FilterAttribute[2]
  ---   0 0 0 0 0 1 0 0 0  *   Std   Strict                                   FilterAttribute
  ---   0 0 0 0 0 1 0 0 1  *   Std   Strict                                  .FilterAttribute
  ---   1 1 1 0 0 1 0 0 *  *   Std   Strict          Avol:Bobj-Cobj-Dobj-Eobj.FilterAttribute
  ---   1 1 1 0 0 0 0 0 0  *   Std   Strict          Avol:Bobj-Cobj-Dobj-Eobj
  ---   1 1 1 0 0 0 0 0 1  *   Std   Strict          Avol:Bobj-Cobj-Dobj-Eobj-
  ---   1 1 0 0 0 0 0 0 0  *   Std   Strict          Avol:Bobj-Cobj-Dobj
  ---   1 1 0 0 0 0 0 0 1  *   Std   Strict          Avol:Bobj-Cobj-Dobj-
  ---   1 0 0 0 0 0 0 0 0  *   Std   Strict          Avol
  ---   1 0 0 0 0 0 0 0 1  *   Std   Strict          Avol:
  --   
  ---   1 1 1 0 0 1 1 1 0  *   Std   Strict          Avol\:Bobj\-Cobj\-Dobj\-Eobj\.FilterAttribute[2]
  ---   0 1 1 0 0 1 1 1 0  *   Std   Strict                Bobj\-Cobj\-Dobj\-Eobj\.FilterAttribute[2]
  ---   0 0 1 0 0 1 1 1 0  *   Std   Strict                                  Eobj\.FilterAttribute[2]
  ---   0 0 0 0 0 1 1 1 0  *   Std   Strict                                        FilterAttribute[2]
  ---   1 1 1 0 0 1 0 1 0  *   Std   Strict          Avol\:Bobj\-Cobj\-Dobj\-Eobj\.FilterAttribute
  ---   1 1 1 0 0 0 0 1 0  *   Std   Strict          Avol\:Bobj\-Cobj\-Dobj\-Eobj
  ---   1 1 0 0 0 0 0 1 0  *   Std   Strict          Avol\:Bobj\-Cobj\-Dobj
  ---   1 0 0 0 0 0 0 1 0  *   Std   Strict          Avol
  --   
  ---   1 1 1 0 0 1 1 0 *  *   Root  Strict          //Avol/Bobj/Cobj/Dobj/Eobj.FilterAttribute[2]
  ---   0 1 1 0 0 1 1 0 *  *   Root  Strict                /Bobj/Cobj/Dobj/Eobj.FilterAttribute[2]
  ---   0 0 1 0 0 1 1 0 *  *   Root  Strict                                Eobj.FilterAttribute[2]
  ---   0 0 0 0 0 1 1 0 0  *   Root  Strict                                     FilterAttribute[2]
  ---   1 1 1 0 0 1 0 0 0  *   Root  Strict          //Avol/Bobj/Cobj/Dobj/Eobj.FilterAttribute
  ---   1 1 1 0 0 0 0 0 0  *   Root  Strict          //Avol/Bobj/Cobj/Dobj/Eobj
  ---   1 1 1 0 0 0 0 0 1  *   Root  Strict          //Avol/Bobj/Cobj/Dobj/Eobj/
  ---   1 1 0 0 0 0 0 0 0  *   Root  Strict          //Avol/Bobj/Cobj/Dobj
  ---   1 1 0 0 0 0 0 0 1  *   Root  Strict          //Avol/Bobj/Cobj/Dobj/
  ---   1 0 0 0 0 0 0 0 0  *   Root  Strict          //Avol
  ---   1 0 0 0 0 0 0 0 1  *   Root  Strict          //Avol/
  --   
  -- 

   type cdh_mName;
   type anon_73 is record
      volume : Extensions.Unsigned_1;  -- co_cdh.h:585
      path : Extensions.Unsigned_1;  -- co_cdh.h:586
      object : Extensions.Unsigned_1;  -- co_cdh.h:587
      bodyId : Extensions.Unsigned_1;  -- co_cdh.h:588
      bodyName : Extensions.Unsigned_1;  -- co_cdh.h:589
      attribute : Extensions.Unsigned_1;  -- co_cdh.h:590
      index : Extensions.Unsigned_1;  -- co_cdh.h:591
      escapeGMS : Extensions.Unsigned_1;  -- co_cdh.h:592
      separator : Extensions.Unsigned_1;  -- co_cdh.h:594
      idString : Extensions.Unsigned_1;  -- co_cdh.h:595
      parent : Extensions.Unsigned_1;  -- co_cdh.h:596
      ref : Extensions.Unsigned_1;  -- co_cdh.h:597
      trueAttr : Extensions.Unsigned_1;  -- co_cdh.h:598
      fill : Extensions.Unsigned_3;  -- co_cdh.h:599
      form : aliased unsigned_char;  -- co_cdh.h:601
      fallback : aliased unsigned_char;  -- co_cdh.h:603
   end record;
   pragma Convention (C_Pass_By_Copy, anon_73);
   type anon_74 is record
      bits : aliased pwr_h.pwr_tUInt16;  -- co_cdh.h:617
      form : aliased pwr_h.pwr_tUInt8;  -- co_cdh.h:618
      fallback : aliased pwr_h.pwr_tUInt8;  -- co_cdh.h:619
   end record;
   pragma Convention (C_Pass_By_Copy, anon_74);
   type cdh_mName (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            m : aliased pwr_h.pwr_tBitMask;  -- co_cdh.h:558
         when 1 =>
            b : aliased anon_73;  -- co_cdh.h:606
         when others =>
            e : aliased anon_74;  -- co_cdh.h:622
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_mName);
   pragma Unchecked_Union (cdh_mName);  -- co_cdh.h:667

   --  skipped anonymous struct anon_72

  --! Bit mask representation.
  --! Word representation.
  --! Parse name struct.
  -- Parent objid, or NOBJID  
   type cdh_sParseName_object_array is array (0 .. 19) of aliased cdh_sFamily;
   type cdh_sParseName_c_body_array is array (0 .. 9) of aliased cdh_sFamily;
   type cdh_sParseName_attribute_array is array (0 .. 19) of aliased cdh_sFamily;
   type cdh_sParseName_index_array is array (0 .. 19) of aliased pwr_h.pwr_tUInt32;
   type cdh_sParseName_hasIndex_array is array (0 .. 19) of aliased pwr_h.pwr_tBoolean;
   type cdh_sParseName is record
      poid : aliased pwr_h.pwr_tOid;  -- co_cdh.h:671
      parseFlags : cdh_mParseName;  -- co_cdh.h:672
      flags : cdh_mName;  -- co_cdh.h:674
      ohp : System.Address;  -- co_cdh.h:675
      eId : aliased cdh_eId;  -- co_cdh.h:676
      uId : cdh_uId;  -- co_cdh.h:677
      bid : aliased pwr_h.pwr_tTid;  -- co_cdh.h:678
      offset : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:679
      size : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:680
      nObject : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:681
      nAttribute : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:682
      nBody : aliased pwr_h.pwr_tUInt32;  -- co_cdh.h:683
      volume : aliased cdh_sFamily;  -- co_cdh.h:684
      object : aliased cdh_sParseName_object_array;  -- co_cdh.h:685
      c_body : aliased cdh_sParseName_c_body_array;  -- co_cdh.h:686
      attribute : aliased cdh_sParseName_attribute_array;  -- co_cdh.h:687
      index : aliased cdh_sParseName_index_array;  -- co_cdh.h:688
      hasIndex : aliased cdh_sParseName_hasIndex_array;  -- co_cdh.h:689
   end record;
   pragma Convention (C_Pass_By_Copy, cdh_sParseName);  -- co_cdh.h:690

   --  skipped anonymous struct anon_75

  --@} 
  --! \defgroup Cdh_FC Cdh Functions
  --    \ingroup Cdh
  -- 

  --! \addtogroup Cdh_FC  
  --@{ 
  --  Function prototypes to exported functions.   
   function cdh_ObjidCompare (Object_1 : pwr_h.pwr_tOid; Object_2 : pwr_h.pwr_tOid) return int;  -- co_cdh.h:704
   pragma Import (C, cdh_ObjidCompare, "cdh_ObjidCompare");

   function cdh_ObjidIsEqual (Object_1 : pwr_h.pwr_tOid; Object_2 : pwr_h.pwr_tOid) return int;  -- co_cdh.h:710
   pragma Import (C, cdh_ObjidIsEqual, "cdh_ObjidIsEqual");

   function cdh_ObjidIsNotEqual (Object_1 : pwr_h.pwr_tOid; Object_2 : pwr_h.pwr_tOid) return int;  -- co_cdh.h:716
   pragma Import (C, cdh_ObjidIsNotEqual, "cdh_ObjidIsNotEqual");

   function cdh_ObjidIsNull (Object : pwr_h.pwr_tOid) return int;  -- co_cdh.h:722
   pragma Import (C, cdh_ObjidIsNull, "cdh_ObjidIsNull");

   function cdh_ObjidIsNotNull (Object : pwr_h.pwr_tOid) return int;  -- co_cdh.h:727
   pragma Import (C, cdh_ObjidIsNotNull, "cdh_ObjidIsNotNull");

   function cdh_SubidCompare (Subscription_1 : pwr_h.pwr_tSubid; Subscription_2 : pwr_h.pwr_tSubid) return int;  -- co_cdh.h:732
   pragma Import (C, cdh_SubidCompare, "cdh_SubidCompare");

   function cdh_SubidIsEqual (Subscription_1 : pwr_h.pwr_tSubid; Subscription_2 : pwr_h.pwr_tSubid) return int;  -- co_cdh.h:738
   pragma Import (C, cdh_SubidIsEqual, "cdh_SubidIsEqual");

   function cdh_SubidIsNotEqual (Subscription_1 : pwr_h.pwr_tSubid; Subscription_2 : pwr_h.pwr_tSubid) return int;  -- co_cdh.h:744
   pragma Import (C, cdh_SubidIsNotEqual, "cdh_SubidIsNotEqual");

   function cdh_SubidIsNull (Subscription : pwr_h.pwr_tSubid) return int;  -- co_cdh.h:750
   pragma Import (C, cdh_SubidIsNull, "cdh_SubidIsNull");

   function cdh_SubidIsNotNull (Subscription : pwr_h.pwr_tSubid) return int;  -- co_cdh.h:755
   pragma Import (C, cdh_SubidIsNotNull, "cdh_SubidIsNotNull");

   function cdh_RefIdCompare (Reference_1 : pwr_h.pwr_tRefId; Reference_2 : pwr_h.pwr_tRefId) return int;  -- co_cdh.h:760
   pragma Import (C, cdh_RefIdCompare, "cdh_RefIdCompare");

   function cdh_RefIdIsEqual (Reference_1 : pwr_h.pwr_tRefId; Reference_2 : pwr_h.pwr_tRefId) return int;  -- co_cdh.h:766
   pragma Import (C, cdh_RefIdIsEqual, "cdh_RefIdIsEqual");

   function cdh_RefIdIsNotEqual (Reference_1 : pwr_h.pwr_tRefId; Reference_2 : pwr_h.pwr_tRefId) return int;  -- co_cdh.h:772
   pragma Import (C, cdh_RefIdIsNotEqual, "cdh_RefIdIsNotEqual");

   function cdh_RefIdIsNull (Reference : pwr_h.pwr_tRefId) return int;  -- co_cdh.h:778
   pragma Import (C, cdh_RefIdIsNull, "cdh_RefIdIsNull");

   function cdh_RefIdIsNotNull (Reference : pwr_h.pwr_tRefId) return int;  -- co_cdh.h:783
   pragma Import (C, cdh_RefIdIsNotNull, "cdh_RefIdIsNotNull");

   function cdh_DlidCompare (DirectLink_1 : pwr_h.pwr_tDlid; DirectLink_2 : pwr_h.pwr_tDlid) return int;  -- co_cdh.h:788
   pragma Import (C, cdh_DlidCompare, "cdh_DlidCompare");

   function cdh_DlidIsEqual (DirectLink_1 : pwr_h.pwr_tDlid; DirectLink_2 : pwr_h.pwr_tDlid) return int;  -- co_cdh.h:794
   pragma Import (C, cdh_DlidIsEqual, "cdh_DlidIsEqual");

   function cdh_DlidIsNotEqual (DirectLink_1 : pwr_h.pwr_tDlid; DirectLink_2 : pwr_h.pwr_tDlid) return int;  -- co_cdh.h:800
   pragma Import (C, cdh_DlidIsNotEqual, "cdh_DlidIsNotEqual");

   function cdh_DlidIsNull (DirectLink : pwr_h.pwr_tDlid) return int;  -- co_cdh.h:806
   pragma Import (C, cdh_DlidIsNull, "cdh_DlidIsNull");

   function cdh_DlidIsNotNull (DirectLink : pwr_h.pwr_tDlid) return int;  -- co_cdh.h:811
   pragma Import (C, cdh_DlidIsNotNull, "cdh_DlidIsNotNull");

   function cdh_ArefIsEqual (arp1 : access pwr_h.pwr_sAttrRef; arp2 : access pwr_h.pwr_sAttrRef) return int;  -- co_cdh.h:816
   pragma Import (C, cdh_ArefIsEqual, "cdh_ArefIsEqual");

   function cdh_IsClassVolume (vid : pwr_h.pwr_tVid) return int;  -- co_cdh.h:821
   pragma Import (C, cdh_IsClassVolume, "cdh_IsClassVolume");

   function cdh_ClassObjidToId (Object : pwr_h.pwr_tOid) return pwr_h.pwr_tCid;  -- co_cdh.h:826
   pragma Import (C, cdh_ClassObjidToId, "cdh_ClassObjidToId");

   function cdh_ClassIdToObjid (Class : pwr_h.pwr_tCid) return pwr_h.pwr_tOid;  -- co_cdh.h:831
   pragma Import (C, cdh_ClassIdToObjid, "cdh_ClassIdToObjid");

   function cdh_TypeObjidToId (Object : pwr_h.pwr_tOid) return pwr_h.pwr_tTid;  -- co_cdh.h:836
   pragma Import (C, cdh_TypeObjidToId, "cdh_TypeObjidToId");

   function cdh_TypeIdToIndex (c_Type : pwr_h.pwr_tTid) return int;  -- co_cdh.h:841
   pragma Import (C, cdh_TypeIdToIndex, "cdh_TypeIdToIndex");

   function cdh_TypeIdToObjid (c_Type : pwr_h.pwr_tTid) return pwr_h.pwr_tOid;  -- co_cdh.h:846
   pragma Import (C, cdh_TypeIdToObjid, "cdh_TypeIdToObjid");

   function cdh_ObjidToAref (Objid : pwr_h.pwr_tObjid) return pwr_h.pwr_sAttrRef;  -- co_cdh.h:851
   pragma Import (C, cdh_ObjidToAref, "cdh_ObjidToAref");

   function cdh_AttrValueToString
     (c_Type : pwr_class_h.pwr_eType;
      Value : System.Address;
      String : Interfaces.C.Strings.chars_ptr;
      MaxSize : int) return pwr_h.pwr_tStatus;  -- co_cdh.h:856
   pragma Import (C, cdh_AttrValueToString, "cdh_AttrValueToString");

   function cdh_StringToAttrValue
     (c_Type : pwr_class_h.pwr_eType;
      String : Interfaces.C.Strings.chars_ptr;
      Value : System.Address) return pwr_h.pwr_tStatus;  -- co_cdh.h:864
   pragma Import (C, cdh_StringToAttrValue, "cdh_StringToAttrValue");

   function cdh_MaskToBinaryString (mask : unsigned; noofbits : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:870
   pragma Import (C, cdh_MaskToBinaryString, "cdh_MaskToBinaryString");

   function cdh_StringToClassId (s : Interfaces.C.Strings.chars_ptr; cid : access pwr_h.pwr_tCid) return pwr_h.pwr_tStatus;  -- co_cdh.h:876
   pragma Import (C, cdh_StringToClassId, "cdh_StringToClassId");

   function cdh_StringToTypeId (s : Interfaces.C.Strings.chars_ptr; tid : access pwr_h.pwr_tTid) return pwr_h.pwr_tStatus;  -- co_cdh.h:882
   pragma Import (C, cdh_StringToTypeId, "cdh_StringToTypeId");

   function cdh_StringToVolumeId (s : Interfaces.C.Strings.chars_ptr; tid : access pwr_h.pwr_tVid) return pwr_h.pwr_tStatus;  -- co_cdh.h:888
   pragma Import (C, cdh_StringToVolumeId, "cdh_StringToVolumeId");

   function cdh_StringToObjectIx (s : Interfaces.C.Strings.chars_ptr; oix : access pwr_h.pwr_tOix) return pwr_h.pwr_tStatus;  -- co_cdh.h:894
   pragma Import (C, cdh_StringToObjectIx, "cdh_StringToObjectIx");

   function cdh_StringToObjid (s : Interfaces.C.Strings.chars_ptr; oid : access pwr_h.pwr_tOid) return pwr_h.pwr_tStatus;  -- co_cdh.h:900
   pragma Import (C, cdh_StringToObjid, "cdh_StringToObjid");

   function cdh_StringToAref (s : Interfaces.C.Strings.chars_ptr; aref : access pwr_h.pwr_tAttrRef) return pwr_h.pwr_tStatus;  -- co_cdh.h:906
   pragma Import (C, cdh_StringToAref, "cdh_StringToAref");

   function cdh_StringToSubid (s : Interfaces.C.Strings.chars_ptr; sid : access pwr_h.pwr_tSubid) return pwr_h.pwr_tStatus;  -- co_cdh.h:912
   pragma Import (C, cdh_StringToSubid, "cdh_StringToSubid");

   function cdh_StringToDlid (s : Interfaces.C.Strings.chars_ptr; did : access pwr_h.pwr_tDlid) return pwr_h.pwr_tStatus;  -- co_cdh.h:918
   pragma Import (C, cdh_StringToDlid, "cdh_StringToDlid");

   function cdh_ClassIdToString
     (s : Interfaces.C.Strings.chars_ptr;
      cid : pwr_h.pwr_tCid;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:924
   pragma Import (C, cdh_ClassIdToString, "cdh_ClassIdToString");

   function cdh_ObjectIxToString
     (s : Interfaces.C.Strings.chars_ptr;
      oix : pwr_h.pwr_tOix;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:931
   pragma Import (C, cdh_ObjectIxToString, "cdh_ObjectIxToString");

   function cdh_ObjidToString
     (s : Interfaces.C.Strings.chars_ptr;
      oid : pwr_h.pwr_tOid;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:938
   pragma Import (C, cdh_ObjidToString, "cdh_ObjidToString");

   function cdh_ObjidToFnString (s : Interfaces.C.Strings.chars_ptr; oid : pwr_h.pwr_tOid) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:945
   pragma Import (C, cdh_ObjidToFnString, "cdh_ObjidToFnString");

   function cdh_ArefToString
     (s : Interfaces.C.Strings.chars_ptr;
      aref : access pwr_h.pwr_sAttrRef;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:951
   pragma Import (C, cdh_ArefToString, "cdh_ArefToString");

   function cdh_NodeIdToString
     (s : Interfaces.C.Strings.chars_ptr;
      nid : pwr_h.pwr_tNid;
      prefix : int;
      suffix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:958
   pragma Import (C, cdh_NodeIdToString, "cdh_NodeIdToString");

   function cdh_TypeIdToString
     (s : Interfaces.C.Strings.chars_ptr;
      tid : pwr_h.pwr_tTid;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:966
   pragma Import (C, cdh_TypeIdToString, "cdh_TypeIdToString");

   function cdh_VolumeIdToString
     (s : Interfaces.C.Strings.chars_ptr;
      vid : pwr_h.pwr_tVid;
      prefix : int;
      suffix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:969
   pragma Import (C, cdh_VolumeIdToString, "cdh_VolumeIdToString");

   function cdh_SubidToString
     (s : Interfaces.C.Strings.chars_ptr;
      sid : pwr_h.pwr_tSubid;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:977
   pragma Import (C, cdh_SubidToString, "cdh_SubidToString");

   function cdh_DlidToString
     (s : Interfaces.C.Strings.chars_ptr;
      did : pwr_h.pwr_tDlid;
      prefix : int) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:984
   pragma Import (C, cdh_DlidToString, "cdh_DlidToString");

   function cdh_Family
     (f : access cdh_sFamily;
      name : Interfaces.C.Strings.chars_ptr;
      poid : pwr_h.pwr_tOid) return access cdh_sFamily;  -- co_cdh.h:991
   pragma Import (C, cdh_Family, "cdh_Family");

   function cdh_ObjName (on : access cdh_sObjName; name : Interfaces.C.Strings.chars_ptr) return access cdh_sObjName;  -- co_cdh.h:998
   pragma Import (C, cdh_ObjName, "cdh_ObjName");

   function cdh_PackName (name : Interfaces.C.Strings.chars_ptr) return pwr_h.pwr_tUInt32;  -- co_cdh.h:1004
   pragma Import (C, cdh_PackName, "cdh_PackName");

   function cdh_ParseName
     (sts : access pwr_h.pwr_tStatus;
      pn : access cdh_sParseName;
      poid : pwr_h.pwr_tOid;
      name : Interfaces.C.Strings.chars_ptr;
      flags : pwr_h.pwr_tUInt32) return access cdh_sParseName;  -- co_cdh.h:1009
   pragma Import (C, cdh_ParseName, "cdh_ParseName");

   function cdh_Low (s : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1018
   pragma Import (C, cdh_Low, "cdh_Low");

   function cdh_ToLower (t : Interfaces.C.Strings.chars_ptr; s : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1023
   pragma Import (C, cdh_ToLower, "cdh_ToLower");

   function cdh_ToUpper (t : Interfaces.C.Strings.chars_ptr; s : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1029
   pragma Import (C, cdh_ToUpper, "cdh_ToUpper");

   function cdh_NoCaseStrcmp (s : Interfaces.C.Strings.chars_ptr; t : Interfaces.C.Strings.chars_ptr) return int;  -- co_cdh.h:1035
   pragma Import (C, cdh_NoCaseStrcmp, "cdh_NoCaseStrcmp");

   function cdh_NoCaseStrncmp
     (s : Interfaces.C.Strings.chars_ptr;
      t : Interfaces.C.Strings.chars_ptr;
      n : stddef_h.size_t) return int;  -- co_cdh.h:1041
   pragma Import (C, cdh_NoCaseStrncmp, "cdh_NoCaseStrncmp");

   function cdh_Strcpy (dest : Interfaces.C.Strings.chars_ptr; src : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1047
   pragma Import (C, cdh_Strcpy, "cdh_Strcpy");

   function cdh_Strncpy
     (dest : Interfaces.C.Strings.chars_ptr;
      src : Interfaces.C.Strings.chars_ptr;
      n : stddef_h.size_t) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1048
   pragma Import (C, cdh_Strncpy, "cdh_Strncpy");

   function cdh_StrncpyCutOff
     (s : Interfaces.C.Strings.chars_ptr;
      t : Interfaces.C.Strings.chars_ptr;
      n : stddef_h.size_t;
      cutleft : int) return int;  -- co_cdh.h:1051
   pragma Import (C, cdh_StrncpyCutOff, "cdh_StrncpyCutOff");

   function cdh_OpSysToStr (opsys : pwr_class_h.pwr_mOpSys) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1058
   pragma Import (C, cdh_OpSysToStr, "cdh_OpSysToStr");

   function cdh_OpSysToDirStr (opsys : pwr_class_h.pwr_mOpSys) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1060
   pragma Import (C, cdh_OpSysToDirStr, "cdh_OpSysToDirStr");

   function cdh_ArefToCastAref (arp : access pwr_h.pwr_sAttrRef) return pwr_h.pwr_sAttrRef;  -- co_cdh.h:1062
   pragma Import (C, cdh_ArefToCastAref, "cdh_ArefToCastAref");

   function cdh_ArefToDisableAref (arp : access pwr_h.pwr_sAttrRef) return pwr_h.pwr_sAttrRef;  -- co_cdh.h:1064
   pragma Import (C, cdh_ArefToDisableAref, "cdh_ArefToDisableAref");

   function cdh_ArefAdd (arp1 : access pwr_h.pwr_sAttrRef; arp2 : access pwr_h.pwr_sAttrRef) return pwr_h.pwr_sAttrRef;  -- co_cdh.h:1066
   pragma Import (C, cdh_ArefAdd, "cdh_ArefAdd");

   procedure cdh_SuppressSuper (c_out : Interfaces.C.Strings.chars_ptr; c_in : Interfaces.C.Strings.chars_ptr);  -- co_cdh.h:1068
   pragma Import (C, cdh_SuppressSuper, "cdh_SuppressSuper");

   procedure cdh_SuppressSuperAll (c_out : Interfaces.C.Strings.chars_ptr; c_in : Interfaces.C.Strings.chars_ptr);  -- co_cdh.h:1070
   pragma Import (C, cdh_SuppressSuperAll, "cdh_SuppressSuperAll");

   function cdh_TypeToMaxStrSize
     (c_type : pwr_class_h.pwr_eType;
      attr_size : int;
      attr_elements : int) return int;  -- co_cdh.h:1072
   pragma Import (C, cdh_TypeToMaxStrSize, "cdh_TypeToMaxStrSize");

   function cdh_TypeToSize (c_type : pwr_class_h.pwr_eType) return int;  -- co_cdh.h:1074
   pragma Import (C, cdh_TypeToSize, "cdh_TypeToSize");

   function cdh_StringToObjectName (t : Interfaces.C.Strings.chars_ptr; s : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- co_cdh.h:1076
   pragma Import (C, cdh_StringToObjectName, "cdh_StringToObjectName");

   function cdh_NextObjectName (t : Interfaces.C.Strings.chars_ptr; s : Interfaces.C.Strings.chars_ptr) return pwr_h.pwr_tStatus;  -- co_cdh.h:1078
   pragma Import (C, cdh_NextObjectName, "cdh_NextObjectName");

   procedure cdh_CutNameSegments
     (outname : Interfaces.C.Strings.chars_ptr;
      name : Interfaces.C.Strings.chars_ptr;
      segments : int);  -- co_cdh.h:1080
   pragma Import (C, cdh_CutNameSegments, "cdh_CutNameSegments");

   function cdh_AttrSize (info : access pwr_class_h.pwr_sParInfo) return pwr_h.pwr_tUInt32;  -- co_cdh.h:1082
   pragma Import (C, cdh_AttrSize, "cdh_AttrSize");

   function cdh_AttrElemSize (info : access pwr_class_h.pwr_sParInfo) return pwr_h.pwr_tUInt32;  -- co_cdh.h:1084
   pragma Import (C, cdh_AttrElemSize, "cdh_AttrElemSize");

  --@} 
end co_cdh_h;
