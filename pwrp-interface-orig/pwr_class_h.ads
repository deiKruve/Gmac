pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with pwr_h;

package pwr_class_h is


   PWR_BREAKPOINTS_MAX : constant := 10;  --  pwr_class.h:52
   PWR_OBJTYPES_MAX : constant := 300;  --  pwr_class.h:53
   PRW_DEFOBJ_MAX : constant := 5;  --  pwr_class.h:54
   pwr_cMaxTyg : constant := 15;  --  pwr_class.h:55

   pwr_cVolumeId : constant := 1;  --  pwr_class.h:173
   --  arg-macro: function pwr_TypeId (Tix)
   --    return 0 + (pwr_cVolumeId << 16) + (2 ** 15) + Tix;
   --  arg-macro: function pwr_Tix (Tid)
   --    return Tid and 16#7ff#;
   --  unsupported macro: pwr_eType_ObjDId pwr_eType_Objid
   --  arg-macro: function pwr_ClassId (Cix)
   --    return 0 + (pwr_cVolumeId << 16) + (Cix << 3);
   --  unsupported macro: pwr_mClassDef_DevOnly pwr_Bit(0)
   --  unsupported macro: pwr_mClassDef_System pwr_Bit(1)
   --  unsupported macro: pwr_mClassDef_Multinode pwr_Bit(2)
   --  unsupported macro: pwr_mClassDef_ObjXRef pwr_Bit(3)
   --  unsupported macro: pwr_mClassDef_RtBody pwr_Bit(4)
   --  unsupported macro: pwr_mClassDef_AttrXRef pwr_Bit(5)
   --  unsupported macro: pwr_mClassDef_ObjRef pwr_Bit(6)
   --  unsupported macro: pwr_mClassDef_AttrRef pwr_Bit(7)
   --  unsupported macro: pwr_mClassDef_TopObject pwr_Bit(8)
   --  unsupported macro: pwr_mClassDef_NoAdopt pwr_Bit(9)
   --  unsupported macro: pwr_mClassDef_Template pwr_Bit(10)
   --  unsupported macro: pwr_mClassDef_IO pwr_Bit(11)
   --  unsupported macro: pwr_mClassDef_IOAgent pwr_Bit(12)
   --  unsupported macro: pwr_mClassDef_IORack pwr_Bit(13)
   --  unsupported macro: pwr_mClassDef_IOCard pwr_Bit(14)
   --  unsupported macro: pwr_mClassDef_HasCallBack pwr_Bit(15)
   --  unsupported macro: pwr_mClassDef_RtReadOnly pwr_Bit(16)
   --  unsupported macro: pwr_mClassDef_HasRef (pwr_mClassDef_ObjXRef|pwr_mClassDef_AttrXRef| pwr_mClassDef_ObjRef|pwr_mClassDef_AttrRef)
   --  unsupported macro: pwr_mObjBodyDef_rtvirtual pwr_Bit(6)
   --  unsupported macro: pwr_mAdef_pointer pwr_Bit(0)
   --  unsupported macro: pwr_mAdef_array pwr_Bit(1)
   --  unsupported macro: pwr_mAdef_backup pwr_Bit(2)
   --  unsupported macro: pwr_mAdef_castattr pwr_Bit(3)
   --  unsupported macro: pwr_mAdef_state pwr_Bit(4)
   --  unsupported macro: pwr_mAdef_const pwr_Bit(5)
   --  unsupported macro: pwr_mAdef_rtvirtual pwr_Bit(6)
   --  unsupported macro: pwr_mAdef_devbodyref pwr_Bit(7)
   --  unsupported macro: pwr_mAdef_dynamic pwr_Bit(8)
   --  unsupported macro: pwr_mAdef_objidself pwr_Bit(9)
   --  unsupported macro: pwr_mAdef_noedit pwr_Bit(10)
   --  unsupported macro: pwr_mAdef_invisible pwr_Bit(11)
   --  unsupported macro: pwr_mAdef_refdirect pwr_Bit(12)
   --  unsupported macro: pwr_mAdef_noinvert pwr_Bit(13)
   --  unsupported macro: pwr_mAdef_noremove pwr_Bit(14)
   --  unsupported macro: pwr_mAdef_rtdbref pwr_Bit(15)
   --  unsupported macro: pwr_mAdef_private pwr_Bit(16)
   --  unsupported macro: pwr_mAdef_class pwr_Bit(17)
   --  unsupported macro: pwr_mAdef_superclass pwr_Bit(18)
   --  unsupported macro: pwr_mAdef_buffer pwr_Bit(19)
   --  unsupported macro: pwr_mAdef_nowbl pwr_Bit(20)
   --  unsupported macro: pwr_mAdef_alwayswbl pwr_Bit(21)
   --  unsupported macro: pwr_mAdef_disableattr pwr_Bit(22)
   --  unsupported macro: pwr_mAdef_rthide pwr_Bit(23)
   --  unsupported macro: pwr_mAdef_newattribute pwr_Bit(24)
   --  unsupported macro: PWR_MASK_POINTER pwr_mAdef_pointer
   --  unsupported macro: PWR_MASK_ARRAY pwr_mAdef_array
   --  unsupported macro: PWR_MASK_BACKUP pwr_mAdef_backup
   --  unsupported macro: PWR_MASK_CASTATTR pwr_mAdef_castattr
   --  unsupported macro: PWR_MASK_STATE pwr_mAdef_state
   --  unsupported macro: PWR_MASK_CONST pwr_mAdef_const
   --  unsupported macro: PWR_MASK_RTVIRTUAL pwr_mAdef_rtvirtual
   --  unsupported macro: PWR_MASK_DEVBODYREF pwr_mAdef_devbodyref
   --  unsupported macro: PWR_MASK_DYNAMIC pwr_mAdef_dynamic
   --  unsupported macro: PWR_MASK_OBJDIDSELF pwr_mAdef_objidself
   --  unsupported macro: PWR_MASK_OBJIDSELF pwr_mAdef_objidself
   --  unsupported macro: PWR_MASK_NOEDIT pwr_mAdef_noedit
   --  unsupported macro: PWR_MASK_INVISIBLE pwr_mAdef_invisible
   --  unsupported macro: PWR_MASK_REFDIRECT pwr_mAdef_refdirect
   --  unsupported macro: PWR_MASK_NOINVERT pwr_mAdef_noinvert
   --  unsupported macro: PWR_MASK_NOREMOVE pwr_mAdef_noremove
   --  unsupported macro: PWR_MASK_RTDBREF pwr_mAdef_rtdbref
   --  unsupported macro: PWR_MASK_PRIVATE pwr_mAdef_private
   --  unsupported macro: PWR_MASK_CLASS pwr_mAdef_class
   --  unsupported macro: PWR_MASK_SUPERCLASS pwr_mAdef_superclass
   --  unsupported macro: PWR_MASK_BUFFER pwr_mAdef_buffer
   --  unsupported macro: PWR_MASK_NOWBL pwr_mAdef_nowbl
   --  unsupported macro: PWR_MASK_ALWAYSWBL pwr_mAdef_alwayswbl
   --  unsupported macro: PWR_MASK_DISABLEATTR pwr_mAdef_disableattr
   --  unsupported macro: PWR_MASK_RTHIDE pwr_mAdef_rthide
   --  unsupported macro: PWR_MASK_NEWATTRIBUTE pwr_mAdef_newattribute

   pwr_mAppl_PLC : constant := 1;  --  pwr_class.h:1084

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

  -- pwr_class.h -- system classes
  -- 

   type pwr_s_ParInfo;
   subtype pwr_sParInfo is pwr_s_ParInfo;

   type pwr_s_ParGraph;
   subtype pwr_sParGraph is pwr_s_ParGraph;

   type pwr_m_Adef;
   type anon_29 is record
      pointer : Extensions.Unsigned_1;  -- pwr_class.h:691
      c_array : Extensions.Unsigned_1;  -- pwr_class.h:691
      backup : Extensions.Unsigned_1;  -- pwr_class.h:691
      castattr : Extensions.Unsigned_1;  -- pwr_class.h:691
      state : Extensions.Unsigned_1;  -- pwr_class.h:691
      c_constant : Extensions.Unsigned_1;  -- pwr_class.h:691
      rtvirtual : Extensions.Unsigned_1;  -- pwr_class.h:691
      devbodyref : Extensions.Unsigned_1;  -- pwr_class.h:691
      dynamic : Extensions.Unsigned_1;  -- pwr_class.h:691
      objidself : Extensions.Unsigned_1;  -- pwr_class.h:691
      noedit : Extensions.Unsigned_1;  -- pwr_class.h:691
      invisible : Extensions.Unsigned_1;  -- pwr_class.h:691
      refdirect : Extensions.Unsigned_1;  -- pwr_class.h:691
      noinvert : Extensions.Unsigned_1;  -- pwr_class.h:691
      noremove : Extensions.Unsigned_1;  -- pwr_class.h:691
      rtdbref : Extensions.Unsigned_1;  -- pwr_class.h:691
      privatepointer : Extensions.Unsigned_1;  -- pwr_class.h:691
      isclass : Extensions.Unsigned_1;  -- pwr_class.h:691
      superclass : Extensions.Unsigned_1;  -- pwr_class.h:691
      buffer : Extensions.Unsigned_1;  -- pwr_class.h:691
      nowbl : Extensions.Unsigned_1;  -- pwr_class.h:691
      alwayswbl : Extensions.Unsigned_1;  -- pwr_class.h:691
      newattribute : Extensions.Unsigned_1;  -- pwr_class.h:691
      fill_0 : Extensions.Unsigned_1;  -- pwr_class.h:691
      fill_1 : aliased unsigned_char;  -- pwr_class.h:691
   end record;
   pragma Convention (C_Pass_By_Copy, anon_29);
   subtype pwr_mAdef is pwr_m_Adef;

   type pwr_m_ClassDef;
   type anon_27 is record
      DevOnly : Extensions.Unsigned_1;  -- pwr_class.h:509
      System : Extensions.Unsigned_1;  -- pwr_class.h:509
      Multinode : Extensions.Unsigned_1;  -- pwr_class.h:509
      ObjXRef : Extensions.Unsigned_1;  -- pwr_class.h:509
      RtBody : Extensions.Unsigned_1;  -- pwr_class.h:509
      AttrXRef : Extensions.Unsigned_1;  -- pwr_class.h:509
      ObjRef : Extensions.Unsigned_1;  -- pwr_class.h:509
      AttrRef : Extensions.Unsigned_1;  -- pwr_class.h:509
      TopObject : Extensions.Unsigned_1;  -- pwr_class.h:509
      NoAdopt : Extensions.Unsigned_1;  -- pwr_class.h:509
      Template : Extensions.Unsigned_1;  -- pwr_class.h:509
      IO : Extensions.Unsigned_1;  -- pwr_class.h:509
      IOAgent : Extensions.Unsigned_1;  -- pwr_class.h:509
      IORack : Extensions.Unsigned_1;  -- pwr_class.h:509
      IOCard : Extensions.Unsigned_1;  -- pwr_class.h:509
      HasCallBack : Extensions.Unsigned_1;  -- pwr_class.h:509
      RtReadOnly : Extensions.Unsigned_1;  -- pwr_class.h:509
      fill_1 : Extensions.Unsigned_7;  -- pwr_class.h:509
      fill_2 : aliased unsigned_char;  -- pwr_class.h:509
   end record;
   pragma Convention (C_Pass_By_Copy, anon_27);
   subtype pwr_mClassDef is pwr_m_ClassDef;

  -- System classes
  -- 
  --   This section defines the typedef's for structs corresponding
  --   to system classes.   

   type pwr_s_Alias;
   subtype pwr_sAlias is pwr_s_Alias;

   type pwr_s_AttrXRef;
   subtype pwr_sAttrXRef is pwr_s_AttrXRef;

   type pwr_s_ClassDef;
   subtype pwr_sClassDef is pwr_s_ClassDef;

   type pwr_s_Hier;
   subtype pwr_sHier is pwr_s_Hier;

   type pwr_s_DocHier;
   subtype pwr_sDocHier is pwr_s_DocHier;

   type pwr_s_LibHier;
   subtype pwr_sLibHier is pwr_s_LibHier;

   type pwr_s_NodeHier;
   subtype pwr_sNodeHier is pwr_s_NodeHier;

   type pwr_s_Type;
   subtype pwr_sType is pwr_s_Type;

   type pwr_s_TypeDef;
   subtype pwr_sTypeDef is pwr_s_TypeDef;

   type pwr_s_ObjBodyDef;
   subtype pwr_sObjBodyDef is pwr_s_ObjBodyDef;

   type pwr_s_Input;
   subtype pwr_sInput is pwr_s_Input;

   type pwr_s_Output;
   subtype pwr_sOutput is pwr_s_Output;

   type pwr_s_Intern;
   subtype pwr_sIntern is pwr_s_Intern;

   type pwr_s_ObjXRef;
   subtype pwr_sObjXRef is pwr_s_ObjXRef;

   type pwr_s_Point;
   subtype pwr_sPoint is pwr_s_Point;

   type pwr_s_PlcProgram;
   type pwr_s_PlcProgram_defnamecount_array is array (0 .. 299) of aliased pwr_h.pwr_tUInt32;
   subtype pwr_sPlcProgram is pwr_s_PlcProgram;

   type pwr_s_PlcWindow;
   subtype pwr_sPlcWindow is pwr_s_PlcWindow;

   type pwr_s_PlcNode;
   type pwr_s_PlcNode_subwind_oid_array is array (0 .. 1) of aliased pwr_h.pwr_tObjid;
   type pwr_s_PlcNode_mask_array is array (0 .. 2) of aliased pwr_h.pwr_tUInt32;
   subtype pwr_sPlcNode is pwr_s_PlcNode;

   type pwr_s_PlcConnection;
   type pwr_s_PlcConnection_point_array is array (0 .. 9) of aliased pwr_sPoint;
   subtype pwr_sPlcConnection is pwr_s_PlcConnection;

   type pwr_s_GraphPlcProgram;
   subtype pwr_sGraphPlcProgram is pwr_s_GraphPlcProgram;

   type pwr_s_GraphPlcWindow;
   type pwr_s_GraphPlcWindow_defobj_class_array is array (0 .. 4) of aliased pwr_h.pwr_tClassId;
   type pwr_s_GraphPlcWindow_defobj_x_array is array (0 .. 4) of aliased pwr_h.pwr_tFloat32;
   type pwr_s_GraphPlcWindow_defobj_y_array is array (0 .. 4) of aliased pwr_h.pwr_tFloat32;
   subtype pwr_sGraphPlcWindow is pwr_s_GraphPlcWindow;

   type pwr_s_GraphPlcNode;
   type pwr_s_GraphPlcNode_parameters_array is array (0 .. 3) of aliased pwr_h.pwr_tUInt32;
   type pwr_s_GraphPlcNode_subwindow_class_array is array (0 .. 1) of aliased pwr_h.pwr_tClassId;
   type pwr_s_GraphPlcNode_sw_page_x_array is array (0 .. 1) of aliased pwr_h.pwr_tFloat32;
   type pwr_s_GraphPlcNode_sw_page_y_array is array (0 .. 1) of aliased pwr_h.pwr_tFloat32;
   type pwr_s_GraphPlcNode_default_mask_array is array (0 .. 1) of aliased pwr_h.pwr_tUInt32;
   subtype pwr_sGraphPlcNode is pwr_s_GraphPlcNode;

   type pwr_s_GraphPlcConnection;
   subtype pwr_sGraphPlcConnection is pwr_s_GraphPlcConnection;

   type pwr_s_Buffer;
   subtype pwr_sBuffer is pwr_s_Buffer;

   type pwr_s_Param;
   subtype pwr_sParam is pwr_s_Param;

   type pwr_s_PlantHier;
   subtype pwr_sPlantHier is pwr_s_PlantHier;

   type pwr_s_Node;
   subtype pwr_s_Node_ErrLogTerm_array is Interfaces.C.char_array (0 .. 131);
   subtype pwr_s_Node_ErrLogFile_array is Interfaces.C.char_array (0 .. 131);
   type pwr_s_Node_ProcStatus_array is array (0 .. 79) of aliased pwr_h.pwr_tStatus;
   type pwr_s_Node_ProcMsgSeverity_array is array (0 .. 79) of aliased pwr_h.pwr_tStatus;
   type pwr_s_Node_ProcMessage_array is array (0 .. 79, 0 .. 79) of aliased char;
   type pwr_s_Node_ProcObject_array is array (0 .. 79) of aliased pwr_h.pwr_tOid;
   type pwr_s_Node_ProcTimeStamp_array is array (0 .. 79) of aliased pwr_h.pwr_tTime;
   subtype pwr_sNode is pwr_s_Node;

   type pwr_s_Appl;
   subtype pwr_s_Appl_FileName_array is Interfaces.C.char_array (0 .. 255);
   subtype pwr_s_Appl_ProgramName_array is Interfaces.C.char_array (0 .. 39);
   subtype pwr_s_Appl_Arg_array is Interfaces.C.char_array (0 .. 255);
   subtype pwr_sAppl is pwr_s_Appl;

   type pwr_s_System;
   subtype pwr_s_System_SystemName_array is Interfaces.C.char_array (0 .. 79);
   subtype pwr_s_System_SystemGroup_array is Interfaces.C.char_array (0 .. 79);
   subtype pwr_sSystem is pwr_s_System;

   type pwr_s_MenuCascade;
   type pwr_s_MenuCascade_FilterArguments_array is array (0 .. 4, 0 .. 39) of aliased char;
   subtype pwr_sMenuCascade is pwr_s_MenuCascade;

   type pwr_s_MenuButton;
   type pwr_s_MenuButton_MethodArguments_array is array (0 .. 4, 0 .. 79) of aliased char;
   type pwr_s_MenuButton_FilterArguments_array is array (0 .. 4, 0 .. 79) of aliased char;
   subtype pwr_sMenuButton is pwr_s_MenuButton;

   type pwr_s_MenuRef;
   type pwr_s_MenuRef_FilterArguments_array is array (0 .. 4, 0 .. 39) of aliased char;
   subtype pwr_sMenuRef is pwr_s_MenuRef;

   type pwr_s_Object;
   subtype pwr_sObject is pwr_s_Object;

   type pwr_s_DbCallBack;
   type pwr_s_DbCallBack_MethodArguments_array is array (0 .. 4, 0 .. 39) of aliased char;
   subtype pwr_sDbCallBack is pwr_s_DbCallBack;

   type pwr_s_RootVolume;
   subtype pwr_sRootVolume is pwr_s_RootVolume;

   type pwr_s_SubVolume;
   subtype pwr_sSubVolume is pwr_s_SubVolume;

   type pwr_s_SharedVolume;
   subtype pwr_sSharedVolume is pwr_s_SharedVolume;

   type pwr_s_DynamicVolume;
   subtype pwr_sDynamicVolume is pwr_s_DynamicVolume;

   type pwr_s_SystemVolume;
   subtype pwr_sSystemVolume is pwr_s_SystemVolume;

   type pwr_s_ClassVolume;
   type pwr_s_ClassVolume_NextTix_array is array (0 .. 15) of aliased pwr_h.pwr_tObjectIx;
   subtype pwr_sClassVolume is pwr_s_ClassVolume;

   subtype pwr_sDetachedClassVolume is pwr_s_ClassVolume;

   type pwr_s_WorkBenchVolume;
   subtype pwr_sWorkBenchVolume is pwr_s_WorkBenchVolume;

   type pwr_s_DirectoryVolume;
   subtype pwr_sDirectoryVolume is pwr_s_DirectoryVolume;

   type pwr_s_VolatileVolume;
   subtype pwr_sVolatileVolume is pwr_s_VolatileVolume;

   type pwr_s_ExternVolume;
   subtype pwr_sExternVolume is pwr_s_ExternVolume;

   type pwr_s_CreateVolume;
   subtype pwr_sCreateVolume is pwr_s_CreateVolume;

   type pwr_s_MountVolume;
   subtype pwr_sMountVolume is pwr_s_MountVolume;

   type pwr_s_MountObject;
   subtype pwr_sMountObject is pwr_s_MountObject;

   type pwr_s_Bit;
   subtype pwr_sBit is pwr_s_Bit;

   type pwr_s_Value;
   subtype pwr_sValue is pwr_s_Value;

   type pwr_s_Method;
   type pwr_s_Method_MethodArguments_array is array (0 .. 4, 0 .. 39) of aliased char;
   subtype pwr_sMethod is pwr_s_Method;

   type pwr_s_Security;
   subtype pwr_sSecurity is pwr_s_Security;

   type pwr_u_ParDef;
   subtype pwr_uParDef is pwr_u_ParDef;

   type pwr_u_Volume;
   subtype pwr_uVolume is pwr_u_Volume;

  --* 
  -- * @brief System types
  -- *
  -- * All other typedef's, structdef's and parameter def's
  -- * refer to these types.
  -- * The numbers defined for each type in this enumeration
  -- * corresponds to the objid of the Type object defining the
  -- * system typ.  
  --  

  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Virtual type  
  -- Virtual type  
  -- Virtual type  
  -- Virtual type  
  -- Virtual type  
  -- Virtual type  
  -- Basic type  
  -- Virtual type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
  -- Basic type  
   type pwr_eTix is 
     (pwr_eTix_u_u,
      pwr_eTix_Boolean,
      pwr_eTix_Float32,
      pwr_eTix_Float64,
      pwr_eTix_Char,
      pwr_eTix_Int8,
      pwr_eTix_Int16,
      pwr_eTix_Int32,
      pwr_eTix_UInt8,
      pwr_eTix_UInt16,
      pwr_eTix_UInt32,
      pwr_eTix_Objid,
      pwr_eTix_Buffer,
      pwr_eTix_String,
      pwr_eTix_Enum,
      pwr_eTix_Struct,
      pwr_eTix_Mask,
      pwr_eTix_Array,
      pwr_eTix_Time,
      pwr_eTix_Text,
      pwr_eTix_AttrRef,
      pwr_eTix_UInt64,
      pwr_eTix_Int64,
      pwr_eTix_ClassId,
      pwr_eTix_TypeId,
      pwr_eTix_VolumeId,
      pwr_eTix_ObjectIx,
      pwr_eTix_RefId,
      pwr_eTix_DeltaTime,
      pwr_eTix_Status,
      pwr_eTix_NetStatus,
      pwr_eTix_CastId,
      pwr_eTix_ProString,
      pwr_eTix_DisableAttr,
      pwr_eTix_DataRef,
      pwr_eTix_Void,
      pwr_eTix_u);
   pragma Convention (C, pwr_eTix);  -- pwr_class.h:171

   subtype pwr_eType is unsigned;
   pwr_eType_u_u : constant pwr_eType := 98304;
   pwr_eType_Boolean : constant pwr_eType := 98305;
   pwr_eType_Float32 : constant pwr_eType := 98306;
   pwr_eType_Float64 : constant pwr_eType := 98307;
   pwr_eType_Char : constant pwr_eType := 98308;
   pwr_eType_Int8 : constant pwr_eType := 98309;
   pwr_eType_Int16 : constant pwr_eType := 98310;
   pwr_eType_Int32 : constant pwr_eType := 98311;
   pwr_eType_UInt8 : constant pwr_eType := 98312;
   pwr_eType_UInt16 : constant pwr_eType := 98313;
   pwr_eType_UInt32 : constant pwr_eType := 98314;
   pwr_eType_Objid : constant pwr_eType := 98315;
   pwr_eType_Buffer : constant pwr_eType := 98316;
   pwr_eType_String : constant pwr_eType := 98317;
   pwr_eType_Enum : constant pwr_eType := 98318;
   pwr_eType_Struct : constant pwr_eType := 98319;
   pwr_eType_Mask : constant pwr_eType := 98320;
   pwr_eType_Array : constant pwr_eType := 98321;
   pwr_eType_Time : constant pwr_eType := 98322;
   pwr_eType_Text : constant pwr_eType := 98323;
   pwr_eType_AttrRef : constant pwr_eType := 98324;
   pwr_eType_UInt64 : constant pwr_eType := 98325;
   pwr_eType_Int64 : constant pwr_eType := 98326;
   pwr_eType_ClassId : constant pwr_eType := 98327;
   pwr_eType_TypeId : constant pwr_eType := 98328;
   pwr_eType_VolumeId : constant pwr_eType := 98329;
   pwr_eType_ObjectIx : constant pwr_eType := 98330;
   pwr_eType_RefId : constant pwr_eType := 98331;
   pwr_eType_DeltaTime : constant pwr_eType := 98332;
   pwr_eType_Status : constant pwr_eType := 98333;
   pwr_eType_NetStatus : constant pwr_eType := 98334;
   pwr_eType_CastId : constant pwr_eType := 98335;
   pwr_eType_ProString : constant pwr_eType := 98336;
   pwr_eType_DisableAttr : constant pwr_eType := 98337;
   pwr_eType_DataRef : constant pwr_eType := 98338;
   pwr_eType_Void : constant pwr_eType := 98339;
   pwr_eType_u : constant pwr_eType := 98340;  -- pwr_class.h:216

  -- Derived type  
  -- Derived type  
  -- Derived type  
   subtype pwr_eTdix is unsigned;
   pwr_eTdix_u_u : constant pwr_eTdix := 0;
   pwr_eTdix_AdefFlags : constant pwr_eTdix := 15;
   pwr_eTdix_ClassDefFlags : constant pwr_eTdix := 16;
   pwr_eTdix_ObjBodyDefFlags : constant pwr_eTdix := 18;
   pwr_eTdix_u : constant pwr_eTdix := 19;  -- pwr_class.h:224

   subtype pwr_eTypeDef is unsigned;
   pwr_eTypeDef_u_u : constant pwr_eTypeDef := 100352;
   pwr_eTypeDef_AdefFlags : constant pwr_eTypeDef := 100367;
   pwr_eTypeDef_ClassDefFlags : constant pwr_eTypeDef := 100368;
   pwr_eTypeDef_ObjBodyDefFlags : constant pwr_eTypeDef := 100370;
   pwr_eTypeDef_u : constant pwr_eTypeDef := 100388;  -- pwr_class.h:232

  --* 
  -- * Due to compiler warnings in some switch statements, pwr_eType_ObjDId has been
  -- * removed from pwr_eType.
  -- *
  -- * @todo Change all ObjDId to Objid and remove this define
  --  

  --*
  -- * The numbers defined for each class in this enumeration
  -- * corresponds to the objid of the ClassDef object defining the
  -- * system class.  
  --  

   subtype pwr_eCix is unsigned;
   pwr_eCix_u_u : constant pwr_eCix := 0;
   pwr_eCix_ClassDef : constant pwr_eCix := 1;
   pwr_eCix_Type : constant pwr_eCix := 2;
   pwr_eCix_TypeDef : constant pwr_eCix := 3;
   pwr_eCix_ObjBodyDef : constant pwr_eCix := 4;
   pwr_eCix_Param : constant pwr_eCix := 5;
   pwr_eCix_Input : constant pwr_eCix := 6;
   pwr_eCix_Output : constant pwr_eCix := 7;
   pwr_eCix_Intern : constant pwr_eCix := 8;
   pwr_eCix_Buffer : constant pwr_eCix := 9;
   pwr_eCix_ObjXRef : constant pwr_eCix := 10;
   pwr_eCix_Layout : constant pwr_eCix := 11;
   pwr_eCix_Group : constant pwr_eCix := 12;
   pwr_eCix_GroupRef : constant pwr_eCix := 13;
   pwr_eCix_TypeHier : constant pwr_eCix := 14;
   pwr_eCix_ClassHier : constant pwr_eCix := 15;
   pwr_eCix_ModHier : constant pwr_eCix := 16;
   pwr_eCix_PlantHier : constant pwr_eCix := 17;
   pwr_eCix_PlcProgram : constant pwr_eCix := 18;
   pwr_eCix_PlcWindow : constant pwr_eCix := 19;
   pwr_eCix_PlcNode : constant pwr_eCix := 20;
   pwr_eCix_PlcConnection : constant pwr_eCix := 21;
   pwr_eCix_Point : constant pwr_eCix := 22;
   pwr_eCix_GraphPlcProgram : constant pwr_eCix := 23;
   pwr_eCix_GraphPlcWindow : constant pwr_eCix := 24;
   pwr_eCix_GraphPlcNode : constant pwr_eCix := 25;
   pwr_eCix_GraphPlcConnection : constant pwr_eCix := 26;
   pwr_eCix_PlcPgm : constant pwr_eCix := 27;
   pwr_eCix_Hierarchy : constant pwr_eCix := 28;
   pwr_eCix_NodeHier : constant pwr_eCix := 29;
   pwr_eCix_PgmDef : constant pwr_eCix := 30;
   pwr_eCix_Node : constant pwr_eCix := 31;
   pwr_eCix_Appl : constant pwr_eCix := 32;
   pwr_eCix_System : constant pwr_eCix := 33;
   pwr_eCix_LibHier : constant pwr_eCix := 34;
   pwr_eCix_DocHier : constant pwr_eCix := 35;
   pwr_eCix_AttrXRef : constant pwr_eCix := 39;
   pwr_eCix_Menu : constant pwr_eCix := 40;
   pwr_eCix_MenuSeparator : constant pwr_eCix := 41;
   pwr_eCix_MenuCascade : constant pwr_eCix := 42;
   pwr_eCix_MenuButton : constant pwr_eCix := 43;
   pwr_eCix_Object : constant pwr_eCix := 44;
   pwr_eCix_DbCallBack : constant pwr_eCix := 45;
   pwr_eCix_Alias : constant pwr_eCix := 46;
   pwr_eCix_RootVolume : constant pwr_eCix := 47;
   pwr_eCix_SubVolume : constant pwr_eCix := 48;
   pwr_eCix_SharedVolume : constant pwr_eCix := 49;
   pwr_eCix_DynamicVolume : constant pwr_eCix := 50;
   pwr_eCix_SystemVolume : constant pwr_eCix := 51;
   pwr_eCix_ClassVolume : constant pwr_eCix := 52;
   pwr_eCix_WorkBenchVolume : constant pwr_eCix := 53;
   pwr_eCix_DirectoryVolume : constant pwr_eCix := 54;
   pwr_eCix_CreateVolume : constant pwr_eCix := 55;
   pwr_eCix_MountVolume : constant pwr_eCix := 56;
   pwr_eCix_MountObject : constant pwr_eCix := 57;
   pwr_eCix_RtMenu : constant pwr_eCix := 58;
   pwr_eCix_VolatileVolume : constant pwr_eCix := 59;
   pwr_eCix_MenuRef : constant pwr_eCix := 60;
   pwr_eCix_Bit : constant pwr_eCix := 61;
   pwr_eCix_Value : constant pwr_eCix := 62;
   pwr_eCix_Method : constant pwr_eCix := 63;
   pwr_eCix_RtMethod : constant pwr_eCix := 64;
   pwr_eCix_ExternVolume : constant pwr_eCix := 65;
   pwr_eCix_Hier : constant pwr_eCix := 66;
   pwr_eCix_ClassLost : constant pwr_eCix := 67;
   pwr_eCix_Security : constant pwr_eCix := 68;
   pwr_eCix_DetachedClassVolume : constant pwr_eCix := 69;
   pwr_eCix_u : constant pwr_eCix := 70;  -- pwr_class.h:317

   subtype pwr_eClass is unsigned;
   pwr_eClass_u_u : constant pwr_eClass := 65536;
   pwr_eClass_ClassDef : constant pwr_eClass := 65544;
   pwr_eClass_Type : constant pwr_eClass := 65552;
   pwr_eClass_TypeDef : constant pwr_eClass := 65560;
   pwr_eClass_ObjBodyDef : constant pwr_eClass := 65568;
   pwr_eClass_Param : constant pwr_eClass := 65576;
   pwr_eClass_Input : constant pwr_eClass := 65584;
   pwr_eClass_Output : constant pwr_eClass := 65592;
   pwr_eClass_Intern : constant pwr_eClass := 65600;
   pwr_eClass_Buffer : constant pwr_eClass := 65608;
   pwr_eClass_ObjXRef : constant pwr_eClass := 65616;
   pwr_eClass_Layout : constant pwr_eClass := 65624;
   pwr_eClass_Group : constant pwr_eClass := 65632;
   pwr_eClass_GroupRef : constant pwr_eClass := 65640;
   pwr_eClass_TypeHier : constant pwr_eClass := 65648;
   pwr_eClass_ClassHier : constant pwr_eClass := 65656;
   pwr_eClass_ModHier : constant pwr_eClass := 65664;
   pwr_eClass_PlantHier : constant pwr_eClass := 65672;
   pwr_eClass_PlcProgram : constant pwr_eClass := 65680;
   pwr_eClass_PlcWindow : constant pwr_eClass := 65688;
   pwr_eClass_PlcNode : constant pwr_eClass := 65696;
   pwr_eClass_PlcConnection : constant pwr_eClass := 65704;
   pwr_eClass_Point : constant pwr_eClass := 65712;
   pwr_eClass_GraphPlcProgram : constant pwr_eClass := 65720;
   pwr_eClass_GraphPlcWindow : constant pwr_eClass := 65728;
   pwr_eClass_GraphPlcNode : constant pwr_eClass := 65736;
   pwr_eClass_GraphPlcConnection : constant pwr_eClass := 65744;
   pwr_eClass_PlcPgm : constant pwr_eClass := 65752;
   pwr_eClass_Hierarchy : constant pwr_eClass := 65760;
   pwr_eClass_NodeHier : constant pwr_eClass := 65768;
   pwr_eClass_PgmDef : constant pwr_eClass := 65776;
   pwr_eClass_Node : constant pwr_eClass := 65784;
   pwr_eClass_Appl : constant pwr_eClass := 65792;
   pwr_eClass_System : constant pwr_eClass := 65800;
   pwr_eClass_LibHier : constant pwr_eClass := 65808;
   pwr_eClass_DocHier : constant pwr_eClass := 65816;
   pwr_eClass_AttrXRef : constant pwr_eClass := 65848;
   pwr_eClass_Menu : constant pwr_eClass := 65856;
   pwr_eClass_MenuSeparator : constant pwr_eClass := 65864;
   pwr_eClass_MenuCascade : constant pwr_eClass := 65872;
   pwr_eClass_MenuButton : constant pwr_eClass := 65880;
   pwr_eClass_Object : constant pwr_eClass := 65888;
   pwr_eClass_DbCallBack : constant pwr_eClass := 65896;
   pwr_eClass_Alias : constant pwr_eClass := 65904;
   pwr_eClass_RootVolume : constant pwr_eClass := 65912;
   pwr_eClass_SubVolume : constant pwr_eClass := 65920;
   pwr_eClass_SharedVolume : constant pwr_eClass := 65928;
   pwr_eClass_DynamicVolume : constant pwr_eClass := 65936;
   pwr_eClass_SystemVolume : constant pwr_eClass := 65944;
   pwr_eClass_ClassVolume : constant pwr_eClass := 65952;
   pwr_eClass_WorkBenchVolume : constant pwr_eClass := 65960;
   pwr_eClass_DirectoryVolume : constant pwr_eClass := 65968;
   pwr_eClass_CreateVolume : constant pwr_eClass := 65976;
   pwr_eClass_MountVolume : constant pwr_eClass := 65984;
   pwr_eClass_MountObject : constant pwr_eClass := 65992;
   pwr_eClass_RtMenu : constant pwr_eClass := 66000;
   pwr_eClass_VolatileVolume : constant pwr_eClass := 66008;
   pwr_eClass_MenuRef : constant pwr_eClass := 66016;
   pwr_eClass_Bit : constant pwr_eClass := 66024;
   pwr_eClass_Value : constant pwr_eClass := 66032;
   pwr_eClass_Method : constant pwr_eClass := 66040;
   pwr_eClass_RtMethod : constant pwr_eClass := 66048;
   pwr_eClass_ExternVolume : constant pwr_eClass := 66056;
   pwr_eClass_Hier : constant pwr_eClass := 66064;
   pwr_eClass_ClassLost : constant pwr_eClass := 66072;
   pwr_eClass_Security : constant pwr_eClass := 66080;
   pwr_eClass_DetachedClassVolume : constant pwr_eClass := 66088;
   pwr_eClass_u : constant pwr_eClass := 66089;  -- pwr_class.h:390

  --*
  -- * When the user wants to edit an object, the Editor defined in ClassDef
  -- * is started with the object.  
  --  

   type pwr_eEditor is 
     (pwr_eEditor_u_u,
      pwr_eEditor_HiEd,
      pwr_eEditor_PlcEd,
      pwr_eEditor_AttrEd,
      pwr_eEditor_ClassEd,
      pwr_eEditor_u);
   pragma Convention (C, pwr_eEditor);  -- pwr_class.h:404

  --* 
  -- * When the user wants to edit an object, the Editor defined in ClassDef
  -- * is started with the object and with a method defined here. 
  --  

   type pwr_eMethod is 
     (pwr_eMethod_u_u,
      pwr_eMethod_Standard,
      pwr_eMethod_Connections,
      pwr_eMethod_DrawingInfo,
      pwr_eMethod_DevBodyOnly,
      pwr_eMethod_RtAndDevBodies,
      pwr_eMethod_RtConnectionsAndDevBodies,
      pwr_eMethod_DevBodyWithChkb,
      pwr_eMethod_SysBody,
      pwr_eMethod_DevBodyConnections,
      pwr_eMethod_u);
   pragma Convention (C, pwr_eMethod);  -- pwr_class.h:422

  --*
  -- * Used in cross references.  
  --  

   type pwr_eXRefType is 
     (pwr_eXRefType_u_u,
      pwr_eXRefType_u);
   pragma Convention (C, pwr_eXRefType);  -- pwr_class.h:430

  --*
  -- * Class to hold methods common to all classes.
  -- * Class is also used in classdefinitions to give default name to 
  -- * an instance of that class.  
  --  

   type pwr_s_Object is record
      Name : aliased pwr_h.pwr_tObjName;  -- pwr_class.h:439
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Object);  -- pwr_class.h:438

  --* 
  -- * When the user wants to edit an object, the PopEditor defined in ClassDef
  -- * is started with the object.  
  -- 

   type pwr_ePopEditor is 
     (pwr_ePopEditor_u_u,
      pwr_ePopEditor_GMS,
      pwr_ePopEditor_Opcom,
      pwr_ePopEditor_u);
   pragma Convention (C, pwr_ePopEditor);  -- pwr_class.h:452

   type pwr_eVolumeAccess is 
     (pwr_eVolumeAccess_u_u,
      pwr_eVolumeAccess_ReadOnly,
      pwr_eVolumeAccess_ReadWrite,
      pwr_eVolumeAccess_u);
   pragma Convention (C, pwr_eVolumeAccess);  -- pwr_class.h:460

   type pwr_eMountType is 
     (pwr_eMountType_u_u,
      pwr_eMountType_Default,
      pwr_eMountType_Cached,
      pwr_eMountType_Structure,
      pwr_eMountType_TryStructure,
      pwr_eMountType_u);
   pragma Convention (C, pwr_eMountType);  -- pwr_class.h:469

   type pwr_eMountedType is 
     (pwr_eMountedType_u_u,
      pwr_eMountedType_Full,
      pwr_eMountedType_Cached,
      pwr_eMountedType_Structure,
      pwr_eMountedType_Shared,
      pwr_eMountedType_Owned,
      pwr_eMountedType_Class,
      pwr_eMountedType_System,
      pwr_eMountedType_NotMounted,
      pwr_eMountedType_u);
   pragma Convention (C, pwr_eMountedType);  -- pwr_class.h:482

  -- This section defines the classes to use when defining types.   
   type pwr_s_Type is record
      c_Type : aliased pwr_eType;  -- pwr_class.h:487
      Size : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:488
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Type);  -- pwr_class.h:486

  -- Number of bytes.  
   type pwr_s_TypeDef is record
      c_Type : aliased pwr_eType;  -- pwr_class.h:492
      Size : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:493
      TypeRef : aliased pwr_h.pwr_tTypeId;  -- pwr_class.h:494
      Elements : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:495
      PgmName : aliased pwr_h.pwr_tPgmName;  -- pwr_class.h:496
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_TypeDef);  -- pwr_class.h:491

  -- Number of bytes.  
  -- Class defining classes. 
  --   This section defines the classes to use when defining classes.   

  --_*
  --  @aref classdefflags ClassDef
  -- 

   subtype pwr_tClassDefFlags is pwr_h.pwr_tMask;  -- pwr_class.h:505

   type pwr_m_ClassDef (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            m : aliased pwr_h.pwr_tBitMask;  -- pwr_class.h:508
         when others =>
            b : aliased anon_27;  -- pwr_class.h:532
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_m_ClassDef);
   pragma Unchecked_Union (pwr_m_ClassDef);  -- pwr_class.h:507

  -- object exists only in development
  --                                   environment   

  -- object is a system object   
  -- object is a multinode object   
  -- object contains ObjXRefs   
  -- object has a body in runtime   
  -- object contains AttrXRefs   
  -- object contains ObjRefs   
  -- object contains AttrRefs   
  -- object can be top object   
  -- object can not have children   
  -- object is a template object   
  -- object is an IO object   
  -- object is IO agent   
  -- object is IO rack   
  -- object is IO card   
  -- object has DbCallBack   
  -- object is readonly in runtime   
  -- Editor to call on a "Edit"
  --                                               	   command.   

   type pwr_s_ClassDef is record
      Editor : aliased pwr_eEditor;  -- pwr_class.h:557
      Method : aliased pwr_eMethod;  -- pwr_class.h:559
      Flags : pwr_mClassDef;  -- pwr_class.h:561
      NumOfObjBodies : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:562
      PopEditor : aliased pwr_ePopEditor;  -- pwr_class.h:563
      Filler : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:565
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ClassDef);  -- pwr_class.h:556

  -- Method to use by the called
  --                                               	   editor.   

  -- What kind of object picture
  --                                               	   dispatcher to use.   

  -- LongWord size alignment  
  -- Body defining classes.
  --  This section defines the classes to use when defining bodies.   

  -- Name of the C-struct to be
  --                                           		   generated.   

   type pwr_s_ObjBodyDef is record
      StructName : aliased pwr_h.pwr_tStructName;  -- pwr_class.h:574
      NumOfParams : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:576
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:577
      NextAix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:578
      Flags : aliased pwr_h.pwr_tMask;  -- pwr_class.h:579
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ObjBodyDef);  -- pwr_class.h:573

  -- Compiled number of parameters.   
  -- Compiled size.   
  -- Next free attribute index.   
  -- Not used  
  -- Parameter defining classes.
  --   This section defines the classes to be used when defining parameters
  --   in classes.
  --  
  --   At the end of this section is a union: pwr_uPar, wich must be updated for
  --   each new parameter class defined.   

  -- This class is used to define graphic appearence of parameters.   
   type pwr_s_ParGraph is record
      GraphName : aliased pwr_h.pwr_tGraphName;  -- pwr_class.h:593
      InputType : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:594
      NiNaAnnot : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:595
      NiNaCond : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:596
      NiNaSegments : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:597
      DebAnnot : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:598
      ConPointNr : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:599
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ParGraph);  -- pwr_class.h:592

  -- This class is used to define information about parameters.   
  -- Name to be used in program.  
   type pwr_s_ParInfo is record
      PgmName : aliased pwr_h.pwr_tPgmName;  -- pwr_class.h:606
      c_Type : aliased pwr_eType;  -- pwr_class.h:607
      Offset : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:608
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:609
      Flags : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:610
      Elements : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:611
      ParamIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:612
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ParInfo);  -- pwr_class.h:605

  -- Compiled system type.  
  -- Compiled offset in body.  
  -- Compiled size, number of bytes.  
  -- Parameter flags  
  -- If array; number of rows.  
  -- Index of param within a body.  
  --_*
  --  @aref privmask PrivMask
  -- 

   subtype pwr_tPrivMask is pwr_h.pwr_tMask;  -- pwr_class.h:618

  --_*
  --  @aref configstatusenum ConfigStatusEnum
  -- 

   subtype pwr_tConfigStatusEnum is pwr_h.pwr_tEnum;  -- pwr_class.h:623

  -- Operating system.   
  --_*
  --  @aref opsys OpSys
  -- 

   subtype pwr_tOpSys is pwr_h.pwr_tMask;  -- pwr_class.h:629

  -- TODO Remove!  
   subtype pwr_mOpSys is unsigned;
   pwr_mOpSys_u_u : constant pwr_mOpSys := 0;
   pwr_mOpSys_CustomBuild : constant pwr_mOpSys := 1;
   pwr_mOpSys_VAX_VMS : constant pwr_mOpSys := 2;
   pwr_mOpSys_AXP_VMS : constant pwr_mOpSys := 4;
   pwr_mOpSys_PPC_LYNX : constant pwr_mOpSys := 8;
   pwr_mOpSys_X86_LYNX : constant pwr_mOpSys := 16;
   pwr_mOpSys_PPC_LINUX : constant pwr_mOpSys := 32;
   pwr_mOpSys_X86_LINUX : constant pwr_mOpSys := 64;
   pwr_mOpSys_X86_64_LINUX : constant pwr_mOpSys := 128;
   pwr_mOpSys_X86_64_MACOS : constant pwr_mOpSys := 256;
   pwr_mOpSys_ARM_LINUX : constant pwr_mOpSys := 512;
   pwr_mOpSys_X86_64_FREEBSD : constant pwr_mOpSys := 1024;
   pwr_mOpSys_X86_64_OPENBSD : constant pwr_mOpSys := 2048;
   pwr_mOpSys_X86_CYGWIN : constant pwr_mOpSys := 4096;
   pwr_mOpSys_X86_64_CYGWIN : constant pwr_mOpSys := 8192;
   pwr_mOpSys_u : constant pwr_mOpSys := 16384;
   pwr_mOpSys_VAX_ELN : constant pwr_mOpSys := 1073741824;  -- pwr_class.h:650

  -- Bitmask for body flags   
  --_*
  --  @aref objbodydefflags ObjBodyDef
  -- 

   subtype pwr_tObjBodyDefFlags is pwr_h.pwr_tMask;  -- pwr_class.h:679

  -- Bitmask for attribute flags   
  --_*
  --  @aref adef Adef
  -- 

   subtype pwr_tAdefFlags is pwr_h.pwr_tMask;  -- pwr_class.h:687

   type pwr_m_Adef (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            m : aliased pwr_h.pwr_tBitMask;  -- pwr_class.h:690
         when others =>
            b : aliased anon_29;  -- pwr_class.h:720
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_m_Adef);
   pragma Unchecked_Union (pwr_m_Adef);  -- pwr_class.h:689

  -- class is a reserved word  
   type pwr_s_Param is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:777
      TypeRef : aliased pwr_h.pwr_tTypeId;  -- pwr_class.h:778
      Filler : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:780
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Param);  -- pwr_class.h:776

  -- Reference to the object defining
  --                                           the type.   

  -- LongWord size alignment  
   type pwr_s_Intern is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:784
      TypeRef : aliased pwr_h.pwr_tTypeId;  -- pwr_class.h:785
      Graph : aliased pwr_sParGraph;  -- pwr_class.h:787
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Intern);  -- pwr_class.h:783

  -- Reference to the object defining
  --                                           the type.   

  -- Used by graphic editor.   
   type pwr_s_Input is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:791
      TypeRef : aliased pwr_h.pwr_tTypeId;  -- pwr_class.h:792
      Graph : aliased pwr_sParGraph;  -- pwr_class.h:794
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Input);  -- pwr_class.h:790

  -- Reference to the object defining
  --                                           the type.   

  -- Used by graphic editor.   
   type pwr_s_Output is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:798
      TypeRef : aliased pwr_h.pwr_tTypeId;  -- pwr_class.h:799
      Graph : aliased pwr_sParGraph;  -- pwr_class.h:801
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Output);  -- pwr_class.h:797

  -- Reference to the object defining
  --                                           the type.   

  -- Used by graphic editor.   
   type pwr_s_AttrXRef is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:805
      Identity : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:806
      Source : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:808
      Target : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:809
      XRefType : aliased pwr_eXRefType;  -- pwr_class.h:810
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_AttrXRef);  -- pwr_class.h:804

  -- A name to identify a cross
  --					           reference.   

   type pwr_s_ObjXRef is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:814
      Identity : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:815
      Source : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:817
      Target : aliased pwr_h.pwr_tXRef;  -- pwr_class.h:818
      XRefType : aliased pwr_eXRefType;  -- pwr_class.h:819
      SourceAttribute : aliased pwr_h.pwr_tObjName;  -- pwr_class.h:820
      TargetAttribute : aliased pwr_h.pwr_tObjName;  -- pwr_class.h:821
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ObjXRef);  -- pwr_class.h:813

  -- A name to identify a cross
  --                                	           reference.   

   type pwr_s_Buffer is record
      Info : aliased pwr_sParInfo;  -- pwr_class.h:825
      Class : aliased pwr_eClass;  -- pwr_class.h:826
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Buffer);  -- pwr_class.h:824

  -- The system class defining the
  --						   data stored here.   

  -- The union pwr_uParDef contains all classes defining parameters.   
   type pwr_u_ParDef (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            Input : aliased pwr_sInput;  -- pwr_class.h:833
         when 1 =>
            Output : aliased pwr_sOutput;  -- pwr_class.h:834
         when 2 =>
            Intern : aliased pwr_sIntern;  -- pwr_class.h:835
         when 3 =>
            ObjXRef : aliased pwr_sObjXRef;  -- pwr_class.h:836
         when 4 =>
            AttrXRef : aliased pwr_sAttrXRef;  -- pwr_class.h:837
         when 5 =>
            Buffer : aliased pwr_sBuffer;  -- pwr_class.h:838
         when others =>
            Param : aliased pwr_sParam;  -- pwr_class.h:839
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_u_ParDef);
   pragma Unchecked_Union (pwr_u_ParDef);  -- pwr_class.h:832

   type pwr_s_Bit is record
      Text : aliased pwr_h.pwr_tString80;  -- pwr_class.h:843
      PgmName : aliased pwr_h.pwr_tString32;  -- pwr_class.h:844
      Value : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:845
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Bit);  -- pwr_class.h:842

   type pwr_s_Value is record
      Text : aliased pwr_h.pwr_tString80;  -- pwr_class.h:849
      PgmName : aliased pwr_h.pwr_tString32;  -- pwr_class.h:850
      Value : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:851
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Value);  -- pwr_class.h:848

  -- Method defining classes.
  --   This section defines the classes to use when defining methods.   

   type pwr_s_DbCallBack is record
      MethodName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:859
      MethodArguments : aliased pwr_s_DbCallBack_MethodArguments_array;  -- pwr_class.h:860
      Method : access function return pwr_h.pwr_tStatus;  -- pwr_class.h:861
      Flags : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:862
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_DbCallBack);  -- pwr_class.h:858

  -- Address to method.  
   type pwr_s_Method is record
      MethodName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:866
      MethodArguments : aliased pwr_s_Method_MethodArguments_array;  -- pwr_class.h:867
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Method);  -- pwr_class.h:865

  -- Menu defining classes.
  --   This section defines the classes to use when defining menus.   

   type pwr_s_MenuCascade is record
      ButtonName : aliased pwr_h.pwr_tString40;  -- pwr_class.h:876
      FilterName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:877
      FilterArguments : aliased pwr_s_MenuCascade_FilterArguments_array;  -- pwr_class.h:878
      Filter : access function return pwr_h.pwr_tBoolean;  -- pwr_class.h:879
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_MenuCascade);  -- pwr_class.h:875

  -- Address to method
  --                                         	          visibility function.   

   type pwr_s_MenuButton is record
      ButtonName : aliased pwr_h.pwr_tString40;  -- pwr_class.h:884
      MethodName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:885
      MethodArguments : aliased pwr_s_MenuButton_MethodArguments_array;  -- pwr_class.h:886
      FilterName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:887
      FilterArguments : aliased pwr_s_MenuButton_FilterArguments_array;  -- pwr_class.h:888
      Method : access function return pwr_h.pwr_tStatus;  -- pwr_class.h:889
      Filter : access function return pwr_h.pwr_tBoolean;  -- pwr_class.h:890
      Flags : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:892
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_MenuButton);  -- pwr_class.h:883

  -- Address to method.   
  -- Address to method
  --								   visibility function.   

   type pwr_s_MenuRef is record
      ButtonName : aliased pwr_h.pwr_tString40;  -- pwr_class.h:896
      RefAttribute : aliased pwr_h.pwr_tString40;  -- pwr_class.h:897
      FilterName : aliased pwr_h.pwr_tString80;  -- pwr_class.h:898
      FilterArguments : aliased pwr_s_MenuRef_FilterArguments_array;  -- pwr_class.h:899
      Filter : access function return pwr_h.pwr_tBoolean;  -- pwr_class.h:900
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_MenuRef);  -- pwr_class.h:895

  -- Address to method
  --                                        		           visibility function.   

  -- Classes for PLC editors.
  --   This section defines the classes which are used by the graphic PLC
  --   editors.   

   type pwr_s_Point is record
      x : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:910
      y : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:911
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Point);  -- pwr_class.h:909

   type pwr_s_PlcProgram is record
      oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:915
      object_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:916
      cid : aliased pwr_h.pwr_tClassId;  -- pwr_class.h:917
      defnamecount : aliased pwr_s_PlcProgram_defnamecount_array;  -- pwr_class.h:918
      reset_objdid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:919
      connamecount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:920
      woid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:921
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_PlcProgram);  -- pwr_class.h:914

   type pwr_s_PlcWindow is record
      oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:925
      object_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:926
      cid : aliased pwr_h.pwr_tClassId;  -- pwr_class.h:927
      x : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:928
      y : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:929
      width : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:930
      height : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:931
      zoom : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:932
      x_root : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:933
      y_root : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:934
      poid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:935
      compobjcount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:936
      refconcount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:937
      subwindowindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:938
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_PlcWindow);  -- pwr_class.h:924

   type pwr_s_PlcNode is record
      object_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:942
      cid : aliased pwr_h.pwr_tClassId;  -- pwr_class.h:943
      oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:944
      x : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:945
      y : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:946
      width : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:947
      height : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:948
      woid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:949
      subwind_oid : aliased pwr_s_PlcNode_subwind_oid_array;  -- pwr_class.h:950
      subwindow : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:951
      graphtype : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:952
      mask : aliased pwr_s_PlcNode_mask_array;  -- pwr_class.h:953
      compdirection : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:954
      nodewidth : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:955
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_PlcNode);  -- pwr_class.h:941

   type pwr_s_PlcConnection is record
      oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:959
      object_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:960
      cid : aliased pwr_h.pwr_tClassId;  -- pwr_class.h:961
      curvature : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:962
      drawtype : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:963
      attributes : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:964
      refnr : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:965
      source_point : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:966
      source_oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:967
      dest_point : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:968
      dest_oid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:969
      point_count : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:970
      point : aliased pwr_s_PlcConnection_point_array;  -- pwr_class.h:971
      woid : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:972
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_PlcConnection);  -- pwr_class.h:958

   type pwr_s_GraphPlcProgram is record
      plc_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:976
      subwindow_class : aliased pwr_h.pwr_tClassId;  -- pwr_class.h:977
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_GraphPlcProgram);  -- pwr_class.h:975

   type pwr_s_GraphPlcWindow is record
      window_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:981
      defaultobjects : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:982
      width : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:983
      height : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:984
      x : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:985
      y : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:986
      zoom : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:987
      node_palettelayout : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:988
      con_palettelayout : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:989
      trace_palettelayout : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:990
      sim_palettelayout : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:991
      defobj_class : aliased pwr_s_GraphPlcWindow_defobj_class_array;  -- pwr_class.h:992
      defobj_x : aliased pwr_s_GraphPlcWindow_defobj_x_array;  -- pwr_class.h:993
      defobj_y : aliased pwr_s_GraphPlcWindow_defobj_y_array;  -- pwr_class.h:994
      compmethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:995
      compindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:996
      tracemethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:997
      traceindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:998
      executeordermethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:999
      objname : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1000
      graphname : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1001
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_GraphPlcWindow);  -- pwr_class.h:980

   type pwr_s_GraphPlcNode is record
      object_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1005
      parameters : aliased pwr_s_GraphPlcNode_parameters_array;  -- pwr_class.h:1006
      subwindows : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1007
      subwindow_class : aliased pwr_s_GraphPlcNode_subwindow_class_array;  -- pwr_class.h:1008
      sw_page_x : aliased pwr_s_GraphPlcNode_sw_page_x_array;  -- pwr_class.h:1009
      sw_page_y : aliased pwr_s_GraphPlcNode_sw_page_y_array;  -- pwr_class.h:1010
      graphmethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1011
      graphindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1012
      default_mask : aliased pwr_s_GraphPlcNode_default_mask_array;  -- pwr_class.h:1013
      segname_annotation : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1014
      rtbody_annotation : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1015
      devbody_annotation : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1016
      compmethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1017
      compindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1018
      tracemethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1019
      traceindex : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1020
      connectmethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1021
      executeordermethod : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1022
      objname : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1023
      graphname : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1024
      debugpar : aliased pwr_h.pwr_tString32;  -- pwr_class.h:1025
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_GraphPlcNode);  -- pwr_class.h:1004

   type pwr_s_GraphPlcConnection is record
      con_type : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1029
      arrows : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1030
      linewidth : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:1031
      dashes : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:1032
      fillpattern : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1033
      color : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1034
      curvature : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1035
      corners : aliased pwr_h.pwr_tFloat32;  -- pwr_class.h:1036
      attributes : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1037
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_GraphPlcConnection);  -- pwr_class.h:1028

  -- Plant defining classes.   
   type pwr_s_PlantHier is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1043
      DefGraph : aliased pwr_h.pwr_tAttrRef;  -- pwr_class.h:1044
      DefTrend : aliased pwr_h.pwr_tAttrRef;  -- pwr_class.h:1045
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_class.h:1046
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_class.h:1047
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_class.h:1048
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_class.h:1049
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1050
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_PlantHier);  -- pwr_class.h:1042

  -- Node defining classes.   
   type pwr_s_System is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1056
      SystemName : aliased pwr_s_System_SystemName_array;  -- pwr_class.h:1057
      SystemGroup : aliased pwr_s_System_SystemGroup_array;  -- pwr_class.h:1058
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_System);  -- pwr_class.h:1055

   type pwr_s_Node is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1062
      ErrLogTerm : aliased pwr_s_Node_ErrLogTerm_array;  -- pwr_class.h:1063
      ErrLogFile : aliased pwr_s_Node_ErrLogFile_array;  -- pwr_class.h:1064
      BootTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1065
      BootVersion : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1066
      BootPlcVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1067
      CurrentVersion : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1068
      CurrentPlcVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1069
      Restarts : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1070
      RestartTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1071
      RestartStallTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_class.h:1072
      SystemTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1073
      SystemStatus : aliased pwr_h.pwr_tNetStatus;  -- pwr_class.h:1074
      ProcStatus : aliased pwr_s_Node_ProcStatus_array;  -- pwr_class.h:1075
      ProcMsgSeverity : aliased pwr_s_Node_ProcMsgSeverity_array;  -- pwr_class.h:1076
      ProcMessage : aliased pwr_s_Node_ProcMessage_array;  -- pwr_class.h:1077
      ProcObject : aliased pwr_s_Node_ProcObject_array;  -- pwr_class.h:1078
      ProcTimeStamp : aliased pwr_s_Node_ProcTimeStamp_array;  -- pwr_class.h:1079
      EmergBreakTrue : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1080
      EmergBreakSelect : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1081
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Node);  -- pwr_class.h:1061

   type pwr_s_Appl is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1087
      FileName : aliased pwr_s_Appl_FileName_array;  -- pwr_class.h:1088
      ProgramName : aliased pwr_s_Appl_ProgramName_array;  -- pwr_class.h:1089
      StartWithDebug : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1090
      Load : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1091
      Run : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1092
      KernelMode : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1093
      KernelStackSize : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1094
      JobPriority : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1095
      ProcessPriority : aliased pwr_h.pwr_tInt32;  -- pwr_class.h:1096
      Arg : aliased pwr_s_Appl_Arg_array;  -- pwr_class.h:1097
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Appl);  -- pwr_class.h:1086

   type pwr_s_Alias is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1101
      Object : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:1102
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Alias);  -- pwr_class.h:1100

   type pwr_s_Hier is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1106
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Hier);  -- pwr_class.h:1105

   type pwr_s_DocHier is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1110
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_DocHier);  -- pwr_class.h:1109

   type pwr_s_LibHier is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1114
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_LibHier);  -- pwr_class.h:1113

   type pwr_s_NodeHier is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1118
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1119
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_NodeHier);  -- pwr_class.h:1117

   type pwr_s_RootVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1123
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1124
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1125
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1126
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1127
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1128
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1129
      OperatingSystem : aliased pwr_mOpSys;  -- pwr_class.h:1130
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1131
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1132
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_RootVolume);  -- pwr_class.h:1122

   type pwr_s_SubVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1136
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1137
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1138
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1139
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1140
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1141
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1142
      OperatingSystem : aliased pwr_mOpSys;  -- pwr_class.h:1143
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1144
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1145
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_SubVolume);  -- pwr_class.h:1135

   type pwr_s_SharedVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1149
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1150
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1151
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1152
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1153
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1154
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1155
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1156
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1157
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_SharedVolume);  -- pwr_class.h:1148

   type pwr_s_DynamicVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1161
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1162
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1163
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1164
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1165
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1166
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1167
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_DynamicVolume);  -- pwr_class.h:1160

   type pwr_s_SystemVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1171
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1172
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1173
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1174
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1175
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1176
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1177
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_SystemVolume);  -- pwr_class.h:1170

   type pwr_s_ClassVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1181
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1182
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1183
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1184
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1185
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1186
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1187
      NextCix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1188
      NextTix : aliased pwr_s_ClassVolume_NextTix_array;  -- pwr_class.h:1189
      DvVersion : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1190
      ConfigurationStatus : aliased pwr_tConfigStatusEnum;  -- pwr_class.h:1191
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ClassVolume);  -- pwr_class.h:1180

  -- Next free class index.   
  -- Next free type index.   
   type pwr_s_WorkBenchVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1195
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1196
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1197
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1198
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1199
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1200
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1201
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_WorkBenchVolume);  -- pwr_class.h:1194

   type pwr_s_DirectoryVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1205
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1206
      RtVersion : aliased pwr_h.pwr_tProjVersion;  -- pwr_class.h:1207
      RtCreTime : aliased pwr_h.pwr_tTime;  -- pwr_class.h:1208
      RtCreator : aliased pwr_h.pwr_tString16;  -- pwr_class.h:1209
      RtCardinality : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1210
      RtBodySize : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1211
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_DirectoryVolume);  -- pwr_class.h:1204

   type pwr_s_VolatileVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1215
      NextOix : aliased pwr_h.pwr_tObjectIx;  -- pwr_class.h:1216
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_VolatileVolume);  -- pwr_class.h:1214

   type pwr_s_ExternVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1220
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_ExternVolume);  -- pwr_class.h:1219

   type pwr_s_CreateVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1224
      Volume : aliased pwr_h.pwr_tVolumeId;  -- pwr_class.h:1225
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_CreateVolume);  -- pwr_class.h:1223

   type pwr_s_MountVolume is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1229
      Volume : aliased pwr_h.pwr_tVolumeId;  -- pwr_class.h:1230
      c_Access : aliased pwr_eVolumeAccess;  -- pwr_class.h:1231
      MountType : aliased pwr_eMountType;  -- pwr_class.h:1232
      MountedType : aliased pwr_eMountedType;  -- pwr_class.h:1233
      CacheMaxCount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1234
      CacheMinCount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1235
      CacheCurCount : aliased pwr_h.pwr_tUInt32;  -- pwr_class.h:1236
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_MountVolume);  -- pwr_class.h:1228

   type pwr_s_MountObject is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1240
      Object : aliased pwr_h.pwr_tObjid;  -- pwr_class.h:1241
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_MountObject);  -- pwr_class.h:1239

   type pwr_s_Security is record
      DefaultWebPriv : aliased pwr_h.pwr_tMask;  -- pwr_class.h:1245
      DefaultXttPriv : aliased pwr_h.pwr_tMask;  -- pwr_class.h:1246
      XttUseOpsysUser : aliased pwr_h.pwr_tBoolean;  -- pwr_class.h:1247
      WebSystemGroup : aliased pwr_h.pwr_tString80;  -- pwr_class.h:1248
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_s_Security);  -- pwr_class.h:1244

   type pwr_u_Volume (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            Root : aliased pwr_sRootVolume;  -- pwr_class.h:1252
         when 1 =>
            Sub : aliased pwr_sSubVolume;  -- pwr_class.h:1253
         when 2 =>
            Shared : aliased pwr_sSharedVolume;  -- pwr_class.h:1254
         when 3 =>
            Dynamic : aliased pwr_sDynamicVolume;  -- pwr_class.h:1255
         when 4 =>
            System : aliased pwr_sSystemVolume;  -- pwr_class.h:1256
         when 5 =>
            Class : aliased pwr_sClassVolume;  -- pwr_class.h:1257
         when 6 =>
            WorkBench : aliased pwr_sWorkBenchVolume;  -- pwr_class.h:1258
         when others =>
            Directory : aliased pwr_sDirectoryVolume;  -- pwr_class.h:1259
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_u_Volume);
   pragma Unchecked_Union (pwr_u_Volume);  -- pwr_class.h:1251

end pwr_class_h;
