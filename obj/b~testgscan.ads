pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2013 (20130314)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_testgscan" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#32419663#;
   pragma Export (C, u00001, "testgscanB");
   u00002 : constant Version_32 := 16#3935bd10#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#b31646c6#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#421d3150#;
   pragma Export (C, u00005, "ada__text_ioB");
   u00006 : constant Version_32 := 16#f792461d#;
   pragma Export (C, u00006, "ada__text_ioS");
   u00007 : constant Version_32 := 16#cff320ef#;
   pragma Export (C, u00007, "ada__exceptionsB");
   u00008 : constant Version_32 := 16#813e0b0c#;
   pragma Export (C, u00008, "ada__exceptionsS");
   u00009 : constant Version_32 := 16#16173147#;
   pragma Export (C, u00009, "ada__exceptions__last_chance_handlerB");
   u00010 : constant Version_32 := 16#1f42fb5e#;
   pragma Export (C, u00010, "ada__exceptions__last_chance_handlerS");
   u00011 : constant Version_32 := 16#bd760655#;
   pragma Export (C, u00011, "systemS");
   u00012 : constant Version_32 := 16#0071025c#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#d02d7c88#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#27940d94#;
   pragma Export (C, u00014, "system__parametersB");
   u00015 : constant Version_32 := 16#0b940a95#;
   pragma Export (C, u00015, "system__parametersS");
   u00016 : constant Version_32 := 16#17775d6d#;
   pragma Export (C, u00016, "system__secondary_stackB");
   u00017 : constant Version_32 := 16#a91821fb#;
   pragma Export (C, u00017, "system__secondary_stackS");
   u00018 : constant Version_32 := 16#ace32e1e#;
   pragma Export (C, u00018, "system__storage_elementsB");
   u00019 : constant Version_32 := 16#47bb7bcd#;
   pragma Export (C, u00019, "system__storage_elementsS");
   u00020 : constant Version_32 := 16#4f750b3b#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#1ed4ba79#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#7b9f0bae#;
   pragma Export (C, u00022, "system__exception_tableB");
   u00023 : constant Version_32 := 16#2c18daf0#;
   pragma Export (C, u00023, "system__exception_tableS");
   u00024 : constant Version_32 := 16#5665ab64#;
   pragma Export (C, u00024, "system__htableB");
   u00025 : constant Version_32 := 16#3ede485b#;
   pragma Export (C, u00025, "system__htableS");
   u00026 : constant Version_32 := 16#8b7dad61#;
   pragma Export (C, u00026, "system__string_hashB");
   u00027 : constant Version_32 := 16#9beadec1#;
   pragma Export (C, u00027, "system__string_hashS");
   u00028 : constant Version_32 := 16#aad75561#;
   pragma Export (C, u00028, "system__exceptionsB");
   u00029 : constant Version_32 := 16#b188cee2#;
   pragma Export (C, u00029, "system__exceptionsS");
   u00030 : constant Version_32 := 16#010db1dc#;
   pragma Export (C, u00030, "system__exceptions_debugB");
   u00031 : constant Version_32 := 16#85062381#;
   pragma Export (C, u00031, "system__exceptions_debugS");
   u00032 : constant Version_32 := 16#b012ff50#;
   pragma Export (C, u00032, "system__img_intB");
   u00033 : constant Version_32 := 16#bfade697#;
   pragma Export (C, u00033, "system__img_intS");
   u00034 : constant Version_32 := 16#dc8e33ed#;
   pragma Export (C, u00034, "system__tracebackB");
   u00035 : constant Version_32 := 16#dcf1d220#;
   pragma Export (C, u00035, "system__tracebackS");
   u00036 : constant Version_32 := 16#907d882f#;
   pragma Export (C, u00036, "system__wch_conB");
   u00037 : constant Version_32 := 16#029d2868#;
   pragma Export (C, u00037, "system__wch_conS");
   u00038 : constant Version_32 := 16#22fed88a#;
   pragma Export (C, u00038, "system__wch_stwB");
   u00039 : constant Version_32 := 16#2f8c0469#;
   pragma Export (C, u00039, "system__wch_stwS");
   u00040 : constant Version_32 := 16#617a40f2#;
   pragma Export (C, u00040, "system__wch_cnvB");
   u00041 : constant Version_32 := 16#1c63aebe#;
   pragma Export (C, u00041, "system__wch_cnvS");
   u00042 : constant Version_32 := 16#cb4a8015#;
   pragma Export (C, u00042, "interfacesS");
   u00043 : constant Version_32 := 16#75729fba#;
   pragma Export (C, u00043, "system__wch_jisB");
   u00044 : constant Version_32 := 16#481135aa#;
   pragma Export (C, u00044, "system__wch_jisS");
   u00045 : constant Version_32 := 16#ada34a87#;
   pragma Export (C, u00045, "system__traceback_entriesB");
   u00046 : constant Version_32 := 16#ef57e814#;
   pragma Export (C, u00046, "system__traceback_entriesS");
   u00047 : constant Version_32 := 16#1358602f#;
   pragma Export (C, u00047, "ada__streamsS");
   u00048 : constant Version_32 := 16#afd62b40#;
   pragma Export (C, u00048, "ada__tagsB");
   u00049 : constant Version_32 := 16#1442fc05#;
   pragma Export (C, u00049, "ada__tagsS");
   u00050 : constant Version_32 := 16#d7975a23#;
   pragma Export (C, u00050, "system__unsigned_typesS");
   u00051 : constant Version_32 := 16#79817c71#;
   pragma Export (C, u00051, "system__val_unsB");
   u00052 : constant Version_32 := 16#c73fb718#;
   pragma Export (C, u00052, "system__val_unsS");
   u00053 : constant Version_32 := 16#aea309ed#;
   pragma Export (C, u00053, "system__val_utilB");
   u00054 : constant Version_32 := 16#11d6b0ab#;
   pragma Export (C, u00054, "system__val_utilS");
   u00055 : constant Version_32 := 16#b7fa72e7#;
   pragma Export (C, u00055, "system__case_utilB");
   u00056 : constant Version_32 := 16#106a66dd#;
   pragma Export (C, u00056, "system__case_utilS");
   u00057 : constant Version_32 := 16#e0b7a7e8#;
   pragma Export (C, u00057, "interfaces__c_streamsB");
   u00058 : constant Version_32 := 16#95ad191f#;
   pragma Export (C, u00058, "interfaces__c_streamsS");
   u00059 : constant Version_32 := 16#d45bc0f4#;
   pragma Export (C, u00059, "system__crtlS");
   u00060 : constant Version_32 := 16#228a5436#;
   pragma Export (C, u00060, "system__file_ioB");
   u00061 : constant Version_32 := 16#2c376772#;
   pragma Export (C, u00061, "system__file_ioS");
   u00062 : constant Version_32 := 16#8cbe6205#;
   pragma Export (C, u00062, "ada__finalizationB");
   u00063 : constant Version_32 := 16#22e22193#;
   pragma Export (C, u00063, "ada__finalizationS");
   u00064 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00064, "system__finalization_rootB");
   u00065 : constant Version_32 := 16#f28475c5#;
   pragma Export (C, u00065, "system__finalization_rootS");
   u00066 : constant Version_32 := 16#b46168d5#;
   pragma Export (C, u00066, "ada__io_exceptionsS");
   u00067 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00067, "interfaces__cB");
   u00068 : constant Version_32 := 16#29899d4e#;
   pragma Export (C, u00068, "interfaces__cS");
   u00069 : constant Version_32 := 16#b2cb9bcf#;
   pragma Export (C, u00069, "interfaces__c__stringsB");
   u00070 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00070, "interfaces__c__stringsS");
   u00071 : constant Version_32 := 16#d6bc4ecc#;
   pragma Export (C, u00071, "system__crtl__runtimeS");
   u00072 : constant Version_32 := 16#1eab0e09#;
   pragma Export (C, u00072, "system__img_enum_newB");
   u00073 : constant Version_32 := 16#3a71cda5#;
   pragma Export (C, u00073, "system__img_enum_newS");
   u00074 : constant Version_32 := 16#14502dea#;
   pragma Export (C, u00074, "system__os_libB");
   u00075 : constant Version_32 := 16#89dce9aa#;
   pragma Export (C, u00075, "system__os_libS");
   u00076 : constant Version_32 := 16#4cd8aca0#;
   pragma Export (C, u00076, "system__stringsB");
   u00077 : constant Version_32 := 16#0a9c4c91#;
   pragma Export (C, u00077, "system__stringsS");
   u00078 : constant Version_32 := 16#9a926c2b#;
   pragma Export (C, u00078, "system__file_control_blockS");
   u00079 : constant Version_32 := 16#91d2300e#;
   pragma Export (C, u00079, "system__finalization_mastersB");
   u00080 : constant Version_32 := 16#d783aa79#;
   pragma Export (C, u00080, "system__finalization_mastersS");
   u00081 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00081, "system__address_imageB");
   u00082 : constant Version_32 := 16#1c9a9b6f#;
   pragma Export (C, u00082, "system__address_imageS");
   u00083 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00083, "system__img_boolB");
   u00084 : constant Version_32 := 16#48af77be#;
   pragma Export (C, u00084, "system__img_boolS");
   u00085 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00085, "system__ioB");
   u00086 : constant Version_32 := 16#2334f11a#;
   pragma Export (C, u00086, "system__ioS");
   u00087 : constant Version_32 := 16#a7a37cb6#;
   pragma Export (C, u00087, "system__storage_poolsB");
   u00088 : constant Version_32 := 16#6ed81938#;
   pragma Export (C, u00088, "system__storage_poolsS");
   u00089 : constant Version_32 := 16#ba5d60c7#;
   pragma Export (C, u00089, "system__pool_globalB");
   u00090 : constant Version_32 := 16#d56df0a6#;
   pragma Export (C, u00090, "system__pool_globalS");
   u00091 : constant Version_32 := 16#fc605663#;
   pragma Export (C, u00091, "system__memoryB");
   u00092 : constant Version_32 := 16#77fdba40#;
   pragma Export (C, u00092, "system__memoryS");
   u00093 : constant Version_32 := 16#1fd820b1#;
   pragma Export (C, u00093, "system__storage_pools__subpoolsB");
   u00094 : constant Version_32 := 16#951e0de9#;
   pragma Export (C, u00094, "system__storage_pools__subpoolsS");
   u00095 : constant Version_32 := 16#1777d351#;
   pragma Export (C, u00095, "system__storage_pools__subpools__finalizationB");
   u00096 : constant Version_32 := 16#12aaf1de#;
   pragma Export (C, u00096, "system__storage_pools__subpools__finalizationS");
   u00097 : constant Version_32 := 16#6c48268b#;
   pragma Export (C, u00097, "gmactextscanB");
   u00098 : constant Version_32 := 16#5f433c3b#;
   pragma Export (C, u00098, "gmactextscanS");
   u00099 : constant Version_32 := 16#12c24a43#;
   pragma Export (C, u00099, "ada__charactersS");
   u00100 : constant Version_32 := 16#051b1b7b#;
   pragma Export (C, u00100, "ada__characters__latin_1S");
   u00101 : constant Version_32 := 16#af50e98f#;
   pragma Export (C, u00101, "ada__stringsS");
   u00102 : constant Version_32 := 16#914b496f#;
   pragma Export (C, u00102, "ada__strings__fixedB");
   u00103 : constant Version_32 := 16#dc686502#;
   pragma Export (C, u00103, "ada__strings__fixedS");
   u00104 : constant Version_32 := 16#96e9c1e7#;
   pragma Export (C, u00104, "ada__strings__mapsB");
   u00105 : constant Version_32 := 16#24318e4c#;
   pragma Export (C, u00105, "ada__strings__mapsS");
   u00106 : constant Version_32 := 16#35042ca6#;
   pragma Export (C, u00106, "system__bit_opsB");
   u00107 : constant Version_32 := 16#c30e4013#;
   pragma Export (C, u00107, "system__bit_opsS");
   u00108 : constant Version_32 := 16#562e7aee#;
   pragma Export (C, u00108, "ada__strings__searchB");
   u00109 : constant Version_32 := 16#b5a8c1d6#;
   pragma Export (C, u00109, "ada__strings__searchS");
   u00110 : constant Version_32 := 16#261c554b#;
   pragma Export (C, u00110, "ada__strings__unboundedB");
   u00111 : constant Version_32 := 16#2bf53506#;
   pragma Export (C, u00111, "ada__strings__unboundedS");
   u00112 : constant Version_32 := 16#c4857ee1#;
   pragma Export (C, u00112, "system__compare_array_unsigned_8B");
   u00113 : constant Version_32 := 16#674df098#;
   pragma Export (C, u00113, "system__compare_array_unsigned_8S");
   u00114 : constant Version_32 := 16#9d3d925a#;
   pragma Export (C, u00114, "system__address_operationsB");
   u00115 : constant Version_32 := 16#7d08efc2#;
   pragma Export (C, u00115, "system__address_operationsS");
   u00116 : constant Version_32 := 16#b2cd7d9b#;
   pragma Export (C, u00116, "system__machine_codeS");
   u00117 : constant Version_32 := 16#8d43fb6a#;
   pragma Export (C, u00117, "system__atomic_countersB");
   u00118 : constant Version_32 := 16#f7ea6ae1#;
   pragma Export (C, u00118, "system__atomic_countersS");
   u00119 : constant Version_32 := 16#a6e358bc#;
   pragma Export (C, u00119, "system__stream_attributesB");
   u00120 : constant Version_32 := 16#e89b4b3f#;
   pragma Export (C, u00120, "system__stream_attributesS");
   u00121 : constant Version_32 := 16#2ba112ac#;
   pragma Export (C, u00121, "generic_scannerB");
   u00122 : constant Version_32 := 16#9b738070#;
   pragma Export (C, u00122, "generic_scannerS");
   u00123 : constant Version_32 := 16#fd2ad2f1#;
   pragma Export (C, u00123, "gnatS");
   u00124 : constant Version_32 := 16#c72dc161#;
   pragma Export (C, u00124, "gnat__regpatS");
   u00125 : constant Version_32 := 16#b97b88d3#;
   pragma Export (C, u00125, "system__regpatB");
   u00126 : constant Version_32 := 16#3f2c9d2a#;
   pragma Export (C, u00126, "system__regpatS");
   u00127 : constant Version_32 := 16#6239f067#;
   pragma Export (C, u00127, "ada__characters__handlingB");
   u00128 : constant Version_32 := 16#3006d996#;
   pragma Export (C, u00128, "ada__characters__handlingS");
   u00129 : constant Version_32 := 16#7a69aa90#;
   pragma Export (C, u00129, "ada__strings__maps__constantsS");
   u00130 : constant Version_32 := 16#2b93a046#;
   pragma Export (C, u00130, "system__img_charB");
   u00131 : constant Version_32 := 16#21425eb2#;
   pragma Export (C, u00131, "system__img_charS");
   u00132 : constant Version_32 := 16#c31442ce#;
   pragma Export (C, u00132, "system__val_intB");
   u00133 : constant Version_32 := 16#f5d32c6a#;
   pragma Export (C, u00133, "system__val_intS");
   u00134 : constant Version_32 := 16#6a5da479#;
   pragma Export (C, u00134, "gnatcollS");
   u00135 : constant Version_32 := 16#41cea6e0#;
   pragma Export (C, u00135, "gnatcoll__tracesB");
   u00136 : constant Version_32 := 16#843efd08#;
   pragma Export (C, u00136, "gnatcoll__tracesS");
   u00137 : constant Version_32 := 16#8ba0787e#;
   pragma Export (C, u00137, "ada__calendarB");
   u00138 : constant Version_32 := 16#e791e294#;
   pragma Export (C, u00138, "ada__calendarS");
   u00139 : constant Version_32 := 16#22d03640#;
   pragma Export (C, u00139, "system__os_primitivesB");
   u00140 : constant Version_32 := 16#0da78a7c#;
   pragma Export (C, u00140, "system__os_primitivesS");
   u00141 : constant Version_32 := 16#7a13e6d7#;
   pragma Export (C, u00141, "ada__calendar__formattingB");
   u00142 : constant Version_32 := 16#929f882b#;
   pragma Export (C, u00142, "ada__calendar__formattingS");
   u00143 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00143, "ada__calendar__time_zonesB");
   u00144 : constant Version_32 := 16#98f012d7#;
   pragma Export (C, u00144, "ada__calendar__time_zonesS");
   u00145 : constant Version_32 := 16#8ff77155#;
   pragma Export (C, u00145, "system__val_realB");
   u00146 : constant Version_32 := 16#435f7144#;
   pragma Export (C, u00146, "system__val_realS");
   u00147 : constant Version_32 := 16#0be1b996#;
   pragma Export (C, u00147, "system__exn_llfB");
   u00148 : constant Version_32 := 16#3cf218ba#;
   pragma Export (C, u00148, "system__exn_llfS");
   u00149 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00149, "system__float_controlB");
   u00150 : constant Version_32 := 16#5d8a4569#;
   pragma Export (C, u00150, "system__float_controlS");
   u00151 : constant Version_32 := 16#ed066022#;
   pragma Export (C, u00151, "system__powten_tableS");
   u00152 : constant Version_32 := 16#e1f42065#;
   pragma Export (C, u00152, "gnat__calendarB");
   u00153 : constant Version_32 := 16#d73dae4e#;
   pragma Export (C, u00153, "gnat__calendarS");
   u00154 : constant Version_32 := 16#8bfb0aae#;
   pragma Export (C, u00154, "gnat__calendar__time_ioB");
   u00155 : constant Version_32 := 16#1efff27c#;
   pragma Export (C, u00155, "gnat__calendar__time_ioS");
   u00156 : constant Version_32 := 16#d37ed4a2#;
   pragma Export (C, u00156, "gnat__case_utilB");
   u00157 : constant Version_32 := 16#5f04590f#;
   pragma Export (C, u00157, "gnat__case_utilS");
   u00158 : constant Version_32 := 16#06417083#;
   pragma Export (C, u00158, "system__img_lluB");
   u00159 : constant Version_32 := 16#9e5e5ae0#;
   pragma Export (C, u00159, "system__img_lluS");
   u00160 : constant Version_32 := 16#c8f3c043#;
   pragma Export (C, u00160, "gnat__directory_operationsB");
   u00161 : constant Version_32 := 16#48e8a667#;
   pragma Export (C, u00161, "gnat__directory_operationsS");
   u00162 : constant Version_32 := 16#3ff16a6d#;
   pragma Export (C, u00162, "gnat__os_libS");
   u00163 : constant Version_32 := 16#00e9dcb1#;
   pragma Export (C, u00163, "gnat__task_lockS");
   u00164 : constant Version_32 := 16#863f9596#;
   pragma Export (C, u00164, "system__task_lockB");
   u00165 : constant Version_32 := 16#dcfc313b#;
   pragma Export (C, u00165, "system__task_lockS");
   u00166 : constant Version_32 := 16#2648146e#;
   pragma Export (C, u00166, "gnat__tracebackB");
   u00167 : constant Version_32 := 16#c23af398#;
   pragma Export (C, u00167, "gnat__tracebackS");
   u00168 : constant Version_32 := 16#25f70bc7#;
   pragma Export (C, u00168, "ada__exceptions__tracebackB");
   u00169 : constant Version_32 := 16#1e536c8b#;
   pragma Export (C, u00169, "ada__exceptions__tracebackS");
   u00170 : constant Version_32 := 16#fdbed2a5#;
   pragma Export (C, u00170, "gnatcoll__mmapB");
   u00171 : constant Version_32 := 16#f168ff55#;
   pragma Export (C, u00171, "gnatcoll__mmapS");
   u00172 : constant Version_32 := 16#7d3103a4#;
   pragma Export (C, u00172, "gnat__stringsS");
   u00173 : constant Version_32 := 16#f29804cb#;
   pragma Export (C, u00173, "gnatcoll__utilsB");
   u00174 : constant Version_32 := 16#da12b2fc#;
   pragma Export (C, u00174, "gnatcoll__utilsS");
   u00175 : constant Version_32 := 16#7a34f6b5#;
   pragma Export (C, u00175, "ada__command_lineB");
   u00176 : constant Version_32 := 16#df5044bd#;
   pragma Export (C, u00176, "ada__command_lineS");
   u00177 : constant Version_32 := 16#2d08d4ae#;
   pragma Export (C, u00177, "system__assertionsB");
   u00178 : constant Version_32 := 16#1ed2e0fe#;
   pragma Export (C, u00178, "system__assertionsS");
   u00179 : constant Version_32 := 16#3f618849#;
   pragma Export (C, u00179, "gnat__expectB");
   u00180 : constant Version_32 := 16#79d903e4#;
   pragma Export (C, u00180, "gnat__expectS");
   u00181 : constant Version_32 := 16#b48102f5#;
   pragma Export (C, u00181, "gnat__ioB");
   u00182 : constant Version_32 := 16#6227e843#;
   pragma Export (C, u00182, "gnat__ioS");
   u00183 : constant Version_32 := 16#eb91c6e6#;
   pragma Export (C, u00183, "system__os_constantsS");
   u00184 : constant Version_32 := 16#8901e98c#;
   pragma Export (C, u00184, "gnatcoll__vfs_utilsB");
   u00185 : constant Version_32 := 16#88472e46#;
   pragma Export (C, u00185, "gnatcoll__vfs_utilsS");
   u00186 : constant Version_32 := 16#7e8f99bf#;
   pragma Export (C, u00186, "ada__directoriesB");
   u00187 : constant Version_32 := 16#9c33e8ea#;
   pragma Export (C, u00187, "ada__directoriesS");
   u00188 : constant Version_32 := 16#e559f18d#;
   pragma Export (C, u00188, "ada__directories__validityB");
   u00189 : constant Version_32 := 16#a2334639#;
   pragma Export (C, u00189, "ada__directories__validityS");
   u00190 : constant Version_32 := 16#daf128da#;
   pragma Export (C, u00190, "system__regexpB");
   u00191 : constant Version_32 := 16#73e7fde9#;
   pragma Export (C, u00191, "system__regexpS");
   u00192 : constant Version_32 := 16#3325c923#;
   pragma Export (C, u00192, "gnatcoll__remoteS");
   u00193 : constant Version_32 := 16#8fb9b025#;
   pragma Export (C, u00193, "gnatcoll__vfs_typesS");
   u00194 : constant Version_32 := 16#f971b57c#;
   pragma Export (C, u00194, "gnatcoll__remote__dbB");
   u00195 : constant Version_32 := 16#329db92e#;
   pragma Export (C, u00195, "gnatcoll__remote__dbS");
   u00196 : constant Version_32 := 16#de99049c#;
   pragma Export (C, u00196, "gnatcoll__pathB");
   u00197 : constant Version_32 := 16#3a9bde91#;
   pragma Export (C, u00197, "gnatcoll__pathS");
   u00198 : constant Version_32 := 16#ec4a3b78#;
   pragma Export (C, u00198, "gnatcoll__vfsB");
   u00199 : constant Version_32 := 16#1e3052b6#;
   pragma Export (C, u00199, "gnatcoll__vfsS");
   u00200 : constant Version_32 := 16#bd084245#;
   pragma Export (C, u00200, "ada__strings__hashB");
   u00201 : constant Version_32 := 16#fe83f2e7#;
   pragma Export (C, u00201, "ada__strings__hashS");
   u00202 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00202, "ada__containersS");
   u00203 : constant Version_32 := 16#e5d07804#;
   pragma Export (C, u00203, "ada__strings__hash_case_insensitiveB");
   u00204 : constant Version_32 := 16#f9e6d5c1#;
   pragma Export (C, u00204, "ada__strings__hash_case_insensitiveS");
   u00205 : constant Version_32 := 16#85f00a19#;
   pragma Export (C, u00205, "gnat__heap_sortB");
   u00206 : constant Version_32 := 16#b4c9f3ab#;
   pragma Export (C, u00206, "gnat__heap_sortS");
   u00207 : constant Version_32 := 16#565fa182#;
   pragma Export (C, u00207, "gnatcoll__ioB");
   u00208 : constant Version_32 := 16#39b41143#;
   pragma Export (C, u00208, "gnatcoll__ioS");
   u00209 : constant Version_32 := 16#6234a788#;
   pragma Export (C, u00209, "gnatcoll__io__remoteB");
   u00210 : constant Version_32 := 16#5a8bc3a1#;
   pragma Export (C, u00210, "gnatcoll__io__remoteS");
   u00211 : constant Version_32 := 16#34310783#;
   pragma Export (C, u00211, "gnatcoll__io__nativeB");
   u00212 : constant Version_32 := 16#7ec6d389#;
   pragma Export (C, u00212, "gnatcoll__io__nativeS");
   u00213 : constant Version_32 := 16#18176e68#;
   pragma Export (C, u00213, "gnatcoll__io__remote__unixB");
   u00214 : constant Version_32 := 16#b432ed1c#;
   pragma Export (C, u00214, "gnatcoll__io__remote__unixS");
   u00215 : constant Version_32 := 16#d3757657#;
   pragma Export (C, u00215, "system__val_lliB");
   u00216 : constant Version_32 := 16#2752e0f5#;
   pragma Export (C, u00216, "system__val_lliS");
   u00217 : constant Version_32 := 16#25c21d28#;
   pragma Export (C, u00217, "system__val_lluB");
   u00218 : constant Version_32 := 16#ad650d51#;
   pragma Export (C, u00218, "system__val_lluS");
   u00219 : constant Version_32 := 16#7ef98ce5#;
   pragma Export (C, u00219, "gnatcoll__io__remote__windowsB");
   u00220 : constant Version_32 := 16#a00994f9#;
   pragma Export (C, u00220, "gnatcoll__io__remote__windowsS");
   u00221 : constant Version_32 := 16#ce0e2acb#;
   pragma Export (C, u00221, "system__strings__stream_opsB");
   u00222 : constant Version_32 := 16#8453d1c6#;
   pragma Export (C, u00222, "system__strings__stream_opsS");
   u00223 : constant Version_32 := 16#7f3a23e7#;
   pragma Export (C, u00223, "ada__streams__stream_ioB");
   u00224 : constant Version_32 := 16#31db4e88#;
   pragma Export (C, u00224, "ada__streams__stream_ioS");
   u00225 : constant Version_32 := 16#5de653db#;
   pragma Export (C, u00225, "system__communicationB");
   u00226 : constant Version_32 := 16#485d2313#;
   pragma Export (C, u00226, "system__communicationS");
   u00227 : constant Version_32 := 16#1b4527ff#;
   pragma Export (C, u00227, "gnat__source_infoS");
   u00228 : constant Version_32 := 16#2eb19eb7#;
   pragma Export (C, u00228, "posixB");
   u00229 : constant Version_32 := 16#fb2e23bb#;
   pragma Export (C, u00229, "posixS");
   u00230 : constant Version_32 := 16#088d298e#;
   pragma Export (C, u00230, "posix__cB");
   u00231 : constant Version_32 := 16#7af586dd#;
   pragma Export (C, u00231, "posix__cS");
   u00232 : constant Version_32 := 16#f0ef6c0b#;
   pragma Export (C, u00232, "posix__implementationB");
   u00233 : constant Version_32 := 16#6e4d901a#;
   pragma Export (C, u00233, "posix__implementationS");
   u00234 : constant Version_32 := 16#903909a4#;
   pragma Export (C, u00234, "system__interrupt_managementB");
   u00235 : constant Version_32 := 16#3d6662cb#;
   pragma Export (C, u00235, "system__interrupt_managementS");
   u00236 : constant Version_32 := 16#3b0b7afe#;
   pragma Export (C, u00236, "system__task_primitivesS");
   u00237 : constant Version_32 := 16#e0522444#;
   pragma Export (C, u00237, "system__os_interfaceB");
   u00238 : constant Version_32 := 16#f136e9a6#;
   pragma Export (C, u00238, "system__os_interfaceS");
   u00239 : constant Version_32 := 16#cdb1cd10#;
   pragma Export (C, u00239, "system__linuxS");
   u00240 : constant Version_32 := 16#d3aa4021#;
   pragma Export (C, u00240, "system__interrupt_management__operationsB");
   u00241 : constant Version_32 := 16#19b909c9#;
   pragma Export (C, u00241, "system__interrupt_management__operationsS");
   u00242 : constant Version_32 := 16#aa574b29#;
   pragma Export (C, u00242, "system__arith_64B");
   u00243 : constant Version_32 := 16#367123b2#;
   pragma Export (C, u00243, "system__arith_64S");
   u00244 : constant Version_32 := 16#dcd1eb4a#;
   pragma Export (C, u00244, "ada_streamsS");
   u00245 : constant Version_32 := 16#836250fa#;
   pragma Export (C, u00245, "posix__file_statusB");
   u00246 : constant Version_32 := 16#eff15d57#;
   pragma Export (C, u00246, "posix__file_statusS");
   u00247 : constant Version_32 := 16#2f59acbb#;
   pragma Export (C, u00247, "posix__permissionsB");
   u00248 : constant Version_32 := 16#501242a1#;
   pragma Export (C, u00248, "posix__permissionsS");
   u00249 : constant Version_32 := 16#9aaaf132#;
   pragma Export (C, u00249, "posix__permissions__implementationB");
   u00250 : constant Version_32 := 16#b2fe179b#;
   pragma Export (C, u00250, "posix__permissions__implementationS");
   u00251 : constant Version_32 := 16#1c546768#;
   pragma Export (C, u00251, "posix__calendarB");
   u00252 : constant Version_32 := 16#e044c1fe#;
   pragma Export (C, u00252, "posix__calendarS");
   u00253 : constant Version_32 := 16#f4d84941#;
   pragma Export (C, u00253, "calendarS");
   u00254 : constant Version_32 := 16#9877ac9a#;
   pragma Export (C, u00254, "posix__ioB");
   u00255 : constant Version_32 := 16#6a104c36#;
   pragma Export (C, u00255, "posix__ioS");
   u00256 : constant Version_32 := 16#e1585557#;
   pragma Export (C, u00256, "posix__process_identificationB");
   u00257 : constant Version_32 := 16#69f4e345#;
   pragma Export (C, u00257, "posix__process_identificationS");
   u00258 : constant Version_32 := 16#845947f8#;
   pragma Export (C, u00258, "system__aux_decB");
   u00259 : constant Version_32 := 16#cbfa0e6c#;
   pragma Export (C, u00259, "system__aux_decS");
   u00260 : constant Version_32 := 16#194ccd7b#;
   pragma Export (C, u00260, "system__img_unsB");
   u00261 : constant Version_32 := 16#486366d4#;
   pragma Export (C, u00261, "system__img_unsS");
   u00262 : constant Version_32 := 16#48f068b7#;
   pragma Export (C, u00262, "posix__filesB");
   u00263 : constant Version_32 := 16#47e3ac67#;
   pragma Export (C, u00263, "posix__filesS");
   u00264 : constant Version_32 := 16#3b19c602#;
   pragma Export (C, u00264, "posix__memory_mappingB");
   u00265 : constant Version_32 := 16#3d9b5bec#;
   pragma Export (C, u00265, "posix__memory_mappingS");
   u00266 : constant Version_32 := 16#4b37b589#;
   pragma Export (C, u00266, "system__val_enumB");
   u00267 : constant Version_32 := 16#066c44c0#;
   pragma Export (C, u00267, "system__val_enumS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.handling%s
   --  ada.characters.latin_1%s
   --  ada.command_line%s
   --  gnat%s
   --  gnat.heap_sort%s
   --  gnat.heap_sort%b
   --  gnat.io%s
   --  gnat.io%b
   --  gnat.source_info%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.arith_64%s
   --  system.atomic_counters%s
   --  system.case_util%s
   --  system.case_util%b
   --  gnat.case_util%s
   --  gnat.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_char%s
   --  system.img_char%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.io%s
   --  system.io%b
   --  system.linux%s
   --  system.machine_code%s
   --  system.atomic_counters%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  gnat.strings%s
   --  system.os_lib%s
   --  gnat.os_lib%s
   --  system.task_lock%s
   --  gnat.task_lock%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.arith_64%b
   --  system.soft_links%s
   --  system.task_lock%b
   --  system.unsigned_types%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.val_enum%s
   --  system.val_int%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.val_int%b
   --  system.val_enum%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  system.address_image%s
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.strings.hash%s
   --  ada.strings.hash%b
   --  ada.strings.hash_case_insensitive%s
   --  ada.strings.maps%s
   --  ada.strings.fixed%s
   --  ada.strings.maps.constants%s
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.tags%s
   --  ada.streams%s
   --  interfaces.c%s
   --  interfaces.c.strings%s
   --  system.aux_dec%s
   --  system.aux_dec%b
   --  system.communication%s
   --  system.communication%b
   --  system.crtl.runtime%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.interrupt_management%s
   --  system.regpat%s
   --  gnat.regpat%s
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  system.task_primitives%s
   --  system.interrupt_management%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  calendar%s
   --  gnat.calendar%s
   --  gnat.calendar%b
   --  gnat.calendar.time_io%s
   --  gnat.directory_operations%s
   --  system.assertions%s
   --  system.assertions%b
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.file_control_block%s
   --  ada.streams.stream_io%s
   --  system.file_io%s
   --  ada.streams.stream_io%b
   --  system.secondary_stack%s
   --  system.file_io%b
   --  system.storage_pools.subpools%b
   --  system.finalization_masters%b
   --  system.regpat%b
   --  interfaces.c.strings%b
   --  interfaces.c%b
   --  ada.tags%b
   --  ada.strings.fixed%b
   --  ada.strings.maps%b
   --  ada.strings.hash_case_insensitive%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  ada.command_line%b
   --  ada.characters.handling%b
   --  system.secondary_stack%b
   --  gnat.directory_operations%b
   --  ada.calendar.formatting%b
   --  system.address_image%b
   --  ada.exceptions.traceback%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  ada.directories%s
   --  ada.directories.validity%s
   --  ada.directories.validity%b
   --  gnat.expect%s
   --  gnat.expect%b
   --  system.regexp%s
   --  system.regexp%b
   --  ada.directories%b
   --  system.strings.stream_ops%s
   --  system.strings.stream_ops%b
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  gnat.calendar.time_io%b
   --  gnat.traceback%s
   --  gnat.traceback%b
   --  system.interrupt_management.operations%s
   --  system.interrupt_management.operations%b
   --  ada_streams%s
   --  gnatcoll%s
   --  generic_scanner%s
   --  generic_scanner%b
   --  gmactextscan%s
   --  testgscan%b
   --  gnatcoll.mmap%s
   --  gnatcoll.mmap%b
   --  gnatcoll.utils%s
   --  gnatcoll.utils%b
   --  gnatcoll.vfs_types%s
   --  gnatcoll.io%s
   --  gnatcoll.io%b
   --  gnatcoll.path%s
   --  gnatcoll.path%b
   --  gnatcoll.io.native%s
   --  gnatcoll.io.native%b
   --  gnatcoll.remote%s
   --  gnatcoll.io.remote%s
   --  gnatcoll.io.remote.unix%s
   --  gnatcoll.io.remote.unix%b
   --  gnatcoll.io.remote.windows%s
   --  gnatcoll.io.remote.windows%b
   --  gnatcoll.remote.db%s
   --  gnatcoll.remote.db%b
   --  gnatcoll.io.remote%b
   --  gnatcoll.vfs%s
   --  gnatcoll.vfs%b
   --  gnatcoll.traces%s
   --  gnatcoll.vfs_utils%s
   --  gnatcoll.vfs_utils%b
   --  gnatcoll.traces%b
   --  posix%s
   --  posix.c%s
   --  posix.c%b
   --  posix.calendar%s
   --  posix.calendar%b
   --  posix.implementation%s
   --  posix.implementation%b
   --  posix%b
   --  posix.permissions%s
   --  posix.permissions.implementation%s
   --  posix.permissions.implementation%b
   --  posix.permissions%b
   --  posix.process_identification%s
   --  posix.process_identification%b
   --  posix.files%s
   --  posix.io%s
   --  posix.io%b
   --  posix.file_status%s
   --  posix.file_status%b
   --  posix.files%b
   --  posix.memory_mapping%s
   --  posix.memory_mapping%b
   --  gmactextscan%b
   --  END ELABORATION ORDER


end ada_main;
