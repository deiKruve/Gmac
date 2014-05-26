pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~testgscan.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~testgscan.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E075 : Short_Integer; pragma Import (Ada, E075, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "ada__containers_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__io_exceptions_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "ada__strings_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__strings__maps_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "ada__strings__maps__constants_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "ada__tags_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__streams_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "interfaces__c_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c__strings_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "system__aux_dec_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__exceptions_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "system__finalization_root_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__finalization_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "system__regpat_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__storage_pools_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__finalization_masters_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "system__storage_pools__subpools_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "ada__calendar_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "ada__calendar__time_zones_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "gnat__calendar_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "gnat__calendar__time_io_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gnat__directory_operations_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "system__assertions_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "system__pool_global_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "system__file_control_block_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "ada__streams__stream_io_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "system__file_io_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "ada__strings__unbounded_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "ada__directories_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "gnat__expect_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "system__regexp_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "system__strings__stream_ops_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__text_io_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "system__interrupt_management__operations_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "generic_scanner_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "gmactextscan_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gnatcoll__mmap_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "gnatcoll__utils_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "gnatcoll__io_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gnatcoll__path_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "gnatcoll__io__native_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "gnatcoll__remote_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "gnatcoll__io__remote_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "gnatcoll__io__remote__unix_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "gnatcoll__io__remote__windows_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "gnatcoll__remote__db_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gnatcoll__vfs_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "gnatcoll__traces_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gnatcoll__vfs_utils_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "posix_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "posix__calendar_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "posix__permissions_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "posix__permissions__implementation_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "posix__process_identification_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "posix__files_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "posix__io_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "posix__file_status_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "posix__memory_mapping_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "gmactextscan__finalize_body");
      begin
         E098 := E098 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gnatcoll__traces__finalize_body");
      begin
         E136 := E136 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gnatcoll__traces__finalize_spec");
      begin
         F3;
      end;
      E199 := E199 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "gnatcoll__vfs__finalize_spec");
      begin
         F4;
      end;
      E210 := E210 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gnatcoll__io__remote__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gnatcoll__remote__finalize_spec");
      begin
         E192 := E192 - 1;
         F6;
      end;
      E212 := E212 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gnatcoll__io__native__finalize_spec");
      begin
         F7;
      end;
      E208 := E208 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gnatcoll__io__finalize_spec");
      begin
         F8;
      end;
      E006 := E006 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "ada__text_io__finalize_spec");
      begin
         F9;
      end;
      E187 := E187 - 1;
      E191 := E191 - 1;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__regexp__finalize_spec");
      begin
         F10;
      end;
      E180 := E180 - 1;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gnat__expect__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "ada__directories__finalize_spec");
      begin
         F12;
      end;
      E111 := E111 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "ada__strings__unbounded__finalize_spec");
      begin
         F13;
      end;
      E080 := E080 - 1;
      E094 := E094 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "system__file_io__finalize_body");
      begin
         E061 := E061 - 1;
         F14;
      end;
      E224 := E224 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "ada__streams__stream_io__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "system__file_control_block__finalize_spec");
      begin
         E078 := E078 - 1;
         F16;
      end;
      E090 := E090 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "system__pool_global__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "system__storage_pools__subpools__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "system__finalization_masters__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Exception_Tracebacks : Integer;
      pragma Import (C, Exception_Tracebacks, "__gl_exception_tracebacks");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Exception_Tracebacks := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Containers'Elab_Spec;
      E202 := E202 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E066 := E066 + 1;
      Ada.Strings'Elab_Spec;
      E101 := E101 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E129 := E129 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E047 := E047 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Aux_Dec'Elab_Spec;
      E259 := E259 + 1;
      System.Exceptions'Elab_Spec;
      E029 := E029 + 1;
      System.Finalization_Root'Elab_Spec;
      E065 := E065 + 1;
      Ada.Finalization'Elab_Spec;
      E063 := E063 + 1;
      System.Regpat'Elab_Spec;
      System.Storage_Pools'Elab_Spec;
      E088 := E088 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E138 := E138 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E144 := E144 + 1;
      Gnat.Calendar'Elab_Spec;
      E153 := E153 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      Gnat.Directory_Operations'Elab_Spec;
      System.Assertions'Elab_Spec;
      E178 := E178 + 1;
      System.Pool_Global'Elab_Spec;
      E090 := E090 + 1;
      System.File_Control_Block'Elab_Spec;
      E078 := E078 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E224 := E224 + 1;
      System.File_Io'Elab_Body;
      E061 := E061 + 1;
      E094 := E094 + 1;
      System.Finalization_Masters'Elab_Body;
      E080 := E080 + 1;
      E126 := E126 + 1;
      E070 := E070 + 1;
      E068 := E068 + 1;
      Ada.Tags'Elab_Body;
      E049 := E049 + 1;
      E105 := E105 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E075 := E075 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      Gnat.Directory_Operations'Elab_Body;
      E161 := E161 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E111 := E111 + 1;
      Ada.Directories'Elab_Spec;
      Gnat.Expect'Elab_Spec;
      E180 := E180 + 1;
      System.Regexp'Elab_Spec;
      E191 := E191 + 1;
      Ada.Directories'Elab_Body;
      E187 := E187 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E222 := E222 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E006 := E006 + 1;
      E155 := E155 + 1;
      System.Interrupt_Management.Operations'Elab_Body;
      E241 := E241 + 1;
      E122 := E122 + 1;
      E171 := E171 + 1;
      GNATCOLL.UTILS'ELAB_SPEC;
      E174 := E174 + 1;
      GNATCOLL.IO'ELAB_SPEC;
      E208 := E208 + 1;
      GNATCOLL.PATH'ELAB_SPEC;
      GNATCOLL.PATH'ELAB_BODY;
      E197 := E197 + 1;
      GNATCOLL.IO.NATIVE'ELAB_SPEC;
      GNATCOLL.IO.NATIVE'ELAB_BODY;
      E212 := E212 + 1;
      GNATCOLL.REMOTE'ELAB_SPEC;
      E192 := E192 + 1;
      GNATCOLL.IO.REMOTE'ELAB_SPEC;
      E214 := E214 + 1;
      E220 := E220 + 1;
      GNATCOLL.REMOTE.DB'ELAB_SPEC;
      E195 := E195 + 1;
      E210 := E210 + 1;
      GNATCOLL.VFS'ELAB_SPEC;
      GNATCOLL.VFS'ELAB_BODY;
      E199 := E199 + 1;
      GNATCOLL.TRACES'ELAB_SPEC;
      GNATCOLL.VFS_UTILS'ELAB_SPEC;
      E185 := E185 + 1;
      GNATCOLL.TRACES'ELAB_BODY;
      E136 := E136 + 1;
      POSIX'ELAB_SPEC;
      POSIX.CALENDAR'ELAB_BODY;
      E252 := E252 + 1;
      E229 := E229 + 1;
      POSIX.PERMISSIONS'ELAB_SPEC;
      E250 := E250 + 1;
      E248 := E248 + 1;
      E257 := E257 + 1;
      POSIX.IO'ELAB_SPEC;
      E255 := E255 + 1;
      E246 := E246 + 1;
      E263 := E263 + 1;
      POSIX.MEMORY_MAPPING'ELAB_SPEC;
      E265 := E265 + 1;
      Gmactextscan'Elab_Body;
      E098 := E098 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_testgscan");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/jan/MMS/programs-PC/obj/gnatcoll.o
   --   /home/jan/MMS/programs-PC/obj/generic_scanner.o
   --   /home/jan/MMS/programs-PC/obj/testgscan.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-mmap.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-utils.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-vfs_types.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-io.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-path.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-io-native.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-remote.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-io-remote-unix.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-io-remote-windows.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-remote-db.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-io-remote.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-vfs.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-vfs_utils.o
   --   /home/jan/MMS/programs-PC/obj/gnatcoll-traces.o
   --   /home/jan/MMS/programs-PC/obj/gmactextscan.o
   --   -L/home/jan/MMS/programs-PC/obj/
   --   -L/home/jan/MMS/programs-PC/obj/
   --   -L/usr/gnat/floristlib/
   --   -L/usr/gnat/lib/gcc/i686-pc-linux-gnu/4.7.4/adalib/
   --   -L/home/jan/MMS/programs-PC/
   --   -lnsl
   --   -lrt
   --   -lpthread
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
--  END Object file/option list   

end ada_main;
