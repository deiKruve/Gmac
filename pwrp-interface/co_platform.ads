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

package co_platform is
   
   type co_eOS is 
     (co_eOS_u_u,
      co_eOS_Lynx,
      co_eOS_VMS,
      co_eOS_ELN,
      co_eOS_WNT,
      co_eOS_W95,
      co_eOS_Amiga,
      co_eOS_Linux,
      co_eOS_MacOS,
      co_eOS_FreeBSD,
      co_eOS_OpenBSD,
      co_eOS_Cygwin,
      co_eOS_u);
   --  OS type
   -- Do not change the order. Must be backward compatible
   pragma Convention (C, co_eOS);  -- co_platform.h:107

   type co_eHW is 
     (co_eHW_u_u,
      co_eHW_x86,
      co_eHW_68k,
      co_eHW_VAX,
      co_eHW_Alpha,
      co_eHW_PPC,
      co_eHW_x86_64,
      co_eHW_ARM,
      co_eHW_u);
   -- Hardware type 
   -- Do not change the order. Must be backward compatible
   pragma Convention (C, co_eHW);  -- co_platform.h:146
   
   type co_eBO is 
     (co_eBO_u_u,
      co_eBO_big,
      co_eBO_little,
      co_eBO_middle);  --Not used, historical reasons
   -- Integer and floating-point byte order.
   --
   --  Network is big    endian
   --  68k     is big    endian
   --  x86     is little endian
   --  PPC     is both   endian
   --  VAX     is little endian
   --
   -- Do not change the order. Must be backward compatible
   pragma Convention (C, co_eBO);  -- co_platform.h:181
   
   type co_eCT is 
     (co_eCT_u_u,
      co_eCT_ascii,
      co_eCT_u);
   -- Character representation type. Always set to ascii
   -- The enum must not exceed 15 
   pragma Convention (C, co_eCT);  -- co_platform.h:199

   type co_eFT is 
     (co_eFT_u_u,
      co_eFT_ieeeS,
      co_eFT_ieeeT, -- Not used
      co_eFT_ieeeK, -- Not used
      co_eFT_vaxF,  -- Both for Alpha and VAX (float)
      co_eFT_vaxD,  -- Never set, there are no support for double
      co_eFT_vaxG,  -- Never set, there are no support for double
      co_eFT_vaxH,  -- Not used
      co_eFT_u);    
   --  Floating-point representation type.
   -- Do not change the order. Must be backward compatible
   pragma Convention (C, co_eFT);  -- co_platform.h:219
   
   type co_mFormat;
   type anon_20             is 
      record
	 bo        : Extensions.Unsigned_4;  -- Byte order
	 ct     : Extensions.Unsigned_4;  -- Not used. Character representation
	 ft        : aliased unsigned_char;  -- Floting-point representation
	 reserved1 : aliased unsigned_char; 
	 reserved2 : aliased unsigned_char;
      end record;
   pragma Convention (C_Pass_By_Copy, anon_20);
   type co_mFormat (discr : unsigned := 0) is 
      record
	 case discr is
	    when 0      =>
	       m : aliased pwr.pwr_tBitMask; 
	    when others =>
	       b : aliased anon_20;
	 end case;
      end record;
   pragma Convention (C_Pass_By_Copy, co_mFormat);
   pragma Unchecked_Union (co_mFormat);  -- co_platform.h:242
   
   type co_sPlatform is record
      os : aliased co_eOS;
      hw : aliased co_eHW;
      bo : aliased co_eBO;
      ft : aliased co_eFT;
   end record;
   pragma Convention (C_Pass_By_Copy, co_sPlatform);  -- co_platform.h:250
   
   --------------------------
   -- Function prototypes. --
   --------------------------
   
   function co_GetOwnFormat (format : access co_mFormat) 
			    return access co_mFormat;  -- co_platform.h:252
   pragma Import (C, co_GetOwnFormat, "co_GetOwnFormat");

   function co_GetOwnPlatform (platform : access co_sPlatform) 
			      return access co_sPlatform;  -- co_platform.h:253
   pragma Import (C, co_GetOwnPlatform, "co_GetOwnPlatform");
   
   function co_SetFormat (format : access co_mFormat;
			  bo : co_eBO;
			  ft : co_eFT) 
			 return access co_mFormat;  -- co_platform.h:254
   pragma Import (C, co_SetFormat, "co_SetFormat");

end Co_Platform;
