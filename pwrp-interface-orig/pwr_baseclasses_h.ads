pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with pwr_h;
with pwr_class_h;
with System;

package pwr_baseclasses_h is


   pwr_cClass_Bi : constant := 135536;  --  pwr_baseclasses.h:965

   pwr_cClass_Bo : constant := 135544;  --  pwr_baseclasses.h:992

   pwr_cClass_CircBuffHeader : constant := 135824;  --  pwr_baseclasses.h:1019

   pwr_cClass_MultiViewElement : constant := 135912;  --  pwr_baseclasses.h:1037

   pwr_cClass_SymbolDefinition : constant := 135464;  --  pwr_baseclasses.h:1060

   pwr_cClass_aarithm : constant := 131088;  --  pwr_baseclasses.h:1076

   pwr_cClass_AArray100 : constant := 135280;  --  pwr_baseclasses.h:1133

   pwr_cClass_AArray500 : constant := 135312;  --  pwr_baseclasses.h:1148

   pwr_cClass_Abs : constant := 134128;  --  pwr_baseclasses.h:1163

   pwr_cClass_ACos : constant := 134152;  --  pwr_baseclasses.h:1189

   pwr_cClass_Add : constant := 134344;  --  pwr_baseclasses.h:1217

   pwr_cClass_adelay : constant := 131096;  --  pwr_baseclasses.h:1257

   pwr_cClass_Ai : constant := 131104;  --  pwr_baseclasses.h:1294

   pwr_cClass_AiArea : constant := 131136;  --  pwr_baseclasses.h:1328

   pwr_cClass_AlarmCategory : constant := 135496;  --  pwr_baseclasses.h:1343

   pwr_cClass_AlarmView : constant := 135488;  --  pwr_baseclasses.h:1361

   pwr_cClass_and : constant := 131144;  --  pwr_baseclasses.h:1377

   pwr_cClass_Ao : constant := 131152;  --  pwr_baseclasses.h:1417

   pwr_cClass_AoArea : constant := 131192;  --  pwr_baseclasses.h:1449

   pwr_cClass_ApCollect : constant := 133224;  --  pwr_baseclasses.h:1464

   pwr_cClass_ApDistribute : constant := 133232;  --  pwr_baseclasses.h:1539

   pwr_cClass_AppGraph : constant := 135960;  --  pwr_baseclasses.h:1589

   pwr_cClass_ApplDistribute : constant := 131208;  --  pwr_baseclasses.h:1607

   pwr_cClass_Application : constant := 133976;  --  pwr_baseclasses.h:1623

   pwr_cClass_AppLink : constant := 136000;  --  pwr_baseclasses.h:1648

   pwr_cClass_ASin : constant := 134144;  --  pwr_baseclasses.h:1665

   pwr_cClass_ASup : constant := 131216;  --  pwr_baseclasses.h:1693

   pwr_cClass_ASupComp : constant := 135976;  --  pwr_baseclasses.h:1761

   pwr_cClass_ASupCompFo : constant := 135992;  --  pwr_baseclasses.h:1818

   pwr_cClass_AtAdd : constant := 134736;  --  pwr_baseclasses.h:1851

   pwr_cClass_ATan : constant := 134160;  --  pwr_baseclasses.h:1879

   pwr_cClass_AtDtSub : constant := 134776;  --  pwr_baseclasses.h:1907

   pwr_cClass_AtEqual : constant := 134800;  --  pwr_baseclasses.h:1935

   pwr_cClass_AtGreaterThan : constant := 134808;  --  pwr_baseclasses.h:1963

   pwr_cClass_AtLessThan : constant := 134792;  --  pwr_baseclasses.h:1991

   pwr_cClass_AToDt : constant := 134840;  --  pwr_baseclasses.h:2019

   pwr_cClass_AtoFloat64 : constant := 135056;  --  pwr_baseclasses.h:2045

   pwr_cClass_AtoI : constant := 133816;  --  pwr_baseclasses.h:2071

   pwr_cClass_AtoStr : constant := 133536;  --  pwr_baseclasses.h:2097

   pwr_cClass_AtSub : constant := 134760;  --  pwr_baseclasses.h:2124

   pwr_cClass_ATv : constant := 134600;  --  pwr_baseclasses.h:2152

   pwr_cClass_Av : constant := 131224;  --  pwr_baseclasses.h:2168

   pwr_cClass_AvArea : constant := 131232;  --  pwr_baseclasses.h:2197

   pwr_cClass_Backup : constant := 131248;  --  pwr_baseclasses.h:2212

   pwr_cClass_Backup_Conf : constant := 131256;  --  pwr_baseclasses.h:2241

   pwr_cClass_BaseReg : constant := 134520;  --  pwr_baseclasses.h:2268

   pwr_cClass_bcddo : constant := 131264;  --  pwr_baseclasses.h:2285

   pwr_cClass_BiArea : constant := 135520;  --  pwr_baseclasses.h:2327

   pwr_cClass_BiFloatArray100 : constant := 135712;  --  pwr_baseclasses.h:2342

   pwr_cClass_BiFloatArray20 : constant := 135664;  --  pwr_baseclasses.h:2359

   pwr_cClass_BiIntArray100 : constant := 135720;  --  pwr_baseclasses.h:2376

   pwr_cClass_BiIntArray20 : constant := 135552;  --  pwr_baseclasses.h:2393

   pwr_cClass_BiString80 : constant := 135592;  --  pwr_baseclasses.h:2410

   pwr_cClass_BoArea : constant := 135528;  --  pwr_baseclasses.h:2427

   pwr_cClass_BodyText : constant := 131272;  --  pwr_baseclasses.h:2442

   pwr_cClass_BoFloatArray100 : constant := 135736;  --  pwr_baseclasses.h:2462

   pwr_cClass_BoFloatArray20 : constant := 135672;  --  pwr_baseclasses.h:2479

   pwr_cClass_BoIntArray100 : constant := 135728;  --  pwr_baseclasses.h:2496

   pwr_cClass_BoIntArray20 : constant := 135560;  --  pwr_baseclasses.h:2513

   pwr_cClass_BoString80 : constant := 135608;  --  pwr_baseclasses.h:2530

   pwr_cClass_BuildOptions : constant := 135424;  --  pwr_baseclasses.h:2547

   pwr_cClass_BusConfig : constant := 133968;  --  pwr_baseclasses.h:2566

   pwr_cClass_BwAnd : constant := 134392;  --  pwr_baseclasses.h:2583

   pwr_cClass_BwInv : constant := 135264;  --  pwr_baseclasses.h:2611

   pwr_cClass_BwOr : constant := 134400;  --  pwr_baseclasses.h:2637

   pwr_cClass_BwRotateLeft : constant := 135256;  --  pwr_baseclasses.h:2665

   pwr_cClass_BwRotateRight : constant := 135248;  --  pwr_baseclasses.h:2693

   pwr_cClass_BwShiftLeft : constant := 135232;  --  pwr_baseclasses.h:2721

   pwr_cClass_BwShiftRight : constant := 135240;  --  pwr_baseclasses.h:2749

   pwr_cClass_CaArea : constant := 131288;  --  pwr_baseclasses.h:2777

   pwr_cClass_CArea : constant := 134536;  --  pwr_baseclasses.h:2792

   pwr_cClass_carithm : constant := 131280;  --  pwr_baseclasses.h:2819

   pwr_cClass_ChanAi : constant := 131296;  --  pwr_baseclasses.h:2915

   pwr_cClass_ChanAit : constant := 131304;  --  pwr_baseclasses.h:2953

   pwr_cClass_ChanAo : constant := 131312;  --  pwr_baseclasses.h:2993

   pwr_cClass_ChanBi : constant := 135504;  --  pwr_baseclasses.h:3030

   pwr_cClass_ChanBiBlob : constant := 135800;  --  pwr_baseclasses.h:3068

   pwr_cClass_ChanBo : constant := 135512;  --  pwr_baseclasses.h:3085

   pwr_cClass_ChanBoBlob : constant := 135808;  --  pwr_baseclasses.h:3119

   pwr_cClass_ChanCo : constant := 131320;  --  pwr_baseclasses.h:3136

   pwr_cClass_ChanCot : constant := 131328;  --  pwr_baseclasses.h:3167

   pwr_cClass_ChanD : constant := 135792;  --  pwr_baseclasses.h:3203

   pwr_cClass_ChanDi : constant := 131336;  --  pwr_baseclasses.h:3228

   pwr_cClass_ChanDo : constant := 131344;  --  pwr_baseclasses.h:3249

   pwr_cClass_ChanIi : constant := 133648;  --  pwr_baseclasses.h:3272

   pwr_cClass_ChanIo : constant := 133656;  --  pwr_baseclasses.h:3292

   pwr_cClass_CircBuff100k : constant := 135856;  --  pwr_baseclasses.h:3314

   pwr_cClass_CircBuff10k : constant := 135840;  --  pwr_baseclasses.h:3330

   pwr_cClass_CircBuff1k : constant := 135832;  --  pwr_baseclasses.h:3346

   pwr_cClass_CircBuff200k : constant := 135864;  --  pwr_baseclasses.h:3362

   pwr_cClass_CircBuff20k : constant := 135848;  --  pwr_baseclasses.h:3378

   pwr_cClass_CircBuff2k : constant := 135872;  --  pwr_baseclasses.h:3394

   pwr_cClass_ClassVolumeConfig : constant := 131352;  --  pwr_baseclasses.h:3410

   pwr_cClass_ClassVolumeLoad : constant := 131360;  --  pwr_baseclasses.h:3421

   pwr_cClass_CloneVolumeConfig : constant := 135904;  --  pwr_baseclasses.h:3436

   pwr_cClass_Co : constant := 131368;  --  pwr_baseclasses.h:3452

   pwr_cClass_CoArea : constant := 131656;  --  pwr_baseclasses.h:3483

   pwr_cClass_CommonClassDistribute : constant := 131376;  --  pwr_baseclasses.h:3498

   pwr_cClass_comph : constant := 131384;  --  pwr_baseclasses.h:3513

   pwr_cClass_compl : constant := 131392;  --  pwr_baseclasses.h:3548

   pwr_cClass_ConAnalog : constant := 131400;  --  pwr_baseclasses.h:3583

   pwr_cClass_ConBlueStrOneArr : constant := 131408;  --  pwr_baseclasses.h:3598

   pwr_cClass_ConDaMeNoArr : constant := 131416;  --  pwr_baseclasses.h:3613

   pwr_cClass_ConDaMeOneArr : constant := 131424;  --  pwr_baseclasses.h:3628

   pwr_cClass_ConDaMeTwoArr : constant := 131432;  --  pwr_baseclasses.h:3643

   pwr_cClass_ConData : constant := 131440;  --  pwr_baseclasses.h:3658

   pwr_cClass_ConDataFeedback : constant := 131448;  --  pwr_baseclasses.h:3673

   pwr_cClass_ConDaThinNoArr : constant := 131456;  --  pwr_baseclasses.h:3688

   pwr_cClass_ConDaThinOneArr : constant := 131464;  --  pwr_baseclasses.h:3703

   pwr_cClass_ConDaThinTwoArr : constant := 131472;  --  pwr_baseclasses.h:3718

   pwr_cClass_ConDigital : constant := 131480;  --  pwr_baseclasses.h:3733

   pwr_cClass_ConExecuteOrder : constant := 131488;  --  pwr_baseclasses.h:3748

   pwr_cClass_ConFeedbackAnalog : constant := 131496;  --  pwr_baseclasses.h:3763

   pwr_cClass_ConFeedbackDigital : constant := 131504;  --  pwr_baseclasses.h:3778

   pwr_cClass_ConGrafcet : constant := 131512;  --  pwr_baseclasses.h:3793

   pwr_cClass_ConGreenTwoArr : constant := 131520;  --  pwr_baseclasses.h:3808

   pwr_cClass_ConMeNoArr : constant := 131528;  --  pwr_baseclasses.h:3823

   pwr_cClass_ConMeOneArr : constant := 131536;  --  pwr_baseclasses.h:3838

   pwr_cClass_ConMeTwoArr : constant := 131544;  --  pwr_baseclasses.h:3853

   pwr_cClass_ConReMeNoArr : constant := 131552;  --  pwr_baseclasses.h:3868

   pwr_cClass_ConReMeOneArr : constant := 131560;  --  pwr_baseclasses.h:3883

   pwr_cClass_ConReMeTwoArr : constant := 131568;  --  pwr_baseclasses.h:3898

   pwr_cClass_ConstAv : constant := 135928;  --  pwr_baseclasses.h:3913

   pwr_cClass_ConstIv : constant := 135936;  --  pwr_baseclasses.h:3933

   pwr_cClass_ConStrMeNoArr : constant := 131576;  --  pwr_baseclasses.h:3952

   pwr_cClass_ConThinNoArr : constant := 131584;  --  pwr_baseclasses.h:3967

   pwr_cClass_ConThinOneArr : constant := 131592;  --  pwr_baseclasses.h:3982

   pwr_cClass_ConThinTwoArr : constant := 131600;  --  pwr_baseclasses.h:3997

   pwr_cClass_ConTrace : constant := 131608;  --  pwr_baseclasses.h:4012

   pwr_cClass_corder : constant := 131616;  --  pwr_baseclasses.h:4027

   pwr_cClass_Cos : constant := 134104;  --  pwr_baseclasses.h:4043

   pwr_cClass_count : constant := 131624;  --  pwr_baseclasses.h:4071

   pwr_cClass_CStoAattr : constant := 133904;  --  pwr_baseclasses.h:4110

   pwr_cClass_cstoai : constant := 131664;  --  pwr_baseclasses.h:4131

   pwr_cClass_cstoao : constant := 131672;  --  pwr_baseclasses.h:4163

   pwr_cClass_cstoap : constant := 131680;  --  pwr_baseclasses.h:4188

   pwr_cClass_CStoAtoIp : constant := 131696;  --  pwr_baseclasses.h:4210

   pwr_cClass_CStoATp : constant := 134688;  --  pwr_baseclasses.h:4232

   pwr_cClass_CStoAttrRefP : constant := 134560;  --  pwr_baseclasses.h:4254

   pwr_cClass_CStoATv : constant := 134672;  --  pwr_baseclasses.h:4283

   pwr_cClass_cstoav : constant := 131688;  --  pwr_baseclasses.h:4305

   pwr_cClass_CStoBiFloat32 : constant := 135784;  --  pwr_baseclasses.h:4327

   pwr_cClass_CStoBiInt32 : constant := 135744;  --  pwr_baseclasses.h:4359

   pwr_cClass_CStoBiString80 : constant := 135768;  --  pwr_baseclasses.h:4391

   pwr_cClass_CStoBoFloat32 : constant := 135760;  --  pwr_baseclasses.h:4416

   pwr_cClass_CStoBoInt32 : constant := 135752;  --  pwr_baseclasses.h:4448

   pwr_cClass_CStoBoString80 : constant := 135776;  --  pwr_baseclasses.h:4480

   pwr_cClass_CStoDTp : constant := 134696;  --  pwr_baseclasses.h:4505

   pwr_cClass_CStoDTv : constant := 134680;  --  pwr_baseclasses.h:4527

   pwr_cClass_CStoExtBoolean : constant := 135032;  --  pwr_baseclasses.h:4549

   pwr_cClass_CStoExtFloat32 : constant := 134872;  --  pwr_baseclasses.h:4579

   pwr_cClass_CStoExtFloat64 : constant := 135112;  --  pwr_baseclasses.h:4609

   pwr_cClass_CStoExtInt16 : constant := 134992;  --  pwr_baseclasses.h:4639

   pwr_cClass_CStoExtInt32 : constant := 134888;  --  pwr_baseclasses.h:4669

   pwr_cClass_CStoExtInt64 : constant := 134904;  --  pwr_baseclasses.h:4699

   pwr_cClass_CStoExtInt8 : constant := 135008;  --  pwr_baseclasses.h:4729

   pwr_cClass_CStoExtString : constant := 135000;  --  pwr_baseclasses.h:4759

   pwr_cClass_CStoExtTime : constant := 135040;  --  pwr_baseclasses.h:4789

   pwr_cClass_CStoExtUInt16 : constant := 134984;  --  pwr_baseclasses.h:4819

   pwr_cClass_CStoExtUInt32 : constant := 134976;  --  pwr_baseclasses.h:4849

   pwr_cClass_CStoExtUInt64 : constant := 135024;  --  pwr_baseclasses.h:4879

   pwr_cClass_CStoExtUInt8 : constant := 135016;  --  pwr_baseclasses.h:4909

   pwr_cClass_CStoIattr : constant := 133912;  --  pwr_baseclasses.h:4939

   pwr_cClass_cstoii : constant := 133752;  --  pwr_baseclasses.h:4960

   pwr_cClass_cstoio : constant := 133760;  --  pwr_baseclasses.h:4992

   pwr_cClass_CStoIp : constant := 133800;  --  pwr_baseclasses.h:5017

   pwr_cClass_cstoiv : constant := 133768;  --  pwr_baseclasses.h:5039

   pwr_cClass_cstonumsp : constant := 134064;  --  pwr_baseclasses.h:5061

   pwr_cClass_CStoSattr : constant := 133928;  --  pwr_baseclasses.h:5084

   pwr_cClass_cstosp : constant := 133560;  --  pwr_baseclasses.h:5105

   pwr_cClass_cstosv : constant := 133512;  --  pwr_baseclasses.h:5127

   pwr_cClass_csub : constant := 131704;  --  pwr_baseclasses.h:5149

   pwr_cClass_CurrentTime : constant := 134848;  --  pwr_baseclasses.h:5174

   pwr_cClass_curve : constant := 131712;  --  pwr_baseclasses.h:5198

   pwr_cClass_CustomBuild : constant := 135408;  --  pwr_baseclasses.h:5226

   pwr_cClass_CycleSup : constant := 133320;  --  pwr_baseclasses.h:5246

   pwr_cClass_darithm : constant := 131728;  --  pwr_baseclasses.h:5309

   pwr_cClass_DArray100 : constant := 135288;  --  pwr_baseclasses.h:5366

   pwr_cClass_DArray500 : constant := 135320;  --  pwr_baseclasses.h:5381

   pwr_cClass_dataarithm : constant := 133240;  --  pwr_baseclasses.h:5396

   pwr_cClass_dataarithml : constant := 135880;  --  pwr_baseclasses.h:5490

   pwr_cClass_DataCollect : constant := 133248;  --  pwr_baseclasses.h:5584

   pwr_cClass_DbConfig : constant := 131736;  --  pwr_baseclasses.h:5660

   pwr_cClass_Demux : constant := 135216;  --  pwr_baseclasses.h:5676

   pwr_cClass_DetachedClassVolumeConfig : constant := 135368;  --  pwr_baseclasses.h:5727

   pwr_cClass_DetachedClassVolumeLoad : constant := 135376;  --  pwr_baseclasses.h:5738

   pwr_cClass_Di : constant := 131760;  --  pwr_baseclasses.h:5753

   pwr_cClass_DiArea : constant := 131808;  --  pwr_baseclasses.h:5782

   pwr_cClass_dibcd : constant := 131768;  --  pwr_baseclasses.h:5797

   pwr_cClass_Disabled : constant := 134544;  --  pwr_baseclasses.h:5855

   pwr_cClass_DiskSup : constant := 134408;  --  pwr_baseclasses.h:5877

   pwr_cClass_Distribute : constant := 133640;  --  pwr_baseclasses.h:5903

   pwr_cClass_Div : constant := 134328;  --  pwr_baseclasses.h:5918

   pwr_cClass_Do : constant := 131816;  --  pwr_baseclasses.h:5946

   pwr_cClass_DoArea : constant := 131880;  --  pwr_baseclasses.h:5973

   pwr_cClass_Document : constant := 131824;  --  pwr_baseclasses.h:5988

   pwr_cClass_DocUser1 : constant := 131832;  --  pwr_baseclasses.h:6007

   pwr_cClass_DocUser2 : constant := 131840;  --  pwr_baseclasses.h:6026

   pwr_cClass_dorder : constant := 131848;  --  pwr_baseclasses.h:6045

   pwr_cClass_DpCollect : constant := 133256;  --  pwr_baseclasses.h:6071

   pwr_cClass_DpDistribute : constant := 133264;  --  pwr_baseclasses.h:6146

   pwr_cClass_drive : constant := 131896;  --  pwr_baseclasses.h:6196

   pwr_cClass_DsFast : constant := 131904;  --  pwr_baseclasses.h:6259

   pwr_cClass_DsFastConf : constant := 131912;  --  pwr_baseclasses.h:6296

   pwr_cClass_DsFastCurve : constant := 133616;  --  pwr_baseclasses.h:6311

   pwr_cClass_DsTrend : constant := 131936;  --  pwr_baseclasses.h:6349

   pwr_cClass_DsTrendConf : constant := 131944;  --  pwr_baseclasses.h:6381

   pwr_cClass_DsTrendCurve : constant := 135816;  --  pwr_baseclasses.h:6396

   pwr_cClass_DSup : constant := 131952;  --  pwr_baseclasses.h:6427

   pwr_cClass_DSupComp : constant := 135968;  --  pwr_baseclasses.h:6492

   pwr_cClass_DSupCompFo : constant := 135984;  --  pwr_baseclasses.h:6546

   pwr_cClass_DtAdd : constant := 134744;  --  pwr_baseclasses.h:6579

   pwr_cClass_DtEqual : constant := 134816;  --  pwr_baseclasses.h:6607

   pwr_cClass_DtGreaterThan : constant := 134832;  --  pwr_baseclasses.h:6635

   pwr_cClass_DtLessThan : constant := 134824;  --  pwr_baseclasses.h:6663

   pwr_cClass_DtoEnum : constant := 133848;  --  pwr_baseclasses.h:6691

   pwr_cClass_DtoMask : constant := 133832;  --  pwr_baseclasses.h:6781

   pwr_cClass_DtoStr : constant := 133576;  --  pwr_baseclasses.h:6869

   pwr_cClass_DtSub : constant := 134768;  --  pwr_baseclasses.h:6896

   pwr_cClass_DtToA : constant := 134784;  --  pwr_baseclasses.h:6924

   pwr_cClass_DTv : constant := 134608;  --  pwr_baseclasses.h:6950

   pwr_cClass_Dv : constant := 131960;  --  pwr_baseclasses.h:6966

   pwr_cClass_DvArea : constant := 131968;  --  pwr_baseclasses.h:6991

   pwr_cClass_edge : constant := 131984;  --  pwr_baseclasses.h:7006

   pwr_cClass_EnumToD : constant := 133856;  --  pwr_baseclasses.h:7033

   pwr_cClass_EnumToStr : constant := 135416;  --  pwr_baseclasses.h:7091

   pwr_cClass_Equal : constant := 134424;  --  pwr_baseclasses.h:7120

   pwr_cClass_Even : constant := 134184;  --  pwr_baseclasses.h:7148

   pwr_cClass_EventPrinter : constant := 131992;  --  pwr_baseclasses.h:7174

   pwr_cClass_Exp : constant := 134368;  --  pwr_baseclasses.h:7192

   pwr_cClass_ExternRef : constant := 132000;  --  pwr_baseclasses.h:7220

   pwr_cClass_ExternVolumeConfig : constant := 134488;  --  pwr_baseclasses.h:7237

   pwr_cClass_False : constant := 135600;  --  pwr_baseclasses.h:7254

   pwr_cClass_filter : constant := 132008;  --  pwr_baseclasses.h:7278

   pwr_cClass_FirstScan : constant := 134080;  --  pwr_baseclasses.h:7311

   pwr_cClass_Float64toA : constant := 135048;  --  pwr_baseclasses.h:7335

   pwr_cClass_Form : constant := 132016;  --  pwr_baseclasses.h:7361

   pwr_cClass_Frame : constant := 132024;  --  pwr_baseclasses.h:7382

   pwr_cClass_FriendNodeConfig : constant := 133360;  --  pwr_baseclasses.h:7402

   pwr_cClass_GetAattr : constant := 133944;  --  pwr_baseclasses.h:7424

   pwr_cClass_GetAgeneric : constant := 133352;  --  pwr_baseclasses.h:7445

   pwr_cClass_GetAi : constant := 132032;  --  pwr_baseclasses.h:7461

   pwr_cClass_GetAo : constant := 132040;  --  pwr_baseclasses.h:7486

   pwr_cClass_GetAp : constant := 132048;  --  pwr_baseclasses.h:7511

   pwr_cClass_GetApPtr : constant := 135160;  --  pwr_baseclasses.h:7533

   pwr_cClass_GetATgeneric : constant := 134728;  --  pwr_baseclasses.h:7560

   pwr_cClass_GetATp : constant := 134632;  --  pwr_baseclasses.h:7576

   pwr_cClass_GetATv : constant := 134616;  --  pwr_baseclasses.h:7598

   pwr_cClass_GetAv : constant := 132056;  --  pwr_baseclasses.h:7620

   pwr_cClass_GetBiFloat32 : constant := 135648;  --  pwr_baseclasses.h:7642

   pwr_cClass_GetBiInt32 : constant := 135568;  --  pwr_baseclasses.h:7667

   pwr_cClass_GetBiString80 : constant := 135680;  --  pwr_baseclasses.h:7692

   pwr_cClass_GetBoFloat32 : constant := 135656;  --  pwr_baseclasses.h:7717

   pwr_cClass_GetBoInt32 : constant := 135624;  --  pwr_baseclasses.h:7742

   pwr_cClass_GetBoString80 : constant := 135696;  --  pwr_baseclasses.h:7767

   pwr_cClass_GetConstAv : constant := 135944;  --  pwr_baseclasses.h:7792

   pwr_cClass_GetConstIv : constant := 135952;  --  pwr_baseclasses.h:7814

   pwr_cClass_GetData : constant := 133272;  --  pwr_baseclasses.h:7836

   pwr_cClass_GetDataInput : constant := 135336;  --  pwr_baseclasses.h:7863

   pwr_cClass_GetDatap : constant := 134856;  --  pwr_baseclasses.h:7890

   pwr_cClass_GetDattr : constant := 133936;  --  pwr_baseclasses.h:7917

   pwr_cClass_GetDgeneric : constant := 133328;  --  pwr_baseclasses.h:7938

   pwr_cClass_GetDi : constant := 132064;  --  pwr_baseclasses.h:7954

   pwr_cClass_GetDo : constant := 132072;  --  pwr_baseclasses.h:7979

   pwr_cClass_GetDp : constant := 132080;  --  pwr_baseclasses.h:8004

   pwr_cClass_GetDpPtr : constant := 135152;  --  pwr_baseclasses.h:8026

   pwr_cClass_GetDTgeneric : constant := 134704;  --  pwr_baseclasses.h:8053

   pwr_cClass_GetDTp : constant := 134640;  --  pwr_baseclasses.h:8069

   pwr_cClass_GetDTv : constant := 134624;  --  pwr_baseclasses.h:8091

   pwr_cClass_GetDv : constant := 132088;  --  pwr_baseclasses.h:8113

   pwr_cClass_GetExtBoolean : constant := 134952;  --  pwr_baseclasses.h:8135

   pwr_cClass_GetExtFloat32 : constant := 134864;  --  pwr_baseclasses.h:8161

   pwr_cClass_GetExtFloat64 : constant := 135120;  --  pwr_baseclasses.h:8187

   pwr_cClass_GetExtInt16 : constant := 134936;  --  pwr_baseclasses.h:8213

   pwr_cClass_GetExtInt32 : constant := 134880;  --  pwr_baseclasses.h:8239

   pwr_cClass_GetExtInt64 : constant := 134896;  --  pwr_baseclasses.h:8265

   pwr_cClass_GetExtInt8 : constant := 134928;  --  pwr_baseclasses.h:8291

   pwr_cClass_GetExtString : constant := 134968;  --  pwr_baseclasses.h:8317

   pwr_cClass_GetExtTime : constant := 134960;  --  pwr_baseclasses.h:8343

   pwr_cClass_GetExtUInt16 : constant := 134920;  --  pwr_baseclasses.h:8369

   pwr_cClass_GetExtUInt32 : constant := 134912;  --  pwr_baseclasses.h:8395

   pwr_cClass_GetExtUInt64 : constant := 135128;  --  pwr_baseclasses.h:8421

   pwr_cClass_GetExtUInt8 : constant := 134944;  --  pwr_baseclasses.h:8447

   pwr_cClass_GetIattr : constant := 133952;  --  pwr_baseclasses.h:8473

   pwr_cClass_GetIgeneric : constant := 133776;  --  pwr_baseclasses.h:8494

   pwr_cClass_GetIi : constant := 133712;  --  pwr_baseclasses.h:8510

   pwr_cClass_GetIo : constant := 133720;  --  pwr_baseclasses.h:8535

   pwr_cClass_GetIp : constant := 133792;  --  pwr_baseclasses.h:8560

   pwr_cClass_GetIpPtr : constant := 135168;  --  pwr_baseclasses.h:8586

   pwr_cClass_GetIpToA : constant := 132096;  --  pwr_baseclasses.h:8613

   pwr_cClass_GetIv : constant := 133704;  --  pwr_baseclasses.h:8639

   pwr_cClass_GetPi : constant := 132104;  --  pwr_baseclasses.h:8661

   pwr_cClass_GetSattr : constant := 133960;  --  pwr_baseclasses.h:8686

   pwr_cClass_GetSgeneric : constant := 133592;  --  pwr_baseclasses.h:8707

   pwr_cClass_GetSp : constant := 133544;  --  pwr_baseclasses.h:8723

   pwr_cClass_GetSv : constant := 133504;  --  pwr_baseclasses.h:8745

   pwr_cClass_Graph : constant := 132112;  --  pwr_baseclasses.h:8767

   pwr_cClass_GraphDistribute : constant := 132120;  --  pwr_baseclasses.h:8797

   pwr_cClass_gray : constant := 132128;  --  pwr_baseclasses.h:8813

   pwr_cClass_GreaterEqual : constant := 134432;  --  pwr_baseclasses.h:8870

   pwr_cClass_GreaterThan : constant := 134440;  --  pwr_baseclasses.h:8898

   pwr_cClass_Group : constant := 132136;  --  pwr_baseclasses.h:8926

   pwr_cClass_Head : constant := 132144;  --  pwr_baseclasses.h:8942

   pwr_cClass_IAbs : constant := 134168;  --  pwr_baseclasses.h:8962

   pwr_cClass_IAdd : constant := 134240;  --  pwr_baseclasses.h:8988

   pwr_cClass_IArray100 : constant := 135272;  --  pwr_baseclasses.h:9028

   pwr_cClass_IArray500 : constant := 135304;  --  pwr_baseclasses.h:9043

   pwr_cClass_IDemux : constant := 135224;  --  pwr_baseclasses.h:9058

   pwr_cClass_IDiv : constant := 134264;  --  pwr_baseclasses.h:9109

   pwr_cClass_IEqual : constant := 134200;  --  pwr_baseclasses.h:9137

   pwr_cClass_IGreaterEqual : constant := 134208;  --  pwr_baseclasses.h:9165

   pwr_cClass_IGreaterThan : constant := 134216;  --  pwr_baseclasses.h:9193

   pwr_cClass_Ii : constant := 133664;  --  pwr_baseclasses.h:9221

   pwr_cClass_IiArea : constant := 133696;  --  pwr_baseclasses.h:9249

   pwr_cClass_ILessEqual : constant := 134224;  --  pwr_baseclasses.h:9264

   pwr_cClass_ILessThan : constant := 134232;  --  pwr_baseclasses.h:9292

   pwr_cClass_ILimit : constant := 134296;  --  pwr_baseclasses.h:9320

   pwr_cClass_IMax : constant := 134272;  --  pwr_baseclasses.h:9352

   pwr_cClass_IMin : constant := 134280;  --  pwr_baseclasses.h:9392

   pwr_cClass_IMul : constant := 134248;  --  pwr_baseclasses.h:9432

   pwr_cClass_IMux : constant := 134304;  --  pwr_baseclasses.h:9472

   pwr_cClass_inc3p : constant := 132152;  --  pwr_baseclasses.h:9546

   pwr_cClass_InitArea : constant := 135392;  --  pwr_baseclasses.h:9590

   pwr_cClass_initstep : constant := 132160;  --  pwr_baseclasses.h:9605

   pwr_cClass_INotEqual : constant := 134472;  --  pwr_baseclasses.h:9633

   pwr_cClass_Int64toI : constant := 135096;  --  pwr_baseclasses.h:9661

   pwr_cClass_inv : constant := 132168;  --  pwr_baseclasses.h:9687

   pwr_cClass_Io : constant := 133672;  --  pwr_baseclasses.h:9713

   pwr_cClass_IoArea : constant := 133688;  --  pwr_baseclasses.h:9741

   pwr_cClass_IOHandler : constant := 132176;  --  pwr_baseclasses.h:9756

   pwr_cClass_IpCollect : constant := 135200;  --  pwr_baseclasses.h:9788

   pwr_cClass_IpDistribute : constant := 135208;  --  pwr_baseclasses.h:9863

   pwr_cClass_ISel : constant := 134288;  --  pwr_baseclasses.h:9913

   pwr_cClass_ISub : constant := 134256;  --  pwr_baseclasses.h:9943

   pwr_cClass_ItoA : constant := 133824;  --  pwr_baseclasses.h:9971

   pwr_cClass_ItoInt64 : constant := 135088;  --  pwr_baseclasses.h:9997

   pwr_cClass_ItoStr : constant := 133568;  --  pwr_baseclasses.h:10023

   pwr_cClass_ItoUInt32 : constant := 135072;  --  pwr_baseclasses.h:10050

   pwr_cClass_ItoUInt64 : constant := 135080;  --  pwr_baseclasses.h:10076

   pwr_cClass_Iv : constant := 133680;  --  pwr_baseclasses.h:10102

   pwr_cClass_IvArea : constant := 133312;  --  pwr_baseclasses.h:10129

   pwr_cClass_LessEqual : constant := 134448;  --  pwr_baseclasses.h:10144

   pwr_cClass_LessThan : constant := 134456;  --  pwr_baseclasses.h:10172

   pwr_cClass_limit : constant := 132192;  --  pwr_baseclasses.h:10200

   pwr_cClass_ListConfig : constant := 133152;  --  pwr_baseclasses.h:10238

   pwr_cClass_ListDescriptor : constant := 132216;  --  pwr_baseclasses.h:10254

   pwr_cClass_Ln : constant := 134352;  --  pwr_baseclasses.h:10398

   pwr_cClass_LocalTime : constant := 135400;  --  pwr_baseclasses.h:10426

   pwr_cClass_Log : constant := 134360;  --  pwr_baseclasses.h:10459

   pwr_cClass_lorder : constant := 132224;  --  pwr_baseclasses.h:10487

   pwr_cClass_MaskToD : constant := 133840;  --  pwr_baseclasses.h:10513

   pwr_cClass_Max : constant := 134384;  --  pwr_baseclasses.h:10570

   pwr_cClass_maxmin : constant := 132232;  --  pwr_baseclasses.h:10610

   pwr_cClass_MessageHandler : constant := 132240;  --  pwr_baseclasses.h:10651

   pwr_cClass_Min : constant := 134376;  --  pwr_baseclasses.h:10686

   pwr_cClass_Mod : constant := 134136;  --  pwr_baseclasses.h:10726

   pwr_cClass_mode : constant := 132248;  --  pwr_baseclasses.h:10754

   pwr_cClass_Mul : constant := 134320;  --  pwr_baseclasses.h:10810

   pwr_cClass_Mux : constant := 134312;  --  pwr_baseclasses.h:10850

   pwr_cClass_mvalve : constant := 132344;  --  pwr_baseclasses.h:10924

   pwr_cClass_NameToStr : constant := 134088;  --  pwr_baseclasses.h:11005

   pwr_cClass_NodeConfig : constant := 132352;  --  pwr_baseclasses.h:11031

   pwr_cClass_NodeLinkSup : constant := 132360;  --  pwr_baseclasses.h:11058

   pwr_cClass_NotEqual : constant := 134464;  --  pwr_baseclasses.h:11117

   pwr_cClass_Odd : constant := 134192;  --  pwr_baseclasses.h:11145

   pwr_cClass_OidArray100 : constant := 135440;  --  pwr_baseclasses.h:11171

   pwr_cClass_OpAppl : constant := 132368;  --  pwr_baseclasses.h:11186

   pwr_cClass_OpApplMsg : constant := 132376;  --  pwr_baseclasses.h:11205

   pwr_cClass_OpPlace : constant := 132384;  --  pwr_baseclasses.h:11223

   pwr_cClass_or : constant := 132392;  --  pwr_baseclasses.h:11261

   pwr_cClass_order : constant := 132400;  --  pwr_baseclasses.h:11301

   pwr_cClass_OrderAct : constant := 132408;  --  pwr_baseclasses.h:11342

   pwr_cClass_out2p : constant := 132416;  --  pwr_baseclasses.h:11367

   pwr_cClass_PackAttrRef : constant := 132424;  --  pwr_baseclasses.h:11398

   pwr_cClass_PackAttrRef10 : constant := 132432;  --  pwr_baseclasses.h:11414

   pwr_cClass_PackOperator : constant := 132440;  --  pwr_baseclasses.h:11430

   pwr_cClass_PackTest : constant := 132448;  --  pwr_baseclasses.h:11445

   pwr_cClass_PageRef : constant := 133144;  --  pwr_baseclasses.h:11465

   pwr_cClass_Pd_7435_26 : constant := 132456;  --  pwr_baseclasses.h:11481

   pwr_cClass_pid : constant := 132464;  --  pwr_baseclasses.h:11518

   pwr_cClass_pipos : constant := 132472;  --  pwr_baseclasses.h:11595

   pwr_cClass_pispeed : constant := 132480;  --  pwr_baseclasses.h:11643

   pwr_cClass_plc : constant := 132488;  --  pwr_baseclasses.h:11672

   pwr_cClass_PlcProcess : constant := 133304;  --  pwr_baseclasses.h:11701

   pwr_cClass_PlcTemplate : constant := 134072;  --  pwr_baseclasses.h:11738

   pwr_cClass_PlcThread : constant := 133160;  --  pwr_baseclasses.h:11761

   pwr_cClass_PlotGroup : constant := 132496;  --  pwr_baseclasses.h:11811

   pwr_cClass_Po : constant := 132504;  --  pwr_baseclasses.h:11841

   pwr_cClass_Point : constant := 132512;  --  pwr_baseclasses.h:11871

   pwr_cClass_porder : constant := 132520;  --  pwr_baseclasses.h:11888

   pwr_cClass_pos3p : constant := 132528;  --  pwr_baseclasses.h:11904

   pwr_cClass_posit : constant := 132536;  --  pwr_baseclasses.h:11947

   pwr_cClass_PostConfig : constant := 135456;  --  pwr_baseclasses.h:12002

   pwr_cClass_ProjectReg : constant := 134528;  --  pwr_baseclasses.h:12026

   pwr_cClass_pulse : constant := 132544;  --  pwr_baseclasses.h:12045

   pwr_cClass_PulseTrain : constant := 135432;  --  pwr_baseclasses.h:12083

   pwr_cClass_Queue : constant := 132552;  --  pwr_baseclasses.h:12120

   pwr_cClass_ramp : constant := 132584;  --  pwr_baseclasses.h:12136

   pwr_cClass_Report : constant := 135480;  --  pwr_baseclasses.h:12174

   pwr_cClass_ReportConfig : constant := 135472;  --  pwr_baseclasses.h:12202

   pwr_cClass_ResDattr : constant := 133880;  --  pwr_baseclasses.h:12227

   pwr_cClass_resdi : constant := 132592;  --  pwr_baseclasses.h:12248

   pwr_cClass_resdo : constant := 132600;  --  pwr_baseclasses.h:12278

   pwr_cClass_resdp : constant := 132608;  --  pwr_baseclasses.h:12303

   pwr_cClass_resdv : constant := 132616;  --  pwr_baseclasses.h:12325

   pwr_cClass_reset_so : constant := 132624;  --  pwr_baseclasses.h:12347

   pwr_cClass_RootVolumeConfig : constant := 132632;  --  pwr_baseclasses.h:12373

   pwr_cClass_RootVolumeLoad : constant := 132640;  --  pwr_baseclasses.h:12390

   pwr_cClass_RttConfig : constant := 133280;  --  pwr_baseclasses.h:12405

   pwr_cClass_SArray100 : constant := 135296;  --  pwr_baseclasses.h:12430

   pwr_cClass_SArray500 : constant := 135328;  --  pwr_baseclasses.h:12445

   pwr_cClass_ScanTime : constant := 133296;  --  pwr_baseclasses.h:12460

   pwr_cClass_select : constant := 132664;  --  pwr_baseclasses.h:12485

   pwr_cClass_setcond : constant := 132672;  --  pwr_baseclasses.h:12523

   pwr_cClass_SetDattr : constant := 133872;  --  pwr_baseclasses.h:12548

   pwr_cClass_setdi : constant := 132680;  --  pwr_baseclasses.h:12569

   pwr_cClass_setdo : constant := 132688;  --  pwr_baseclasses.h:12599

   pwr_cClass_setdp : constant := 132696;  --  pwr_baseclasses.h:12624

   pwr_cClass_setdv : constant := 132704;  --  pwr_baseclasses.h:12646

   pwr_cClass_SevHist : constant := 131920;  --  pwr_baseclasses.h:12668

   pwr_cClass_SevHistEvents : constant := 135896;  --  pwr_baseclasses.h:12691

   pwr_cClass_SevHistMonitor : constant := 135344;  --  pwr_baseclasses.h:12712

   pwr_cClass_SevHistObject : constant := 135384;  --  pwr_baseclasses.h:12730

   pwr_cClass_SevHistThread : constant := 131928;  --  pwr_baseclasses.h:12753

   pwr_cClass_SevNodeConfig : constant := 135360;  --  pwr_baseclasses.h:12775

   pwr_cClass_SevServer : constant := 135352;  --  pwr_baseclasses.h:12800

   pwr_cClass_SharedVolumeConfig : constant := 132712;  --  pwr_baseclasses.h:12816

   pwr_cClass_SharedVolumeLoad : constant := 132720;  --  pwr_baseclasses.h:12833

   pwr_cClass_ShowPlcAttr : constant := 132728;  --  pwr_baseclasses.h:12848

   pwr_cClass_SimulateConfig : constant := 135888;  --  pwr_baseclasses.h:12866

   pwr_cClass_Sin : constant := 134096;  --  pwr_baseclasses.h:12912

   pwr_cClass_sorder : constant := 132736;  --  pwr_baseclasses.h:12940

   pwr_cClass_Sound : constant := 134576;  --  pwr_baseclasses.h:12957

   pwr_cClass_SoundSeqElem : constant := 134592;  --  pwr_baseclasses.h:12984

   pwr_cClass_SoundSequence : constant := 134584;  --  pwr_baseclasses.h:13005

   pwr_cClass_speed : constant := 132744;  --  pwr_baseclasses.h:13025

   pwr_cClass_Sqrt : constant := 134120;  --  pwr_baseclasses.h:13053

   pwr_cClass_sr_r : constant := 132760;  --  pwr_baseclasses.h:13081

   pwr_cClass_sr_s : constant := 132768;  --  pwr_baseclasses.h:13110

   pwr_cClass_ssbegin : constant := 132776;  --  pwr_baseclasses.h:13139

   pwr_cClass_ssend : constant := 132784;  --  pwr_baseclasses.h:13165

   pwr_cClass_StatusServerConfig : constant := 135136;  --  pwr_baseclasses.h:13190

   pwr_cClass_step : constant := 132792;  --  pwr_baseclasses.h:13207

   pwr_cClass_StepConv : constant := 132800;  --  pwr_baseclasses.h:13233

   pwr_cClass_StepDiv : constant := 132808;  --  pwr_baseclasses.h:13248

   pwr_cClass_StoAattr : constant := 133896;  --  pwr_baseclasses.h:13263

   pwr_cClass_StoAgeneric : constant := 133336;  --  pwr_baseclasses.h:13284

   pwr_cClass_stoai : constant := 132816;  --  pwr_baseclasses.h:13301

   pwr_cClass_stoao : constant := 132824;  --  pwr_baseclasses.h:13331

   pwr_cClass_stoap : constant := 132832;  --  pwr_baseclasses.h:13356

   pwr_cClass_StoApPtr : constant := 135184;  --  pwr_baseclasses.h:13378

   pwr_cClass_StoATgeneric : constant := 134712;  --  pwr_baseclasses.h:13406

   pwr_cClass_StoAtoIp : constant := 132880;  --  pwr_baseclasses.h:13423

   pwr_cClass_StoATp : constant := 134664;  --  pwr_baseclasses.h:13445

   pwr_cClass_StoATv : constant := 134648;  --  pwr_baseclasses.h:13467

   pwr_cClass_stoav : constant := 132840;  --  pwr_baseclasses.h:13489

   pwr_cClass_StoBiFloat32 : constant := 135632;  --  pwr_baseclasses.h:13511

   pwr_cClass_StoBiInt32 : constant := 135576;  --  pwr_baseclasses.h:13541

   pwr_cClass_StoBiString80 : constant := 135688;  --  pwr_baseclasses.h:13571

   pwr_cClass_StoBoFloat32 : constant := 135640;  --  pwr_baseclasses.h:13596

   pwr_cClass_StoBoInt32 : constant := 135616;  --  pwr_baseclasses.h:13626

   pwr_cClass_StoBoString80 : constant := 135704;  --  pwr_baseclasses.h:13656

   pwr_cClass_StoDattr : constant := 133864;  --  pwr_baseclasses.h:13681

   pwr_cClass_StoDgeneric : constant := 133344;  --  pwr_baseclasses.h:13702

   pwr_cClass_stodi : constant := 132848;  --  pwr_baseclasses.h:13719

   pwr_cClass_stodo : constant := 132856;  --  pwr_baseclasses.h:13749

   pwr_cClass_stodp : constant := 132864;  --  pwr_baseclasses.h:13774

   pwr_cClass_StoDpPtr : constant := 135176;  --  pwr_baseclasses.h:13796

   pwr_cClass_StoDTgeneric : constant := 134720;  --  pwr_baseclasses.h:13824

   pwr_cClass_StoDTp : constant := 134752;  --  pwr_baseclasses.h:13841

   pwr_cClass_StoDTv : constant := 134656;  --  pwr_baseclasses.h:13863

   pwr_cClass_stodv : constant := 132872;  --  pwr_baseclasses.h:13885

   pwr_cClass_StoIattr : constant := 133888;  --  pwr_baseclasses.h:13907

   pwr_cClass_StoIgeneric : constant := 133784;  --  pwr_baseclasses.h:13928

   pwr_cClass_stoii : constant := 133736;  --  pwr_baseclasses.h:13945

   pwr_cClass_stoio : constant := 133728;  --  pwr_baseclasses.h:13975

   pwr_cClass_StoIp : constant := 133808;  --  pwr_baseclasses.h:14000

   pwr_cClass_StoIpPtr : constant := 135192;  --  pwr_baseclasses.h:14022

   pwr_cClass_stoiv : constant := 133744;  --  pwr_baseclasses.h:14050

   pwr_cClass_stonumsp : constant := 134056;  --  pwr_baseclasses.h:14072

   pwr_cClass_stopi : constant := 132888;  --  pwr_baseclasses.h:14095

   pwr_cClass_Store : constant := 132896;  --  pwr_baseclasses.h:14125

   pwr_cClass_StoreFormat : constant := 132904;  --  pwr_baseclasses.h:14143

   pwr_cClass_StoreTrig : constant := 132912;  --  pwr_baseclasses.h:14159

   pwr_cClass_StoSattr : constant := 133920;  --  pwr_baseclasses.h:14178

   pwr_cClass_StoSgeneric : constant := 133600;  --  pwr_baseclasses.h:14199

   pwr_cClass_stosp : constant := 133552;  --  pwr_baseclasses.h:14216

   pwr_cClass_stosv : constant := 133528;  --  pwr_baseclasses.h:14238

   pwr_cClass_Strcat : constant := 133520;  --  pwr_baseclasses.h:14260

   pwr_cClass_StrToEnum : constant := 135448;  --  pwr_baseclasses.h:14288

   pwr_cClass_Sub : constant := 134336;  --  pwr_baseclasses.h:14317

   pwr_cClass_substep : constant := 132920;  --  pwr_baseclasses.h:14345

   pwr_cClass_SubStr : constant := 133584;  --  pwr_baseclasses.h:14371

   pwr_cClass_SubVolumeConfig : constant := 132928;  --  pwr_baseclasses.h:14399

   pwr_cClass_SubVolumeLoad : constant := 132936;  --  pwr_baseclasses.h:14416

   pwr_cClass_sum : constant := 132944;  --  pwr_baseclasses.h:14431

   pwr_cClass_Sv : constant := 133496;  --  pwr_baseclasses.h:14479

   pwr_cClass_SysMonConfig : constant := 134416;  --  pwr_baseclasses.h:14495

   pwr_cClass_SystemGroupReg : constant := 134512;  --  pwr_baseclasses.h:14512

   pwr_cClass_table : constant := 132960;  --  pwr_baseclasses.h:14528

   pwr_cClass_Tan : constant := 134112;  --  pwr_baseclasses.h:14552

   pwr_cClass_Text : constant := 132968;  --  pwr_baseclasses.h:14580

   pwr_cClass_timer : constant := 132976;  --  pwr_baseclasses.h:14600

   pwr_cClass_timint : constant := 132984;  --  pwr_baseclasses.h:14638

   pwr_cClass_Title : constant := 132992;  --  pwr_baseclasses.h:14670

   pwr_cClass_toggledi : constant := 134552;  --  pwr_baseclasses.h:14690

   pwr_cClass_trans : constant := 133008;  --  pwr_baseclasses.h:14720

   pwr_cClass_TransConv : constant := 133016;  --  pwr_baseclasses.h:14753

   pwr_cClass_TransDiv : constant := 133024;  --  pwr_baseclasses.h:14768

   pwr_cClass_True : constant := 135584;  --  pwr_baseclasses.h:14783

   pwr_cClass_UInt32toI : constant := 135064;  --  pwr_baseclasses.h:14807

   pwr_cClass_UInt64toI : constant := 135104;  --  pwr_baseclasses.h:14833

   pwr_cClass_User : constant := 133032;  --  pwr_baseclasses.h:14859

   pwr_cClass_UserReg : constant := 134504;  --  pwr_baseclasses.h:14888

   pwr_cClass_valve : constant := 133040;  --  pwr_baseclasses.h:14909

   pwr_cClass_VolumeDistribute : constant := 133048;  --  pwr_baseclasses.h:14972

   pwr_cClass_VolumeLoad : constant := 133056;  --  pwr_baseclasses.h:14991

   pwr_cClass_VolumeReg : constant := 134496;  --  pwr_baseclasses.h:15006

   pwr_cClass_wait : constant := 133064;  --  pwr_baseclasses.h:15023

   pwr_cClass_waith : constant := 133072;  --  pwr_baseclasses.h:15061

   pwr_cClass_WbEnvironment : constant := 133608;  --  pwr_baseclasses.h:15101

   pwr_cClass_WebBrowserConfig : constant := 133488;  --  pwr_baseclasses.h:15116

   pwr_cClass_WebGraph : constant := 133472;  --  pwr_baseclasses.h:15132

   pwr_cClass_WebHandler : constant := 133440;  --  pwr_baseclasses.h:15150

   pwr_cClass_WebLink : constant := 133480;  --  pwr_baseclasses.h:15187

   pwr_cClass_windowcond : constant := 133104;  --  pwr_baseclasses.h:15204

   pwr_cClass_windoworderact : constant := 133112;  --  pwr_baseclasses.h:15231

   pwr_cClass_windowplc : constant := 133120;  --  pwr_baseclasses.h:15258

   pwr_cClass_windowsubstep : constant := 133128;  --  pwr_baseclasses.h:15285

   pwr_cClass_xor : constant := 133136;  --  pwr_baseclasses.h:15312

   pwr_cClass_XttGraph : constant := 133464;  --  pwr_baseclasses.h:15340

   pwr_cClass_XttMultiView : constant := 135920;  --  pwr_baseclasses.h:15366

   pwr_cClass_XyCurve : constant := 135144;  --  pwr_baseclasses.h:15393

  --	Proview V5.1.0 pwr_baseclasses.h  
  --	Generated by co_convert.  
  --	Do not edit this file.  
  --_* Enum: AiFilterTypeEnum
  --    @Aref AiFilterTypeEnum AiFilterTypeEnum
  -- 

   subtype pwr_tAiFilterTypeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:18

   type pwr_eAiFilterTypeEnum is 
     (pwr_eAiFilterTypeEnum_No,
      pwr_eAiFilterTypeEnum_Exponential);
   pragma Convention (C, pwr_eAiFilterTypeEnum);  -- pwr_baseclasses.h:23

  --_* Enum: AiSensorTypeEnum
  --    @Aref AiSensorTypeEnum AiSensorTypeEnum
  -- 

   subtype pwr_tAiSensorTypeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:29

   type pwr_eAiSensorTypeEnum is 
     (pwr_eAiSensorTypeEnum_SignalValue,
      pwr_eAiSensorTypeEnum_Linear,
      pwr_eAiSensorTypeEnum_Parabolic,
      pwr_eAiSensorTypeEnum_SquareRoot,
      pwr_eAiSensorTypeEnum_SignedSquareRoot);
   pragma Convention (C, pwr_eAiSensorTypeEnum);  -- pwr_baseclasses.h:37

  --_* Enum: AudioToneEnum
  --    @Aref AudioToneEnum AudioToneEnum
  -- 

   subtype pwr_tAudioToneEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:43

   type pwr_eAudioToneEnum is 
     (pwr_eAudioToneEnum_C2,
      pwr_eAudioToneEnum_Db2,
      pwr_eAudioToneEnum_D2,
      pwr_eAudioToneEnum_Eb2,
      pwr_eAudioToneEnum_E2,
      pwr_eAudioToneEnum_F2,
      pwr_eAudioToneEnum_Gb2,
      pwr_eAudioToneEnum_G2,
      pwr_eAudioToneEnum_Ab2,
      pwr_eAudioToneEnum_A2,
      pwr_eAudioToneEnum_Bb2,
      pwr_eAudioToneEnum_B2,
      pwr_eAudioToneEnum_C3,
      pwr_eAudioToneEnum_Db3,
      pwr_eAudioToneEnum_D3,
      pwr_eAudioToneEnum_Eb3,
      pwr_eAudioToneEnum_E3,
      pwr_eAudioToneEnum_F3,
      pwr_eAudioToneEnum_Gb3,
      pwr_eAudioToneEnum_G3,
      pwr_eAudioToneEnum_Ab3,
      pwr_eAudioToneEnum_A3,
      pwr_eAudioToneEnum_Bb3,
      pwr_eAudioToneEnum_B3,
      pwr_eAudioToneEnum_C4,
      pwr_eAudioToneEnum_Db4,
      pwr_eAudioToneEnum_D4,
      pwr_eAudioToneEnum_Eb4,
      pwr_eAudioToneEnum_E4,
      pwr_eAudioToneEnum_F4,
      pwr_eAudioToneEnum_Gb4,
      pwr_eAudioToneEnum_G4,
      pwr_eAudioToneEnum_Ab4,
      pwr_eAudioToneEnum_A4,
      pwr_eAudioToneEnum_Bb4,
      pwr_eAudioToneEnum_B4,
      pwr_eAudioToneEnum_C5,
      pwr_eAudioToneEnum_Db5,
      pwr_eAudioToneEnum_D5,
      pwr_eAudioToneEnum_Eb5,
      pwr_eAudioToneEnum_E5,
      pwr_eAudioToneEnum_F5,
      pwr_eAudioToneEnum_Gb5,
      pwr_eAudioToneEnum_G5,
      pwr_eAudioToneEnum_Ab5,
      pwr_eAudioToneEnum_A5,
      pwr_eAudioToneEnum_Bb5,
      pwr_eAudioToneEnum_B5,
      pwr_eAudioToneEnum_C6,
      pwr_eAudioToneEnum_Db6,
      pwr_eAudioToneEnum_D6,
      pwr_eAudioToneEnum_Eb6,
      pwr_eAudioToneEnum_E6,
      pwr_eAudioToneEnum_F6,
      pwr_eAudioToneEnum_Gb6,
      pwr_eAudioToneEnum_G6,
      pwr_eAudioToneEnum_Ab6,
      pwr_eAudioToneEnum_A6,
      pwr_eAudioToneEnum_Bb6,
      pwr_eAudioToneEnum_B6,
      pwr_eAudioToneEnum_C7,
      pwr_eAudioToneEnum_Db7,
      pwr_eAudioToneEnum_D7,
      pwr_eAudioToneEnum_Eb7,
      pwr_eAudioToneEnum_E7,
      pwr_eAudioToneEnum_F7,
      pwr_eAudioToneEnum_Gb7,
      pwr_eAudioToneEnum_G7,
      pwr_eAudioToneEnum_Ab7,
      pwr_eAudioToneEnum_A7,
      pwr_eAudioToneEnum_Bb7,
      pwr_eAudioToneEnum_B7,
      pwr_eAudioToneEnum_C8,
      pwr_eAudioToneEnum_Db8,
      pwr_eAudioToneEnum_D8,
      pwr_eAudioToneEnum_Eb8,
      pwr_eAudioToneEnum_E8,
      pwr_eAudioToneEnum_F8,
      pwr_eAudioToneEnum_Gb8,
      pwr_eAudioToneEnum_G8,
      pwr_eAudioToneEnum_Ab8,
      pwr_eAudioToneEnum_A8,
      pwr_eAudioToneEnum_Bb8,
      pwr_eAudioToneEnum_B8,
      pwr_eAudioToneEnum_C9,
      pwr_eAudioToneEnum_Db9,
      pwr_eAudioToneEnum_D9,
      pwr_eAudioToneEnum_Eb9,
      pwr_eAudioToneEnum_E9,
      pwr_eAudioToneEnum_F9,
      pwr_eAudioToneEnum_Gb9,
      pwr_eAudioToneEnum_G9,
      pwr_eAudioToneEnum_Ab9,
      pwr_eAudioToneEnum_A9,
      pwr_eAudioToneEnum_Bb9,
      pwr_eAudioToneEnum_B9,
      pwr_eAudioToneEnum_C10);
   pragma Convention (C, pwr_eAudioToneEnum);  -- pwr_baseclasses.h:143

  --_* Mask: BuildOptionsMask
  --    @Aref BuildOptionsMask BuildOptionsMask
  -- 

   subtype pwr_tBuildOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:149

   subtype pwr_mBuildOptionsMask is unsigned;
   pwr_mBuildOptionsMask_IoUser : constant pwr_mBuildOptionsMask := 1;
   pwr_mBuildOptionsMask_PwrpArchive : constant pwr_mBuildOptionsMask := 2;
   pwr_mBuildOptionsMask_NMpsArchive : constant pwr_mBuildOptionsMask := 4;
   pwr_mBuildOptionsMask_RemoteArchive : constant pwr_mBuildOptionsMask := 8;
   pwr_mBuildOptionsMask_MiscArchive : constant pwr_mBuildOptionsMask := 16;
   pwr_mBuildOptionsMask_SsaboxArchive : constant pwr_mBuildOptionsMask := 32;
   pwr_mBuildOptionsMask_SoftingPNAK : constant pwr_mBuildOptionsMask := 65536;
   pwr_mBuildOptionsMask_HilscherCifX : constant pwr_mBuildOptionsMask := 131072;
   pwr_mBuildOptionsMask_UsbLib : constant pwr_mBuildOptionsMask := 262144;
   pwr_mBuildOptionsMask_MotionControlUSBIO : constant pwr_mBuildOptionsMask := 524288;
   pwr_mBuildOptionsMask_Nodave : constant pwr_mBuildOptionsMask := 1048576;  -- pwr_baseclasses.h:163

  --_* Enum: ByteOrderingEnum
  --    @Aref ByteOrderingEnum ByteOrderingEnum
  -- 

   subtype pwr_tByteOrderingEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:169

   type pwr_eByteOrderingEnum is 
     (pwr_eByteOrderingEnum_LittleEndian,
      pwr_eByteOrderingEnum_BigEndian);
   pragma Convention (C, pwr_eByteOrderingEnum);  -- pwr_baseclasses.h:174

  --_* Mask: CardMask1_1
  --    @Aref CardMask1_1 CardMask1_1
  -- 

   subtype pwr_tCardMask1_1 is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:180

   subtype pwr_mCardMask1_1 is unsigned;
   pwr_mCardMask1_1_Channel1 : constant pwr_mCardMask1_1 := 1;
   pwr_mCardMask1_1_Channel2 : constant pwr_mCardMask1_1 := 2;
   pwr_mCardMask1_1_Channel3 : constant pwr_mCardMask1_1 := 4;
   pwr_mCardMask1_1_Channel4 : constant pwr_mCardMask1_1 := 8;
   pwr_mCardMask1_1_Channel5 : constant pwr_mCardMask1_1 := 16;
   pwr_mCardMask1_1_Channel6 : constant pwr_mCardMask1_1 := 32;
   pwr_mCardMask1_1_Channel7 : constant pwr_mCardMask1_1 := 64;
   pwr_mCardMask1_1_Channel8 : constant pwr_mCardMask1_1 := 128;
   pwr_mCardMask1_1_Channel9 : constant pwr_mCardMask1_1 := 256;
   pwr_mCardMask1_1_Channel10 : constant pwr_mCardMask1_1 := 512;
   pwr_mCardMask1_1_Channel11 : constant pwr_mCardMask1_1 := 1024;
   pwr_mCardMask1_1_Channel12 : constant pwr_mCardMask1_1 := 2048;
   pwr_mCardMask1_1_Channel13 : constant pwr_mCardMask1_1 := 4096;
   pwr_mCardMask1_1_Channel14 : constant pwr_mCardMask1_1 := 8192;
   pwr_mCardMask1_1_Channel15 : constant pwr_mCardMask1_1 := 16384;
   pwr_mCardMask1_1_Channel16 : constant pwr_mCardMask1_1 := 32768;  -- pwr_baseclasses.h:199

  --_* Mask: CardMask2_1
  --    @Aref CardMask2_1 CardMask2_1
  -- 

   subtype pwr_tCardMask2_1 is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:205

   subtype pwr_mCardMask2_1 is unsigned;
   pwr_mCardMask2_1_Channel17 : constant pwr_mCardMask2_1 := 1;
   pwr_mCardMask2_1_Channel18 : constant pwr_mCardMask2_1 := 2;
   pwr_mCardMask2_1_Channel19 : constant pwr_mCardMask2_1 := 4;
   pwr_mCardMask2_1_Channel20 : constant pwr_mCardMask2_1 := 8;
   pwr_mCardMask2_1_Channel21 : constant pwr_mCardMask2_1 := 16;
   pwr_mCardMask2_1_Channel22 : constant pwr_mCardMask2_1 := 32;
   pwr_mCardMask2_1_Channel23 : constant pwr_mCardMask2_1 := 64;
   pwr_mCardMask2_1_Channel24 : constant pwr_mCardMask2_1 := 128;
   pwr_mCardMask2_1_Channel25 : constant pwr_mCardMask2_1 := 256;
   pwr_mCardMask2_1_Channel26 : constant pwr_mCardMask2_1 := 512;
   pwr_mCardMask2_1_Channel27 : constant pwr_mCardMask2_1 := 1024;
   pwr_mCardMask2_1_Channel28 : constant pwr_mCardMask2_1 := 2048;
   pwr_mCardMask2_1_Channel29 : constant pwr_mCardMask2_1 := 4096;
   pwr_mCardMask2_1_Channel30 : constant pwr_mCardMask2_1 := 8192;
   pwr_mCardMask2_1_Channel31 : constant pwr_mCardMask2_1 := 16384;
   pwr_mCardMask2_1_Channel32 : constant pwr_mCardMask2_1 := 32768;  -- pwr_baseclasses.h:224

  --_* Enum: ClassVolumeDatabaseEnum
  --    @Aref ClassVolumeDatabaseEnum ClassVolumeDatabaseEnum
  -- 

   subtype pwr_tClassVolumeDatabaseEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:230

   type pwr_eClassVolumeDatabaseEnum is 
     (pwr_eClassVolumeDatabaseEnum_WbLoad,
      pwr_eClassVolumeDatabaseEnum_BerkeleyDb,
      pwr_eClassVolumeDatabaseEnum_MySql);
   pragma Convention (C, pwr_eClassVolumeDatabaseEnum);  -- pwr_baseclasses.h:236

  --_* Enum: ClientServerEnum
  --    @Aref ClientServerEnum ClientServerEnum
  -- 

   subtype pwr_tClientServerEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:242

   type pwr_eClientServerEnum is 
     (pwr_eClientServerEnum_Client,
      pwr_eClientServerEnum_Server);
   pragma Convention (C, pwr_eClientServerEnum);  -- pwr_baseclasses.h:247

  --_* Mask: CurveLayoutMask
  --    @Aref CurveLayoutMask CurveLayoutMask
  -- 

   subtype pwr_tCurveLayoutMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:253

   subtype pwr_mCurveLayoutMask is unsigned;
   pwr_mCurveLayoutMask_AttrDescrFirst : constant pwr_mCurveLayoutMask := 1;  -- pwr_baseclasses.h:257

  --_* Enum: DataBitsEnum
  --    @Aref DataBitsEnum DataBitsEnum
  -- 

   subtype pwr_tDataBitsEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:263

   type pwr_eDataBitsEnum is 
     (pwr_eDataBitsEnum_0,
      pwr_eDataBitsEnum_1,
      pwr_eDataBitsEnum_2,
      pwr_eDataBitsEnum_3,
      pwr_eDataBitsEnum_4,
      pwr_eDataBitsEnum_5,
      pwr_eDataBitsEnum_6,
      pwr_eDataBitsEnum_7,
      pwr_eDataBitsEnum_8);
   pragma Convention (C, pwr_eDataBitsEnum);  -- pwr_baseclasses.h:275

  --_* Enum: DataRepEnum
  --    @Aref DataRepEnum DataRepEnum
  -- 

   subtype pwr_tDataRepEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:281

   type pwr_eDataRepEnum is 
     (pwr_eDataRepEnum_Int32,
      pwr_eDataRepEnum_UInt32,
      pwr_eDataRepEnum_Int16,
      pwr_eDataRepEnum_UInt16,
      pwr_eDataRepEnum_Int8,
      pwr_eDataRepEnum_UInt8,
      pwr_eDataRepEnum_Int64,
      pwr_eDataRepEnum_UInt64,
      pwr_eDataRepEnum_Bit8,
      pwr_eDataRepEnum_Bit16,
      pwr_eDataRepEnum_Bit32,
      pwr_eDataRepEnum_Bit64,
      pwr_eDataRepEnum_Float32,
      pwr_eDataRepEnum_Float64,
      pwr_eDataRepEnum_Int24,
      pwr_eDataRepEnum_UInt24);
   pragma Convention (C, pwr_eDataRepEnum);  -- pwr_baseclasses.h:300

  --_* Enum: DChanTypeEnum
  --    @Aref DChanTypeEnum DChanTypeEnum
  -- 

   subtype pwr_tDChanTypeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:306

   type pwr_eDChanTypeEnum is 
     (pwr_eDChanTypeEnum_Di,
      pwr_eDChanTypeEnum_Do);
   pragma Convention (C, pwr_eDChanTypeEnum);  -- pwr_baseclasses.h:311

  --_* Enum: DiFilterTypeEnum
  --    @Aref DiFilterTypeEnum DiFilterTypeEnum
  -- 

   subtype pwr_tDiFilterTypeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:317

   type pwr_eDiFilterTypeEnum is 
     (pwr_eDiFilterTypeEnum_No,
      pwr_eDiFilterTypeEnum_SetAndResetDelay);
   pragma Convention (C, pwr_eDiFilterTypeEnum);  -- pwr_baseclasses.h:322

  --_* Mask: DiskSupActionMask
  --    @Aref DiskSupActionMask DiskSupActionMask
  -- 

   subtype pwr_tDiskSupActionMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:328

   subtype pwr_mDiskSupActionMask is unsigned;
   pwr_mDiskSupActionMask_Alarm : constant pwr_mDiskSupActionMask := 1;
   pwr_mDiskSupActionMask_Command : constant pwr_mDiskSupActionMask := 2;  -- pwr_baseclasses.h:333

  --_* Mask: DistrComponentMask
  --    @Aref DistrComponentMask DistrComponentMask
  -- 

   subtype pwr_tDistrComponentMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:339

   subtype pwr_mDistrComponentMask is unsigned;
   pwr_mDistrComponentMask_UserDatabase : constant pwr_mDistrComponentMask := 1;
   pwr_mDistrComponentMask_LoadFiles : constant pwr_mDistrComponentMask := 2;
   pwr_mDistrComponentMask_ApplFile : constant pwr_mDistrComponentMask := 4;
   pwr_mDistrComponentMask_PwrpAliasFile : constant pwr_mDistrComponentMask := 8;
   pwr_mDistrComponentMask_IncludeFiles : constant pwr_mDistrComponentMask := 16;
   pwr_mDistrComponentMask_GraphFiles : constant pwr_mDistrComponentMask := 32;
   pwr_mDistrComponentMask_XttHelpFile : constant pwr_mDistrComponentMask := 64;
   pwr_mDistrComponentMask_XttResourceFile : constant pwr_mDistrComponentMask := 128;
   pwr_mDistrComponentMask_XttSetupFile : constant pwr_mDistrComponentMask := 256;
   pwr_mDistrComponentMask_FlowFiles : constant pwr_mDistrComponentMask := 512;
   pwr_mDistrComponentMask_RHostsFile : constant pwr_mDistrComponentMask := 1024;
   pwr_mDistrComponentMask_WebFiles : constant pwr_mDistrComponentMask := 2048;
   pwr_mDistrComponentMask_PwrpStop : constant pwr_mDistrComponentMask := 4096;
   pwr_mDistrComponentMask_AuthorizedKeysFile : constant pwr_mDistrComponentMask := 8192;
   pwr_mDistrComponentMask_XMLFiles : constant pwr_mDistrComponentMask := 16384;  -- pwr_baseclasses.h:357

  --_* Enum: DocumentFormatEnum
  --    @Aref DocumentFormatEnum DocumentFormatEnum
  -- 

   subtype pwr_tDocumentFormatEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:363

   type pwr_eDocumentFormatEnum is 
     (pwr_eDocumentFormatEnum_PDF,
      pwr_eDocumentFormatEnum_Html,
      pwr_eDocumentFormatEnum_Text,
      pwr_eDocumentFormatEnum_Postscript);
   pragma Convention (C, pwr_eDocumentFormatEnum);  -- pwr_baseclasses.h:370

  --_* Enum: DocumentOrientEnum
  --    @Aref DocumentOrientEnum DocumentOrientEnum
  -- 

   subtype pwr_tDocumentOrientEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:376

   type pwr_eDocumentOrientEnum is 
     (pwr_eDocumentOrientEnum_Portrait,
      pwr_eDocumentOrientEnum_Landscape);
   pragma Convention (C, pwr_eDocumentOrientEnum);  -- pwr_baseclasses.h:381

  --_* Enum: DocumentSizeEnum
  --    @Aref DocumentSizeEnum DocumentSizeEnum
  -- 

   subtype pwr_tDocumentSizeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:387

   type pwr_eDocumentSizeEnum is 
     (pwr_eDocumentSizeEnum_A0,
      pwr_eDocumentSizeEnum_A1,
      pwr_eDocumentSizeEnum_A2,
      pwr_eDocumentSizeEnum_A3,
      pwr_eDocumentSizeEnum_A4,
      pwr_eDocumentSizeEnum_A5);
   pragma Convention (C, pwr_eDocumentSizeEnum);  -- pwr_baseclasses.h:396

  --_* Mask: EventFlagsMask
  --    @Aref EventFlagsMask EventFlagsMask
  -- 

   subtype pwr_tEventFlagsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:402

   subtype pwr_mEventFlagsMask is unsigned;
   pwr_mEventFlagsMask_Return : constant pwr_mEventFlagsMask := 1;
   pwr_mEventFlagsMask_Ack : constant pwr_mEventFlagsMask := 2;
   pwr_mEventFlagsMask_Bell : constant pwr_mEventFlagsMask := 4;
   pwr_mEventFlagsMask_Force : constant pwr_mEventFlagsMask := 8;
   pwr_mEventFlagsMask_InfoWindow : constant pwr_mEventFlagsMask := 16;
   pwr_mEventFlagsMask_Returned : constant pwr_mEventFlagsMask := 32;
   pwr_mEventFlagsMask_NoObject : constant pwr_mEventFlagsMask := 64;
   pwr_mEventFlagsMask_Email : constant pwr_mEventFlagsMask := 128;
   pwr_mEventFlagsMask_SMS : constant pwr_mEventFlagsMask := 256;
   pwr_mEventFlagsMask_UserDetectTime : constant pwr_mEventFlagsMask := 512;  -- pwr_baseclasses.h:415

  --_* Mask: EventListMask
  --    @Aref EventListMask EventListMask
  -- 

   subtype pwr_tEventListMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:421

   subtype pwr_mEventListMask is unsigned;
   pwr_mEventListMask_AlarmReturn : constant pwr_mEventListMask := 1;
   pwr_mEventListMask_AlarmAck : constant pwr_mEventListMask := 2;  -- pwr_baseclasses.h:426

  --_* Enum: EventPrioEnum
  --    @Aref EventPrioEnum EventPrioEnum
  -- 

   subtype pwr_tEventPrioEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:432

   subtype pwr_eEventPrioEnum is unsigned;
   pwr_eEventPrioEnum_A : constant pwr_eEventPrioEnum := 67;
   pwr_eEventPrioEnum_B : constant pwr_eEventPrioEnum := 66;
   pwr_eEventPrioEnum_C : constant pwr_eEventPrioEnum := 65;
   pwr_eEventPrioEnum_D : constant pwr_eEventPrioEnum := 64;  -- pwr_baseclasses.h:439

  --_* Mask: EventPrioMask
  --    @Aref EventPrioMask EventPrioMask
  -- 

   subtype pwr_tEventPrioMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:445

   subtype pwr_mEventPrioMask is unsigned;
   pwr_mEventPrioMask_A : constant pwr_mEventPrioMask := 1;
   pwr_mEventPrioMask_B : constant pwr_mEventPrioMask := 2;
   pwr_mEventPrioMask_C : constant pwr_mEventPrioMask := 4;
   pwr_mEventPrioMask_D : constant pwr_mEventPrioMask := 8;  -- pwr_baseclasses.h:452

  --_* Enum: EventTypeEnum
  --    @Aref EventTypeEnum EventTypeEnum
  -- 

   subtype pwr_tEventTypeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:458

   subtype pwr_eEventTypeEnum is unsigned;
   pwr_eEventTypeEnum_Info : constant pwr_eEventTypeEnum := 32;
   pwr_eEventTypeEnum_Alarm : constant pwr_eEventTypeEnum := 64;  -- pwr_baseclasses.h:463

  --_* Enum: FloatRepEnum
  --    @Aref FloatRepEnum FloatRepEnum
  -- 

   subtype pwr_tFloatRepEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:469

   type pwr_eFloatRepEnum is 
     (pwr_eFloatRepEnum_FloatIntel,
      pwr_eFloatRepEnum_FloatIEEE);
   pragma Convention (C, pwr_eFloatRepEnum);  -- pwr_baseclasses.h:474

  --_* Enum: FrameAttrEnum
  --    @Aref FrameAttrEnum FrameAttrEnum
  -- 

   subtype pwr_tFrameAttrEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:480

   type pwr_eFrameAttrEnum is 
     (pwr_eFrameAttrEnum_Grey,
      pwr_eFrameAttrEnum_Black,
      pwr_eFrameAttrEnum_No);
   pragma Convention (C, pwr_eFrameAttrEnum);  -- pwr_baseclasses.h:486

  --_* Mask: IoProcessMask
  --    @Aref IoProcessMask IoProcessMask
  -- 

   subtype pwr_tIoProcessMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:492

   subtype pwr_mIoProcessMask is unsigned;
   pwr_mIoProcessMask_Plc : constant pwr_mIoProcessMask := 1;
   pwr_mIoProcessMask_IoComm : constant pwr_mIoProcessMask := 2;
   pwr_mIoProcessMask_Profibus : constant pwr_mIoProcessMask := 4;
   pwr_mIoProcessMask_User : constant pwr_mIoProcessMask := 8;
   pwr_mIoProcessMask_User2 : constant pwr_mIoProcessMask := 16;
   pwr_mIoProcessMask_User3 : constant pwr_mIoProcessMask := 32;
   pwr_mIoProcessMask_User4 : constant pwr_mIoProcessMask := 64;
   pwr_mIoProcessMask_Powerlink : constant pwr_mIoProcessMask := 128;  -- pwr_baseclasses.h:503

  --_* Enum: LanguageEnum
  --    @Aref LanguageEnum LanguageEnum
  -- 

   subtype pwr_tLanguageEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:509

   subtype pwr_eLanguageEnum is unsigned;
   pwr_eLanguageEnum_English : constant pwr_eLanguageEnum := 45;
   pwr_eLanguageEnum_Swedish : constant pwr_eLanguageEnum := 119;
   pwr_eLanguageEnum_German : constant pwr_eLanguageEnum := 31;
   pwr_eLanguageEnum_French : constant pwr_eLanguageEnum := 76;
   pwr_eLanguageEnum_Chinese : constant pwr_eLanguageEnum := 132;  -- pwr_baseclasses.h:517

  --_* Enum: MultiViewContentEnum
  --    @Aref MultiViewContentEnum MultiViewContentEnum
  -- 

   subtype pwr_tMultiViewContentEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:523

   type pwr_eMultiViewContentEnum is 
     (pwr_eMultiViewContentEnum_Graph,
      pwr_eMultiViewContentEnum_ObjectGraph,
      pwr_eMultiViewContentEnum_AlarmList,
      pwr_eMultiViewContentEnum_MultiView,
      pwr_eMultiViewContentEnum_EventList,
      pwr_eMultiViewContentEnum_TrendCurve,
      pwr_eMultiViewContentEnum_FastCurve,
      pwr_eMultiViewContentEnum_SevHistory);
   pragma Convention (C, pwr_eMultiViewContentEnum);  -- pwr_baseclasses.h:534

  --_* Mask: MultiViewElemOptionsMask
  --    @Aref MultiViewElemOptionsMask MultiViewElemOptionsMask
  -- 

   subtype pwr_tMultiViewElemOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:540

   subtype pwr_mMultiViewElemOptionsMask is unsigned;
   pwr_mMultiViewElemOptionsMask_Menu : constant pwr_mMultiViewElemOptionsMask := 1;
   pwr_mMultiViewElemOptionsMask_Scrollbars : constant pwr_mMultiViewElemOptionsMask := 2;
   pwr_mMultiViewElemOptionsMask_Exchangeable : constant pwr_mMultiViewElemOptionsMask := 4;  -- pwr_baseclasses.h:546

  --_* Enum: MultiViewLayoutEnum
  --    @Aref MultiViewLayoutEnum MultiViewLayoutEnum
  -- 

   subtype pwr_tMultiViewLayoutEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:552

   type pwr_eMultiViewLayoutEnum is 
     (pwr_eMultiViewLayoutEnum_Box,
      pwr_eMultiViewLayoutEnum_Fix,
      pwr_eMultiViewLayoutEnum_Table);
   pragma Convention (C, pwr_eMultiViewLayoutEnum);  -- pwr_baseclasses.h:558

  --_* Mask: MultiViewOptionsMask
  --    @Aref MultiViewOptionsMask MultiViewOptionsMask
  -- 

   subtype pwr_tMultiViewOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:564

   subtype pwr_mMultiViewOptionsMask is unsigned;
   pwr_mMultiViewOptionsMask_FullScreen : constant pwr_mMultiViewOptionsMask := 1;
   pwr_mMultiViewOptionsMask_Maximize : constant pwr_mMultiViewOptionsMask := 2;
   pwr_mMultiViewOptionsMask_FullMaximize : constant pwr_mMultiViewOptionsMask := 4;
   pwr_mMultiViewOptionsMask_Iconify : constant pwr_mMultiViewOptionsMask := 8;
   pwr_mMultiViewOptionsMask_ColumnSeparators : constant pwr_mMultiViewOptionsMask := 16;
   pwr_mMultiViewOptionsMask_RowSeparators : constant pwr_mMultiViewOptionsMask := 64;  -- pwr_baseclasses.h:573

  --_* Enum: NodeConnectionEnum
  --    @Aref NodeConnectionEnum NodeConnectionEnum
  -- 

   subtype pwr_tNodeConnectionEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:579

   type pwr_eNodeConnectionEnum is 
     (pwr_eNodeConnectionEnum_Full,
      pwr_eNodeConnectionEnum_QcomOnly);
   pragma Convention (C, pwr_eNodeConnectionEnum);  -- pwr_baseclasses.h:584

  --_* Enum: NumberRepEnum
  --    @Aref NumberRepEnum NumberRepEnum
  -- 

   subtype pwr_tNumberRepEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:590

   type pwr_eNumberRepEnum is 
     (pwr_eNumberRepEnum_IntUnsigned,
      pwr_eNumberRepEnum_IntSigned,
      pwr_eNumberRepEnum_FloatIEEE,
      pwr_eNumberRepEnum_FloatVAX,
      pwr_eNumberRepEnum_FloatIntel);
   pragma Convention (C, pwr_eNumberRepEnum);  -- pwr_baseclasses.h:598

  --_* Enum: OnOffEnum
  --    @Aref OnOffEnum OnOffEnum
  -- 

   subtype pwr_tOnOffEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:604

   type pwr_eOnOffEnum is 
     (pwr_eOnOffEnum_Off,
      pwr_eOnOffEnum_On);
   pragma Convention (C, pwr_eOnOffEnum);  -- pwr_baseclasses.h:609

  --_* Mask: OpPlaceOptionsMask
  --    @Aref OpPlaceOptionsMask OpPlaceOptionsMask
  -- 

   subtype pwr_tOpPlaceOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:615

   subtype pwr_mOpPlaceOptionsMask is unsigned;
   pwr_mOpPlaceOptionsMask_OperatorLog : constant pwr_mOpPlaceOptionsMask := 1;
   pwr_mOpPlaceOptionsMask_OperatorExtendedLog : constant pwr_mOpPlaceOptionsMask := 2;
   pwr_mOpPlaceOptionsMask_EnablePrintDialog : constant pwr_mOpPlaceOptionsMask := 4;  -- pwr_baseclasses.h:621

  --_* Mask: OpWindLayoutMask
  --    @Aref OpWindLayoutMask OpWindLayoutMask
  -- 

   subtype pwr_tOpWindLayoutMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:627

   subtype pwr_mOpWindLayoutMask is unsigned;
   pwr_mOpWindLayoutMask_HideOperatorWindow : constant pwr_mOpWindLayoutMask := 1;
   pwr_mOpWindLayoutMask_HideLicenseWindow : constant pwr_mOpWindLayoutMask := 2;
   pwr_mOpWindLayoutMask_HideStatusBar : constant pwr_mOpWindLayoutMask := 4;
   pwr_mOpWindLayoutMask_HideCloseButton : constant pwr_mOpWindLayoutMask := 8;
   pwr_mOpWindLayoutMask_ShowAlarmTime : constant pwr_mOpWindLayoutMask := 16;
   pwr_mOpWindLayoutMask_ShowAlarmDateAndTime : constant pwr_mOpWindLayoutMask := 32;
   pwr_mOpWindLayoutMask_HideNavigator : constant pwr_mOpWindLayoutMask := 64;  -- pwr_baseclasses.h:637

  --_* Mask: OpWindPopMask
  --    @Aref OpWindPopMask OpWindPopMask
  -- 

   subtype pwr_tOpWindPopMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:643

   subtype pwr_mOpWindPopMask is unsigned;
   pwr_mOpWindPopMask_Aalarm : constant pwr_mOpWindPopMask := 1;
   pwr_mOpWindPopMask_Balarm : constant pwr_mOpWindPopMask := 2;
   pwr_mOpWindPopMask_Calarm : constant pwr_mOpWindPopMask := 4;
   pwr_mOpWindPopMask_Dalarm : constant pwr_mOpWindPopMask := 8;
   pwr_mOpWindPopMask_InfoMsg : constant pwr_mOpWindPopMask := 16;  -- pwr_baseclasses.h:651

  --_* Enum: ParityEnum
  --    @Aref ParityEnum ParityEnum
  -- 

   subtype pwr_tParityEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:657

   type pwr_eParityEnum is 
     (pwr_eParityEnum_None,
      pwr_eParityEnum_Odd,
      pwr_eParityEnum_Even);
   pragma Convention (C, pwr_eParityEnum);  -- pwr_baseclasses.h:663

  --_* Enum: PeriodicEnum
  --    @Aref PeriodicEnum PeriodicEnum
  -- 

   subtype pwr_tPeriodicEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:669

   type pwr_ePeriodicEnum is 
     (pwr_ePeriodicEnum_No,
      pwr_ePeriodicEnum_Yearly,
      pwr_ePeriodicEnum_Monthly,
      pwr_ePeriodicEnum_Weekly,
      pwr_ePeriodicEnum_Daily,
      pwr_ePeriodicEnum_Hourly);
   pragma Convention (C, pwr_ePeriodicEnum);  -- pwr_baseclasses.h:678

  --_* Enum: PidAlgEnum
  --    @Aref PidAlgEnum PidAlgEnum
  -- 

   subtype pwr_tPidAlgEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:684

   subtype pwr_ePidAlgEnum is unsigned;
   pwr_ePidAlgEnum_I : constant pwr_ePidAlgEnum := 1;
   pwr_ePidAlgEnum_I_P : constant pwr_ePidAlgEnum := 3;
   pwr_ePidAlgEnum_P : constant pwr_ePidAlgEnum := 6;
   pwr_ePidAlgEnum_PI : constant pwr_ePidAlgEnum := 7;
   pwr_ePidAlgEnum_I_PD : constant pwr_ePidAlgEnum := 11;
   pwr_ePidAlgEnum_P_D : constant pwr_ePidAlgEnum := 14;
   pwr_ePidAlgEnum_PI_D : constant pwr_ePidAlgEnum := 15;
   pwr_ePidAlgEnum_PD : constant pwr_ePidAlgEnum := 30;
   pwr_ePidAlgEnum_PID : constant pwr_ePidAlgEnum := 31;  -- pwr_baseclasses.h:696

  --_* Enum: PidModeEnum
  --    @Aref PidModeEnum PidModeEnum
  -- 

   subtype pwr_tPidModeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:702

   subtype pwr_ePidModeEnum is unsigned;
   pwr_ePidModeEnum_Manual : constant pwr_ePidModeEnum := 1;
   pwr_ePidModeEnum_Auto : constant pwr_ePidModeEnum := 2;
   pwr_ePidModeEnum_ManAuto : constant pwr_ePidModeEnum := 3;
   pwr_ePidModeEnum_Cascade : constant pwr_ePidModeEnum := 4;
   pwr_ePidModeEnum_CascMan : constant pwr_ePidModeEnum := 5;
   pwr_ePidModeEnum_CascAuto : constant pwr_ePidModeEnum := 6;
   pwr_ePidModeEnum_CascAutoMan : constant pwr_ePidModeEnum := 7;  -- pwr_baseclasses.h:712

  --_* Mask: PidModeMask
  --    @Aref PidModeMask PidModeMask
  -- 

   subtype pwr_tPidModeMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:718

   subtype pwr_mPidModeMask is unsigned;
   pwr_mPidModeMask_Manual : constant pwr_mPidModeMask := 1;
   pwr_mPidModeMask_Auto : constant pwr_mPidModeMask := 2;
   pwr_mPidModeMask_Cascade : constant pwr_mPidModeMask := 4;  -- pwr_baseclasses.h:724

  --_* Enum: PidOpModeEnum
  --    @Aref PidOpModeEnum PidOpModeEnum
  -- 

   subtype pwr_tPidOpModeEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:730

   subtype pwr_ePidOpModeEnum is unsigned;
   pwr_ePidOpModeEnum_Manual : constant pwr_ePidOpModeEnum := 1;
   pwr_ePidOpModeEnum_Auto : constant pwr_ePidOpModeEnum := 2;
   pwr_ePidOpModeEnum_Cascade : constant pwr_ePidOpModeEnum := 4;  -- pwr_baseclasses.h:736

  --_* Mask: PostOptionsMask
  --    @Aref PostOptionsMask PostOptionsMask
  -- 

   subtype pwr_tPostOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:742

   subtype pwr_mPostOptionsMask is unsigned;
   pwr_mPostOptionsMask_SingleLineSMS : constant pwr_mPostOptionsMask := 1;
   pwr_mPostOptionsMask_Log : constant pwr_mPostOptionsMask := 2;  -- pwr_baseclasses.h:747

  --_* Enum: ReadyNotReadyEnum
  --    @Aref ReadyNotReadyEnum ReadyNotReadyEnum
  -- 

   subtype pwr_tReadyNotReadyEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:753

   type pwr_eReadyNotReadyEnum is 
     (pwr_eReadyNotReadyEnum_NotReady,
      pwr_eReadyNotReadyEnum_Ready);
   pragma Convention (C, pwr_eReadyNotReadyEnum);  -- pwr_baseclasses.h:758

  --_* Enum: RemoteShellEnum
  --    @Aref RemoteShellEnum RemoteShellEnum
  -- 

   subtype pwr_tRemoteShellEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:764

   type pwr_eRemoteShellEnum is 
     (pwr_eRemoteShellEnum_SSH,
      pwr_eRemoteShellEnum_RSH);
   pragma Convention (C, pwr_eRemoteShellEnum);  -- pwr_baseclasses.h:769

  --_* Mask: ReportMediaMask
  --    @Aref ReportMediaMask ReportMediaMask
  -- 

   subtype pwr_tReportMediaMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:775

   subtype pwr_mReportMediaMask is unsigned;
   pwr_mReportMediaMask_Email : constant pwr_mReportMediaMask := 1;
   pwr_mReportMediaMask_SMS : constant pwr_mReportMediaMask := 2;
   pwr_mReportMediaMask_Printer : constant pwr_mReportMediaMask := 4;
   pwr_mReportMediaMask_File : constant pwr_mReportMediaMask := 8;  -- pwr_baseclasses.h:782

  --_* Enum: SevDatabaseEnum
  --    @Aref SevDatabaseEnum SevDatabaseEnum
  -- 

   subtype pwr_tSevDatabaseEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:788

   type pwr_eSevDatabaseEnum is 
     (pwr_eSevDatabaseEnum_MySQL,
      pwr_eSevDatabaseEnum_SQLite);
   pragma Convention (C, pwr_eSevDatabaseEnum);  -- pwr_baseclasses.h:793

  --_* Mask: SevHistOptionsMask
  --    @Aref SevHistOptionsMask SevHistOptionsMask
  -- 

   subtype pwr_tSevHistOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:799

   subtype pwr_mSevOptionsMask is unsigned;
   pwr_mSevOptionsMask_PosixTime : constant pwr_mSevOptionsMask := 1;
   pwr_mSevOptionsMask_HighTimeResolution : constant pwr_mSevOptionsMask := 2;
   pwr_mSevOptionsMask_ReadOptimized : constant pwr_mSevOptionsMask := 4;
   pwr_mSevOptionsMask_UseDeadBand : constant pwr_mSevOptionsMask := 8;
   pwr_mSevOptionsMask_Parameter : constant pwr_mSevOptionsMask := 16;
   pwr_mSevOptionsMask_Event : constant pwr_mSevOptionsMask := 32;  -- pwr_baseclasses.h:808

  --_* Enum: StallActionEnum
  --    @Aref StallActionEnum StallActionEnum
  -- 

   subtype pwr_tStallActionEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:814

   type pwr_eStallActionEnum is 
     (pwr_eStallActionEnum_No,
      pwr_eStallActionEnum_ResetInputs,
      pwr_eStallActionEnum_EmergencyBreak);
   pragma Convention (C, pwr_eStallActionEnum);  -- pwr_baseclasses.h:820

  --_* Enum: StopBitsEnum
  --    @Aref StopBitsEnum StopBitsEnum
  -- 

   subtype pwr_tStopBitsEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:826

   type pwr_eStopBitsEnum is 
     (pwr_eStopBitsEnum_0,
      pwr_eStopBitsEnum_1,
      pwr_eStopBitsEnum_2);
   pragma Convention (C, pwr_eStopBitsEnum);  -- pwr_baseclasses.h:832

  --_* Enum: SupDelayActionEnum
  --    @Aref SupDelayActionEnum SupDelayActionEnum
  -- 

   subtype pwr_tSupDelayActionEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:838

   type pwr_eSupDelayActionEnum is 
     (pwr_eSupDelayActionEnum_No,
      pwr_eSupDelayActionEnum_Message,
      pwr_eSupDelayActionEnum_EmergencyBreak);
   pragma Convention (C, pwr_eSupDelayActionEnum);  -- pwr_baseclasses.h:844

  --_* Mask: SysGroupAttrMask
  --    @Aref SysGroupAttrMask SysGroupAttrMask
  -- 

   subtype pwr_tSysGroupAttrMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:850

   subtype pwr_mSysGroupAttrMask is unsigned;
   pwr_mSysGroupAttrMask_UserInherit : constant pwr_mSysGroupAttrMask := 1;  -- pwr_baseclasses.h:854

  --_* Enum: TextAttrEnum
  --    @Aref TextAttrEnum TextAttrEnum
  -- 

   subtype pwr_tTextAttrEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:860

   type pwr_eTextAttrEnum is 
     (pwr_eTextAttrEnum_SmallBold,
      pwr_eTextAttrEnum_Small,
      pwr_eTextAttrEnum_Medium,
      pwr_eTextAttrEnum_Large);
   pragma Convention (C, pwr_eTextAttrEnum);  -- pwr_baseclasses.h:867

  --_* Mask: ThreadOptionsMask
  --    @Aref ThreadOptionsMask ThreadOptionsMask
  -- 

   subtype pwr_tThreadOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:873

   subtype pwr_mThreadOptionsMask is unsigned;
   pwr_mThreadOptionsMask_OverExecScanAlways : constant pwr_mThreadOptionsMask := 1;
   pwr_mThreadOptionsMask_OverExecScanSingle : constant pwr_mThreadOptionsMask := 2;  -- pwr_baseclasses.h:878

  --_* Enum: TimeResolutionEnum
  --    @Aref TimeResolutionEnum TimeResolutionEnum
  -- 

   subtype pwr_tTimeResolutionEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:884

   type pwr_eTimeResolutionEnum is 
     (pwr_eTimeResolutionEnum_Second,
      pwr_eTimeResolutionEnum_Nanosecond);
   pragma Convention (C, pwr_eTimeResolutionEnum);  -- pwr_baseclasses.h:889

  --_* Enum: TrueFalseEnum
  --    @Aref TrueFalseEnum TrueFalseEnum
  -- 

   subtype pwr_tTrueFalseEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:895

   type pwr_eTrueFalseEnum is 
     (pwr_eTrueFalseEnum_False,
      pwr_eTrueFalseEnum_True);
   pragma Convention (C, pwr_eTrueFalseEnum);  -- pwr_baseclasses.h:900

  --_* Enum: UpDownEnum
  --    @Aref UpDownEnum UpDownEnum
  -- 

   subtype pwr_tUpDownEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:906

   type pwr_eUpDownEnum is 
     (pwr_eUpDownEnum_Down,
      pwr_eUpDownEnum_Up);
   pragma Convention (C, pwr_eUpDownEnum);  -- pwr_baseclasses.h:911

  --_* Enum: VolumeDatabaseEnum
  --    @Aref VolumeDatabaseEnum VolumeDatabaseEnum
  -- 

   subtype pwr_tVolumeDatabaseEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:917

   type pwr_eVolumeDatabaseEnum is 
     (pwr_eVolumeDatabaseEnum_BerkeleyDb,
      pwr_eVolumeDatabaseEnum_MySql);
   pragma Convention (C, pwr_eVolumeDatabaseEnum);  -- pwr_baseclasses.h:922

  --_* Enum: WebTargetEnum
  --    @Aref WebTargetEnum WebTargetEnum
  -- 

   subtype pwr_tWebTargetEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:928

   type pwr_eWebTargetEnum is 
     (pwr_eWebTargetEnum_RightFrame,
      pwr_eWebTargetEnum_ParentWindow,
      pwr_eWebTargetEnum_SeparateWindow);
   pragma Convention (C, pwr_eWebTargetEnum);  -- pwr_baseclasses.h:934

  --_* Mask: XttGraphOptionsMask
  --    @Aref XttGraphOptionsMask XttGraphOptionsMask
  -- 

   subtype pwr_tXttGraphOptionsMask is pwr_h.pwr_tMask;  -- pwr_baseclasses.h:940

   subtype pwr_mXttGraphOptionsMask is unsigned;
   pwr_mXttGraphOptionsMask_FullScreen : constant pwr_mXttGraphOptionsMask := 1;
   pwr_mXttGraphOptionsMask_Maximize : constant pwr_mXttGraphOptionsMask := 2;
   pwr_mXttGraphOptionsMask_FullMaximize : constant pwr_mXttGraphOptionsMask := 4;
   pwr_mXttGraphOptionsMask_Iconify : constant pwr_mXttGraphOptionsMask := 8;
   pwr_mXttGraphOptionsMask_Menu : constant pwr_mXttGraphOptionsMask := 16;
   pwr_mXttGraphOptionsMask_Scrollbars : constant pwr_mXttGraphOptionsMask := 32;
   pwr_mXttGraphOptionsMask_Navigator : constant pwr_mXttGraphOptionsMask := 64;  -- pwr_baseclasses.h:950

  --_* Enum: YesNoEnum
  --    @Aref YesNoEnum YesNoEnum
  -- 

   subtype pwr_tYesNoEnum is pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:956

   type pwr_eYesNoEnum is 
     (pwr_eYesNoEnum_No,
      pwr_eYesNoEnum_Yes);
   pragma Convention (C, pwr_eYesNoEnum);  -- pwr_baseclasses.h:961

  --_* Class: Bi
  --    Body:  RtBody
  --    @Aref Bi pwr_sClass_Bi
  -- 

   type pwr_sClass_Bi is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:973
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:974
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:975
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:976
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:977
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:978
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:979
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:980
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:981
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:982
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:983
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:984
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:985
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Bi);  -- pwr_baseclasses.h:986

   --  skipped anonymous struct anon_93

  --_* Class: Bo
  --    Body:  RtBody
  --    @Aref Bo pwr_sClass_Bo
  -- 

   type pwr_sClass_Bo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1000
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1001
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1002
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1003
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1004
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1005
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1006
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1007
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1008
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1009
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1010
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1011
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1012
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Bo);  -- pwr_baseclasses.h:1013

   --  skipped anonymous struct anon_94

  --_* Class: CircBuffHeader
  --    Body:  RtBody
  --    @Aref CircBuffHeader pwr_sClass_CircBuffHeader
  -- 

   type pwr_sClass_CircBuffHeader is record
      FirstIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1027
      LastIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1028
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1029
      ElementSize : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1030
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuffHeader);  -- pwr_baseclasses.h:1031

   --  skipped anonymous struct anon_95

  --_* Class: MultiViewElement
  --    Body:  RtBody
  --    @Aref MultiViewElement pwr_sClass_MultiViewElement
  -- 

   type pwr_sClass_MultiViewElement is record
      Name : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1045
      c_Type : aliased pwr_tMultiViewContentEnum;  -- pwr_baseclasses.h:1046
      Action : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1047
      X : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1048
      Y : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1049
      Width : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1050
      Height : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1051
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1052
      Options : aliased pwr_tMultiViewElemOptionsMask;  -- pwr_baseclasses.h:1053
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_MultiViewElement);  -- pwr_baseclasses.h:1054

   --  skipped anonymous struct anon_96

  --_* Class: SymbolDefinition
  --    Body:  RtBody
  --    @Aref SymbolDefinition pwr_sClass_SymbolDefinition
  -- 

   type pwr_sClass_SymbolDefinition is record
      Name : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1068
      Value : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1069
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SymbolDefinition);  -- pwr_baseclasses.h:1070

   --  skipped anonymous struct anon_97

  --_* Class: AArithm
  --    Body:  RtBody
  --    @Aref AArithm pwr_sClass_aarithm
  -- 

   type pwr_sClass_aarithm is record
      AIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1084
      AIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1085
      AIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1086
      AIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1087
      AIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1088
      AIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1089
      AIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1090
      AIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1091
      AIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1092
      AIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1093
      AIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1094
      AIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1095
      AIn7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1096
      AIn7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1097
      AIn8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1098
      AIn8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1099
      DIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1100
      DIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1101
      DIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1102
      DIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1103
      DIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1104
      DIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1105
      DIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1106
      DIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1107
      DIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1108
      DIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1109
      DIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1110
      DIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1111
      DIn7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1112
      DIn7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1113
      DIn8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1114
      DIn8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1115
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1116
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_aarithm);  -- pwr_baseclasses.h:1117

   --  skipped anonymous struct anon_98

  --_* Class: AArithm
  --    Body:  DevBody
  --    @Aref AArithm pwr_sdClass_AArithm
  -- 

   type pwr_sdClass_AArithm is record
      Expr : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1125
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1126
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AArithm);  -- pwr_baseclasses.h:1127

   --  skipped anonymous struct anon_99

  --_* Class: AArray100
  --    Body:  RtBody
  --    @Aref AArray100 pwr_sClass_AArray100
  -- 

   type pwr_sClass_AArray100_Value_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_AArray100 is record
      Value : aliased pwr_sClass_AArray100_Value_array;  -- pwr_baseclasses.h:1141
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AArray100);  -- pwr_baseclasses.h:1142

   --  skipped anonymous struct anon_100

  --_* Class: AArray500
  --    Body:  RtBody
  --    @Aref AArray500 pwr_sClass_AArray500
  -- 

   type pwr_sClass_AArray500_Value_array is array (0 .. 499) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_AArray500 is record
      Value : aliased pwr_sClass_AArray500_Value_array;  -- pwr_baseclasses.h:1156
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AArray500);  -- pwr_baseclasses.h:1157

   --  skipped anonymous struct anon_101

  --_* Class: Abs
  --    Body:  RtBody
  --    @Aref Abs pwr_sClass_Abs
  -- 

   type pwr_sClass_Abs is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1171
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1172
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1173
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Abs);  -- pwr_baseclasses.h:1174

   --  skipped anonymous struct anon_102

  --_* Class: Abs
  --    Body:  DevBody
  --    @Aref Abs pwr_sdClass_Abs
  -- 

   type pwr_sdClass_Abs is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1182
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Abs);  -- pwr_baseclasses.h:1183

   --  skipped anonymous struct anon_103

  --_* Class: ACos
  --    Body:  RtBody
  --    @Aref ACos pwr_sClass_ACos
  -- 

   type pwr_sClass_ACos is record
      inP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1197
      c_in : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1198
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1199
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1200
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1201
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ACos);  -- pwr_baseclasses.h:1202

   --  skipped anonymous struct anon_104

  --_* Class: ACos
  --    Body:  DevBody
  --    @Aref ACos pwr_sdClass_ACos
  -- 

   type pwr_sdClass_ACos is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1210
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ACos);  -- pwr_baseclasses.h:1211

   --  skipped anonymous struct anon_105

  --_* Class: Add
  --    Body:  RtBody
  --    @Aref Add pwr_sClass_Add
  -- 

   type pwr_sClass_Add is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1225
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1226
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1227
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1228
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1229
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1230
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1231
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1232
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1233
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1234
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1235
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1236
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1237
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1238
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1239
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1240
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1241
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Add);  -- pwr_baseclasses.h:1242

   --  skipped anonymous struct anon_106

  --_* Class: Add
  --    Body:  DevBody
  --    @Aref Add pwr_sdClass_Add
  -- 

   type pwr_sdClass_Add is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1250
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Add);  -- pwr_baseclasses.h:1251

   --  skipped anonymous struct anon_107

  --_* Class: Adelay
  --    Body:  RtBody
  --    @Aref Adelay pwr_sClass_adelay
  -- 

   type pwr_sClass_adelay_TimVect_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_adelay is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1265
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1266
      TimP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1267
      Tim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1268
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1269
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1270
      TimVect : aliased pwr_sClass_adelay_TimVect_array;  -- pwr_baseclasses.h:1271
      StoInd : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1272
      MaxCount : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1273
      StoredNumbers : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1274
      Count : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1275
      AccTim : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1276
      MinTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1277
      MaxTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1278
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_adelay);  -- pwr_baseclasses.h:1279

   --  skipped anonymous struct anon_108

  --_* Class: Adelay
  --    Body:  DevBody
  --    @Aref Adelay pwr_sdClass_Adelay
  -- 

   type pwr_sdClass_Adelay is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1287
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Adelay);  -- pwr_baseclasses.h:1288

   --  skipped anonymous struct anon_109

  --_* Class: Ai
  --    Body:  RtBody
  --    @Aref Ai pwr_sClass_Ai
  -- 

   type pwr_sClass_Ai_FilterAttribute_array is array (0 .. 3) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_Ai is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1302
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1303
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1304
      ActualValue : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1305
      InitialValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1306
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:1307
      NoOfDecimals : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:1308
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1309
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1310
      SigValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1311
      RawValue : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:1312
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1313
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1314
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1315
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1316
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1317
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1318
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1319
      FilterType : aliased pwr_tAiFilterTypeEnum;  -- pwr_baseclasses.h:1320
      FilterAttribute : aliased pwr_sClass_Ai_FilterAttribute_array;  -- pwr_baseclasses.h:1321
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Ai);  -- pwr_baseclasses.h:1322

   --  skipped anonymous struct anon_110

  --_* Class: AiArea
  --    Body:  RtBody
  --    @Aref AiArea pwr_sClass_AiArea
  -- 

   type pwr_sClass_AiArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_AiArea is record
      Value : aliased pwr_sClass_AiArea_Value_array;  -- pwr_baseclasses.h:1336
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AiArea);  -- pwr_baseclasses.h:1337

   --  skipped anonymous struct anon_111

  --_* Class: AlarmCategory
  --    Body:  RtBody
  --    @Aref AlarmCategory pwr_sClass_AlarmCategory
  -- 

   type pwr_sClass_AlarmCategory_Members_array is array (0 .. 99) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_AlarmCategory is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1351
      Text : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:1352
      EventPriority : aliased pwr_tEventPrioMask;  -- pwr_baseclasses.h:1353
      Members : aliased pwr_sClass_AlarmCategory_Members_array;  -- pwr_baseclasses.h:1354
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AlarmCategory);  -- pwr_baseclasses.h:1355

   --  skipped anonymous struct anon_112

  --_* Class: AlarmView
  --    Body:  RtBody
  --    @Aref AlarmView pwr_sClass_AlarmView
  -- 

   type pwr_sClass_AlarmView is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1369
      Name : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:1370
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AlarmView);  -- pwr_baseclasses.h:1371

   --  skipped anonymous struct anon_113

  --_* Class: And
  --    Body:  RtBody
  --    @Aref And pwr_sClass_and
  -- 

   type pwr_sClass_and is record
      In1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1385
      In1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1386
      In2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1387
      In2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1388
      In3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1389
      In3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1390
      In4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1391
      In4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1392
      In5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1393
      In5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1394
      In6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1395
      In6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1396
      In7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1397
      In7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1398
      In8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1399
      In8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1400
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1401
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_and);  -- pwr_baseclasses.h:1402

   --  skipped anonymous struct anon_114

  --_* Class: And
  --    Body:  DevBody
  --    @Aref And pwr_sdClass_And
  -- 

   type pwr_sdClass_And is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1410
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_And);  -- pwr_baseclasses.h:1411

   --  skipped anonymous struct anon_115

  --_* Class: Ao
  --    Body:  RtBody
  --    @Aref Ao pwr_sClass_Ao
  -- 

   type pwr_sClass_Ao is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1425
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1426
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1427
      ActualValue : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1428
      InitialValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1429
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:1430
      NoOfDecimals : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:1431
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1432
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1433
      SigValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1434
      RawValue : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:1435
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1436
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1437
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1438
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1439
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1440
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1441
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1442
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Ao);  -- pwr_baseclasses.h:1443

   --  skipped anonymous struct anon_116

  --_* Class: AoArea
  --    Body:  RtBody
  --    @Aref AoArea pwr_sClass_AoArea
  -- 

   type pwr_sClass_AoArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_AoArea is record
      Value : aliased pwr_sClass_AoArea_Value_array;  -- pwr_baseclasses.h:1457
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AoArea);  -- pwr_baseclasses.h:1458

   --  skipped anonymous struct anon_117

  --_* Class: ApCollect
  --    Body:  RtBody
  --    @Aref ApCollect pwr_sClass_ApCollect
  -- 

   type pwr_sClass_ApCollect_Ap_array is array (0 .. 23) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ApCollect is record
      ApIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1472
      ApIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1473
      ApIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1474
      ApIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1475
      ApIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1476
      ApIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1477
      ApIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1478
      ApIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1479
      ApIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1480
      ApIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1481
      ApIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1482
      ApIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1483
      ApIn7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1484
      ApIn7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1485
      ApIn8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1486
      ApIn8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1487
      ApIn9P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1488
      ApIn9 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1489
      ApIn10P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1490
      ApIn10 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1491
      ApIn11P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1492
      ApIn11 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1493
      ApIn12P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1494
      ApIn12 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1495
      ApIn13P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1496
      ApIn13 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1497
      ApIn14P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1498
      ApIn14 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1499
      ApIn15P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1500
      ApIn15 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1501
      ApIn16P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1502
      ApIn16 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1503
      ApIn17P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1504
      ApIn17 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1505
      ApIn18P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1506
      ApIn18 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1507
      ApIn19P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1508
      ApIn19 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1509
      ApIn20P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1510
      ApIn20 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1511
      ApIn21P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1512
      ApIn21 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1513
      ApIn22P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1514
      ApIn22 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1515
      ApIn23P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1516
      ApIn23 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1517
      ApIn24P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1518
      ApIn24 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1519
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1520
      Ap : aliased pwr_sClass_ApCollect_Ap_array;  -- pwr_baseclasses.h:1521
      OutDataP : System.Address;  -- pwr_baseclasses.h:1522
      OutData_ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:1523
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ApCollect);  -- pwr_baseclasses.h:1524

   --  skipped anonymous struct anon_118

  --_* Class: ApCollect
  --    Body:  DevBody
  --    @Aref ApCollect pwr_sdClass_ApCollect
  -- 

   type pwr_sdClass_ApCollect is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1532
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ApCollect);  -- pwr_baseclasses.h:1533

   --  skipped anonymous struct anon_119

  --_* Class: ApDistribute
  --    Body:  RtBody
  --    @Aref ApDistribute pwr_sClass_ApDistribute
  -- 

   type pwr_sClass_ApDistribute is record
      DataInP : System.Address;  -- pwr_baseclasses.h:1547
      DataIn : System.Address;  -- pwr_baseclasses.h:1548
      ApOut1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1549
      ApOut2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1550
      ApOut3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1551
      ApOut4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1552
      ApOut5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1553
      ApOut6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1554
      ApOut7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1555
      ApOut8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1556
      ApOut9 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1557
      ApOut10 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1558
      ApOut11 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1559
      ApOut12 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1560
      ApOut13 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1561
      ApOut14 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1562
      ApOut15 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1563
      ApOut16 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1564
      ApOut17 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1565
      ApOut18 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1566
      ApOut19 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1567
      ApOut20 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1568
      ApOut21 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1569
      ApOut22 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1570
      ApOut23 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1571
      ApOut24 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1572
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1573
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ApDistribute);  -- pwr_baseclasses.h:1574

   --  skipped anonymous struct anon_120

  --_* Class: ApDistribute
  --    Body:  DevBody
  --    @Aref ApDistribute pwr_sdClass_ApDistribute
  -- 

   type pwr_sdClass_ApDistribute is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1582
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ApDistribute);  -- pwr_baseclasses.h:1583

   --  skipped anonymous struct anon_121

  --_* Class: AppGraph
  --    Body:  RtBody
  --    @Aref AppGraph pwr_sClass_AppGraph
  -- 

   type pwr_sClass_AppGraph is record
      Name : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1597
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1598
      Image : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1599
      ConfigurationStatus : aliased pwr_class_h.pwr_tConfigStatusEnum;  -- pwr_baseclasses.h:1600
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AppGraph);  -- pwr_baseclasses.h:1601

   --  skipped anonymous struct anon_122

  --_* Class: ApplDistribute
  --    Body:  DevBody
  --    @Aref ApplDistribute pwr_sdClass_ApplDistribute
  -- 

   type pwr_sdClass_ApplDistribute is record
      Source : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1615
      Target : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1616
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ApplDistribute);  -- pwr_baseclasses.h:1617

   --  skipped anonymous struct anon_123

  --_* Class: Application
  --    Body:  RtBody
  --    @Aref Application pwr_sClass_Application
  -- 

   type pwr_sClass_Application is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1631
      Anix : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1632
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Application);  -- pwr_baseclasses.h:1633

   --  skipped anonymous struct anon_124

  --_* Class: Application
  --    Body:  DevBody
  --    @Aref Application pwr_sdClass_Application
  -- 

   type pwr_sdClass_Application is record
      BuildCmd : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1641
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Application);  -- pwr_baseclasses.h:1642

   --  skipped anonymous struct anon_125

  --_* Class: AppLink
  --    Body:  RtBody
  --    @Aref AppLink pwr_sClass_AppLink
  -- 

   type pwr_sClass_AppLink is record
      URL : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:1656
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1657
      Image : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1658
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AppLink);  -- pwr_baseclasses.h:1659

   --  skipped anonymous struct anon_126

  --_* Class: ASin
  --    Body:  RtBody
  --    @Aref ASin pwr_sClass_ASin
  -- 

   type pwr_sClass_ASin is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1673
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1674
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1675
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1676
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1677
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ASin);  -- pwr_baseclasses.h:1678

   --  skipped anonymous struct anon_127

  --_* Class: ASin
  --    Body:  DevBody
  --    @Aref ASin pwr_sdClass_ASin
  -- 

   type pwr_sdClass_ASin is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1686
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ASin);  -- pwr_baseclasses.h:1687

   --  skipped anonymous struct anon_128

  --_* Class: ASup
  --    Body:  RtBody
  --    @Aref ASup pwr_sClass_ASup
  -- 

   type pwr_sClass_ASup is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1701
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1702
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1703
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1704
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1705
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1706
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1707
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1708
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1709
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1710
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1711
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:1712
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:1713
      EventFlags : aliased pwr_tEventFlagsMask;  -- pwr_baseclasses.h:1714
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1715
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:1716
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1717
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1718
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1719
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1720
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1721
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1722
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1723
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1724
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1725
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1726
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1727
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:1728
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1729
      CtrlLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1730
      Hysteres : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1731
      High : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1732
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:1733
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1734
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1735
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1736
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1737
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1738
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1739
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:1740
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1741
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1742
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1743
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ASup);  -- pwr_baseclasses.h:1744

   --  skipped anonymous struct anon_129

  --_* Class: ASup
  --    Body:  DevBody
  --    @Aref ASup pwr_sdClass_ASup
  -- 

   type pwr_sdClass_ASup is record
      ShowDetectText : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1752
      LockAttribute : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1753
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1754
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ASup);  -- pwr_baseclasses.h:1755

   --  skipped anonymous struct anon_130

  --_* Class: ASupComp
  --    Body:  RtBody
  --    @Aref ASupComp pwr_sClass_ASupComp
  -- 

   type pwr_sClass_ASupComp is record
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1769
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1770
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1771
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1772
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1773
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1774
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1775
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1776
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:1777
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:1778
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:1779
      EventFlags : aliased pwr_tEventFlagsMask;  -- pwr_baseclasses.h:1780
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1781
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:1782
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:1783
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1784
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1785
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1786
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1787
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1788
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1789
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1790
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1791
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1792
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1793
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:1794
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1795
      CtrlLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1796
      Hysteres : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1797
      High : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1798
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:1799
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1800
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1801
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:1802
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1803
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1804
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1805
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:1806
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:1807
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1808
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1809
      PlcConnect : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1810
      LockAttribute : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1811
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ASupComp);  -- pwr_baseclasses.h:1812

   --  skipped anonymous struct anon_131

  --_* Class: ASupCompFo
  --    Body:  RtBody
  --    @Aref ASupCompFo pwr_sClass_ASupCompFo
  -- 

   type pwr_sClass_ASupCompFo is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1826
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1827
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1828
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1829
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1830
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1831
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1832
      PlcConnect : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:1833
      PlcConnectP : System.Address;  -- pwr_baseclasses.h:1834
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ASupCompFo);  -- pwr_baseclasses.h:1835

   --  skipped anonymous struct anon_132

  --_* Class: ASupCompFo
  --    Body:  DevBody
  --    @Aref ASupCompFo pwr_sdClass_ASupCompFo
  -- 

   type pwr_sdClass_ASupCompFo is record
      ShowDetectText : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1843
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1844
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ASupCompFo);  -- pwr_baseclasses.h:1845

   --  skipped anonymous struct anon_133

  --_* Class: AtAdd
  --    Body:  RtBody
  --    @Aref AtAdd pwr_sClass_AtAdd
  -- 

   type pwr_sClass_AtAdd is record
      ATimeP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1859
      ATime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1860
      DTimeP : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:1861
      DTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:1862
      ActVal : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1863
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtAdd);  -- pwr_baseclasses.h:1864

   --  skipped anonymous struct anon_134

  --_* Class: AtAdd
  --    Body:  DevBody
  --    @Aref AtAdd pwr_sdClass_AtAdd
  -- 

   type pwr_sdClass_AtAdd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1872
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtAdd);  -- pwr_baseclasses.h:1873

   --  skipped anonymous struct anon_135

  --_* Class: ATan
  --    Body:  RtBody
  --    @Aref ATan pwr_sClass_ATan
  -- 

   type pwr_sClass_ATan is record
      inP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1887
      c_in : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1888
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1889
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1890
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:1891
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ATan);  -- pwr_baseclasses.h:1892

   --  skipped anonymous struct anon_136

  --_* Class: ATan
  --    Body:  DevBody
  --    @Aref ATan pwr_sdClass_ATan
  -- 

   type pwr_sdClass_ATan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1900
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ATan);  -- pwr_baseclasses.h:1901

   --  skipped anonymous struct anon_137

  --_* Class: AtDtSub
  --    Body:  RtBody
  --    @Aref AtDtSub pwr_sClass_AtDtSub
  -- 

   type pwr_sClass_AtDtSub is record
      ATimeP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1915
      ATime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1916
      DTimeP : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:1917
      DTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:1918
      ActVal : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1919
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtDtSub);  -- pwr_baseclasses.h:1920

   --  skipped anonymous struct anon_138

  --_* Class: AtDtSub
  --    Body:  DevBody
  --    @Aref AtDtSub pwr_sdClass_AtDtSub
  -- 

   type pwr_sdClass_AtDtSub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1928
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtDtSub);  -- pwr_baseclasses.h:1929

   --  skipped anonymous struct anon_139

  --_* Class: AtEqual
  --    Body:  RtBody
  --    @Aref AtEqual pwr_sClass_AtEqual
  -- 

   type pwr_sClass_AtEqual is record
      ATime1P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1943
      ATime1 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1944
      ATime2P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1945
      ATime2 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1946
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1947
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtEqual);  -- pwr_baseclasses.h:1948

   --  skipped anonymous struct anon_140

  --_* Class: AtEqual
  --    Body:  DevBody
  --    @Aref AtEqual pwr_sdClass_AtEqual
  -- 

   type pwr_sdClass_AtEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1956
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtEqual);  -- pwr_baseclasses.h:1957

   --  skipped anonymous struct anon_141

  --_* Class: AtGreaterThan
  --    Body:  RtBody
  --    @Aref AtGreaterThan pwr_sClass_AtGreaterThan
  -- 

   type pwr_sClass_AtGreaterThan is record
      ATime1P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1971
      ATime1 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1972
      ATime2P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1973
      ATime2 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1974
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:1975
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtGreaterThan);  -- pwr_baseclasses.h:1976

   --  skipped anonymous struct anon_142

  --_* Class: AtGreaterThan
  --    Body:  DevBody
  --    @Aref AtGreaterThan pwr_sdClass_AtGreaterThan
  -- 

   type pwr_sdClass_AtGreaterThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:1984
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtGreaterThan);  -- pwr_baseclasses.h:1985

   --  skipped anonymous struct anon_143

  --_* Class: AtLessThan
  --    Body:  RtBody
  --    @Aref AtLessThan pwr_sClass_AtLessThan
  -- 

   type pwr_sClass_AtLessThan is record
      ATime1P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:1999
      ATime1 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2000
      ATime2P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2001
      ATime2 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2002
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2003
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtLessThan);  -- pwr_baseclasses.h:2004

   --  skipped anonymous struct anon_144

  --_* Class: AtLessThan
  --    Body:  DevBody
  --    @Aref AtLessThan pwr_sdClass_AtLessThan
  -- 

   type pwr_sdClass_AtLessThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2012
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtLessThan);  -- pwr_baseclasses.h:2013

   --  skipped anonymous struct anon_145

  --_* Class: AToDt
  --    Body:  RtBody
  --    @Aref AToDt pwr_sClass_AToDt
  -- 

   type pwr_sClass_AToDt is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2027
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2028
      DTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:2029
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AToDt);  -- pwr_baseclasses.h:2030

   --  skipped anonymous struct anon_146

  --_* Class: AToDt
  --    Body:  DevBody
  --    @Aref AToDt pwr_sdClass_AToDt
  -- 

   type pwr_sdClass_AToDt is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2038
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AToDt);  -- pwr_baseclasses.h:2039

   --  skipped anonymous struct anon_147

  --_* Class: AtoFloat64
  --    Body:  RtBody
  --    @Aref AtoFloat64 pwr_sClass_AtoFloat64
  -- 

   type pwr_sClass_AtoFloat64 is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2053
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2054
      ActVal : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:2055
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtoFloat64);  -- pwr_baseclasses.h:2056

   --  skipped anonymous struct anon_148

  --_* Class: AtoFloat64
  --    Body:  DevBody
  --    @Aref AtoFloat64 pwr_sdClass_AtoFloat64
  -- 

   type pwr_sdClass_AtoFloat64 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2064
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtoFloat64);  -- pwr_baseclasses.h:2065

   --  skipped anonymous struct anon_149

  --_* Class: AtoI
  --    Body:  RtBody
  --    @Aref AtoI pwr_sClass_AtoI
  -- 

   type pwr_sClass_AtoI is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2079
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2080
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2081
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtoI);  -- pwr_baseclasses.h:2082

   --  skipped anonymous struct anon_150

  --_* Class: AtoI
  --    Body:  DevBody
  --    @Aref AtoI pwr_sdClass_AtoI
  -- 

   type pwr_sdClass_AtoI is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2090
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtoI);  -- pwr_baseclasses.h:2091

   --  skipped anonymous struct anon_151

  --_* Class: AtoStr
  --    Body:  RtBody
  --    @Aref AtoStr pwr_sClass_AtoStr
  -- 

   type pwr_sClass_AtoStr is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2105
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2106
      Format : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2107
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2108
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtoStr);  -- pwr_baseclasses.h:2109

   --  skipped anonymous struct anon_152

  --_* Class: AtoStr
  --    Body:  DevBody
  --    @Aref AtoStr pwr_sdClass_AtoStr
  -- 

   type pwr_sdClass_AtoStr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2117
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtoStr);  -- pwr_baseclasses.h:2118

   --  skipped anonymous struct anon_153

  --_* Class: AtSub
  --    Body:  RtBody
  --    @Aref AtSub pwr_sClass_AtSub
  -- 

   type pwr_sClass_AtSub is record
      ATime1P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2132
      ATime1 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2133
      ATime2P : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2134
      ATime2 : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2135
      ActVal : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:2136
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AtSub);  -- pwr_baseclasses.h:2137

   --  skipped anonymous struct anon_154

  --_* Class: AtSub
  --    Body:  DevBody
  --    @Aref AtSub pwr_sdClass_AtSub
  -- 

   type pwr_sdClass_AtSub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2145
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_AtSub);  -- pwr_baseclasses.h:2146

   --  skipped anonymous struct anon_155

  --_* Class: ATv
  --    Body:  RtBody
  --    @Aref ATv pwr_sClass_ATv
  -- 

   type pwr_sClass_ATv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2160
      ActualValue : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2161
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ATv);  -- pwr_baseclasses.h:2162

   --  skipped anonymous struct anon_156

  --_* Class: Av
  --    Body:  RtBody
  --    @Aref Av pwr_sClass_Av
  -- 

   type pwr_sClass_Av is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2176
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2177
      ActualValue : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2178
      InitialValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2179
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:2180
      NoOfDecimals : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:2181
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2182
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2183
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:2184
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:2185
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:2186
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:2187
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:2188
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:2189
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2190
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Av);  -- pwr_baseclasses.h:2191

   --  skipped anonymous struct anon_157

  --_* Class: AvArea
  --    Body:  RtBody
  --    @Aref AvArea pwr_sClass_AvArea
  -- 

   type pwr_sClass_AvArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_AvArea is record
      Value : aliased pwr_sClass_AvArea_Value_array;  -- pwr_baseclasses.h:2205
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_AvArea);  -- pwr_baseclasses.h:2206

   --  skipped anonymous struct anon_158

  --_* Class: Backup
  --    Body:  RtBody
  --    @Aref Backup pwr_sClass_Backup
  -- 

   type pwr_sClass_Backup is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2220
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2221
      ObjectBackup : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2222
      DataName : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:2223
      Fast : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2224
      Status : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2225
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Backup);  -- pwr_baseclasses.h:2226

   --  skipped anonymous struct anon_159

  --_* Class: Backup
  --    Body:  DevBody
  --    @Aref Backup pwr_sdClass_Backup
  -- 

   type pwr_sdClass_Backup is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2234
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Backup);  -- pwr_baseclasses.h:2235

   --  skipped anonymous struct anon_160

  --_* Class: Backup_Conf
  --    Body:  RtBody
  --    @Aref Backup_Conf pwr_sClass_Backup_Conf
  -- 

   type pwr_sClass_Backup_Conf is record
      BackupFile : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2249
      CycleFast : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2250
      CycleSlow : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2251
      CntFast : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2252
      CntSlow : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2253
      BytesFast : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2254
      BytesSlow : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2255
      SegFast : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2256
      SegSlow : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2257
      ObjTimeFast : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2258
      ObjTimeSlow : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2259
      LastWrite : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2260
      DiskStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2261
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Backup_Conf);  -- pwr_baseclasses.h:2262

   --  skipped anonymous struct anon_161

  --_* Class: BaseReg
  --    Body:  RtBody
  --    @Aref BaseReg pwr_sClass_BaseReg
  -- 

   type pwr_sClass_BaseReg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2276
      Version : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:2277
      Path : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2278
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BaseReg);  -- pwr_baseclasses.h:2279

   --  skipped anonymous struct anon_162

  --_* Class: BCDDo
  --    Body:  RtBody
  --    @Aref BCDDo pwr_sClass_bcddo
  -- 

   type pwr_sClass_bcddo is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2293
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2294
      BCD0 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2295
      BCD1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2296
      BCD2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2297
      BCD3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2298
      BCD4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2299
      BCD5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2300
      BCD6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2301
      BCD7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2302
      BCD8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2303
      BCD9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2304
      BCDA : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2305
      BCDB : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2306
      BCDC : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2307
      BCDD : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2308
      BCDE : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2309
      BCDF : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2310
      Rest : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2311
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_bcddo);  -- pwr_baseclasses.h:2312

   --  skipped anonymous struct anon_163

  --_* Class: BCDDo
  --    Body:  DevBody
  --    @Aref BCDDo pwr_sdClass_BCDDo
  -- 

   type pwr_sdClass_BCDDo is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2320
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BCDDo);  -- pwr_baseclasses.h:2321

   --  skipped anonymous struct anon_164

  --_* Class: BiArea
  --    Body:  RtBody
  --    @Aref BiArea pwr_sClass_BiArea
  -- 

   type pwr_sClass_BiArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tUInt8;
   type pwr_sClass_BiArea is record
      Value : aliased pwr_sClass_BiArea_Value_array;  -- pwr_baseclasses.h:2335
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiArea);  -- pwr_baseclasses.h:2336

   --  skipped anonymous struct anon_165

  --_* Class: BiFloatArray100
  --    Body:  RtBody
  --    @Aref BiFloatArray100 pwr_sClass_BiFloatArray100
  -- 

   type pwr_sClass_BiFloatArray100_ActualValue_array is array (0 .. 99) of access pwr_h.pwr_tFloat32;
   type pwr_sClass_BiFloatArray100_InitialValue_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_BiFloatArray100 is record
      Super : aliased pwr_sClass_Bi;  -- pwr_baseclasses.h:2350
      ActualValue : aliased pwr_sClass_BiFloatArray100_ActualValue_array;  -- pwr_baseclasses.h:2351
      InitialValue : aliased pwr_sClass_BiFloatArray100_InitialValue_array;  -- pwr_baseclasses.h:2352
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiFloatArray100);  -- pwr_baseclasses.h:2353

   --  skipped anonymous struct anon_166

  --_* Class: BiFloatArray20
  --    Body:  RtBody
  --    @Aref BiFloatArray20 pwr_sClass_BiFloatArray20
  -- 

   type pwr_sClass_BiFloatArray20_ActualValue_array is array (0 .. 19) of access pwr_h.pwr_tFloat32;
   type pwr_sClass_BiFloatArray20_InitialValue_array is array (0 .. 19) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_BiFloatArray20 is record
      Super : aliased pwr_sClass_Bi;  -- pwr_baseclasses.h:2367
      ActualValue : aliased pwr_sClass_BiFloatArray20_ActualValue_array;  -- pwr_baseclasses.h:2368
      InitialValue : aliased pwr_sClass_BiFloatArray20_InitialValue_array;  -- pwr_baseclasses.h:2369
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiFloatArray20);  -- pwr_baseclasses.h:2370

   --  skipped anonymous struct anon_167

  --_* Class: BiIntArray100
  --    Body:  RtBody
  --    @Aref BiIntArray100 pwr_sClass_BiIntArray100
  -- 

   type pwr_sClass_BiIntArray100_ActualValue_array is array (0 .. 99) of access pwr_h.pwr_tInt32;
   type pwr_sClass_BiIntArray100_InitialValue_array is array (0 .. 99) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_BiIntArray100 is record
      Super : aliased pwr_sClass_Bi;  -- pwr_baseclasses.h:2384
      ActualValue : aliased pwr_sClass_BiIntArray100_ActualValue_array;  -- pwr_baseclasses.h:2385
      InitialValue : aliased pwr_sClass_BiIntArray100_InitialValue_array;  -- pwr_baseclasses.h:2386
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiIntArray100);  -- pwr_baseclasses.h:2387

   --  skipped anonymous struct anon_168

  --_* Class: BiIntArray20
  --    Body:  RtBody
  --    @Aref BiIntArray20 pwr_sClass_BiIntArray20
  -- 

   type pwr_sClass_BiIntArray20_ActualValue_array is array (0 .. 19) of access pwr_h.pwr_tInt32;
   type pwr_sClass_BiIntArray20_InitialValue_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_BiIntArray20 is record
      Super : aliased pwr_sClass_Bi;  -- pwr_baseclasses.h:2401
      ActualValue : aliased pwr_sClass_BiIntArray20_ActualValue_array;  -- pwr_baseclasses.h:2402
      InitialValue : aliased pwr_sClass_BiIntArray20_InitialValue_array;  -- pwr_baseclasses.h:2403
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiIntArray20);  -- pwr_baseclasses.h:2404

   --  skipped anonymous struct anon_169

  --_* Class: BiString80
  --    Body:  RtBody
  --    @Aref BiString80 pwr_sClass_BiString80
  -- 

   type pwr_sClass_BiString80 is record
      Super : aliased pwr_sClass_Bi;  -- pwr_baseclasses.h:2418
      ActualValue : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2419
      InitialValue : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2420
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BiString80);  -- pwr_baseclasses.h:2421

   --  skipped anonymous struct anon_170

  --_* Class: BoArea
  --    Body:  RtBody
  --    @Aref BoArea pwr_sClass_BoArea
  -- 

   type pwr_sClass_BoArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tUInt8;
   type pwr_sClass_BoArea is record
      Value : aliased pwr_sClass_BoArea_Value_array;  -- pwr_baseclasses.h:2435
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoArea);  -- pwr_baseclasses.h:2436

   --  skipped anonymous struct anon_171

  --_* Class: BodyText
  --    Body:  DevBody
  --    @Aref BodyText pwr_sdClass_BodyText
  -- 

   type pwr_sdClass_BodyText is record
      TextAttribute : aliased pwr_tTextAttrEnum;  -- pwr_baseclasses.h:2450
      FrameAttribute : aliased pwr_tFrameAttrEnum;  -- pwr_baseclasses.h:2451
      FrameWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2452
      FrameHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2453
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2454
      Text : aliased pwr_h.pwr_tText1024;  -- pwr_baseclasses.h:2455
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BodyText);  -- pwr_baseclasses.h:2456

   --  skipped anonymous struct anon_172

  --_* Class: BoFloatArray100
  --    Body:  RtBody
  --    @Aref BoFloatArray100 pwr_sClass_BoFloatArray100
  -- 

   type pwr_sClass_BoFloatArray100_ActualValue_array is array (0 .. 99) of access pwr_h.pwr_tFloat32;
   type pwr_sClass_BoFloatArray100_InitialValue_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_BoFloatArray100 is record
      Super : aliased pwr_sClass_Bo;  -- pwr_baseclasses.h:2470
      ActualValue : aliased pwr_sClass_BoFloatArray100_ActualValue_array;  -- pwr_baseclasses.h:2471
      InitialValue : aliased pwr_sClass_BoFloatArray100_InitialValue_array;  -- pwr_baseclasses.h:2472
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoFloatArray100);  -- pwr_baseclasses.h:2473

   --  skipped anonymous struct anon_173

  --_* Class: BoFloatArray20
  --    Body:  RtBody
  --    @Aref BoFloatArray20 pwr_sClass_BoFloatArray20
  -- 

   type pwr_sClass_BoFloatArray20_ActualValue_array is array (0 .. 19) of access pwr_h.pwr_tFloat32;
   type pwr_sClass_BoFloatArray20_InitialValue_array is array (0 .. 19) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_BoFloatArray20 is record
      Super : aliased pwr_sClass_Bo;  -- pwr_baseclasses.h:2487
      ActualValue : aliased pwr_sClass_BoFloatArray20_ActualValue_array;  -- pwr_baseclasses.h:2488
      InitialValue : aliased pwr_sClass_BoFloatArray20_InitialValue_array;  -- pwr_baseclasses.h:2489
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoFloatArray20);  -- pwr_baseclasses.h:2490

   --  skipped anonymous struct anon_174

  --_* Class: BoIntArray100
  --    Body:  RtBody
  --    @Aref BoIntArray100 pwr_sClass_BoIntArray100
  -- 

   type pwr_sClass_BoIntArray100_ActualValue_array is array (0 .. 99) of access pwr_h.pwr_tInt32;
   type pwr_sClass_BoIntArray100_InitialValue_array is array (0 .. 99) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_BoIntArray100 is record
      Super : aliased pwr_sClass_Bo;  -- pwr_baseclasses.h:2504
      ActualValue : aliased pwr_sClass_BoIntArray100_ActualValue_array;  -- pwr_baseclasses.h:2505
      InitialValue : aliased pwr_sClass_BoIntArray100_InitialValue_array;  -- pwr_baseclasses.h:2506
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoIntArray100);  -- pwr_baseclasses.h:2507

   --  skipped anonymous struct anon_175

  --_* Class: BoIntArray20
  --    Body:  RtBody
  --    @Aref BoIntArray20 pwr_sClass_BoIntArray20
  -- 

   type pwr_sClass_BoIntArray20_ActualValue_array is array (0 .. 19) of access pwr_h.pwr_tInt32;
   type pwr_sClass_BoIntArray20_InitialValue_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_BoIntArray20 is record
      Super : aliased pwr_sClass_Bo;  -- pwr_baseclasses.h:2521
      ActualValue : aliased pwr_sClass_BoIntArray20_ActualValue_array;  -- pwr_baseclasses.h:2522
      InitialValue : aliased pwr_sClass_BoIntArray20_InitialValue_array;  -- pwr_baseclasses.h:2523
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoIntArray20);  -- pwr_baseclasses.h:2524

   --  skipped anonymous struct anon_176

  --_* Class: BoString80
  --    Body:  RtBody
  --    @Aref BoString80 pwr_sClass_BoString80
  -- 

   type pwr_sClass_BoString80 is record
      Super : aliased pwr_sClass_Bo;  -- pwr_baseclasses.h:2538
      ActualValue : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2539
      InitialValue : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2540
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BoString80);  -- pwr_baseclasses.h:2541

   --  skipped anonymous struct anon_177

  --_* Class: BuildOptions
  --    Body:  RtBody
  --    @Aref BuildOptions pwr_sClass_BuildOptions
  -- 

   type pwr_sClass_BuildOptions_ObjectModules_array is array (0 .. 24, 0 .. 79) of aliased char;
   type pwr_sClass_BuildOptions_Archives_array is array (0 .. 24, 0 .. 79) of aliased char;
   type pwr_sClass_BuildOptions_ArchivePath_array is array (0 .. 9, 0 .. 79) of aliased char;
   type pwr_sClass_BuildOptions is record
      PlcProcess : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:2555
      SystemModules : aliased pwr_tBuildOptionsMask;  -- pwr_baseclasses.h:2556
      ObjectModules : aliased pwr_sClass_BuildOptions_ObjectModules_array;  -- pwr_baseclasses.h:2557
      Archives : aliased pwr_sClass_BuildOptions_Archives_array;  -- pwr_baseclasses.h:2558
      ArchivePath : aliased pwr_sClass_BuildOptions_ArchivePath_array;  -- pwr_baseclasses.h:2559
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BuildOptions);  -- pwr_baseclasses.h:2560

   --  skipped anonymous struct anon_178

  --_* Class: BusConfig
  --    Body:  RtBody
  --    @Aref BusConfig pwr_sClass_BusConfig
  -- 

   type pwr_sClass_BusConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2574
      BusNumber : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2575
      QComAutoConnectDisable : aliased pwr_tYesNoEnum;  -- pwr_baseclasses.h:2576
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BusConfig);  -- pwr_baseclasses.h:2577

   --  skipped anonymous struct anon_179

  --_* Class: BwAnd
  --    Body:  RtBody
  --    @Aref BwAnd pwr_sClass_BwAnd
  -- 

   type pwr_sClass_BwAnd is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2591
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2592
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2593
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2594
      Status : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2595
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwAnd);  -- pwr_baseclasses.h:2596

   --  skipped anonymous struct anon_180

  --_* Class: BwAnd
  --    Body:  DevBody
  --    @Aref BwAnd pwr_sdClass_BwAnd
  -- 

   type pwr_sdClass_BwAnd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2604
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwAnd);  -- pwr_baseclasses.h:2605

   --  skipped anonymous struct anon_181

  --_* Class: BwInv
  --    Body:  RtBody
  --    @Aref BwInv pwr_sClass_BwInv
  -- 

   type pwr_sClass_BwInv is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2619
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2620
      c_Out : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2621
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwInv);  -- pwr_baseclasses.h:2622

   --  skipped anonymous struct anon_182

  --_* Class: BwInv
  --    Body:  DevBody
  --    @Aref BwInv pwr_sdClass_BwInv
  -- 

   type pwr_sdClass_BwInv is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2630
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwInv);  -- pwr_baseclasses.h:2631

   --  skipped anonymous struct anon_183

  --_* Class: BwOr
  --    Body:  RtBody
  --    @Aref BwOr pwr_sClass_BwOr
  -- 

   type pwr_sClass_BwOr is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2645
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2646
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2647
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2648
      Status : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2649
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwOr);  -- pwr_baseclasses.h:2650

   --  skipped anonymous struct anon_184

  --_* Class: BwOr
  --    Body:  DevBody
  --    @Aref BwOr pwr_sdClass_BwOr
  -- 

   type pwr_sdClass_BwOr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2658
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwOr);  -- pwr_baseclasses.h:2659

   --  skipped anonymous struct anon_185

  --_* Class: BwRotateLeft
  --    Body:  RtBody
  --    @Aref BwRotateLeft pwr_sClass_BwRotateLeft
  -- 

   type pwr_sClass_BwRotateLeft is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2673
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2674
      NumP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2675
      Num : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2676
      c_Out : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2677
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwRotateLeft);  -- pwr_baseclasses.h:2678

   --  skipped anonymous struct anon_186

  --_* Class: BwRotateLeft
  --    Body:  DevBody
  --    @Aref BwRotateLeft pwr_sdClass_BwRotateLeft
  -- 

   type pwr_sdClass_BwRotateLeft is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2686
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwRotateLeft);  -- pwr_baseclasses.h:2687

   --  skipped anonymous struct anon_187

  --_* Class: BwRotateRight
  --    Body:  RtBody
  --    @Aref BwRotateRight pwr_sClass_BwRotateRight
  -- 

   type pwr_sClass_BwRotateRight is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2701
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2702
      NumP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2703
      Num : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2704
      c_Out : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2705
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwRotateRight);  -- pwr_baseclasses.h:2706

   --  skipped anonymous struct anon_188

  --_* Class: BwRotateRight
  --    Body:  DevBody
  --    @Aref BwRotateRight pwr_sdClass_BwRotateRight
  -- 

   type pwr_sdClass_BwRotateRight is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2714
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwRotateRight);  -- pwr_baseclasses.h:2715

   --  skipped anonymous struct anon_189

  --_* Class: BwShiftLeft
  --    Body:  RtBody
  --    @Aref BwShiftLeft pwr_sClass_BwShiftLeft
  -- 

   type pwr_sClass_BwShiftLeft is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2729
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2730
      NumP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2731
      Num : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2732
      c_Out : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2733
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwShiftLeft);  -- pwr_baseclasses.h:2734

   --  skipped anonymous struct anon_190

  --_* Class: BwShiftLeft
  --    Body:  DevBody
  --    @Aref BwShiftLeft pwr_sdClass_BwShiftLeft
  -- 

   type pwr_sdClass_BwShiftLeft is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2742
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwShiftLeft);  -- pwr_baseclasses.h:2743

   --  skipped anonymous struct anon_191

  --_* Class: BwShiftRight
  --    Body:  RtBody
  --    @Aref BwShiftRight pwr_sClass_BwShiftRight
  -- 

   type pwr_sClass_BwShiftRight is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2757
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2758
      NumP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2759
      Num : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2760
      c_Out : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2761
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_BwShiftRight);  -- pwr_baseclasses.h:2762

   --  skipped anonymous struct anon_192

  --_* Class: BwShiftRight
  --    Body:  DevBody
  --    @Aref BwShiftRight pwr_sdClass_BwShiftRight
  -- 

   type pwr_sdClass_BwShiftRight is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2770
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_BwShiftRight);  -- pwr_baseclasses.h:2771

   --  skipped anonymous struct anon_193

  --_* Class: CaArea
  --    Body:  RtBody
  --    @Aref CaArea pwr_sClass_CaArea
  -- 

   type pwr_sClass_CaArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_CaArea is record
      Value : aliased pwr_sClass_CaArea_Value_array;  -- pwr_baseclasses.h:2785
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CaArea);  -- pwr_baseclasses.h:2786

   --  skipped anonymous struct anon_194

  --_* Class: CArea
  --    Body:  RtBody
  --    @Aref CArea pwr_sClass_CArea
  -- 

   type pwr_sClass_CArea is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2800
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2801
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CArea);  -- pwr_baseclasses.h:2802

   --  skipped anonymous struct anon_195

  --_* Class: CArea
  --    Body:  DevBody
  --    @Aref CArea pwr_sdClass_CArea
  -- 

   type pwr_sdClass_CArea is record
      AreaWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2810
      AreaHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2811
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2812
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CArea);  -- pwr_baseclasses.h:2813

   --  skipped anonymous struct anon_196

  --_* Class: CArithm
  --    Body:  RtBody
  --    @Aref CArithm pwr_sClass_carithm
  -- 

   type pwr_sClass_carithm is record
      AIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2827
      AIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2828
      AIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2829
      AIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2830
      AIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2831
      AIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2832
      AIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2833
      AIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2834
      AIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2835
      AIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2836
      AIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2837
      AIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2838
      AIn7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2839
      AIn7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2840
      AIn8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2841
      AIn8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2842
      DIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2843
      DIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2844
      DIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2845
      DIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2846
      DIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2847
      DIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2848
      DIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2849
      DIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2850
      DIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2851
      DIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2852
      DIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2853
      DIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2854
      DIn7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2855
      DIn7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2856
      DIn8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2857
      DIn8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2858
      IIn1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2859
      IIn1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2860
      IIn2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2861
      IIn2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2862
      IIn3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2863
      IIn3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2864
      IIn4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2865
      IIn4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2866
      IIn5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2867
      IIn5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2868
      IIn6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2869
      IIn6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2870
      IIn7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2871
      IIn7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2872
      IIn8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2873
      IIn8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2874
      OutA1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2875
      OutA2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2876
      OutA3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2877
      OutA4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2878
      OutA5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2879
      OutA6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2880
      OutA7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2881
      OutA8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2882
      OutD1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2883
      OutD2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2884
      OutD3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2885
      OutD4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2886
      OutD5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2887
      OutD6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2888
      OutD7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2889
      OutD8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2890
      OutI1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2891
      OutI2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2892
      OutI3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2893
      OutI4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2894
      OutI5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2895
      OutI6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2896
      OutI7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2897
      OutI8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:2898
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_carithm);  -- pwr_baseclasses.h:2899

   --  skipped anonymous struct anon_197

  --_* Class: CArithm
  --    Body:  DevBody
  --    @Aref CArithm pwr_sdClass_CArithm
  -- 

   type pwr_sdClass_CArithm is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:2907
      Code : aliased pwr_h.pwr_tText1024;  -- pwr_baseclasses.h:2908
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CArithm);  -- pwr_baseclasses.h:2909

   --  skipped anonymous struct anon_198

  --_* Class: ChanAi
  --    Body:  RtBody
  --    @Aref ChanAi pwr_sClass_ChanAi
  -- 

   type pwr_sClass_ChanAi is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2923
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:2924
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:2925
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2926
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2927
      ScanInterval : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2928
      CalculateNewCoef : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2929
      RawValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2930
      RawValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2931
      ChannelSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2932
      ChannelSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2933
      SigValPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2934
      SigValPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2935
      SigValueUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:2936
      SensorTypeCode : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2937
      SensorPolyType : aliased pwr_tAiSensorTypeEnum;  -- pwr_baseclasses.h:2938
      SensorPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2939
      SensorPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2940
      SensorPolyCoef2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2941
      SensorSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2942
      SensorSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2943
      ActValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2944
      ActValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2945
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:2946
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanAi);  -- pwr_baseclasses.h:2947

   --  skipped anonymous struct anon_199

  --_* Class: ChanAit
  --    Body:  RtBody
  --    @Aref ChanAit pwr_sClass_ChanAit
  -- 

   type pwr_sClass_ChanAit_InValue_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanAit_OutValue_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanAit_Intercept_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanAit_Slope_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanAit_PolCoefficients_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanAit is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:2961
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:2962
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:2963
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2964
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2965
      ScanInterval : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:2966
      CalculateNewCoef : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2967
      RawValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2968
      RawValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2969
      ChannelSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2970
      ChannelSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2971
      SigValPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2972
      SigValPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:2973
      SigValueUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:2974
      SensorTypeCode : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2975
      SensorPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2976
      NoOfCoordinates : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:2977
      InValue : aliased pwr_sClass_ChanAit_InValue_array;  -- pwr_baseclasses.h:2978
      OutValue : aliased pwr_sClass_ChanAit_OutValue_array;  -- pwr_baseclasses.h:2979
      Intercept : aliased pwr_sClass_ChanAit_Intercept_array;  -- pwr_baseclasses.h:2980
      Slope : aliased pwr_sClass_ChanAit_Slope_array;  -- pwr_baseclasses.h:2981
      PolCoefficients : aliased pwr_sClass_ChanAit_PolCoefficients_array;  -- pwr_baseclasses.h:2982
      PolUsedFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:2983
      Date : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:2984
      Signature : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:2985
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:2986
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanAit);  -- pwr_baseclasses.h:2987

   --  skipped anonymous struct anon_200

  --_* Class: ChanAo
  --    Body:  RtBody
  --    @Aref ChanAo pwr_sClass_ChanAo
  -- 

   type pwr_sClass_ChanAo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3001
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3002
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3003
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3004
      TestOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3005
      TestValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3006
      FixedOutValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3007
      CalculateNewCoef : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3008
      OutPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3009
      OutPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3010
      OutPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3011
      ActValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3012
      ActValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3013
      SigValPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3014
      SigValPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3015
      SensorSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3016
      SensorSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3017
      SigValueUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3018
      ChannelSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3019
      ChannelSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3020
      RawValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3021
      RawValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3022
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3023
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanAo);  -- pwr_baseclasses.h:3024

   --  skipped anonymous struct anon_201

  --_* Class: ChanBi
  --    Body:  RtBody
  --    @Aref ChanBi pwr_sClass_ChanBi
  -- 

   type pwr_sClass_ChanBi is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3038
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3039
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3040
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3041
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3042
      ScanInterval : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3043
      CalculateNewCoef : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3044
      RawValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3045
      RawValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3046
      ChannelSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3047
      ChannelSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3048
      SigValPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3049
      SigValPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3050
      SigValueUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3051
      SensorTypeCode : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3052
      SensorPolyType : aliased pwr_tAiSensorTypeEnum;  -- pwr_baseclasses.h:3053
      SensorPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3054
      SensorPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3055
      SensorPolyCoef2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3056
      SensorSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3057
      SensorSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3058
      ActValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3059
      ActValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3060
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3061
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanBi);  -- pwr_baseclasses.h:3062

   --  skipped anonymous struct anon_202

  --_* Class: ChanBiBlob
  --    Body:  RtBody
  --    @Aref ChanBiBlob pwr_sClass_ChanBiBlob
  -- 

   type pwr_sClass_ChanBiBlob is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3076
      AttributeChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3077
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3078
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanBiBlob);  -- pwr_baseclasses.h:3079

   --  skipped anonymous struct anon_203

  --_* Class: ChanBo
  --    Body:  RtBody
  --    @Aref ChanBo pwr_sClass_ChanBo
  -- 

   type pwr_sClass_ChanBo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3093
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3094
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3095
      Size : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3096
      CalculateNewCoef : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3097
      OutPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3098
      OutPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3099
      OutPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3100
      ActValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3101
      ActValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3102
      SigValPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3103
      SigValPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3104
      SensorSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3105
      SensorSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3106
      SigValueUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3107
      ChannelSigValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3108
      ChannelSigValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3109
      RawValRangeLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3110
      RawValRangeHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3111
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3112
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanBo);  -- pwr_baseclasses.h:3113

   --  skipped anonymous struct anon_204

  --_* Class: ChanBoBlob
  --    Body:  RtBody
  --    @Aref ChanBoBlob pwr_sClass_ChanBoBlob
  -- 

   type pwr_sClass_ChanBoBlob is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3127
      AttributeChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3128
      Size : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3129
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanBoBlob);  -- pwr_baseclasses.h:3130

   --  skipped anonymous struct anon_205

  --_* Class: ChanCo
  --    Body:  RtBody
  --    @Aref ChanCo pwr_sClass_ChanCo
  -- 

   type pwr_sClass_ChanCo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3144
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3145
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3146
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3147
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3148
      SensorPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3149
      SensorPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3150
      SensorPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3151
      SensorPolyCoef2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3152
      SyncRawValue : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3153
      CounterZeroFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3154
      CounterSyncFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3155
      CounterSyncValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3156
      IntegrationSum : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3157
      IntegrationTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3158
      LastUpdateTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:3159
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3160
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanCo);  -- pwr_baseclasses.h:3161

   --  skipped anonymous struct anon_206

  --_* Class: ChanCot
  --    Body:  RtBody
  --    @Aref ChanCot pwr_sClass_ChanCot
  -- 

   type pwr_sClass_ChanCot_InValue_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanCot_OutValue_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanCot_Intercept_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanCot_Slope_array is array (0 .. 29) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanCot_PolCoefficients_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_ChanCot is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3175
      SigChanCon : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:3176
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3177
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3178
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3179
      SensorPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3180
      NoOfCoordinates : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3181
      InValue : aliased pwr_sClass_ChanCot_InValue_array;  -- pwr_baseclasses.h:3182
      OutValue : aliased pwr_sClass_ChanCot_OutValue_array;  -- pwr_baseclasses.h:3183
      Intercept : aliased pwr_sClass_ChanCot_Intercept_array;  -- pwr_baseclasses.h:3184
      Slope : aliased pwr_sClass_ChanCot_Slope_array;  -- pwr_baseclasses.h:3185
      PolCoefficients : aliased pwr_sClass_ChanCot_PolCoefficients_array;  -- pwr_baseclasses.h:3186
      PolUsedFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3187
      Date : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:3188
      Signature : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3189
      SyncRawValue : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3190
      CounterZeroFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3191
      CounterSyncFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3192
      CounterSyncValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3193
      IntegrationSum : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3194
      IntegrationTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3195
      LastUpdateTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:3196
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanCot);  -- pwr_baseclasses.h:3197

   --  skipped anonymous struct anon_207

  --_* Class: ChanD
  --    Body:  RtBody
  --    @Aref ChanD pwr_sClass_ChanD
  -- 

   type pwr_sClass_ChanD is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3211
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3212
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3213
      c_Type : aliased pwr_tDChanTypeEnum;  -- pwr_baseclasses.h:3214
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3215
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3216
      InvertOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3217
      TestOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3218
      TestValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3219
      FixedOutValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3220
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3221
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanD);  -- pwr_baseclasses.h:3222

   --  skipped anonymous struct anon_208

  --_* Class: ChanDi
  --    Body:  RtBody
  --    @Aref ChanDi pwr_sClass_ChanDi
  -- 

   type pwr_sClass_ChanDi is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3236
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3237
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3238
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3239
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3240
      InvertOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3241
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3242
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanDi);  -- pwr_baseclasses.h:3243

   --  skipped anonymous struct anon_209

  --_* Class: ChanDo
  --    Body:  RtBody
  --    @Aref ChanDo pwr_sClass_ChanDo
  -- 

   type pwr_sClass_ChanDo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3257
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3258
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3259
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3260
      InvertOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3261
      TestOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3262
      TestValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3263
      FixedOutValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3264
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3265
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanDo);  -- pwr_baseclasses.h:3266

   --  skipped anonymous struct anon_210

  --_* Class: ChanIi
  --    Body:  RtBody
  --    @Aref ChanIi pwr_sClass_ChanIi
  -- 

   type pwr_sClass_ChanIi is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3280
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3281
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3282
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3283
      ConversionOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3284
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3285
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanIi);  -- pwr_baseclasses.h:3286

   --  skipped anonymous struct anon_211

  --_* Class: ChanIo
  --    Body:  RtBody
  --    @Aref ChanIo pwr_sClass_ChanIo
  -- 

   type pwr_sClass_ChanIo is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3300
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3301
      Identity : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3302
      Number : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:3303
      TestOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3304
      TestValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3305
      FixedOutValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3306
      Representation : aliased pwr_tDataRepEnum;  -- pwr_baseclasses.h:3307
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ChanIo);  -- pwr_baseclasses.h:3308

   --  skipped anonymous struct anon_212

  --_* Class: CircBuff100k
  --    Body:  RtBody
  --    @Aref CircBuff100k pwr_sClass_CircBuff100k
  -- 

   type pwr_sClass_CircBuff100k_Data_array is array (0 .. 24999) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff100k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3322
      Data : aliased pwr_sClass_CircBuff100k_Data_array;  -- pwr_baseclasses.h:3323
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff100k);  -- pwr_baseclasses.h:3324

   --  skipped anonymous struct anon_213

  --_* Class: CircBuff10k
  --    Body:  RtBody
  --    @Aref CircBuff10k pwr_sClass_CircBuff10k
  -- 

   type pwr_sClass_CircBuff10k_Data_array is array (0 .. 2499) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff10k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3338
      Data : aliased pwr_sClass_CircBuff10k_Data_array;  -- pwr_baseclasses.h:3339
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff10k);  -- pwr_baseclasses.h:3340

   --  skipped anonymous struct anon_214

  --_* Class: CircBuff1k
  --    Body:  RtBody
  --    @Aref CircBuff1k pwr_sClass_CircBuff1k
  -- 

   type pwr_sClass_CircBuff1k_Data_array is array (0 .. 249) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff1k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3354
      Data : aliased pwr_sClass_CircBuff1k_Data_array;  -- pwr_baseclasses.h:3355
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff1k);  -- pwr_baseclasses.h:3356

   --  skipped anonymous struct anon_215

  --_* Class: CircBuff200k
  --    Body:  RtBody
  --    @Aref CircBuff200k pwr_sClass_CircBuff200k
  -- 

   type pwr_sClass_CircBuff200k_Data_array is array (0 .. 49999) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff200k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3370
      Data : aliased pwr_sClass_CircBuff200k_Data_array;  -- pwr_baseclasses.h:3371
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff200k);  -- pwr_baseclasses.h:3372

   --  skipped anonymous struct anon_216

  --_* Class: CircBuff20k
  --    Body:  RtBody
  --    @Aref CircBuff20k pwr_sClass_CircBuff20k
  -- 

   type pwr_sClass_CircBuff20k_Data_array is array (0 .. 4999) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff20k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3386
      Data : aliased pwr_sClass_CircBuff20k_Data_array;  -- pwr_baseclasses.h:3387
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff20k);  -- pwr_baseclasses.h:3388

   --  skipped anonymous struct anon_217

  --_* Class: CircBuff2k
  --    Body:  RtBody
  --    @Aref CircBuff2k pwr_sClass_CircBuff2k
  -- 

   type pwr_sClass_CircBuff2k_Data_array is array (0 .. 499) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_CircBuff2k is record
      Head : aliased pwr_sClass_CircBuffHeader;  -- pwr_baseclasses.h:3402
      Data : aliased pwr_sClass_CircBuff2k_Data_array;  -- pwr_baseclasses.h:3403
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CircBuff2k);  -- pwr_baseclasses.h:3404

   --  skipped anonymous struct anon_218

  --  Class: ClassVolumeConfig
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: ClassVolumeLoad
  --    Body:  RtBody
  --    @Aref ClassVolumeLoad pwr_sClass_ClassVolumeLoad
  -- 

   type pwr_sClass_ClassVolumeLoad is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3429
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ClassVolumeLoad);  -- pwr_baseclasses.h:3430

   --  skipped anonymous struct anon_219

  --_* Class: CloneVolumeConfig
  --    Body:  RtBody
  --    @Aref CloneVolumeConfig pwr_sClass_CloneVolumeConfig
  -- 

   type pwr_sClass_CloneVolumeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3444
      ParentVolume : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3445
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CloneVolumeConfig);  -- pwr_baseclasses.h:3446

   --  skipped anonymous struct anon_220

  --_* Class: Co
  --    Body:  RtBody
  --    @Aref Co pwr_sClass_Co
  -- 

   type pwr_sClass_Co is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3460
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3461
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3462
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3463
      NoOfDecimals : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:3464
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3465
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3466
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:3467
      RawValue : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3468
      AbsValue : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3469
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3470
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3471
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3472
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:3473
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:3474
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:3475
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3476
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Co);  -- pwr_baseclasses.h:3477

   --  skipped anonymous struct anon_221

  --_* Class: CoArea
  --    Body:  RtBody
  --    @Aref CoArea pwr_sClass_CoArea
  -- 

   type pwr_sClass_CoArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_CoArea is record
      Value : aliased pwr_sClass_CoArea_Value_array;  -- pwr_baseclasses.h:3491
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CoArea);  -- pwr_baseclasses.h:3492

   --  skipped anonymous struct anon_222

  --_* Class: CommonClassDistribute
  --    Body:  DevBody
  --    @Aref CommonClassDistribute pwr_sdClass_CommonClassDistribute
  -- 

   type pwr_sdClass_CommonClassDistribute is record
      TargetProject : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3506
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CommonClassDistribute);  -- pwr_baseclasses.h:3507

   --  skipped anonymous struct anon_223

  --_* Class: Comph
  --    Body:  RtBody
  --    @Aref Comph pwr_sClass_comph
  -- 

   type pwr_sClass_comph is record
      LimP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3521
      Lim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3522
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3523
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3524
      High : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3525
      Hysteres : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3526
      AccLim : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3527
      MinLim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3528
      MaxLim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3529
      AccHys : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3530
      MinHys : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3531
      MaxHys : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3532
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_comph);  -- pwr_baseclasses.h:3533

   --  skipped anonymous struct anon_224

  --_* Class: Comph
  --    Body:  DevBody
  --    @Aref Comph pwr_sdClass_Comph
  -- 

   type pwr_sdClass_Comph is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:3541
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Comph);  -- pwr_baseclasses.h:3542

   --  skipped anonymous struct anon_225

  --_* Class: Compl
  --    Body:  RtBody
  --    @Aref Compl pwr_sClass_compl
  -- 

   type pwr_sClass_compl is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3556
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3557
      LimP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3558
      Lim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3559
      Low : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:3560
      Hysteres : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3561
      AccLim : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3562
      MinLim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3563
      MaxLim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3564
      AccHys : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3565
      MinHys : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3566
      MaxHys : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3567
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_compl);  -- pwr_baseclasses.h:3568

   --  skipped anonymous struct anon_226

  --_* Class: Compl
  --    Body:  DevBody
  --    @Aref Compl pwr_sdClass_Compl
  -- 

   type pwr_sdClass_Compl is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:3576
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Compl);  -- pwr_baseclasses.h:3577

   --  skipped anonymous struct anon_227

  --_* Class: ConAnalog
  --    Body:  DevBody
  --    @Aref ConAnalog pwr_sdClass_ConAnalog
  -- 

   type pwr_sdClass_ConAnalog is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3591
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConAnalog);  -- pwr_baseclasses.h:3592

   --  skipped anonymous struct anon_228

  --_* Class: ConBlueStrOneArr
  --    Body:  DevBody
  --    @Aref ConBlueStrOneArr pwr_sdClass_ConBlueStrOneArr
  -- 

   type pwr_sdClass_ConBlueStrOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3606
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConBlueStrOneArr);  -- pwr_baseclasses.h:3607

   --  skipped anonymous struct anon_229

  --_* Class: ConDaMeNoArr
  --    Body:  DevBody
  --    @Aref ConDaMeNoArr pwr_sdClass_ConDaMeNoArr
  -- 

   type pwr_sdClass_ConDaMeNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3621
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaMeNoArr);  -- pwr_baseclasses.h:3622

   --  skipped anonymous struct anon_230

  --_* Class: ConDaMeOneArr
  --    Body:  DevBody
  --    @Aref ConDaMeOneArr pwr_sdClass_ConDaMeOneArr
  -- 

   type pwr_sdClass_ConDaMeOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3636
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaMeOneArr);  -- pwr_baseclasses.h:3637

   --  skipped anonymous struct anon_231

  --_* Class: ConDaMeTwoArr
  --    Body:  DevBody
  --    @Aref ConDaMeTwoArr pwr_sdClass_ConDaMeTwoArr
  -- 

   type pwr_sdClass_ConDaMeTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3651
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaMeTwoArr);  -- pwr_baseclasses.h:3652

   --  skipped anonymous struct anon_232

  --_* Class: ConData
  --    Body:  DevBody
  --    @Aref ConData pwr_sdClass_ConData
  -- 

   type pwr_sdClass_ConData is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3666
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConData);  -- pwr_baseclasses.h:3667

   --  skipped anonymous struct anon_233

  --_* Class: ConDataFeedback
  --    Body:  DevBody
  --    @Aref ConDataFeedback pwr_sdClass_ConDataFeedback
  -- 

   type pwr_sdClass_ConDataFeedback is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3681
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDataFeedback);  -- pwr_baseclasses.h:3682

   --  skipped anonymous struct anon_234

  --_* Class: ConDaThinNoArr
  --    Body:  DevBody
  --    @Aref ConDaThinNoArr pwr_sdClass_ConDaThinNoArr
  -- 

   type pwr_sdClass_ConDaThinNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3696
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaThinNoArr);  -- pwr_baseclasses.h:3697

   --  skipped anonymous struct anon_235

  --_* Class: ConDaThinOneArr
  --    Body:  DevBody
  --    @Aref ConDaThinOneArr pwr_sdClass_ConDaThinOneArr
  -- 

   type pwr_sdClass_ConDaThinOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3711
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaThinOneArr);  -- pwr_baseclasses.h:3712

   --  skipped anonymous struct anon_236

  --_* Class: ConDaThinTwoArr
  --    Body:  DevBody
  --    @Aref ConDaThinTwoArr pwr_sdClass_ConDaThinTwoArr
  -- 

   type pwr_sdClass_ConDaThinTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3726
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDaThinTwoArr);  -- pwr_baseclasses.h:3727

   --  skipped anonymous struct anon_237

  --_* Class: ConDigital
  --    Body:  DevBody
  --    @Aref ConDigital pwr_sdClass_ConDigital
  -- 

   type pwr_sdClass_ConDigital is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3741
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConDigital);  -- pwr_baseclasses.h:3742

   --  skipped anonymous struct anon_238

  --_* Class: ConExecuteOrder
  --    Body:  DevBody
  --    @Aref ConExecuteOrder pwr_sdClass_ConExecuteOrder
  -- 

   type pwr_sdClass_ConExecuteOrder is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3756
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConExecuteOrder);  -- pwr_baseclasses.h:3757

   --  skipped anonymous struct anon_239

  --_* Class: ConFeedbackAnalog
  --    Body:  DevBody
  --    @Aref ConFeedbackAnalog pwr_sdClass_ConFeedbackAnalog
  -- 

   type pwr_sdClass_ConFeedbackAnalog is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3771
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConFeedbackAnalog);  -- pwr_baseclasses.h:3772

   --  skipped anonymous struct anon_240

  --_* Class: ConFeedbackDigital
  --    Body:  DevBody
  --    @Aref ConFeedbackDigital pwr_sdClass_ConFeedbackDigital
  -- 

   type pwr_sdClass_ConFeedbackDigital is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3786
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConFeedbackDigital);  -- pwr_baseclasses.h:3787

   --  skipped anonymous struct anon_241

  --_* Class: ConGrafcet
  --    Body:  DevBody
  --    @Aref ConGrafcet pwr_sdClass_ConGrafcet
  -- 

   type pwr_sdClass_ConGrafcet is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3801
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConGrafcet);  -- pwr_baseclasses.h:3802

   --  skipped anonymous struct anon_242

  --_* Class: ConGreenTwoArr
  --    Body:  DevBody
  --    @Aref ConGreenTwoArr pwr_sdClass_ConGreenTwoArr
  -- 

   type pwr_sdClass_ConGreenTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3816
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConGreenTwoArr);  -- pwr_baseclasses.h:3817

   --  skipped anonymous struct anon_243

  --_* Class: ConMeNoArr
  --    Body:  DevBody
  --    @Aref ConMeNoArr pwr_sdClass_ConMeNoArr
  -- 

   type pwr_sdClass_ConMeNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3831
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConMeNoArr);  -- pwr_baseclasses.h:3832

   --  skipped anonymous struct anon_244

  --_* Class: ConMeOneArr
  --    Body:  DevBody
  --    @Aref ConMeOneArr pwr_sdClass_ConMeOneArr
  -- 

   type pwr_sdClass_ConMeOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3846
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConMeOneArr);  -- pwr_baseclasses.h:3847

   --  skipped anonymous struct anon_245

  --_* Class: ConMeTwoArr
  --    Body:  DevBody
  --    @Aref ConMeTwoArr pwr_sdClass_ConMeTwoArr
  -- 

   type pwr_sdClass_ConMeTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3861
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConMeTwoArr);  -- pwr_baseclasses.h:3862

   --  skipped anonymous struct anon_246

  --_* Class: ConReMeNoArr
  --    Body:  DevBody
  --    @Aref ConReMeNoArr pwr_sdClass_ConReMeNoArr
  -- 

   type pwr_sdClass_ConReMeNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3876
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConReMeNoArr);  -- pwr_baseclasses.h:3877

   --  skipped anonymous struct anon_247

  --_* Class: ConReMeOneArr
  --    Body:  DevBody
  --    @Aref ConReMeOneArr pwr_sdClass_ConReMeOneArr
  -- 

   type pwr_sdClass_ConReMeOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3891
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConReMeOneArr);  -- pwr_baseclasses.h:3892

   --  skipped anonymous struct anon_248

  --_* Class: ConReMeTwoArr
  --    Body:  DevBody
  --    @Aref ConReMeTwoArr pwr_sdClass_ConReMeTwoArr
  -- 

   type pwr_sdClass_ConReMeTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3906
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConReMeTwoArr);  -- pwr_baseclasses.h:3907

   --  skipped anonymous struct anon_249

  --_* Class: ConstAv
  --    Body:  RtBody
  --    @Aref ConstAv pwr_sClass_ConstAv
  -- 

   type pwr_sClass_ConstAv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3921
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:3922
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3923
      NoOfDecimals : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:3924
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3925
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3926
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ConstAv);  -- pwr_baseclasses.h:3927

   --  skipped anonymous struct anon_250

  --_* Class: ConstIv
  --    Body:  RtBody
  --    @Aref ConstIv pwr_sClass_ConstIv
  -- 

   type pwr_sClass_ConstIv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:3941
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:3942
      Unit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:3943
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:3944
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:3945
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ConstIv);  -- pwr_baseclasses.h:3946

   --  skipped anonymous struct anon_251

  --_* Class: ConStrMeNoArr
  --    Body:  DevBody
  --    @Aref ConStrMeNoArr pwr_sdClass_ConStrMeNoArr
  -- 

   type pwr_sdClass_ConStrMeNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3960
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConStrMeNoArr);  -- pwr_baseclasses.h:3961

   --  skipped anonymous struct anon_252

  --_* Class: ConThinNoArr
  --    Body:  DevBody
  --    @Aref ConThinNoArr pwr_sdClass_ConThinNoArr
  -- 

   type pwr_sdClass_ConThinNoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3975
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConThinNoArr);  -- pwr_baseclasses.h:3976

   --  skipped anonymous struct anon_253

  --_* Class: ConThinOneArr
  --    Body:  DevBody
  --    @Aref ConThinOneArr pwr_sdClass_ConThinOneArr
  -- 

   type pwr_sdClass_ConThinOneArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:3990
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConThinOneArr);  -- pwr_baseclasses.h:3991

   --  skipped anonymous struct anon_254

  --_* Class: ConThinTwoArr
  --    Body:  DevBody
  --    @Aref ConThinTwoArr pwr_sdClass_ConThinTwoArr
  -- 

   type pwr_sdClass_ConThinTwoArr is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:4005
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConThinTwoArr);  -- pwr_baseclasses.h:4006

   --  skipped anonymous struct anon_255

  --_* Class: ConTrace
  --    Body:  DevBody
  --    @Aref ConTrace pwr_sdClass_ConTrace
  -- 

   type pwr_sdClass_ConTrace is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:4020
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ConTrace);  -- pwr_baseclasses.h:4021

   --  skipped anonymous struct anon_256

  --_* Class: COrder
  --    Body:  RtBody
  --    @Aref COrder pwr_sClass_corder
  -- 

   type pwr_sClass_corder_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_corder is record
      Status : aliased pwr_sClass_corder_Status_array;  -- pwr_baseclasses.h:4035
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4036
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_corder);  -- pwr_baseclasses.h:4037

   --  skipped anonymous struct anon_257

  --_* Class: Cos
  --    Body:  RtBody
  --    @Aref Cos pwr_sClass_Cos
  -- 

   type pwr_sClass_Cos is record
      inP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4051
      c_in : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4052
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4053
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4054
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4055
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Cos);  -- pwr_baseclasses.h:4056

   --  skipped anonymous struct anon_258

  --_* Class: Cos
  --    Body:  DevBody
  --    @Aref Cos pwr_sdClass_Cos
  -- 

   type pwr_sdClass_Cos is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4064
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Cos);  -- pwr_baseclasses.h:4065

   --  skipped anonymous struct anon_259

  --_* Class: Count
  --    Body:  RtBody
  --    @Aref Count pwr_sClass_count
  -- 

   type pwr_sClass_count is record
      CountUpP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4079
      CountUp : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4080
      CountDownP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4081
      CountDown : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4082
      ClearP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4083
      Clear : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4084
      InitP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4085
      Init : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4086
      Accum : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4087
      Pos : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4088
      Zero : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4089
      Neg : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4090
      Equal : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4091
      Preset : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4092
      AccPre : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4093
      AccAccum : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4094
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_count);  -- pwr_baseclasses.h:4095

   --  skipped anonymous struct anon_260

  --_* Class: Count
  --    Body:  DevBody
  --    @Aref Count pwr_sdClass_Count
  -- 

   type pwr_sdClass_Count is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4103
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Count);  -- pwr_baseclasses.h:4104

   --  skipped anonymous struct anon_261

  --  Class: CStoAattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoAattr
  --    Body:  DevBody
  --    @Aref CStoAattr pwr_sdClass_CStoAattr
  -- 

   type pwr_sdClass_CStoAattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:4123
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4124
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAattr);  -- pwr_baseclasses.h:4125

   --  skipped anonymous struct anon_262

  --_* Class: CStoAi
  --    Body:  RtBody
  --    @Aref CStoAi pwr_sClass_cstoai
  -- 

   type pwr_sClass_cstoai is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4139
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4140
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4141
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4142
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_cstoai);  -- pwr_baseclasses.h:4143

   --  skipped anonymous struct anon_263

  --_* Class: CStoAi
  --    Body:  DevBody
  --    @Aref CStoAi pwr_sdClass_CStoAi
  -- 

   type pwr_sdClass_CStoAi is record
      AiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4151
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4152
      AiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4153
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4154
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4155
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4156
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAi);  -- pwr_baseclasses.h:4157

   --  skipped anonymous struct anon_264

  --  Class: CStoAo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoAo
  --    Body:  DevBody
  --    @Aref CStoAo pwr_sdClass_CStoAo
  -- 

   type pwr_sdClass_CStoAo is record
      AoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4176
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4177
      AoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4178
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4179
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4180
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4181
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAo);  -- pwr_baseclasses.h:4182

   --  skipped anonymous struct anon_265

  --  Class: CStoAp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoAp
  --    Body:  DevBody
  --    @Aref CStoAp pwr_sdClass_CStoAp
  -- 

   type pwr_sdClass_CStoAp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4201
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4202
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4203
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAp);  -- pwr_baseclasses.h:4204

   --  skipped anonymous struct anon_266

  --  Class: CStoAtoIp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoAtoIp
  --    Body:  DevBody
  --    @Aref CStoAtoIp pwr_sdClass_CStoAtoIp
  -- 

   type pwr_sdClass_CStoAtoIp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4223
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4224
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4225
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAtoIp);  -- pwr_baseclasses.h:4226

   --  skipped anonymous struct anon_267

  --  Class: CStoATp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoATp
  --    Body:  DevBody
  --    @Aref CStoATp pwr_sdClass_CStoATp
  -- 

   type pwr_sdClass_CStoATp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4245
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4246
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4247
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoATp);  -- pwr_baseclasses.h:4248

   --  skipped anonymous struct anon_268

  --_* Class: CStoAttrRefP
  --    Body:  RtBody
  --    @Aref CStoAttrRefP pwr_sClass_CStoAttrRefP
  -- 

   type pwr_sClass_CStoAttrRefP is record
      InP : access pwr_h.pwr_tDataRef;  -- pwr_baseclasses.h:4262
      c_In : aliased pwr_h.pwr_tDataRef;  -- pwr_baseclasses.h:4263
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4264
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4265
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoAttrRefP);  -- pwr_baseclasses.h:4266

   --  skipped anonymous struct anon_269

  --_* Class: CStoAttrRefP
  --    Body:  DevBody
  --    @Aref CStoAttrRefP pwr_sdClass_CStoAttrRefP
  -- 

   type pwr_sdClass_CStoAttrRefP is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4274
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4275
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4276
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAttrRefP);  -- pwr_baseclasses.h:4277

   --  skipped anonymous struct anon_270

  --  Class: CStoATv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoATv
  --    Body:  DevBody
  --    @Aref CStoATv pwr_sdClass_CStoATv
  -- 

   type pwr_sdClass_CStoATv is record
      ATvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4296
      ATvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4297
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4298
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoATv);  -- pwr_baseclasses.h:4299

   --  skipped anonymous struct anon_271

  --  Class: CStoAv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoAv
  --    Body:  DevBody
  --    @Aref CStoAv pwr_sdClass_CStoAv
  -- 

   type pwr_sdClass_CStoAv is record
      AvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4318
      AvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4319
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4320
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoAv);  -- pwr_baseclasses.h:4321

   --  skipped anonymous struct anon_272

  --_* Class: CStoBiFloat32
  --    Body:  RtBody
  --    @Aref CStoBiFloat32 pwr_sClass_CStoBiFloat32
  -- 

   type pwr_sClass_CStoBiFloat32 is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4335
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4336
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4337
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4338
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoBiFloat32);  -- pwr_baseclasses.h:4339

   --  skipped anonymous struct anon_273

  --_* Class: CStoBiFloat32
  --    Body:  DevBody
  --    @Aref CStoBiFloat32 pwr_sdClass_CStoBiFloat32
  -- 

   type pwr_sdClass_CStoBiFloat32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4347
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4348
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4349
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4350
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4351
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4352
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBiFloat32);  -- pwr_baseclasses.h:4353

   --  skipped anonymous struct anon_274

  --_* Class: CStoBiInt32
  --    Body:  RtBody
  --    @Aref CStoBiInt32 pwr_sClass_CStoBiInt32
  -- 

   type pwr_sClass_CStoBiInt32 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4367
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4368
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4369
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4370
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoBiInt32);  -- pwr_baseclasses.h:4371

   --  skipped anonymous struct anon_275

  --_* Class: CStoBiInt32
  --    Body:  DevBody
  --    @Aref CStoBiInt32 pwr_sdClass_CStoBiInt32
  -- 

   type pwr_sdClass_CStoBiInt32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4379
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4380
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4381
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4382
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4383
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4384
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBiInt32);  -- pwr_baseclasses.h:4385

   --  skipped anonymous struct anon_276

  --  Class: CStoBiString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoBiString80
  --    Body:  DevBody
  --    @Aref CStoBiString80 pwr_sdClass_CStoBiString80
  -- 

   type pwr_sdClass_CStoBiString80 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4404
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4405
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4406
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4407
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4408
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4409
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBiString80);  -- pwr_baseclasses.h:4410

   --  skipped anonymous struct anon_277

  --_* Class: CStoBoFloat32
  --    Body:  RtBody
  --    @Aref CStoBoFloat32 pwr_sClass_CStoBoFloat32
  -- 

   type pwr_sClass_CStoBoFloat32 is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4424
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4425
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4426
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4427
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoBoFloat32);  -- pwr_baseclasses.h:4428

   --  skipped anonymous struct anon_278

  --_* Class: CStoBoFloat32
  --    Body:  DevBody
  --    @Aref CStoBoFloat32 pwr_sdClass_CStoBoFloat32
  -- 

   type pwr_sdClass_CStoBoFloat32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4436
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4437
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4438
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4439
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4440
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4441
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBoFloat32);  -- pwr_baseclasses.h:4442

   --  skipped anonymous struct anon_279

  --_* Class: CStoBoInt32
  --    Body:  RtBody
  --    @Aref CStoBoInt32 pwr_sClass_CStoBoInt32
  -- 

   type pwr_sClass_CStoBoInt32 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4456
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4457
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4458
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4459
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoBoInt32);  -- pwr_baseclasses.h:4460

   --  skipped anonymous struct anon_280

  --_* Class: CStoBoInt32
  --    Body:  DevBody
  --    @Aref CStoBoInt32 pwr_sdClass_CStoBoInt32
  -- 

   type pwr_sdClass_CStoBoInt32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4468
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4469
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4470
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4471
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4472
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4473
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBoInt32);  -- pwr_baseclasses.h:4474

   --  skipped anonymous struct anon_281

  --  Class: CStoBoString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoBoString80
  --    Body:  DevBody
  --    @Aref CStoBoString80 pwr_sdClass_CStoBoString80
  -- 

   type pwr_sdClass_CStoBoString80 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4493
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4494
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4495
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4496
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4497
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4498
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoBoString80);  -- pwr_baseclasses.h:4499

   --  skipped anonymous struct anon_282

  --  Class: CStoDTp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoDTp
  --    Body:  DevBody
  --    @Aref CStoDTp pwr_sdClass_CStoDTp
  -- 

   type pwr_sdClass_CStoDTp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4518
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4519
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4520
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoDTp);  -- pwr_baseclasses.h:4521

   --  skipped anonymous struct anon_283

  --  Class: CStoDTv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoDTv
  --    Body:  DevBody
  --    @Aref CStoDTv pwr_sdClass_CStoDTv
  -- 

   type pwr_sdClass_CStoDTv is record
      DTvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4540
      DTvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4541
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4542
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoDTv);  -- pwr_baseclasses.h:4543

   --  skipped anonymous struct anon_284

  --_* Class: CStoExtBoolean
  --    Body:  RtBody
  --    @Aref CStoExtBoolean pwr_sClass_CStoExtBoolean
  -- 

   type pwr_sClass_CStoExtBoolean is record
      ActualValueP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4557
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4558
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4559
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4560
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4561
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4562
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtBoolean);  -- pwr_baseclasses.h:4563

   --  skipped anonymous struct anon_285

  --_* Class: CStoExtBoolean
  --    Body:  DevBody
  --    @Aref CStoExtBoolean pwr_sdClass_CStoExtBoolean
  -- 

   type pwr_sdClass_CStoExtBoolean is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4571
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4572
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtBoolean);  -- pwr_baseclasses.h:4573

   --  skipped anonymous struct anon_286

  --_* Class: CStoExtFloat32
  --    Body:  RtBody
  --    @Aref CStoExtFloat32 pwr_sClass_CStoExtFloat32
  -- 

   type pwr_sClass_CStoExtFloat32 is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4587
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:4588
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4589
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4590
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4591
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4592
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtFloat32);  -- pwr_baseclasses.h:4593

   --  skipped anonymous struct anon_287

  --_* Class: CStoExtFloat32
  --    Body:  DevBody
  --    @Aref CStoExtFloat32 pwr_sdClass_CStoExtFloat32
  -- 

   type pwr_sdClass_CStoExtFloat32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4601
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4602
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtFloat32);  -- pwr_baseclasses.h:4603

   --  skipped anonymous struct anon_288

  --_* Class: CStoExtFloat64
  --    Body:  RtBody
  --    @Aref CStoExtFloat64 pwr_sClass_CStoExtFloat64
  -- 

   type pwr_sClass_CStoExtFloat64 is record
      ActualValueP : access pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:4617
      ActualValue : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:4618
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4619
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4620
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4621
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4622
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtFloat64);  -- pwr_baseclasses.h:4623

   --  skipped anonymous struct anon_289

  --_* Class: CStoExtFloat64
  --    Body:  DevBody
  --    @Aref CStoExtFloat64 pwr_sdClass_CStoExtFloat64
  -- 

   type pwr_sdClass_CStoExtFloat64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4631
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4632
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtFloat64);  -- pwr_baseclasses.h:4633

   --  skipped anonymous struct anon_290

  --_* Class: CStoExtInt16
  --    Body:  RtBody
  --    @Aref CStoExtInt16 pwr_sClass_CStoExtInt16
  -- 

   type pwr_sClass_CStoExtInt16 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4647
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4648
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4649
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4650
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4651
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4652
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtInt16);  -- pwr_baseclasses.h:4653

   --  skipped anonymous struct anon_291

  --_* Class: CStoExtInt16
  --    Body:  DevBody
  --    @Aref CStoExtInt16 pwr_sdClass_CStoExtInt16
  -- 

   type pwr_sdClass_CStoExtInt16 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4661
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4662
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtInt16);  -- pwr_baseclasses.h:4663

   --  skipped anonymous struct anon_292

  --_* Class: CStoExtInt32
  --    Body:  RtBody
  --    @Aref CStoExtInt32 pwr_sClass_CStoExtInt32
  -- 

   type pwr_sClass_CStoExtInt32 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4677
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4678
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4679
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4680
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4681
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4682
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtInt32);  -- pwr_baseclasses.h:4683

   --  skipped anonymous struct anon_293

  --_* Class: CStoExtInt32
  --    Body:  DevBody
  --    @Aref CStoExtInt32 pwr_sdClass_CStoExtInt32
  -- 

   type pwr_sdClass_CStoExtInt32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4691
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4692
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtInt32);  -- pwr_baseclasses.h:4693

   --  skipped anonymous struct anon_294

  --_* Class: CStoExtInt64
  --    Body:  RtBody
  --    @Aref CStoExtInt64 pwr_sClass_CStoExtInt64
  -- 

   type pwr_sClass_CStoExtInt64 is record
      ActualValueP : access pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:4707
      ActualValue : aliased pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:4708
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4709
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4710
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4711
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4712
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtInt64);  -- pwr_baseclasses.h:4713

   --  skipped anonymous struct anon_295

  --_* Class: CStoExtInt64
  --    Body:  DevBody
  --    @Aref CStoExtInt64 pwr_sdClass_CStoExtInt64
  -- 

   type pwr_sdClass_CStoExtInt64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4721
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4722
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtInt64);  -- pwr_baseclasses.h:4723

   --  skipped anonymous struct anon_296

  --_* Class: CStoExtInt8
  --    Body:  RtBody
  --    @Aref CStoExtInt8 pwr_sClass_CStoExtInt8
  -- 

   type pwr_sClass_CStoExtInt8 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4737
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4738
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4739
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4740
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4741
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4742
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtInt8);  -- pwr_baseclasses.h:4743

   --  skipped anonymous struct anon_297

  --_* Class: CStoExtInt8
  --    Body:  DevBody
  --    @Aref CStoExtInt8 pwr_sdClass_CStoExtInt8
  -- 

   type pwr_sdClass_CStoExtInt8 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4751
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4752
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtInt8);  -- pwr_baseclasses.h:4753

   --  skipped anonymous struct anon_298

  --_* Class: CStoExtString
  --    Body:  RtBody
  --    @Aref CStoExtString pwr_sClass_CStoExtString
  -- 

   type pwr_sClass_CStoExtString is record
      ActualValueP : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:4767
      ActualValue : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:4768
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4769
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4770
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4771
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4772
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtString);  -- pwr_baseclasses.h:4773

   --  skipped anonymous struct anon_299

  --_* Class: CStoExtString
  --    Body:  DevBody
  --    @Aref CStoExtString pwr_sdClass_CStoExtString
  -- 

   type pwr_sdClass_CStoExtString is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4781
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4782
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtString);  -- pwr_baseclasses.h:4783

   --  skipped anonymous struct anon_300

  --_* Class: CStoExtTime
  --    Body:  RtBody
  --    @Aref CStoExtTime pwr_sClass_CStoExtTime
  -- 

   type pwr_sClass_CStoExtTime is record
      ActualValueP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:4797
      ActualValue : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:4798
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4799
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4800
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4801
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4802
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtTime);  -- pwr_baseclasses.h:4803

   --  skipped anonymous struct anon_301

  --_* Class: CStoExtTime
  --    Body:  DevBody
  --    @Aref CStoExtTime pwr_sdClass_CStoExtTime
  -- 

   type pwr_sdClass_CStoExtTime is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4811
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4812
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtTime);  -- pwr_baseclasses.h:4813

   --  skipped anonymous struct anon_302

  --_* Class: CStoExtUInt16
  --    Body:  RtBody
  --    @Aref CStoExtUInt16 pwr_sClass_CStoExtUInt16
  -- 

   type pwr_sClass_CStoExtUInt16 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4827
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4828
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4829
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4830
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4831
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4832
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtUInt16);  -- pwr_baseclasses.h:4833

   --  skipped anonymous struct anon_303

  --_* Class: CStoExtUInt16
  --    Body:  DevBody
  --    @Aref CStoExtUInt16 pwr_sdClass_CStoExtUInt16
  -- 

   type pwr_sdClass_CStoExtUInt16 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4841
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4842
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtUInt16);  -- pwr_baseclasses.h:4843

   --  skipped anonymous struct anon_304

  --_* Class: CStoExtUInt32
  --    Body:  RtBody
  --    @Aref CStoExtUInt32 pwr_sClass_CStoExtUInt32
  -- 

   type pwr_sClass_CStoExtUInt32 is record
      ActualValueP : access pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:4857
      ActualValue : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:4858
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4859
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4860
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4861
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4862
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtUInt32);  -- pwr_baseclasses.h:4863

   --  skipped anonymous struct anon_305

  --_* Class: CStoExtUInt32
  --    Body:  DevBody
  --    @Aref CStoExtUInt32 pwr_sdClass_CStoExtUInt32
  -- 

   type pwr_sdClass_CStoExtUInt32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4871
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4872
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtUInt32);  -- pwr_baseclasses.h:4873

   --  skipped anonymous struct anon_306

  --_* Class: CStoExtUInt64
  --    Body:  RtBody
  --    @Aref CStoExtUInt64 pwr_sClass_CStoExtUInt64
  -- 

   type pwr_sClass_CStoExtUInt64 is record
      ActualValueP : access pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:4887
      ActualValue : aliased pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:4888
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4889
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4890
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4891
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4892
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtUInt64);  -- pwr_baseclasses.h:4893

   --  skipped anonymous struct anon_307

  --_* Class: CStoExtUInt64
  --    Body:  DevBody
  --    @Aref CStoExtUInt64 pwr_sdClass_CStoExtUInt64
  -- 

   type pwr_sdClass_CStoExtUInt64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4901
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4902
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtUInt64);  -- pwr_baseclasses.h:4903

   --  skipped anonymous struct anon_308

  --_* Class: CStoExtUInt8
  --    Body:  RtBody
  --    @Aref CStoExtUInt8 pwr_sClass_CStoExtUInt8
  -- 

   type pwr_sClass_CStoExtUInt8 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4917
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4918
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4919
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4920
      OldCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4921
      LastStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:4922
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CStoExtUInt8);  -- pwr_baseclasses.h:4923

   --  skipped anonymous struct anon_309

  --_* Class: CStoExtUInt8
  --    Body:  DevBody
  --    @Aref CStoExtUInt8 pwr_sdClass_CStoExtUInt8
  -- 

   type pwr_sdClass_CStoExtUInt8 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:4931
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4932
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoExtUInt8);  -- pwr_baseclasses.h:4933

   --  skipped anonymous struct anon_310

  --  Class: CStoIattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoIattr
  --    Body:  DevBody
  --    @Aref CStoIattr pwr_sdClass_CStoIattr
  -- 

   type pwr_sdClass_CStoIattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:4952
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4953
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoIattr);  -- pwr_baseclasses.h:4954

   --  skipped anonymous struct anon_311

  --_* Class: CStoIi
  --    Body:  RtBody
  --    @Aref CStoIi pwr_sClass_cstoii
  -- 

   type pwr_sClass_cstoii is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4968
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4969
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4970
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4971
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_cstoii);  -- pwr_baseclasses.h:4972

   --  skipped anonymous struct anon_312

  --_* Class: CStoIi
  --    Body:  DevBody
  --    @Aref CStoIi pwr_sdClass_CStoIi
  -- 

   type pwr_sdClass_CStoIi is record
      IiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4980
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:4981
      IiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4982
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:4983
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:4984
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:4985
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoIi);  -- pwr_baseclasses.h:4986

   --  skipped anonymous struct anon_313

  --  Class: CStoIo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoIo
  --    Body:  DevBody
  --    @Aref CStoIo pwr_sdClass_CStoIo
  -- 

   type pwr_sdClass_CStoIo is record
      IoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5005
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5006
      IoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5007
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5008
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5009
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5010
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoIo);  -- pwr_baseclasses.h:5011

   --  skipped anonymous struct anon_314

  --  Class: CStoIp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoIp
  --    Body:  DevBody
  --    @Aref CStoIp pwr_sdClass_CStoIp
  -- 

   type pwr_sdClass_CStoIp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5030
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5031
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5032
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoIp);  -- pwr_baseclasses.h:5033

   --  skipped anonymous struct anon_315

  --  Class: CStoIv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoIv
  --    Body:  DevBody
  --    @Aref CStoIv pwr_sdClass_CStoIv
  -- 

   type pwr_sdClass_CStoIv is record
      IvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5052
      IvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5053
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5054
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoIv);  -- pwr_baseclasses.h:5055

   --  skipped anonymous struct anon_316

  --  Class: CStoNumSp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoNumSp
  --    Body:  DevBody
  --    @Aref CStoNumSp pwr_sdClass_CStoNumSp
  -- 

   type pwr_sdClass_CStoNumSp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5074
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5075
      NumberOfChar : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5076
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5077
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoNumSp);  -- pwr_baseclasses.h:5078

   --  skipped anonymous struct anon_317

  --  Class: CStoSattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoSattr
  --    Body:  DevBody
  --    @Aref CStoSattr pwr_sdClass_CStoSattr
  -- 

   type pwr_sdClass_CStoSattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:5097
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5098
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoSattr);  -- pwr_baseclasses.h:5099

   --  skipped anonymous struct anon_318

  --  Class: CStoSp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoSp
  --    Body:  DevBody
  --    @Aref CStoSp pwr_sdClass_CStoSp
  -- 

   type pwr_sdClass_CStoSp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5118
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5119
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5120
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoSp);  -- pwr_baseclasses.h:5121

   --  skipped anonymous struct anon_319

  --  Class: CStoSv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: CStoSv
  --    Body:  DevBody
  --    @Aref CStoSv pwr_sdClass_CStoSv
  -- 

   type pwr_sdClass_CStoSv is record
      SvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5140
      SvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5141
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5142
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CStoSv);  -- pwr_baseclasses.h:5143

   --  skipped anonymous struct anon_320

  --_* Class: CSub
  --    Body:  RtBody
  --    @Aref CSub pwr_sClass_csub
  -- 

   type pwr_sClass_csub is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5157
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5158
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_csub);  -- pwr_baseclasses.h:5159

   --  skipped anonymous struct anon_321

  --_* Class: CSub
  --    Body:  DevBody
  --    @Aref CSub pwr_sdClass_CSub
  -- 

   type pwr_sdClass_CSub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5167
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CSub);  -- pwr_baseclasses.h:5168

   --  skipped anonymous struct anon_322

  --_* Class: CurrentTime
  --    Body:  RtBody
  --    @Aref CurrentTime pwr_sClass_CurrentTime
  -- 

   type pwr_sClass_CurrentTime is record
      Time : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5182
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CurrentTime);  -- pwr_baseclasses.h:5183

   --  skipped anonymous struct anon_323

  --_* Class: CurrentTime
  --    Body:  DevBody
  --    @Aref CurrentTime pwr_sdClass_CurrentTime
  -- 

   type pwr_sdClass_CurrentTime is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5191
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CurrentTime);  -- pwr_baseclasses.h:5192

   --  skipped anonymous struct anon_324

  --_* Class: Curve
  --    Body:  RtBody
  --    @Aref Curve pwr_sClass_curve
  -- 

   type pwr_sClass_curve is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5206
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5207
      TabP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5208
      Tab : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5209
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5210
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_curve);  -- pwr_baseclasses.h:5211

   --  skipped anonymous struct anon_325

  --_* Class: Curve
  --    Body:  DevBody
  --    @Aref Curve pwr_sdClass_Curve
  -- 

   type pwr_sdClass_Curve is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5219
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Curve);  -- pwr_baseclasses.h:5220

   --  skipped anonymous struct anon_326

  --_* Class: CustomBuild
  --    Body:  DevBody
  --    @Aref CustomBuild pwr_sdClass_CustomBuild
  -- 

   type pwr_sdClass_CustomBuild is record
      cc : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:5234
      cxx : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:5235
      ar : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:5236
      OperatingSystem : aliased pwr_h.pwr_tOpSysEnum;  -- pwr_baseclasses.h:5237
      Platform : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:5238
      Release : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:5239
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_CustomBuild);  -- pwr_baseclasses.h:5240

   --  skipped anonymous struct anon_327

  --_* Class: CycleSup
  --    Body:  RtBody
  --    @Aref CycleSup pwr_sClass_CycleSup
  -- 

   type pwr_sClass_CycleSup is record
      MaxDelay : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5254
      DelayLimit : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:5255
      DelayAction : aliased pwr_tSupDelayActionEnum;  -- pwr_baseclasses.h:5256
      DelayCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5257
      DetectCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5258
      CycleCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5259
      NextLimit : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:5260
      LastDelay : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5261
      DelayedTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5262
      Delayed : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5263
      DelayNoted : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5264
      TimelyTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5265
      Timely : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5266
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5267
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5268
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5269
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5270
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5271
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5272
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5273
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5274
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5275
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:5276
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:5277
      EventFlags : aliased pwr_tEventFlagsMask;  -- pwr_baseclasses.h:5278
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5279
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:5280
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:5281
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5282
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5283
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5284
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5285
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5286
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5287
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5288
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5289
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5290
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5291
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5292
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5293
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5294
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5295
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5296
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5297
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5298
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5299
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5300
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5301
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5302
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_CycleSup);  -- pwr_baseclasses.h:5303

   --  skipped anonymous struct anon_328

  --_* Class: DArithm
  --    Body:  RtBody
  --    @Aref DArithm pwr_sClass_darithm
  -- 

   type pwr_sClass_darithm is record
      DIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5317
      DIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5318
      DIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5319
      DIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5320
      DIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5321
      DIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5322
      DIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5323
      DIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5324
      DIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5325
      DIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5326
      DIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5327
      DIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5328
      DIn7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5329
      DIn7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5330
      DIn8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5331
      DIn8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5332
      AIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5333
      AIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5334
      AIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5335
      AIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5336
      AIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5337
      AIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5338
      AIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5339
      AIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5340
      AIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5341
      AIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5342
      AIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5343
      AIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5344
      AIn7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5345
      AIn7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5346
      AIn8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5347
      AIn8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5348
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5349
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_darithm);  -- pwr_baseclasses.h:5350

   --  skipped anonymous struct anon_329

  --_* Class: DArithm
  --    Body:  DevBody
  --    @Aref DArithm pwr_sdClass_DArithm
  -- 

   type pwr_sdClass_DArithm is record
      Expr : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5358
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5359
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DArithm);  -- pwr_baseclasses.h:5360

   --  skipped anonymous struct anon_330

  --_* Class: DArray100
  --    Body:  RtBody
  --    @Aref DArray100 pwr_sClass_DArray100
  -- 

   type pwr_sClass_DArray100_Value_array is array (0 .. 99) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DArray100 is record
      Value : aliased pwr_sClass_DArray100_Value_array;  -- pwr_baseclasses.h:5374
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DArray100);  -- pwr_baseclasses.h:5375

   --  skipped anonymous struct anon_331

  --_* Class: DArray500
  --    Body:  RtBody
  --    @Aref DArray500 pwr_sClass_DArray500
  -- 

   type pwr_sClass_DArray500_Value_array is array (0 .. 499) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DArray500 is record
      Value : aliased pwr_sClass_DArray500_Value_array;  -- pwr_baseclasses.h:5389
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DArray500);  -- pwr_baseclasses.h:5390

   --  skipped anonymous struct anon_332

  --_* Class: DataArithm
  --    Body:  RtBody
  --    @Aref DataArithm pwr_sClass_dataarithm
  -- 

   type pwr_sClass_dataarithm is record
      DataIn1P : System.Address;  -- pwr_baseclasses.h:5404
      DataIn1 : System.Address;  -- pwr_baseclasses.h:5405
      DataIn2P : System.Address;  -- pwr_baseclasses.h:5406
      DataIn2 : System.Address;  -- pwr_baseclasses.h:5407
      DataIn3P : System.Address;  -- pwr_baseclasses.h:5408
      DataIn3 : System.Address;  -- pwr_baseclasses.h:5409
      DataIn4P : System.Address;  -- pwr_baseclasses.h:5410
      DataIn4 : System.Address;  -- pwr_baseclasses.h:5411
      AIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5412
      AIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5413
      AIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5414
      AIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5415
      AIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5416
      AIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5417
      AIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5418
      AIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5419
      AIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5420
      AIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5421
      AIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5422
      AIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5423
      DIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5424
      DIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5425
      DIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5426
      DIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5427
      DIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5428
      DIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5429
      DIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5430
      DIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5431
      DIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5432
      DIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5433
      DIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5434
      DIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5435
      IIn1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5436
      IIn1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5437
      IIn2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5438
      IIn2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5439
      IIn3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5440
      IIn3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5441
      IIn4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5442
      IIn4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5443
      IIn5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5444
      IIn5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5445
      IIn6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5446
      IIn6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5447
      OutData1 : System.Address;  -- pwr_baseclasses.h:5448
      OutData1ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5449
      OutData2 : System.Address;  -- pwr_baseclasses.h:5450
      OutData2ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5451
      OutData3 : System.Address;  -- pwr_baseclasses.h:5452
      OutData3ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5453
      OutData4 : System.Address;  -- pwr_baseclasses.h:5454
      OutData4ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5455
      OutA1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5456
      OutA2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5457
      OutA3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5458
      OutA4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5459
      OutA5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5460
      OutA6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5461
      OutD1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5462
      OutD2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5463
      OutD3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5464
      OutD4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5465
      OutD5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5466
      OutD6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5467
      OutI1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5468
      OutI2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5469
      OutI3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5470
      OutI4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5471
      OutI5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5472
      OutI6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5473
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_dataarithm);  -- pwr_baseclasses.h:5474

   --  skipped anonymous struct anon_333

  --_* Class: DataArithm
  --    Body:  DevBody
  --    @Aref DataArithm pwr_sdClass_DataArithm
  -- 

   type pwr_sdClass_DataArithm is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5482
      Code : aliased pwr_h.pwr_tText1024;  -- pwr_baseclasses.h:5483
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DataArithm);  -- pwr_baseclasses.h:5484

   --  skipped anonymous struct anon_334

  --_* Class: DataArithmL
  --    Body:  RtBody
  --    @Aref DataArithmL pwr_sClass_dataarithml
  -- 

   type pwr_sClass_dataarithml is record
      DataIn1P : System.Address;  -- pwr_baseclasses.h:5498
      DataIn1 : System.Address;  -- pwr_baseclasses.h:5499
      DataIn2P : System.Address;  -- pwr_baseclasses.h:5500
      DataIn2 : System.Address;  -- pwr_baseclasses.h:5501
      DataIn3P : System.Address;  -- pwr_baseclasses.h:5502
      DataIn3 : System.Address;  -- pwr_baseclasses.h:5503
      DataIn4P : System.Address;  -- pwr_baseclasses.h:5504
      DataIn4 : System.Address;  -- pwr_baseclasses.h:5505
      AIn1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5506
      AIn1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5507
      AIn2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5508
      AIn2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5509
      AIn3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5510
      AIn3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5511
      AIn4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5512
      AIn4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5513
      AIn5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5514
      AIn5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5515
      AIn6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5516
      AIn6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5517
      DIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5518
      DIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5519
      DIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5520
      DIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5521
      DIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5522
      DIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5523
      DIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5524
      DIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5525
      DIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5526
      DIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5527
      DIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5528
      DIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5529
      IIn1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5530
      IIn1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5531
      IIn2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5532
      IIn2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5533
      IIn3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5534
      IIn3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5535
      IIn4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5536
      IIn4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5537
      IIn5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5538
      IIn5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5539
      IIn6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5540
      IIn6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5541
      OutData1 : System.Address;  -- pwr_baseclasses.h:5542
      OutData1ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5543
      OutData2 : System.Address;  -- pwr_baseclasses.h:5544
      OutData2ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5545
      OutData3 : System.Address;  -- pwr_baseclasses.h:5546
      OutData3ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5547
      OutData4 : System.Address;  -- pwr_baseclasses.h:5548
      OutData4ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5549
      OutA1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5550
      OutA2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5551
      OutA3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5552
      OutA4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5553
      OutA5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5554
      OutA6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5555
      OutD1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5556
      OutD2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5557
      OutD3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5558
      OutD4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5559
      OutD5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5560
      OutD6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5561
      OutI1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5562
      OutI2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5563
      OutI3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5564
      OutI4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5565
      OutI5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5566
      OutI6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5567
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_dataarithml);  -- pwr_baseclasses.h:5568

   --  skipped anonymous struct anon_335

  --_* Class: DataArithmL
  --    Body:  DevBody
  --    @Aref DataArithmL pwr_sdClass_DataArithmL
  -- 

   type pwr_sdClass_DataArithmL is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5576
      Code : aliased pwr_h.pwr_tText8192;  -- pwr_baseclasses.h:5577
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DataArithmL);  -- pwr_baseclasses.h:5578

   --  skipped anonymous struct anon_336

  --_* Class: DataCollect
  --    Body:  RtBody
  --    @Aref DataCollect pwr_sClass_DataCollect
  -- 

   type pwr_sClass_DataCollect_DataP_array is array (0 .. 23) of System.Address;
   type pwr_sClass_DataCollect_DataObjId_array is array (0 .. 23) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_DataCollect is record
      DataIn1P : System.Address;  -- pwr_baseclasses.h:5592
      DataIn1 : System.Address;  -- pwr_baseclasses.h:5593
      DataIn2P : System.Address;  -- pwr_baseclasses.h:5594
      DataIn2 : System.Address;  -- pwr_baseclasses.h:5595
      DataIn3P : System.Address;  -- pwr_baseclasses.h:5596
      DataIn3 : System.Address;  -- pwr_baseclasses.h:5597
      DataIn4P : System.Address;  -- pwr_baseclasses.h:5598
      DataIn4 : System.Address;  -- pwr_baseclasses.h:5599
      DataIn5P : System.Address;  -- pwr_baseclasses.h:5600
      DataIn5 : System.Address;  -- pwr_baseclasses.h:5601
      DataIn6P : System.Address;  -- pwr_baseclasses.h:5602
      DataIn6 : System.Address;  -- pwr_baseclasses.h:5603
      DataIn7P : System.Address;  -- pwr_baseclasses.h:5604
      DataIn7 : System.Address;  -- pwr_baseclasses.h:5605
      DataIn8P : System.Address;  -- pwr_baseclasses.h:5606
      DataIn8 : System.Address;  -- pwr_baseclasses.h:5607
      DataIn9P : System.Address;  -- pwr_baseclasses.h:5608
      DataIn9 : System.Address;  -- pwr_baseclasses.h:5609
      DataIn10P : System.Address;  -- pwr_baseclasses.h:5610
      DataIn10 : System.Address;  -- pwr_baseclasses.h:5611
      DataIn11P : System.Address;  -- pwr_baseclasses.h:5612
      DataIn11 : System.Address;  -- pwr_baseclasses.h:5613
      DataIn12P : System.Address;  -- pwr_baseclasses.h:5614
      DataIn12 : System.Address;  -- pwr_baseclasses.h:5615
      DataIn13P : System.Address;  -- pwr_baseclasses.h:5616
      DataIn13 : System.Address;  -- pwr_baseclasses.h:5617
      DataIn14P : System.Address;  -- pwr_baseclasses.h:5618
      DataIn14 : System.Address;  -- pwr_baseclasses.h:5619
      DataIn15P : System.Address;  -- pwr_baseclasses.h:5620
      DataIn15 : System.Address;  -- pwr_baseclasses.h:5621
      DataIn16P : System.Address;  -- pwr_baseclasses.h:5622
      DataIn16 : System.Address;  -- pwr_baseclasses.h:5623
      DataIn17P : System.Address;  -- pwr_baseclasses.h:5624
      DataIn17 : System.Address;  -- pwr_baseclasses.h:5625
      DataIn18P : System.Address;  -- pwr_baseclasses.h:5626
      DataIn18 : System.Address;  -- pwr_baseclasses.h:5627
      DataIn19P : System.Address;  -- pwr_baseclasses.h:5628
      DataIn19 : System.Address;  -- pwr_baseclasses.h:5629
      DataIn20P : System.Address;  -- pwr_baseclasses.h:5630
      DataIn20 : System.Address;  -- pwr_baseclasses.h:5631
      DataIn21P : System.Address;  -- pwr_baseclasses.h:5632
      DataIn21 : System.Address;  -- pwr_baseclasses.h:5633
      DataIn22P : System.Address;  -- pwr_baseclasses.h:5634
      DataIn22 : System.Address;  -- pwr_baseclasses.h:5635
      DataIn23P : System.Address;  -- pwr_baseclasses.h:5636
      DataIn23 : System.Address;  -- pwr_baseclasses.h:5637
      DataIn24P : System.Address;  -- pwr_baseclasses.h:5638
      DataIn24 : System.Address;  -- pwr_baseclasses.h:5639
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5640
      DataP : aliased pwr_sClass_DataCollect_DataP_array;  -- pwr_baseclasses.h:5641
      DataObjId : aliased pwr_sClass_DataCollect_DataObjId_array;  -- pwr_baseclasses.h:5642
      OutDataP : System.Address;  -- pwr_baseclasses.h:5643
      OutData_ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:5644
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DataCollect);  -- pwr_baseclasses.h:5645

   --  skipped anonymous struct anon_337

  --_* Class: DataCollect
  --    Body:  DevBody
  --    @Aref DataCollect pwr_sdClass_DataCollect
  -- 

   type pwr_sdClass_DataCollect is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5653
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DataCollect);  -- pwr_baseclasses.h:5654

   --  skipped anonymous struct anon_338

  --_* Class: DbConfig
  --    Body:  RtBody
  --    @Aref DbConfig pwr_sClass_DbConfig
  -- 

   type pwr_sClass_DbConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5668
      Id : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:5669
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DbConfig);  -- pwr_baseclasses.h:5670

   --  skipped anonymous struct anon_339

  --_* Class: Demux
  --    Body:  RtBody
  --    @Aref Demux pwr_sClass_Demux
  -- 

   type pwr_sClass_Demux is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5684
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5685
      IndexP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5686
      Index : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5687
      Out0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5688
      Out1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5689
      Out2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5690
      Out3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5691
      Out4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5692
      Out5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5693
      Out6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5694
      Out7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5695
      Out8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5696
      Out9 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5697
      Out10 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5698
      Out11 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5699
      Out12 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5700
      Out13 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5701
      Out14 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5702
      Out15 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5703
      Out16 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5704
      Out17 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5705
      Out18 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5706
      Out19 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5707
      Out20 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5708
      Out21 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5709
      Out22 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5710
      Out23 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5711
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Demux);  -- pwr_baseclasses.h:5712

   --  skipped anonymous struct anon_340

  --_* Class: Demux
  --    Body:  DevBody
  --    @Aref Demux pwr_sdClass_Demux
  -- 

   type pwr_sdClass_Demux is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5720
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Demux);  -- pwr_baseclasses.h:5721

   --  skipped anonymous struct anon_341

  --  Class: DetachedClassVolumeConfig
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: DetachedClassVolumeLoad
  --    Body:  RtBody
  --    @Aref DetachedClassVolumeLoad pwr_sClass_DetachedClassVolumeLoad
  -- 

   type pwr_sClass_DetachedClassVolumeLoad is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5746
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DetachedClassVolumeLoad);  -- pwr_baseclasses.h:5747

   --  skipped anonymous struct anon_342

  --_* Class: Di
  --    Body:  RtBody
  --    @Aref Di pwr_sClass_Di
  -- 

   type pwr_sClass_Di_FilterAttribute_array is array (0 .. 3) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_Di is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5761
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5762
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5763
      ActualValue : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5764
      InitialValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5765
      SigValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5766
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5767
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5768
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:5769
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5770
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5771
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5772
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5773
      FilterType : aliased pwr_tDiFilterTypeEnum;  -- pwr_baseclasses.h:5774
      FilterAttribute : aliased pwr_sClass_Di_FilterAttribute_array;  -- pwr_baseclasses.h:5775
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Di);  -- pwr_baseclasses.h:5776

   --  skipped anonymous struct anon_343

  --_* Class: DiArea
  --    Body:  RtBody
  --    @Aref DiArea pwr_sClass_DiArea
  -- 

   type pwr_sClass_DiArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DiArea is record
      Value : aliased pwr_sClass_DiArea_Value_array;  -- pwr_baseclasses.h:5790
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DiArea);  -- pwr_baseclasses.h:5791

   --  skipped anonymous struct anon_344

  --_* Class: DiBCD
  --    Body:  RtBody
  --    @Aref DiBCD pwr_sClass_dibcd
  -- 

   type pwr_sClass_dibcd is record
      BCD0P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5805
      BCD0 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5806
      BCD1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5807
      BCD1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5808
      BCD2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5809
      BCD2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5810
      BCD3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5811
      BCD3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5812
      BCD4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5813
      BCD4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5814
      BCD5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5815
      BCD5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5816
      BCD6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5817
      BCD6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5818
      BCD7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5819
      BCD7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5820
      BCD8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5821
      BCD8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5822
      BCD9P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5823
      BCD9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5824
      BCDAP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5825
      BCDA : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5826
      BCDBP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5827
      BCDB : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5828
      BCDCP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5829
      BCDC : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5830
      BCDDP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5831
      BCDD : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5832
      BCDEP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5833
      BCDE : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5834
      BCDFP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5835
      BCDF : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5836
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5837
      Error : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5838
      Inv : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5839
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_dibcd);  -- pwr_baseclasses.h:5840

   --  skipped anonymous struct anon_345

  --_* Class: DiBCD
  --    Body:  DevBody
  --    @Aref DiBCD pwr_sdClass_DiBCD
  -- 

   type pwr_sdClass_DiBCD is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5848
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DiBCD);  -- pwr_baseclasses.h:5849

   --  skipped anonymous struct anon_346

  --  Class: Disabled
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: Disabled
  --    Body:  DevBody
  --    @Aref Disabled pwr_sdClass_Disabled
  -- 

   type pwr_sdClass_Disabled is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5868
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:5869
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5870
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Disabled);  -- pwr_baseclasses.h:5871

   --  skipped anonymous struct anon_347

  --_* Class: DiskSup
  --    Body:  RtBody
  --    @Aref DiskSup pwr_sClass_DiskSup
  -- 

   type pwr_sClass_DiskSup is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5885
      UsedMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5886
      DiskName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5887
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5888
      Action : aliased pwr_tDiskSupActionMask;  -- pwr_baseclasses.h:5889
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5890
      Command : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5891
      CurrentUse : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5892
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:5893
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:5894
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:5895
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:5896
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DiskSup);  -- pwr_baseclasses.h:5897

   --  skipped anonymous struct anon_348

  --_* Class: Distribute
  --    Body:  DevBody
  --    @Aref Distribute pwr_sdClass_Distribute
  -- 

   type pwr_sdClass_Distribute is record
      Components : aliased pwr_tDistrComponentMask;  -- pwr_baseclasses.h:5911
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Distribute);  -- pwr_baseclasses.h:5912

   --  skipped anonymous struct anon_349

  --_* Class: Div
  --    Body:  RtBody
  --    @Aref Div pwr_sClass_Div
  -- 

   type pwr_sClass_Div is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5926
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5927
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5928
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5929
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:5930
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Div);  -- pwr_baseclasses.h:5931

   --  skipped anonymous struct anon_350

  --_* Class: Div
  --    Body:  DevBody
  --    @Aref Div pwr_sdClass_Div
  -- 

   type pwr_sdClass_Div is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5939
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Div);  -- pwr_baseclasses.h:5940

   --  skipped anonymous struct anon_351

  --_* Class: Do
  --    Body:  RtBody
  --    @Aref Do pwr_sClass_Do
  -- 

   type pwr_sClass_Do is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5954
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5955
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:5956
      ActualValue : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5957
      InitialValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5958
      SigValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:5959
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5960
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:5961
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:5962
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5963
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5964
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:5965
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:5966
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Do);  -- pwr_baseclasses.h:5967

   --  skipped anonymous struct anon_352

  --_* Class: DoArea
  --    Body:  RtBody
  --    @Aref DoArea pwr_sClass_DoArea
  -- 

   type pwr_sClass_DoArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DoArea is record
      Value : aliased pwr_sClass_DoArea_Value_array;  -- pwr_baseclasses.h:5981
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DoArea);  -- pwr_baseclasses.h:5982

   --  skipped anonymous struct anon_353

  --_* Class: Document
  --    Body:  DevBody
  --    @Aref Document pwr_sdClass_Document
  -- 

   type pwr_sdClass_Document is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:5996
      Page : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:5997
      Signature : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:5998
      DocumentOrientation : aliased pwr_tDocumentOrientEnum;  -- pwr_baseclasses.h:5999
      DocumentSize : aliased pwr_tDocumentSizeEnum;  -- pwr_baseclasses.h:6000
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Document);  -- pwr_baseclasses.h:6001

   --  skipped anonymous struct anon_354

  --_* Class: DocUser1
  --    Body:  DevBody
  --    @Aref DocUser1 pwr_sdClass_DocUser1
  -- 

   type pwr_sdClass_DocUser1 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6015
      Page : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:6016
      Signature : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:6017
      DocumentOrientation : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:6018
      DocumentSize : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:6019
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DocUser1);  -- pwr_baseclasses.h:6020

   --  skipped anonymous struct anon_355

  --_* Class: DocUser2
  --    Body:  DevBody
  --    @Aref DocUser2 pwr_sdClass_DocUser2
  -- 

   type pwr_sdClass_DocUser2 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6034
      Page : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:6035
      Signature : aliased pwr_h.pwr_tString8;  -- pwr_baseclasses.h:6036
      DocumentOrientation : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:6037
      DocumentSize : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:6038
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DocUser2);  -- pwr_baseclasses.h:6039

   --  skipped anonymous struct anon_356

  --_* Class: DOrder
  --    Body:  RtBody
  --    @Aref DOrder pwr_sClass_dorder
  -- 

   type pwr_sClass_dorder_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_dorder is record
      Status : aliased pwr_sClass_dorder_Status_array;  -- pwr_baseclasses.h:6053
      Old : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6054
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6055
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6056
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6057
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6058
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6059
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6060
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6061
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6062
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6063
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6064
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_dorder);  -- pwr_baseclasses.h:6065

   --  skipped anonymous struct anon_357

  --_* Class: DpCollect
  --    Body:  RtBody
  --    @Aref DpCollect pwr_sClass_DpCollect
  -- 

   type pwr_sClass_DpCollect_Dp_array is array (0 .. 23) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DpCollect is record
      DpIn1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6079
      DpIn1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6080
      DpIn2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6081
      DpIn2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6082
      DpIn3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6083
      DpIn3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6084
      DpIn4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6085
      DpIn4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6086
      DpIn5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6087
      DpIn5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6088
      DpIn6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6089
      DpIn6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6090
      DpIn7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6091
      DpIn7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6092
      DpIn8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6093
      DpIn8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6094
      DpIn9P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6095
      DpIn9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6096
      DpIn10P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6097
      DpIn10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6098
      DpIn11P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6099
      DpIn11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6100
      DpIn12P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6101
      DpIn12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6102
      DpIn13P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6103
      DpIn13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6104
      DpIn14P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6105
      DpIn14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6106
      DpIn15P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6107
      DpIn15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6108
      DpIn16P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6109
      DpIn16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6110
      DpIn17P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6111
      DpIn17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6112
      DpIn18P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6113
      DpIn18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6114
      DpIn19P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6115
      DpIn19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6116
      DpIn20P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6117
      DpIn20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6118
      DpIn21P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6119
      DpIn21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6120
      DpIn22P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6121
      DpIn22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6122
      DpIn23P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6123
      DpIn23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6124
      DpIn24P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6125
      DpIn24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6126
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6127
      Dp : aliased pwr_sClass_DpCollect_Dp_array;  -- pwr_baseclasses.h:6128
      OutDataP : System.Address;  -- pwr_baseclasses.h:6129
      OutData_ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6130
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DpCollect);  -- pwr_baseclasses.h:6131

   --  skipped anonymous struct anon_358

  --_* Class: DpCollect
  --    Body:  DevBody
  --    @Aref DpCollect pwr_sdClass_DpCollect
  -- 

   type pwr_sdClass_DpCollect is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6139
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DpCollect);  -- pwr_baseclasses.h:6140

   --  skipped anonymous struct anon_359

  --_* Class: DpDistribute
  --    Body:  RtBody
  --    @Aref DpDistribute pwr_sClass_DpDistribute
  -- 

   type pwr_sClass_DpDistribute is record
      DataInP : System.Address;  -- pwr_baseclasses.h:6154
      DataIn : System.Address;  -- pwr_baseclasses.h:6155
      DpOut1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6156
      DpOut2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6157
      DpOut3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6158
      DpOut4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6159
      DpOut5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6160
      DpOut6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6161
      DpOut7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6162
      DpOut8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6163
      DpOut9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6164
      DpOut10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6165
      DpOut11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6166
      DpOut12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6167
      DpOut13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6168
      DpOut14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6169
      DpOut15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6170
      DpOut16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6171
      DpOut17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6172
      DpOut18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6173
      DpOut19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6174
      DpOut20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6175
      DpOut21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6176
      DpOut22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6177
      DpOut23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6178
      DpOut24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6179
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6180
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DpDistribute);  -- pwr_baseclasses.h:6181

   --  skipped anonymous struct anon_360

  --_* Class: DpDistribute
  --    Body:  DevBody
  --    @Aref DpDistribute pwr_sdClass_DpDistribute
  -- 

   type pwr_sdClass_DpDistribute is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6189
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DpDistribute);  -- pwr_baseclasses.h:6190

   --  skipped anonymous struct anon_361

  --_* Class: Drive
  --    Body:  RtBody
  --    @Aref Drive pwr_sClass_drive
  -- 

   type pwr_sClass_drive is record
      AutoStartP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6204
      AutoStart : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6205
      AutoNoStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6206
      AutoNoStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6207
      LocalP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6208
      Local : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6209
      LocStartP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6210
      LocStart : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6211
      LocDriveP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6212
      LocDrive : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6213
      ConOnP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6214
      ConOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6215
      SpeedP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6216
      Speed : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6217
      SafeStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6218
      SafeStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6219
      ProdStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6220
      ProdStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6221
      NoStartP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6222
      NoStart : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6223
      ManMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6224
      Order : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6225
      Ind : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6226
      Alarm1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6227
      Alarm2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6228
      Alarm3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6229
      SumAlarm : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6230
      ManSta : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6231
      ManStp : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6232
      ProdTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6233
      SpeedTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6234
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6235
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6236
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6237
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6238
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6239
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6240
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6241
      ManAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6242
      Status : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6243
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_drive);  -- pwr_baseclasses.h:6244

   --  skipped anonymous struct anon_362

  --_* Class: Drive
  --    Body:  DevBody
  --    @Aref Drive pwr_sdClass_Drive
  -- 

   type pwr_sdClass_Drive is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6252
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Drive);  -- pwr_baseclasses.h:6253

   --  skipped anonymous struct anon_363

  --_* Class: DsFast
  --    Body:  RtBody
  --    @Aref DsFast pwr_sClass_DsFast
  -- 

   type pwr_sClass_DsFast_DataBuffer_array is array (0 .. 459) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_DsFast is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6267
      Start : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6268
      BaseFrequency : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6269
      Multiple : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6270
      NextMultiple : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6271
      TrigMode : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:6272
      TrigName : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6273
      TrigPointer : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6274
      TrigSubId : aliased pwr_h.pwr_tRefId;  -- pwr_baseclasses.h:6275
      TrigManTrue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6276
      DataType : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:6277
      DataName : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6278
      DataPointer : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6279
      DataSubId : aliased pwr_h.pwr_tRefId;  -- pwr_baseclasses.h:6280
      StorageTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6281
      NoOfSample : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6282
      SampBeforeTrig : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6283
      TrigIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6284
      Trigged : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6285
      NextIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6286
      AllDataOK : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6287
      NoOfBufElement : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6288
      DataBuffer : aliased pwr_sClass_DsFast_DataBuffer_array;  -- pwr_baseclasses.h:6289
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsFast);  -- pwr_baseclasses.h:6290

   --  skipped anonymous struct anon_364

  --_* Class: DsFastConf
  --    Body:  RtBody
  --    @Aref DsFastConf pwr_sClass_DsFastConf
  -- 

   type pwr_sClass_DsFastConf is record
      BaseFrequency : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6304
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsFastConf);  -- pwr_baseclasses.h:6305

   --  skipped anonymous struct anon_365

  --_* Class: DsFastCurve
  --    Body:  RtBody
  --    @Aref DsFastCurve pwr_sClass_DsFastCurve
  -- 

   type pwr_sClass_DsFastCurve_AttributeType_array is array (0 .. 9) of aliased pwr_h.pwr_tTypeId;
   type pwr_sClass_DsFastCurve_Attribute_array is array (0 .. 9) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_DsFastCurve_Buffers_array is array (0 .. 9) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_DsFastCurve_YMinValue_array is array (0 .. 9) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_DsFastCurve_YMaxValue_array is array (0 .. 9) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_DsFastCurve_CurveValid_array is array (0 .. 9) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DsFastCurve is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6319
      Title : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6320
      c_Function : aliased pwr_h.pwr_tMask;  -- pwr_baseclasses.h:6321
      Active : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6322
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6323
      TriggObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6324
      TriggMan : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6325
      TriggLevel : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6326
      Prepare : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6327
      AttributeType : aliased pwr_sClass_DsFastCurve_AttributeType_array;  -- pwr_baseclasses.h:6328
      Attribute : aliased pwr_sClass_DsFastCurve_Attribute_array;  -- pwr_baseclasses.h:6329
      Buffers : aliased pwr_sClass_DsFastCurve_Buffers_array;  -- pwr_baseclasses.h:6330
      TimeBuffer : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6331
      YMinValue : aliased pwr_sClass_DsFastCurve_YMinValue_array;  -- pwr_baseclasses.h:6332
      YMaxValue : aliased pwr_sClass_DsFastCurve_YMaxValue_array;  -- pwr_baseclasses.h:6333
      NoOfPoints : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6334
      NoOfPointsBeforeTrigg : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6335
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:6336
      TriggIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6337
      FirstIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6338
      LastIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6339
      c_New : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6340
      CurveValid : aliased pwr_sClass_DsFastCurve_CurveValid_array;  -- pwr_baseclasses.h:6341
      TriggTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6342
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsFastCurve);  -- pwr_baseclasses.h:6343

   --  skipped anonymous struct anon_366

  --_* Class: DsTrend
  --    Body:  RtBody
  --    @Aref DsTrend pwr_sClass_DsTrend
  -- 

   type pwr_sClass_DsTrend_NextWriteIndex_array is array (0 .. 1) of aliased pwr_h.pwr_tUInt16;
   type pwr_sClass_DsTrend_BufferStatus_array is array (0 .. 1) of aliased pwr_h.pwr_tUInt16;
   type pwr_sClass_DsTrend_BufferTime_array is array (0 .. 1) of aliased pwr_h.pwr_tTime;
   type pwr_sClass_DsTrend_DataBuffer_array is array (0 .. 477) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_DsTrend is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6357
      ScanTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6358
      Multiple : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6359
      NextMultiple : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6360
      DataType : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6361
      DataName : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6362
      DataPointer : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6363
      DataSubId : aliased pwr_h.pwr_tRefId;  -- pwr_baseclasses.h:6364
      StorageTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6365
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:6366
      NoOfSample : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6367
      WriteBuffer : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6368
      NextWriteIndex : aliased pwr_sClass_DsTrend_NextWriteIndex_array;  -- pwr_baseclasses.h:6369
      BufferStatus : aliased pwr_sClass_DsTrend_BufferStatus_array;  -- pwr_baseclasses.h:6370
      NoOfBuffers : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6371
      NoOfBufElement : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:6372
      BufferTime : aliased pwr_sClass_DsTrend_BufferTime_array;  -- pwr_baseclasses.h:6373
      DataBuffer : aliased pwr_sClass_DsTrend_DataBuffer_array;  -- pwr_baseclasses.h:6374
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsTrend);  -- pwr_baseclasses.h:6375

   --  skipped anonymous struct anon_367

  --_* Class: DsTrendConf
  --    Body:  RtBody
  --    @Aref DsTrendConf pwr_sClass_DsTrendConf
  -- 

   type pwr_sClass_DsTrendConf is record
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6389
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsTrendConf);  -- pwr_baseclasses.h:6390

   --  skipped anonymous struct anon_368

  --_* Class: DsTrendCurve
  --    Body:  RtBody
  --    @Aref DsTrendCurve pwr_sClass_DsTrendCurve
  -- 

   type pwr_sClass_DsTrendCurve_AttributeType_array is array (0 .. 9) of aliased pwr_h.pwr_tTypeId;
   type pwr_sClass_DsTrendCurve_Attribute_array is array (0 .. 9) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_DsTrendCurve_Buffers_array is array (0 .. 9) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_DsTrendCurve is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6404
      Title : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6405
      c_Function : aliased pwr_h.pwr_tMask;  -- pwr_baseclasses.h:6406
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6407
      AttributeType : aliased pwr_sClass_DsTrendCurve_AttributeType_array;  -- pwr_baseclasses.h:6408
      Attribute : aliased pwr_sClass_DsTrendCurve_Attribute_array;  -- pwr_baseclasses.h:6409
      Buffers : aliased pwr_sClass_DsTrendCurve_Buffers_array;  -- pwr_baseclasses.h:6410
      TimeBuffer : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6411
      TimeResolution : aliased pwr_tTimeResolutionEnum;  -- pwr_baseclasses.h:6412
      StorageTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6413
      DisplayTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6414
      DisplayResolution : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6415
      DisplayUpdateTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6416
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:6417
      NoOfSample : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6418
      FirstIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6419
      LastIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6420
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DsTrendCurve);  -- pwr_baseclasses.h:6421

   --  skipped anonymous struct anon_369

  --_* Class: DSup
  --    Body:  RtBody
  --    @Aref DSup pwr_sClass_DSup
  -- 

   type pwr_sClass_DSup is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6435
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6436
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6437
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6438
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6439
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6440
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6441
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6442
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6443
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6444
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6445
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:6446
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:6447
      EventFlags : aliased pwr_tEventFlagsMask;  -- pwr_baseclasses.h:6448
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6449
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:6450
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:6451
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6452
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6453
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6454
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6455
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6456
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6457
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6458
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6459
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6460
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6461
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6462
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6463
      CtrlPosition : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6464
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6465
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6466
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6467
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6468
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6469
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6470
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6471
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6472
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6473
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6474
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DSup);  -- pwr_baseclasses.h:6475

   --  skipped anonymous struct anon_370

  --_* Class: DSup
  --    Body:  DevBody
  --    @Aref DSup pwr_sdClass_DSup
  -- 

   type pwr_sdClass_DSup is record
      ShowDetectText : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6483
      LockAttribute : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6484
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6485
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DSup);  -- pwr_baseclasses.h:6486

   --  skipped anonymous struct anon_371

  --_* Class: DSupComp
  --    Body:  RtBody
  --    @Aref DSupComp pwr_sClass_DSupComp
  -- 

   type pwr_sClass_DSupComp is record
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6500
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6501
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6502
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6503
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6504
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6505
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6506
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6507
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6508
      EventType : aliased pwr_tEventTypeEnum;  -- pwr_baseclasses.h:6509
      EventPriority : aliased pwr_tEventPrioEnum;  -- pwr_baseclasses.h:6510
      EventFlags : aliased pwr_tEventFlagsMask;  -- pwr_baseclasses.h:6511
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6512
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:6513
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:6514
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6515
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6516
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6517
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6518
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6519
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6520
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6521
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6522
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6523
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:6524
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6525
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6526
      CtrlPosition : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6527
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6528
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6529
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6530
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6531
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6532
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6533
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:6534
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6535
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6536
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6537
      PlcConnect : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6538
      LockAttribute : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6539
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DSupComp);  -- pwr_baseclasses.h:6540

   --  skipped anonymous struct anon_372

  --_* Class: DSupCompFo
  --    Body:  RtBody
  --    @Aref DSupCompFo pwr_sClass_DSupCompFo
  -- 

   type pwr_sClass_DSupCompFo is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6554
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6555
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6556
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6557
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6558
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6559
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6560
      PlcConnect : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6561
      PlcConnectP : System.Address;  -- pwr_baseclasses.h:6562
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DSupCompFo);  -- pwr_baseclasses.h:6563

   --  skipped anonymous struct anon_373

  --_* Class: DSupCompFo
  --    Body:  DevBody
  --    @Aref DSupCompFo pwr_sdClass_DSupCompFo
  -- 

   type pwr_sdClass_DSupCompFo is record
      ShowDetectText : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6571
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6572
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DSupCompFo);  -- pwr_baseclasses.h:6573

   --  skipped anonymous struct anon_374

  --_* Class: DtAdd
  --    Body:  RtBody
  --    @Aref DtAdd pwr_sClass_DtAdd
  -- 

   type pwr_sClass_DtAdd is record
      DTime1P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6587
      DTime1 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6588
      DTime2P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6589
      DTime2 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6590
      ActVal : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6591
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtAdd);  -- pwr_baseclasses.h:6592

   --  skipped anonymous struct anon_375

  --_* Class: DtAdd
  --    Body:  DevBody
  --    @Aref DtAdd pwr_sdClass_DtAdd
  -- 

   type pwr_sdClass_DtAdd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6600
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtAdd);  -- pwr_baseclasses.h:6601

   --  skipped anonymous struct anon_376

  --_* Class: DtEqual
  --    Body:  RtBody
  --    @Aref DtEqual pwr_sClass_DtEqual
  -- 

   type pwr_sClass_DtEqual is record
      DTime1P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6615
      DTime1 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6616
      DTime2P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6617
      DTime2 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6618
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6619
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtEqual);  -- pwr_baseclasses.h:6620

   --  skipped anonymous struct anon_377

  --_* Class: DtEqual
  --    Body:  DevBody
  --    @Aref DtEqual pwr_sdClass_DtEqual
  -- 

   type pwr_sdClass_DtEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6628
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtEqual);  -- pwr_baseclasses.h:6629

   --  skipped anonymous struct anon_378

  --_* Class: DtGreaterThan
  --    Body:  RtBody
  --    @Aref DtGreaterThan pwr_sClass_DtGreaterThan
  -- 

   type pwr_sClass_DtGreaterThan is record
      DTime1P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6643
      DTime1 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6644
      DTime2P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6645
      DTime2 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6646
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6647
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtGreaterThan);  -- pwr_baseclasses.h:6648

   --  skipped anonymous struct anon_379

  --_* Class: DtGreaterThan
  --    Body:  DevBody
  --    @Aref DtGreaterThan pwr_sdClass_DtGreaterThan
  -- 

   type pwr_sdClass_DtGreaterThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6656
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtGreaterThan);  -- pwr_baseclasses.h:6657

   --  skipped anonymous struct anon_380

  --_* Class: DtLessThan
  --    Body:  RtBody
  --    @Aref DtLessThan pwr_sClass_DtLessThan
  -- 

   type pwr_sClass_DtLessThan is record
      DTime1P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6671
      DTime1 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6672
      DTime2P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6673
      DTime2 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6674
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6675
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtLessThan);  -- pwr_baseclasses.h:6676

   --  skipped anonymous struct anon_381

  --_* Class: DtLessThan
  --    Body:  DevBody
  --    @Aref DtLessThan pwr_sdClass_DtLessThan
  -- 

   type pwr_sdClass_DtLessThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6684
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtLessThan);  -- pwr_baseclasses.h:6685

   --  skipped anonymous struct anon_382

  --_* Class: DtoEnum
  --    Body:  RtBody
  --    @Aref DtoEnum pwr_sClass_DtoEnum
  -- 

   type pwr_sClass_DtoEnum_EnumValues_array is array (0 .. 31) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_DtoEnum is record
      d0P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6699
      d0 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6700
      d1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6701
      d1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6702
      d2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6703
      d2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6704
      d3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6705
      d3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6706
      d4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6707
      d4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6708
      d5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6709
      d5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6710
      d6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6711
      d6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6712
      d7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6713
      d7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6714
      d8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6715
      d8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6716
      d9P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6717
      d9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6718
      d10P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6719
      d10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6720
      d11P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6721
      d11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6722
      d12P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6723
      d12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6724
      d13P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6725
      d13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6726
      d14P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6727
      d14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6728
      d15P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6729
      d15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6730
      d16P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6731
      d16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6732
      d17P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6733
      d17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6734
      d18P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6735
      d18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6736
      d19P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6737
      d19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6738
      d20P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6739
      d20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6740
      d21P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6741
      d21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6742
      d22P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6743
      d22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6744
      d23P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6745
      d23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6746
      d24P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6747
      d24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6748
      d25P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6749
      d25 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6750
      d26P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6751
      d26 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6752
      d27P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6753
      d27 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6754
      d28P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6755
      d28 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6756
      d29P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6757
      d29 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6758
      d30P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6759
      d30 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6760
      d31P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6761
      d31 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6762
      EnumValues : aliased pwr_sClass_DtoEnum_EnumValues_array;  -- pwr_baseclasses.h:6763
      DefaultValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6764
      Enum : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6765
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtoEnum);  -- pwr_baseclasses.h:6766

   --  skipped anonymous struct anon_383

  --_* Class: DtoEnum
  --    Body:  DevBody
  --    @Aref DtoEnum pwr_sdClass_DtoEnum
  -- 

   type pwr_sdClass_DtoEnum is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6774
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtoEnum);  -- pwr_baseclasses.h:6775

   --  skipped anonymous struct anon_384

  --_* Class: DtoMask
  --    Body:  RtBody
  --    @Aref DtoMask pwr_sClass_DtoMask
  -- 

   type pwr_sClass_DtoMask is record
      d1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6789
      d1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6790
      d2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6791
      d2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6792
      d3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6793
      d3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6794
      d4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6795
      d4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6796
      d5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6797
      d5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6798
      d6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6799
      d6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6800
      d7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6801
      d7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6802
      d8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6803
      d8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6804
      d9P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6805
      d9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6806
      d10P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6807
      d10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6808
      d11P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6809
      d11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6810
      d12P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6811
      d12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6812
      d13P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6813
      d13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6814
      d14P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6815
      d14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6816
      d15P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6817
      d15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6818
      d16P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6819
      d16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6820
      d17P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6821
      d17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6822
      d18P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6823
      d18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6824
      d19P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6825
      d19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6826
      d20P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6827
      d20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6828
      d21P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6829
      d21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6830
      d22P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6831
      d22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6832
      d23P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6833
      d23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6834
      d24P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6835
      d24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6836
      d25P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6837
      d25 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6838
      d26P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6839
      d26 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6840
      d27P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6841
      d27 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6842
      d28P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6843
      d28 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6844
      d29P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6845
      d29 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6846
      d30P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6847
      d30 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6848
      d31P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6849
      d31 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6850
      d32P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6851
      d32 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6852
      Mask : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:6853
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtoMask);  -- pwr_baseclasses.h:6854

   --  skipped anonymous struct anon_385

  --_* Class: DtoMask
  --    Body:  DevBody
  --    @Aref DtoMask pwr_sdClass_DtoMask
  -- 

   type pwr_sdClass_DtoMask is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6862
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtoMask);  -- pwr_baseclasses.h:6863

   --  skipped anonymous struct anon_386

  --_* Class: DtoStr
  --    Body:  RtBody
  --    @Aref DtoStr pwr_sClass_DtoStr
  -- 

   type pwr_sClass_DtoStr is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6877
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6878
      Format : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6879
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6880
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtoStr);  -- pwr_baseclasses.h:6881

   --  skipped anonymous struct anon_387

  --_* Class: DtoStr
  --    Body:  DevBody
  --    @Aref DtoStr pwr_sdClass_DtoStr
  -- 

   type pwr_sdClass_DtoStr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6889
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtoStr);  -- pwr_baseclasses.h:6890

   --  skipped anonymous struct anon_388

  --_* Class: DtSub
  --    Body:  RtBody
  --    @Aref DtSub pwr_sClass_DtSub
  -- 

   type pwr_sClass_DtSub is record
      DTime1P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6904
      DTime1 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6905
      DTime2P : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6906
      DTime2 : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6907
      ActVal : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6908
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtSub);  -- pwr_baseclasses.h:6909

   --  skipped anonymous struct anon_389

  --_* Class: DtSub
  --    Body:  DevBody
  --    @Aref DtSub pwr_sdClass_DtSub
  -- 

   type pwr_sdClass_DtSub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6917
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtSub);  -- pwr_baseclasses.h:6918

   --  skipped anonymous struct anon_390

  --_* Class: DtToA
  --    Body:  RtBody
  --    @Aref DtToA pwr_sClass_DtToA
  -- 

   type pwr_sClass_DtToA is record
      DTimeP : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6932
      DTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6933
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:6934
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DtToA);  -- pwr_baseclasses.h:6935

   --  skipped anonymous struct anon_391

  --_* Class: DtToA
  --    Body:  DevBody
  --    @Aref DtToA pwr_sdClass_DtToA
  -- 

   type pwr_sdClass_DtToA is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:6943
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_DtToA);  -- pwr_baseclasses.h:6944

   --  skipped anonymous struct anon_392

  --_* Class: DTv
  --    Body:  RtBody
  --    @Aref DTv pwr_sClass_DTv
  -- 

   type pwr_sClass_DTv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6958
      ActualValue : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:6959
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DTv);  -- pwr_baseclasses.h:6960

   --  skipped anonymous struct anon_393

  --_* Class: Dv
  --    Body:  RtBody
  --    @Aref Dv pwr_sClass_Dv
  -- 

   type pwr_sClass_Dv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6974
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:6975
      ActualValue : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6976
      InitialValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:6977
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6978
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:6979
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:6980
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:6981
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:6982
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:6983
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:6984
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Dv);  -- pwr_baseclasses.h:6985

   --  skipped anonymous struct anon_394

  --_* Class: DvArea
  --    Body:  RtBody
  --    @Aref DvArea pwr_sClass_DvArea
  -- 

   type pwr_sClass_DvArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_DvArea is record
      Value : aliased pwr_sClass_DvArea_Value_array;  -- pwr_baseclasses.h:6999
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_DvArea);  -- pwr_baseclasses.h:7000

   --  skipped anonymous struct anon_395

  --_* Class: Edge
  --    Body:  RtBody
  --    @Aref Edge pwr_sClass_edge
  -- 

   type pwr_sClass_edge is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7014
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7015
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7016
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7017
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_edge);  -- pwr_baseclasses.h:7018

   --  skipped anonymous struct anon_396

  --_* Class: Edge
  --    Body:  DevBody
  --    @Aref Edge pwr_sdClass_Edge
  -- 

   type pwr_sdClass_Edge is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7026
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Edge);  -- pwr_baseclasses.h:7027

   --  skipped anonymous struct anon_397

  --_* Class: EnumToD
  --    Body:  RtBody
  --    @Aref EnumToD pwr_sClass_EnumToD
  -- 

   type pwr_sClass_EnumToD_EnumValues_array is array (0 .. 31) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_EnumToD is record
      EnumP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7041
      Enum : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7042
      EnumValues : aliased pwr_sClass_EnumToD_EnumValues_array;  -- pwr_baseclasses.h:7043
      od0 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7044
      od1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7045
      od2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7046
      od3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7047
      od4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7048
      od5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7049
      od6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7050
      od7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7051
      od8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7052
      od9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7053
      od10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7054
      od11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7055
      od12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7056
      od13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7057
      od14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7058
      od15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7059
      od16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7060
      od17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7061
      od18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7062
      od19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7063
      od20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7064
      od21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7065
      od22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7066
      od23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7067
      od24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7068
      od25 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7069
      od26 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7070
      od27 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7071
      od28 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7072
      od29 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7073
      od30 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7074
      od31 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7075
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_EnumToD);  -- pwr_baseclasses.h:7076

   --  skipped anonymous struct anon_398

  --_* Class: EnumToD
  --    Body:  DevBody
  --    @Aref EnumToD pwr_sdClass_EnumToD
  -- 

   type pwr_sdClass_EnumToD is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7084
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_EnumToD);  -- pwr_baseclasses.h:7085

   --  skipped anonymous struct anon_399

  --_* Class: EnumToStr
  --    Body:  RtBody
  --    @Aref EnumToStr pwr_sClass_EnumToStr
  -- 

   type pwr_sClass_EnumToStr is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7099
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7100
      TypeId : aliased pwr_h.pwr_tTypeId;  -- pwr_baseclasses.h:7101
      EnumDefP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7102
      EnumDefRows : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:7103
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7104
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_EnumToStr);  -- pwr_baseclasses.h:7105

   --  skipped anonymous struct anon_400

  --_* Class: EnumToStr
  --    Body:  DevBody
  --    @Aref EnumToStr pwr_sdClass_EnumToStr
  -- 

   type pwr_sdClass_EnumToStr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7113
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_EnumToStr);  -- pwr_baseclasses.h:7114

   --  skipped anonymous struct anon_401

  --_* Class: Equal
  --    Body:  RtBody
  --    @Aref Equal pwr_sClass_Equal
  -- 

   type pwr_sClass_Equal is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7128
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7129
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7130
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7131
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7132
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Equal);  -- pwr_baseclasses.h:7133

   --  skipped anonymous struct anon_402

  --_* Class: Equal
  --    Body:  DevBody
  --    @Aref Equal pwr_sdClass_Equal
  -- 

   type pwr_sdClass_Equal is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7141
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Equal);  -- pwr_baseclasses.h:7142

   --  skipped anonymous struct anon_403

  --_* Class: Even
  --    Body:  RtBody
  --    @Aref Even pwr_sClass_Even
  -- 

   type pwr_sClass_Even is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7156
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7157
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7158
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Even);  -- pwr_baseclasses.h:7159

   --  skipped anonymous struct anon_404

  --_* Class: Even
  --    Body:  DevBody
  --    @Aref Even pwr_sdClass_Even
  -- 

   type pwr_sdClass_Even is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7167
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Even);  -- pwr_baseclasses.h:7168

   --  skipped anonymous struct anon_405

  --_* Class: EventPrinter
  --    Body:  RtBody
  --    @Aref EventPrinter pwr_sClass_EventPrinter
  -- 

   type pwr_sClass_EventPrinter_SelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_EventPrinter is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7182
      DeviceName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7183
      RowSize : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:7184
      SelectList : aliased pwr_sClass_EventPrinter_SelectList_array;  -- pwr_baseclasses.h:7185
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_EventPrinter);  -- pwr_baseclasses.h:7186

   --  skipped anonymous struct anon_406

  --_* Class: Exp
  --    Body:  RtBody
  --    @Aref Exp pwr_sClass_Exp
  -- 

   type pwr_sClass_Exp is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7200
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7201
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7202
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7203
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7204
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Exp);  -- pwr_baseclasses.h:7205

   --  skipped anonymous struct anon_407

  --_* Class: Exp
  --    Body:  DevBody
  --    @Aref Exp pwr_sdClass_Exp
  -- 

   type pwr_sdClass_Exp is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7213
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Exp);  -- pwr_baseclasses.h:7214

   --  skipped anonymous struct anon_408

  --_* Class: ExternRef
  --    Body:  DevBody
  --    @Aref ExternRef pwr_sdClass_ExternRef
  -- 

   type pwr_sdClass_ExternRef is record
      Object : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:7228
      Write : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:7229
      Description : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:7230
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ExternRef);  -- pwr_baseclasses.h:7231

   --  skipped anonymous struct anon_409

  --_* Class: ExternVolumeConfig
  --    Body:  RtBody
  --    @Aref ExternVolumeConfig pwr_sClass_ExternVolumeConfig
  -- 

   type pwr_sClass_ExternVolumeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7245
      DevProvider : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7246
      RtProvider : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7247
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ExternVolumeConfig);  -- pwr_baseclasses.h:7248

   --  skipped anonymous struct anon_410

  --_* Class: False
  --    Body:  RtBody
  --    @Aref False pwr_sClass_False
  -- 

   type pwr_sClass_False is record
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7262
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_False);  -- pwr_baseclasses.h:7263

   --  skipped anonymous struct anon_411

  --_* Class: False
  --    Body:  DevBody
  --    @Aref False pwr_sdClass_False
  -- 

   type pwr_sdClass_False is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7271
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_False);  -- pwr_baseclasses.h:7272

   --  skipped anonymous struct anon_412

  --_* Class: Filter
  --    Body:  RtBody
  --    @Aref Filter pwr_sClass_filter
  -- 

   type pwr_sClass_filter is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7286
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7287
      FeedBP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7288
      FeedB : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7289
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7290
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7291
      FiltCon : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7292
      AccCon : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7293
      MinCon : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7294
      MaxCon : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7295
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_filter);  -- pwr_baseclasses.h:7296

   --  skipped anonymous struct anon_413

  --_* Class: Filter
  --    Body:  DevBody
  --    @Aref Filter pwr_sdClass_Filter
  -- 

   type pwr_sdClass_Filter is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7304
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Filter);  -- pwr_baseclasses.h:7305

   --  skipped anonymous struct anon_414

  --_* Class: FirstScan
  --    Body:  RtBody
  --    @Aref FirstScan pwr_sClass_FirstScan
  -- 

   type pwr_sClass_FirstScan is record
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7319
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_FirstScan);  -- pwr_baseclasses.h:7320

   --  skipped anonymous struct anon_415

  --_* Class: FirstScan
  --    Body:  DevBody
  --    @Aref FirstScan pwr_sdClass_FirstScan
  -- 

   type pwr_sdClass_FirstScan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7328
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_FirstScan);  -- pwr_baseclasses.h:7329

   --  skipped anonymous struct anon_416

  --_* Class: Float64toA
  --    Body:  RtBody
  --    @Aref Float64toA pwr_sClass_Float64toA
  -- 

   type pwr_sClass_Float64toA is record
      InP : access pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:7343
      c_In : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:7344
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7345
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Float64toA);  -- pwr_baseclasses.h:7346

   --  skipped anonymous struct anon_417

  --_* Class: Float64toA
  --    Body:  DevBody
  --    @Aref Float64toA pwr_sdClass_Float64toA
  -- 

   type pwr_sdClass_Float64toA is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7354
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Float64toA);  -- pwr_baseclasses.h:7355

   --  skipped anonymous struct anon_418

  --_* Class: Form
  --    Body:  RtBody
  --    @Aref Form pwr_sClass_Form
  -- 

   type pwr_sClass_Form is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7369
      Title : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:7370
      FormName : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:7371
      X : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:7372
      Y : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:7373
      FirstInputField : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:7374
      MaxNoOfInstances : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:7375
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Form);  -- pwr_baseclasses.h:7376

   --  skipped anonymous struct anon_419

  --_* Class: Frame
  --    Body:  DevBody
  --    @Aref Frame pwr_sdClass_Frame
  -- 

   type pwr_sdClass_Frame is record
      FrameAttribute : aliased pwr_tFrameAttrEnum;  -- pwr_baseclasses.h:7390
      FrameWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7391
      FrameHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7392
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7393
      TextAttribute : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:7394
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7395
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Frame);  -- pwr_baseclasses.h:7396

   --  skipped anonymous struct anon_420

  --_* Class: FriendNodeConfig
  --    Body:  RtBody
  --    @Aref FriendNodeConfig pwr_sClass_FriendNodeConfig
  -- 

   type pwr_sClass_FriendNodeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7410
      NodeName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7411
      Connection : aliased pwr_tNodeConnectionEnum;  -- pwr_baseclasses.h:7412
      Address : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:7413
      Port : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:7414
      Volume : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:7415
      QComMinResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7416
      QComMaxResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7417
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_FriendNodeConfig);  -- pwr_baseclasses.h:7418

   --  skipped anonymous struct anon_421

  --  Class: GetAattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetAattr
  --    Body:  DevBody
  --    @Aref GetAattr pwr_sdClass_GetAattr
  -- 

   type pwr_sdClass_GetAattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:7437
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7438
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAattr);  -- pwr_baseclasses.h:7439

   --  skipped anonymous struct anon_422

  --_* Class: GetAgeneric
  --    Body:  DevBody
  --    @Aref GetAgeneric pwr_sdClass_GetAgeneric
  -- 

   type pwr_sdClass_GetAgeneric is record
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7453
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7454
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAgeneric);  -- pwr_baseclasses.h:7455

   --  skipped anonymous struct anon_423

  --  Class: GetAi
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetAi
  --    Body:  DevBody
  --    @Aref GetAi pwr_sdClass_GetAi
  -- 

   type pwr_sdClass_GetAi is record
      AiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7474
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7475
      AiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7476
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7477
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7478
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7479
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAi);  -- pwr_baseclasses.h:7480

   --  skipped anonymous struct anon_424

  --  Class: GetAo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetAo
  --    Body:  DevBody
  --    @Aref GetAo pwr_sdClass_GetAo
  -- 

   type pwr_sdClass_GetAo is record
      AoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7499
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7500
      AoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7501
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7502
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7503
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7504
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAo);  -- pwr_baseclasses.h:7505

   --  skipped anonymous struct anon_425

  --  Class: GetAp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetAp
  --    Body:  DevBody
  --    @Aref GetAp pwr_sdClass_GetAp
  -- 

   type pwr_sdClass_GetAp is record
      ApObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7524
      ApObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7525
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7526
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAp);  -- pwr_baseclasses.h:7527

   --  skipped anonymous struct anon_426

  --_* Class: GetApPtr
  --    Body:  RtBody
  --    @Aref GetApPtr pwr_sClass_GetApPtr
  -- 

   type pwr_sClass_GetApPtr is record
      ApPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7541
      Ptr : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7542
      Value : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7543
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetApPtr);  -- pwr_baseclasses.h:7544

   --  skipped anonymous struct anon_427

  --_* Class: GetApPtr
  --    Body:  DevBody
  --    @Aref GetApPtr pwr_sdClass_GetApPtr
  -- 

   type pwr_sdClass_GetApPtr is record
      ApPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7552
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7553
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetApPtr);  -- pwr_baseclasses.h:7554

   --  skipped anonymous struct anon_428

  --_* Class: GetATgeneric
  --    Body:  DevBody
  --    @Aref GetATgeneric pwr_sdClass_GetATgeneric
  -- 

   type pwr_sdClass_GetATgeneric is record
      ActualValue : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:7568
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7569
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetATgeneric);  -- pwr_baseclasses.h:7570

   --  skipped anonymous struct anon_429

  --  Class: GetATp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetATp
  --    Body:  DevBody
  --    @Aref GetATp pwr_sdClass_GetATp
  -- 

   type pwr_sdClass_GetATp is record
      ATpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7589
      ATpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7590
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7591
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetATp);  -- pwr_baseclasses.h:7592

   --  skipped anonymous struct anon_430

  --  Class: GetATv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetATv
  --    Body:  DevBody
  --    @Aref GetATv pwr_sdClass_GetATv
  -- 

   type pwr_sdClass_GetATv is record
      ATvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7611
      ATvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7612
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7613
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetATv);  -- pwr_baseclasses.h:7614

   --  skipped anonymous struct anon_431

  --  Class: GetAv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetAv
  --    Body:  DevBody
  --    @Aref GetAv pwr_sdClass_GetAv
  -- 

   type pwr_sdClass_GetAv is record
      AvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7633
      AvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7634
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7635
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetAv);  -- pwr_baseclasses.h:7636

   --  skipped anonymous struct anon_432

  --  Class: GetBiFloat32
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBiFloat32
  --    Body:  DevBody
  --    @Aref GetBiFloat32 pwr_sdClass_GetBiFloat32
  -- 

   type pwr_sdClass_GetBiFloat32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7655
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7656
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7657
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7658
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7659
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7660
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBiFloat32);  -- pwr_baseclasses.h:7661

   --  skipped anonymous struct anon_433

  --  Class: GetBiInt32
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBiInt32
  --    Body:  DevBody
  --    @Aref GetBiInt32 pwr_sdClass_GetBiInt32
  -- 

   type pwr_sdClass_GetBiInt32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7680
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7681
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7682
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7683
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7684
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7685
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBiInt32);  -- pwr_baseclasses.h:7686

   --  skipped anonymous struct anon_434

  --  Class: GetBiString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBiString80
  --    Body:  DevBody
  --    @Aref GetBiString80 pwr_sdClass_GetBiString80
  -- 

   type pwr_sdClass_GetBiString80 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7705
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7706
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7707
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7708
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7709
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7710
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBiString80);  -- pwr_baseclasses.h:7711

   --  skipped anonymous struct anon_435

  --  Class: GetBoFloat32
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBoFloat32
  --    Body:  DevBody
  --    @Aref GetBoFloat32 pwr_sdClass_GetBoFloat32
  -- 

   type pwr_sdClass_GetBoFloat32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7730
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7731
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7732
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7733
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7734
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7735
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBoFloat32);  -- pwr_baseclasses.h:7736

   --  skipped anonymous struct anon_436

  --  Class: GetBoInt32
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBoInt32
  --    Body:  DevBody
  --    @Aref GetBoInt32 pwr_sdClass_GetBoInt32
  -- 

   type pwr_sdClass_GetBoInt32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7755
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7756
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7757
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7758
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7759
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7760
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBoInt32);  -- pwr_baseclasses.h:7761

   --  skipped anonymous struct anon_437

  --  Class: GetBoString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetBoString80
  --    Body:  DevBody
  --    @Aref GetBoString80 pwr_sdClass_GetBoString80
  -- 

   type pwr_sdClass_GetBoString80 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7780
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7781
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7782
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7783
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7784
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7785
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetBoString80);  -- pwr_baseclasses.h:7786

   --  skipped anonymous struct anon_438

  --  Class: GetConstAv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetConstAv
  --    Body:  DevBody
  --    @Aref GetConstAv pwr_sdClass_GetConstAv
  -- 

   type pwr_sdClass_GetConstAv is record
      AvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7805
      AvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7806
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7807
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetConstAv);  -- pwr_baseclasses.h:7808

   --  skipped anonymous struct anon_439

  --  Class: GetConstIv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetConstIv
  --    Body:  DevBody
  --    @Aref GetConstIv pwr_sdClass_GetConstIv
  -- 

   type pwr_sdClass_GetConstIv is record
      IvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7827
      IvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7828
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7829
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetConstIv);  -- pwr_baseclasses.h:7830

   --  skipped anonymous struct anon_440

  --_* Class: GetData
  --    Body:  RtBody
  --    @Aref GetData pwr_sClass_GetData
  -- 

   type pwr_sClass_GetData is record
      c_Out : System.Address;  -- pwr_baseclasses.h:7844
      DataObjid : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:7845
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetData);  -- pwr_baseclasses.h:7846

   --  skipped anonymous struct anon_441

  --_* Class: GetData
  --    Body:  DevBody
  --    @Aref GetData pwr_sdClass_GetData
  -- 

   type pwr_sdClass_GetData is record
      DataObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7854
      DataObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7855
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7856
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetData);  -- pwr_baseclasses.h:7857

   --  skipped anonymous struct anon_442

  --_* Class: GetDataInput
  --    Body:  RtBody
  --    @Aref GetDataInput pwr_sClass_GetDataInput
  -- 

   type pwr_sClass_GetDataInput is record
      OutDataP : System.Address;  -- pwr_baseclasses.h:7871
      OutDataObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:7872
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetDataInput);  -- pwr_baseclasses.h:7873

   --  skipped anonymous struct anon_443

  --_* Class: GetDataInput
  --    Body:  DevBody
  --    @Aref GetDataInput pwr_sdClass_GetDataInput
  -- 

   type pwr_sdClass_GetDataInput is record
      DataObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7881
      DataObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7882
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7883
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDataInput);  -- pwr_baseclasses.h:7884

   --  skipped anonymous struct anon_444

  --_* Class: GetDatap
  --    Body:  RtBody
  --    @Aref GetDatap pwr_sClass_GetDatap
  -- 

   type pwr_sClass_GetDatap is record
      c_Out : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:7898
      DataObjid : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:7899
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetDatap);  -- pwr_baseclasses.h:7900

   --  skipped anonymous struct anon_445

  --_* Class: GetDatap
  --    Body:  DevBody
  --    @Aref GetDatap pwr_sdClass_GetDatap
  -- 

   type pwr_sdClass_GetDatap is record
      DatapObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7908
      DatapObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7909
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7910
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDatap);  -- pwr_baseclasses.h:7911

   --  skipped anonymous struct anon_446

  --  Class: GetDattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDattr
  --    Body:  DevBody
  --    @Aref GetDattr pwr_sdClass_GetDattr
  -- 

   type pwr_sdClass_GetDattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:7930
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7931
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDattr);  -- pwr_baseclasses.h:7932

   --  skipped anonymous struct anon_447

  --_* Class: GetDgeneric
  --    Body:  DevBody
  --    @Aref GetDgeneric pwr_sdClass_GetDgeneric
  -- 

   type pwr_sdClass_GetDgeneric is record
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7946
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7947
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDgeneric);  -- pwr_baseclasses.h:7948

   --  skipped anonymous struct anon_448

  --  Class: GetDi
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDi
  --    Body:  DevBody
  --    @Aref GetDi pwr_sdClass_GetDi
  -- 

   type pwr_sdClass_GetDi is record
      DiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7967
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7968
      DiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7969
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7970
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7971
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7972
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDi);  -- pwr_baseclasses.h:7973

   --  skipped anonymous struct anon_449

  --  Class: GetDo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDo
  --    Body:  DevBody
  --    @Aref GetDo pwr_sdClass_GetDo
  -- 

   type pwr_sdClass_GetDo is record
      DoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7992
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:7993
      DoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7994
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:7995
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:7996
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:7997
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDo);  -- pwr_baseclasses.h:7998

   --  skipped anonymous struct anon_450

  --  Class: GetDp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDp
  --    Body:  DevBody
  --    @Aref GetDp pwr_sdClass_GetDp
  -- 

   type pwr_sdClass_GetDp is record
      DpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8017
      DpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8018
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8019
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDp);  -- pwr_baseclasses.h:8020

   --  skipped anonymous struct anon_451

  --_* Class: GetDpPtr
  --    Body:  RtBody
  --    @Aref GetDpPtr pwr_sClass_GetDpPtr
  -- 

   type pwr_sClass_GetDpPtr is record
      DpPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8034
      Ptr : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8035
      Value : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8036
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetDpPtr);  -- pwr_baseclasses.h:8037

   --  skipped anonymous struct anon_452

  --_* Class: GetDpPtr
  --    Body:  DevBody
  --    @Aref GetDpPtr pwr_sdClass_GetDpPtr
  -- 

   type pwr_sdClass_GetDpPtr is record
      DpPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8045
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8046
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDpPtr);  -- pwr_baseclasses.h:8047

   --  skipped anonymous struct anon_453

  --_* Class: GetDTgeneric
  --    Body:  DevBody
  --    @Aref GetDTgeneric pwr_sdClass_GetDTgeneric
  -- 

   type pwr_sdClass_GetDTgeneric is record
      ActualValue : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:8061
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8062
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDTgeneric);  -- pwr_baseclasses.h:8063

   --  skipped anonymous struct anon_454

  --  Class: GetDTp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDTp
  --    Body:  DevBody
  --    @Aref GetDTp pwr_sdClass_GetDTp
  -- 

   type pwr_sdClass_GetDTp is record
      DTpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8082
      DTpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8083
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8084
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDTp);  -- pwr_baseclasses.h:8085

   --  skipped anonymous struct anon_455

  --  Class: GetDTv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDTv
  --    Body:  DevBody
  --    @Aref GetDTv pwr_sdClass_GetDTv
  -- 

   type pwr_sdClass_GetDTv is record
      DTvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8104
      DTvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8105
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8106
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDTv);  -- pwr_baseclasses.h:8107

   --  skipped anonymous struct anon_456

  --  Class: GetDv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetDv
  --    Body:  DevBody
  --    @Aref GetDv pwr_sdClass_GetDv
  -- 

   type pwr_sdClass_GetDv is record
      DvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8126
      DvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8127
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8128
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetDv);  -- pwr_baseclasses.h:8129

   --  skipped anonymous struct anon_457

  --_* Class: GetExtBoolean
  --    Body:  RtBody
  --    @Aref GetExtBoolean pwr_sClass_GetExtBoolean
  -- 

   type pwr_sClass_GetExtBoolean is record
      ExtP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8143
      ActVal : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8144
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtBoolean);  -- pwr_baseclasses.h:8145

   --  skipped anonymous struct anon_458

  --_* Class: GetExtBoolean
  --    Body:  DevBody
  --    @Aref GetExtBoolean pwr_sdClass_GetExtBoolean
  -- 

   type pwr_sdClass_GetExtBoolean is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8153
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8154
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtBoolean);  -- pwr_baseclasses.h:8155

   --  skipped anonymous struct anon_459

  --_* Class: GetExtFloat32
  --    Body:  RtBody
  --    @Aref GetExtFloat32 pwr_sClass_GetExtFloat32
  -- 

   type pwr_sClass_GetExtFloat32 is record
      ExtP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8169
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8170
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtFloat32);  -- pwr_baseclasses.h:8171

   --  skipped anonymous struct anon_460

  --_* Class: GetExtFloat32
  --    Body:  DevBody
  --    @Aref GetExtFloat32 pwr_sdClass_GetExtFloat32
  -- 

   type pwr_sdClass_GetExtFloat32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8179
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8180
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtFloat32);  -- pwr_baseclasses.h:8181

   --  skipped anonymous struct anon_461

  --_* Class: GetExtFloat64
  --    Body:  RtBody
  --    @Aref GetExtFloat64 pwr_sClass_GetExtFloat64
  -- 

   type pwr_sClass_GetExtFloat64 is record
      ExtP : access pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:8195
      ActVal : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:8196
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtFloat64);  -- pwr_baseclasses.h:8197

   --  skipped anonymous struct anon_462

  --_* Class: GetExtFloat64
  --    Body:  DevBody
  --    @Aref GetExtFloat64 pwr_sdClass_GetExtFloat64
  -- 

   type pwr_sdClass_GetExtFloat64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8205
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8206
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtFloat64);  -- pwr_baseclasses.h:8207

   --  skipped anonymous struct anon_463

  --_* Class: GetExtInt16
  --    Body:  RtBody
  --    @Aref GetExtInt16 pwr_sClass_GetExtInt16
  -- 

   type pwr_sClass_GetExtInt16 is record
      ExtP : access pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:8221
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8222
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtInt16);  -- pwr_baseclasses.h:8223

   --  skipped anonymous struct anon_464

  --_* Class: GetExtInt16
  --    Body:  DevBody
  --    @Aref GetExtInt16 pwr_sdClass_GetExtInt16
  -- 

   type pwr_sdClass_GetExtInt16 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8231
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8232
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtInt16);  -- pwr_baseclasses.h:8233

   --  skipped anonymous struct anon_465

  --_* Class: GetExtInt32
  --    Body:  RtBody
  --    @Aref GetExtInt32 pwr_sClass_GetExtInt32
  -- 

   type pwr_sClass_GetExtInt32 is record
      ExtP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8247
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8248
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtInt32);  -- pwr_baseclasses.h:8249

   --  skipped anonymous struct anon_466

  --_* Class: GetExtInt32
  --    Body:  DevBody
  --    @Aref GetExtInt32 pwr_sdClass_GetExtInt32
  -- 

   type pwr_sdClass_GetExtInt32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8257
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8258
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtInt32);  -- pwr_baseclasses.h:8259

   --  skipped anonymous struct anon_467

  --_* Class: GetExtInt64
  --    Body:  RtBody
  --    @Aref GetExtInt64 pwr_sClass_GetExtInt64
  -- 

   type pwr_sClass_GetExtInt64 is record
      ExtP : access pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:8273
      ActVal : aliased pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:8274
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtInt64);  -- pwr_baseclasses.h:8275

   --  skipped anonymous struct anon_468

  --_* Class: GetExtInt64
  --    Body:  DevBody
  --    @Aref GetExtInt64 pwr_sdClass_GetExtInt64
  -- 

   type pwr_sdClass_GetExtInt64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8283
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8284
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtInt64);  -- pwr_baseclasses.h:8285

   --  skipped anonymous struct anon_469

  --_* Class: GetExtInt8
  --    Body:  RtBody
  --    @Aref GetExtInt8 pwr_sClass_GetExtInt8
  -- 

   type pwr_sClass_GetExtInt8 is record
      ExtP : access pwr_h.pwr_tInt8;  -- pwr_baseclasses.h:8299
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8300
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtInt8);  -- pwr_baseclasses.h:8301

   --  skipped anonymous struct anon_470

  --_* Class: GetExtInt8
  --    Body:  DevBody
  --    @Aref GetExtInt8 pwr_sdClass_GetExtInt8
  -- 

   type pwr_sdClass_GetExtInt8 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8309
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8310
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtInt8);  -- pwr_baseclasses.h:8311

   --  skipped anonymous struct anon_471

  --_* Class: GetExtString
  --    Body:  RtBody
  --    @Aref GetExtString pwr_sClass_GetExtString
  -- 

   type pwr_sClass_GetExtString is record
      ExtP : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8325
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8326
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtString);  -- pwr_baseclasses.h:8327

   --  skipped anonymous struct anon_472

  --_* Class: GetExtString
  --    Body:  DevBody
  --    @Aref GetExtString pwr_sdClass_GetExtString
  -- 

   type pwr_sdClass_GetExtString is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8335
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8336
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtString);  -- pwr_baseclasses.h:8337

   --  skipped anonymous struct anon_473

  --_* Class: GetExtTime
  --    Body:  RtBody
  --    @Aref GetExtTime pwr_sClass_GetExtTime
  -- 

   type pwr_sClass_GetExtTime is record
      ExtP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:8351
      ActVal : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:8352
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtTime);  -- pwr_baseclasses.h:8353

   --  skipped anonymous struct anon_474

  --_* Class: GetExtTime
  --    Body:  DevBody
  --    @Aref GetExtTime pwr_sdClass_GetExtTime
  -- 

   type pwr_sdClass_GetExtTime is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8361
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8362
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtTime);  -- pwr_baseclasses.h:8363

   --  skipped anonymous struct anon_475

  --_* Class: GetExtUInt16
  --    Body:  RtBody
  --    @Aref GetExtUInt16 pwr_sClass_GetExtUInt16
  -- 

   type pwr_sClass_GetExtUInt16 is record
      ExtP : access pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:8377
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8378
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtUInt16);  -- pwr_baseclasses.h:8379

   --  skipped anonymous struct anon_476

  --_* Class: GetExtUInt16
  --    Body:  DevBody
  --    @Aref GetExtUInt16 pwr_sdClass_GetExtUInt16
  -- 

   type pwr_sdClass_GetExtUInt16 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8387
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8388
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtUInt16);  -- pwr_baseclasses.h:8389

   --  skipped anonymous struct anon_477

  --_* Class: GetExtUInt32
  --    Body:  RtBody
  --    @Aref GetExtUInt32 pwr_sClass_GetExtUInt32
  -- 

   type pwr_sClass_GetExtUInt32 is record
      ExtP : access pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:8403
      ActVal : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:8404
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtUInt32);  -- pwr_baseclasses.h:8405

   --  skipped anonymous struct anon_478

  --_* Class: GetExtUInt32
  --    Body:  DevBody
  --    @Aref GetExtUInt32 pwr_sdClass_GetExtUInt32
  -- 

   type pwr_sdClass_GetExtUInt32 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8413
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8414
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtUInt32);  -- pwr_baseclasses.h:8415

   --  skipped anonymous struct anon_479

  --_* Class: GetExtUInt64
  --    Body:  RtBody
  --    @Aref GetExtUInt64 pwr_sClass_GetExtUInt64
  -- 

   type pwr_sClass_GetExtUInt64 is record
      ExtP : access pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:8429
      ActVal : aliased pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:8430
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtUInt64);  -- pwr_baseclasses.h:8431

   --  skipped anonymous struct anon_480

  --_* Class: GetExtUInt64
  --    Body:  DevBody
  --    @Aref GetExtUInt64 pwr_sdClass_GetExtUInt64
  -- 

   type pwr_sdClass_GetExtUInt64 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8439
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8440
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtUInt64);  -- pwr_baseclasses.h:8441

   --  skipped anonymous struct anon_481

  --_* Class: GetExtUInt8
  --    Body:  RtBody
  --    @Aref GetExtUInt8 pwr_sClass_GetExtUInt8
  -- 

   type pwr_sClass_GetExtUInt8 is record
      ExtP : access pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:8455
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8456
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetExtUInt8);  -- pwr_baseclasses.h:8457

   --  skipped anonymous struct anon_482

  --_* Class: GetExtUInt8
  --    Body:  DevBody
  --    @Aref GetExtUInt8 pwr_sdClass_GetExtUInt8
  -- 

   type pwr_sdClass_GetExtUInt8 is record
      ExtAttribute : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:8465
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8466
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetExtUInt8);  -- pwr_baseclasses.h:8467

   --  skipped anonymous struct anon_483

  --  Class: GetIattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetIattr
  --    Body:  DevBody
  --    @Aref GetIattr pwr_sdClass_GetIattr
  -- 

   type pwr_sdClass_GetIattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:8486
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8487
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIattr);  -- pwr_baseclasses.h:8488

   --  skipped anonymous struct anon_484

  --_* Class: GetIgeneric
  --    Body:  DevBody
  --    @Aref GetIgeneric pwr_sdClass_GetIgeneric
  -- 

   type pwr_sdClass_GetIgeneric is record
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8502
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8503
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIgeneric);  -- pwr_baseclasses.h:8504

   --  skipped anonymous struct anon_485

  --  Class: GetIi
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetIi
  --    Body:  DevBody
  --    @Aref GetIi pwr_sdClass_GetIi
  -- 

   type pwr_sdClass_GetIi is record
      IiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8523
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8524
      IiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8525
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8526
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8527
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8528
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIi);  -- pwr_baseclasses.h:8529

   --  skipped anonymous struct anon_486

  --  Class: GetIo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetIo
  --    Body:  DevBody
  --    @Aref GetIo pwr_sdClass_GetIo
  -- 

   type pwr_sdClass_GetIo is record
      IoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8548
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8549
      IoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8550
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8551
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8552
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8553
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIo);  -- pwr_baseclasses.h:8554

   --  skipped anonymous struct anon_487

  --_* Class: GetIp
  --    Body:  RtBody
  --    @Aref GetIp pwr_sClass_GetIp
  -- 

   type pwr_sClass_GetIp is record
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8568
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetIp);  -- pwr_baseclasses.h:8569

   --  skipped anonymous struct anon_488

  --_* Class: GetIp
  --    Body:  DevBody
  --    @Aref GetIp pwr_sdClass_GetIp
  -- 

   type pwr_sdClass_GetIp is record
      IpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8577
      IpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8578
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8579
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIp);  -- pwr_baseclasses.h:8580

   --  skipped anonymous struct anon_489

  --_* Class: GetIpPtr
  --    Body:  RtBody
  --    @Aref GetIpPtr pwr_sClass_GetIpPtr
  -- 

   type pwr_sClass_GetIpPtr is record
      IpPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8594
      Ptr : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8595
      Value : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8596
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetIpPtr);  -- pwr_baseclasses.h:8597

   --  skipped anonymous struct anon_490

  --_* Class: GetIpPtr
  --    Body:  DevBody
  --    @Aref GetIpPtr pwr_sdClass_GetIpPtr
  -- 

   type pwr_sdClass_GetIpPtr is record
      IpPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8605
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8606
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIpPtr);  -- pwr_baseclasses.h:8607

   --  skipped anonymous struct anon_491

  --_* Class: GetIpToA
  --    Body:  RtBody
  --    @Aref GetIpToA pwr_sClass_GetIpToA
  -- 

   type pwr_sClass_GetIpToA is record
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8621
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GetIpToA);  -- pwr_baseclasses.h:8622

   --  skipped anonymous struct anon_492

  --_* Class: GetIpToA
  --    Body:  DevBody
  --    @Aref GetIpToA pwr_sdClass_GetIpToA
  -- 

   type pwr_sdClass_GetIpToA is record
      IpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8630
      IpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8631
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8632
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIpToA);  -- pwr_baseclasses.h:8633

   --  skipped anonymous struct anon_493

  --  Class: GetIv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetIv
  --    Body:  DevBody
  --    @Aref GetIv pwr_sdClass_GetIv
  -- 

   type pwr_sdClass_GetIv is record
      IvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8652
      IvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8653
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8654
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetIv);  -- pwr_baseclasses.h:8655

   --  skipped anonymous struct anon_494

  --  Class: GetPi
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetPi
  --    Body:  DevBody
  --    @Aref GetPi pwr_sdClass_GetPi
  -- 

   type pwr_sdClass_GetPi is record
      CoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8674
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8675
      CoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8676
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8677
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8678
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8679
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetPi);  -- pwr_baseclasses.h:8680

   --  skipped anonymous struct anon_495

  --  Class: GetSattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetSattr
  --    Body:  DevBody
  --    @Aref GetSattr pwr_sdClass_GetSattr
  -- 

   type pwr_sdClass_GetSattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:8699
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8700
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetSattr);  -- pwr_baseclasses.h:8701

   --  skipped anonymous struct anon_496

  --_* Class: GetSgeneric
  --    Body:  DevBody
  --    @Aref GetSgeneric pwr_sdClass_GetSgeneric
  -- 

   type pwr_sdClass_GetSgeneric is record
      ActualValue : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8715
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8716
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetSgeneric);  -- pwr_baseclasses.h:8717

   --  skipped anonymous struct anon_497

  --  Class: GetSp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetSp
  --    Body:  DevBody
  --    @Aref GetSp pwr_sdClass_GetSp
  -- 

   type pwr_sdClass_GetSp is record
      SpObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8736
      SpObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8737
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8738
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetSp);  -- pwr_baseclasses.h:8739

   --  skipped anonymous struct anon_498

  --  Class: GetSv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: GetSv
  --    Body:  DevBody
  --    @Aref GetSv pwr_sdClass_GetSv
  -- 

   type pwr_sdClass_GetSv is record
      SvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:8758
      SvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8759
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8760
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GetSv);  -- pwr_baseclasses.h:8761

   --  skipped anonymous struct anon_499

  --_* Class: Graph
  --    Body:  RtBody
  --    @Aref Graph pwr_sClass_Graph
  -- 

   type pwr_sClass_Graph is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8775
      Title : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:8776
      GMS_Model : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8777
      UpdateInterval : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8778
      X : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:8779
      Y : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:8780
      Width : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:8781
      GmsX1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8782
      GmsY1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8783
      GmsX2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8784
      GmsY2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8785
      FirstInputField : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:8786
      RemSubscrWhenIcon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8787
      ScreenNo : aliased pwr_h.pwr_tInt8;  -- pwr_baseclasses.h:8788
      CodeBehind : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8789
      ClassName : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:8790
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Graph);  -- pwr_baseclasses.h:8791

   --  skipped anonymous struct anon_500

  --_* Class: GraphDistribute
  --    Body:  DevBody
  --    @Aref GraphDistribute pwr_sdClass_GraphDistribute
  -- 

   type pwr_sdClass_GraphDistribute is record
      Source : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8805
      Target : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8806
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GraphDistribute);  -- pwr_baseclasses.h:8807

   --  skipped anonymous struct anon_501

  --_* Class: Gray
  --    Body:  RtBody
  --    @Aref Gray pwr_sClass_gray
  -- 

   type pwr_sClass_gray is record
      Din0P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8821
      Din0 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8822
      Din1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8823
      Din1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8824
      Din2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8825
      Din2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8826
      Din3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8827
      Din3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8828
      Din4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8829
      Din4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8830
      Din5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8831
      Din5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8832
      Din6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8833
      Din6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8834
      Din7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8835
      Din7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8836
      Din8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8837
      Din8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8838
      Din9P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8839
      Din9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8840
      DinAP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8841
      DinA : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8842
      DinBP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8843
      DinB : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8844
      DinCP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8845
      DinC : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8846
      DinDP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8847
      DinD : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8848
      DinEP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8849
      DinE : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8850
      DinFP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8851
      DinF : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8852
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8853
      Inv : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8854
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_gray);  -- pwr_baseclasses.h:8855

   --  skipped anonymous struct anon_502

  --_* Class: Gray
  --    Body:  DevBody
  --    @Aref Gray pwr_sdClass_Gray
  -- 

   type pwr_sdClass_Gray is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8863
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Gray);  -- pwr_baseclasses.h:8864

   --  skipped anonymous struct anon_503

  --_* Class: GreaterEqual
  --    Body:  RtBody
  --    @Aref GreaterEqual pwr_sClass_GreaterEqual
  -- 

   type pwr_sClass_GreaterEqual is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8878
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8879
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8880
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8881
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8882
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GreaterEqual);  -- pwr_baseclasses.h:8883

   --  skipped anonymous struct anon_504

  --_* Class: GreaterEqual
  --    Body:  DevBody
  --    @Aref GreaterEqual pwr_sdClass_GreaterEqual
  -- 

   type pwr_sdClass_GreaterEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8891
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GreaterEqual);  -- pwr_baseclasses.h:8892

   --  skipped anonymous struct anon_505

  --_* Class: GreaterThan
  --    Body:  RtBody
  --    @Aref GreaterThan pwr_sClass_GreaterThan
  -- 

   type pwr_sClass_GreaterThan is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8906
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8907
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8908
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8909
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:8910
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_GreaterThan);  -- pwr_baseclasses.h:8911

   --  skipped anonymous struct anon_506

  --_* Class: GreaterThan
  --    Body:  DevBody
  --    @Aref GreaterThan pwr_sdClass_GreaterThan
  -- 

   type pwr_sdClass_GreaterThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8919
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_GreaterThan);  -- pwr_baseclasses.h:8920

   --  skipped anonymous struct anon_507

  --_* Class: Group
  --    Body:  RtBody
  --    @Aref Group pwr_sClass_Group
  -- 

   type pwr_sClass_Group_GroupObjects_array is array (0 .. 7, 0 .. 79) of aliased char;
   type pwr_sClass_Group is record
      NoOfObjects : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:8934
      GroupObjects : aliased pwr_sClass_Group_GroupObjects_array;  -- pwr_baseclasses.h:8935
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Group);  -- pwr_baseclasses.h:8936

   --  skipped anonymous struct anon_508

  --_* Class: Head
  --    Body:  DevBody
  --    @Aref Head pwr_sdClass_Head
  -- 

   type pwr_sdClass_Head is record
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:8950
      TextAttribute : aliased pwr_tTextAttrEnum;  -- pwr_baseclasses.h:8951
      FrameAttribute : aliased pwr_tFrameAttrEnum;  -- pwr_baseclasses.h:8952
      FrameWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8953
      FrameHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:8954
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8955
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Head);  -- pwr_baseclasses.h:8956

   --  skipped anonymous struct anon_509

  --_* Class: IAbs
  --    Body:  RtBody
  --    @Aref IAbs pwr_sClass_IAbs
  -- 

   type pwr_sClass_IAbs is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8970
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8971
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8972
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IAbs);  -- pwr_baseclasses.h:8973

   --  skipped anonymous struct anon_510

  --_* Class: IAbs
  --    Body:  DevBody
  --    @Aref IAbs pwr_sdClass_IAbs
  -- 

   type pwr_sdClass_IAbs is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:8981
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IAbs);  -- pwr_baseclasses.h:8982

   --  skipped anonymous struct anon_511

  --_* Class: IAdd
  --    Body:  RtBody
  --    @Aref IAdd pwr_sClass_IAdd
  -- 

   type pwr_sClass_IAdd is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8996
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8997
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8998
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:8999
      In3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9000
      In3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9001
      In4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9002
      In4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9003
      In5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9004
      In5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9005
      In6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9006
      In6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9007
      In7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9008
      In7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9009
      In8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9010
      In8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9011
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9012
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IAdd);  -- pwr_baseclasses.h:9013

   --  skipped anonymous struct anon_512

  --_* Class: IAdd
  --    Body:  DevBody
  --    @Aref IAdd pwr_sdClass_IAdd
  -- 

   type pwr_sdClass_IAdd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9021
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IAdd);  -- pwr_baseclasses.h:9022

   --  skipped anonymous struct anon_513

  --_* Class: IArray100
  --    Body:  RtBody
  --    @Aref IArray100 pwr_sClass_IArray100
  -- 

   type pwr_sClass_IArray100_Value_array is array (0 .. 99) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IArray100 is record
      Value : aliased pwr_sClass_IArray100_Value_array;  -- pwr_baseclasses.h:9036
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IArray100);  -- pwr_baseclasses.h:9037

   --  skipped anonymous struct anon_514

  --_* Class: IArray500
  --    Body:  RtBody
  --    @Aref IArray500 pwr_sClass_IArray500
  -- 

   type pwr_sClass_IArray500_Value_array is array (0 .. 499) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IArray500 is record
      Value : aliased pwr_sClass_IArray500_Value_array;  -- pwr_baseclasses.h:9051
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IArray500);  -- pwr_baseclasses.h:9052

   --  skipped anonymous struct anon_515

  --_* Class: IDemux
  --    Body:  RtBody
  --    @Aref IDemux pwr_sClass_IDemux
  -- 

   type pwr_sClass_IDemux is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9066
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9067
      IndexP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9068
      Index : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9069
      Out0 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9070
      Out1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9071
      Out2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9072
      Out3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9073
      Out4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9074
      Out5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9075
      Out6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9076
      Out7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9077
      Out8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9078
      Out9 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9079
      Out10 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9080
      Out11 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9081
      Out12 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9082
      Out13 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9083
      Out14 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9084
      Out15 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9085
      Out16 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9086
      Out17 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9087
      Out18 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9088
      Out19 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9089
      Out20 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9090
      Out21 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9091
      Out22 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9092
      Out23 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9093
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IDemux);  -- pwr_baseclasses.h:9094

   --  skipped anonymous struct anon_516

  --_* Class: IDemux
  --    Body:  DevBody
  --    @Aref IDemux pwr_sdClass_IDemux
  -- 

   type pwr_sdClass_IDemux is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9102
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IDemux);  -- pwr_baseclasses.h:9103

   --  skipped anonymous struct anon_517

  --_* Class: IDiv
  --    Body:  RtBody
  --    @Aref IDiv pwr_sClass_IDiv
  -- 

   type pwr_sClass_IDiv is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9117
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9118
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9119
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9120
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9121
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IDiv);  -- pwr_baseclasses.h:9122

   --  skipped anonymous struct anon_518

  --_* Class: IDiv
  --    Body:  DevBody
  --    @Aref IDiv pwr_sdClass_IDiv
  -- 

   type pwr_sdClass_IDiv is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9130
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IDiv);  -- pwr_baseclasses.h:9131

   --  skipped anonymous struct anon_519

  --_* Class: IEqual
  --    Body:  RtBody
  --    @Aref IEqual pwr_sClass_IEqual
  -- 

   type pwr_sClass_IEqual is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9145
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9146
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9147
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9148
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9149
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IEqual);  -- pwr_baseclasses.h:9150

   --  skipped anonymous struct anon_520

  --_* Class: IEqual
  --    Body:  DevBody
  --    @Aref IEqual pwr_sdClass_IEqual
  -- 

   type pwr_sdClass_IEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9158
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IEqual);  -- pwr_baseclasses.h:9159

   --  skipped anonymous struct anon_521

  --_* Class: IGreaterEqual
  --    Body:  RtBody
  --    @Aref IGreaterEqual pwr_sClass_IGreaterEqual
  -- 

   type pwr_sClass_IGreaterEqual is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9173
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9174
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9175
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9176
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9177
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IGreaterEqual);  -- pwr_baseclasses.h:9178

   --  skipped anonymous struct anon_522

  --_* Class: IGreaterEqual
  --    Body:  DevBody
  --    @Aref IGreaterEqual pwr_sdClass_IGreaterEqual
  -- 

   type pwr_sdClass_IGreaterEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9186
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IGreaterEqual);  -- pwr_baseclasses.h:9187

   --  skipped anonymous struct anon_523

  --_* Class: IGreaterThan
  --    Body:  RtBody
  --    @Aref IGreaterThan pwr_sClass_IGreaterThan
  -- 

   type pwr_sClass_IGreaterThan is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9201
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9202
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9203
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9204
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9205
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IGreaterThan);  -- pwr_baseclasses.h:9206

   --  skipped anonymous struct anon_524

  --_* Class: IGreaterThan
  --    Body:  DevBody
  --    @Aref IGreaterThan pwr_sdClass_IGreaterThan
  -- 

   type pwr_sdClass_IGreaterThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9214
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IGreaterThan);  -- pwr_baseclasses.h:9215

   --  skipped anonymous struct anon_525

  --_* Class: Ii
  --    Body:  RtBody
  --    @Aref Ii pwr_sClass_Ii
  -- 

   type pwr_sClass_Ii is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:9229
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9230
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9231
      ActualValue : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9232
      InitialValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9233
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9234
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9235
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9236
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9237
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:9238
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9239
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9240
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9241
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:9242
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Ii);  -- pwr_baseclasses.h:9243

   --  skipped anonymous struct anon_526

  --_* Class: IiArea
  --    Body:  RtBody
  --    @Aref IiArea pwr_sClass_IiArea
  -- 

   type pwr_sClass_IiArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IiArea is record
      Value : aliased pwr_sClass_IiArea_Value_array;  -- pwr_baseclasses.h:9257
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IiArea);  -- pwr_baseclasses.h:9258

   --  skipped anonymous struct anon_527

  --_* Class: ILessEqual
  --    Body:  RtBody
  --    @Aref ILessEqual pwr_sClass_ILessEqual
  -- 

   type pwr_sClass_ILessEqual is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9272
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9273
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9274
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9275
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9276
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ILessEqual);  -- pwr_baseclasses.h:9277

   --  skipped anonymous struct anon_528

  --_* Class: ILessEqual
  --    Body:  DevBody
  --    @Aref ILessEqual pwr_sdClass_ILessEqual
  -- 

   type pwr_sdClass_ILessEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9285
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ILessEqual);  -- pwr_baseclasses.h:9286

   --  skipped anonymous struct anon_529

  --_* Class: ILessThan
  --    Body:  RtBody
  --    @Aref ILessThan pwr_sClass_ILessThan
  -- 

   type pwr_sClass_ILessThan is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9300
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9301
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9302
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9303
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9304
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ILessThan);  -- pwr_baseclasses.h:9305

   --  skipped anonymous struct anon_530

  --_* Class: ILessThan
  --    Body:  DevBody
  --    @Aref ILessThan pwr_sdClass_ILessThan
  -- 

   type pwr_sdClass_ILessThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9313
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ILessThan);  -- pwr_baseclasses.h:9314

   --  skipped anonymous struct anon_531

  --_* Class: ILimit
  --    Body:  RtBody
  --    @Aref ILimit pwr_sClass_ILimit
  -- 

   type pwr_sClass_ILimit is record
      MaxP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9328
      Max : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9329
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9330
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9331
      MinP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9332
      Min : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9333
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9334
      High : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9335
      Low : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9336
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ILimit);  -- pwr_baseclasses.h:9337

   --  skipped anonymous struct anon_532

  --_* Class: ILimit
  --    Body:  DevBody
  --    @Aref ILimit pwr_sdClass_ILimit
  -- 

   type pwr_sdClass_ILimit is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9345
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ILimit);  -- pwr_baseclasses.h:9346

   --  skipped anonymous struct anon_533

  --_* Class: IMax
  --    Body:  RtBody
  --    @Aref IMax pwr_sClass_IMax
  -- 

   type pwr_sClass_IMax is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9360
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9361
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9362
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9363
      In3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9364
      In3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9365
      In4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9366
      In4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9367
      In5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9368
      In5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9369
      In6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9370
      In6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9371
      In7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9372
      In7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9373
      In8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9374
      In8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9375
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9376
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IMax);  -- pwr_baseclasses.h:9377

   --  skipped anonymous struct anon_534

  --_* Class: IMax
  --    Body:  DevBody
  --    @Aref IMax pwr_sdClass_IMax
  -- 

   type pwr_sdClass_IMax is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9385
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IMax);  -- pwr_baseclasses.h:9386

   --  skipped anonymous struct anon_535

  --_* Class: IMin
  --    Body:  RtBody
  --    @Aref IMin pwr_sClass_IMin
  -- 

   type pwr_sClass_IMin is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9400
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9401
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9402
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9403
      In3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9404
      In3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9405
      In4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9406
      In4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9407
      In5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9408
      In5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9409
      In6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9410
      In6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9411
      In7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9412
      In7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9413
      In8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9414
      In8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9415
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9416
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IMin);  -- pwr_baseclasses.h:9417

   --  skipped anonymous struct anon_536

  --_* Class: IMin
  --    Body:  DevBody
  --    @Aref IMin pwr_sdClass_IMin
  -- 

   type pwr_sdClass_IMin is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9425
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IMin);  -- pwr_baseclasses.h:9426

   --  skipped anonymous struct anon_537

  --_* Class: IMul
  --    Body:  RtBody
  --    @Aref IMul pwr_sClass_IMul
  -- 

   type pwr_sClass_IMul is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9440
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9441
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9442
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9443
      In3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9444
      In3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9445
      In4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9446
      In4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9447
      In5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9448
      In5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9449
      In6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9450
      In6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9451
      In7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9452
      In7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9453
      In8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9454
      In8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9455
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9456
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IMul);  -- pwr_baseclasses.h:9457

   --  skipped anonymous struct anon_538

  --_* Class: IMul
  --    Body:  DevBody
  --    @Aref IMul pwr_sdClass_IMul
  -- 

   type pwr_sdClass_IMul is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9465
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IMul);  -- pwr_baseclasses.h:9466

   --  skipped anonymous struct anon_539

  --_* Class: IMux
  --    Body:  RtBody
  --    @Aref IMux pwr_sClass_IMux
  -- 

   type pwr_sClass_IMux is record
      IndexP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9480
      Index : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9481
      In0P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9482
      In0 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9483
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9484
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9485
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9486
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9487
      In3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9488
      In3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9489
      In4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9490
      In4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9491
      In5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9492
      In5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9493
      In6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9494
      In6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9495
      In7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9496
      In7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9497
      In8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9498
      In8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9499
      In9P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9500
      In9 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9501
      In10P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9502
      In10 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9503
      In11P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9504
      In11 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9505
      In12P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9506
      In12 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9507
      In13P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9508
      In13 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9509
      In14P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9510
      In14 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9511
      In15P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9512
      In15 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9513
      In16P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9514
      In16 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9515
      In17P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9516
      In17 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9517
      In18P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9518
      In18 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9519
      In19P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9520
      In19 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9521
      In20P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9522
      In20 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9523
      In21P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9524
      In21 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9525
      In22P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9526
      In22 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9527
      In23P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9528
      In23 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9529
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9530
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IMux);  -- pwr_baseclasses.h:9531

   --  skipped anonymous struct anon_540

  --_* Class: IMux
  --    Body:  DevBody
  --    @Aref IMux pwr_sdClass_IMux
  -- 

   type pwr_sdClass_IMux is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9539
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IMux);  -- pwr_baseclasses.h:9540

   --  skipped anonymous struct anon_541

  --_* Class: Inc3P
  --    Body:  RtBody
  --    @Aref Inc3P pwr_sClass_inc3p
  -- 

   type pwr_sClass_inc3p is record
      OutChangeP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9554
      OutChange : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9555
      Open : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9556
      Close : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9557
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9558
      Gain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9559
      MinTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9560
      MaxTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9561
      OpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9562
      CloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9563
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9564
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9565
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9566
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9567
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9568
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9569
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:9570
      Acc : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9571
      AccTim : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9572
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_inc3p);  -- pwr_baseclasses.h:9573

   --  skipped anonymous struct anon_542

  --_* Class: Inc3P
  --    Body:  DevBody
  --    @Aref Inc3P pwr_sdClass_Inc3P
  -- 

   type pwr_sdClass_Inc3P is record
      DoOpen : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9581
      DoClose : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9582
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9583
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Inc3P);  -- pwr_baseclasses.h:9584

   --  skipped anonymous struct anon_543

  --_* Class: InitArea
  --    Body:  RtBody
  --    @Aref InitArea pwr_sClass_InitArea
  -- 

   type pwr_sClass_InitArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tUInt64;
   type pwr_sClass_InitArea is record
      Value : aliased pwr_sClass_InitArea_Value_array;  -- pwr_baseclasses.h:9598
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_InitArea);  -- pwr_baseclasses.h:9599

   --  skipped anonymous struct anon_544

  --_* Class: InitStep
  --    Body:  RtBody
  --    @Aref InitStep pwr_sClass_initstep
  -- 

   type pwr_sClass_initstep_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_initstep is record
      StatusIn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9613
      StatusOut : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9614
      Status : aliased pwr_sClass_initstep_Status_array;  -- pwr_baseclasses.h:9615
      ResetOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9616
      StatusInit : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9617
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_initstep);  -- pwr_baseclasses.h:9618

   --  skipped anonymous struct anon_545

  --_* Class: InitStep
  --    Body:  DevBody
  --    @Aref InitStep pwr_sdClass_InitStep
  -- 

   type pwr_sdClass_InitStep is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9626
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_InitStep);  -- pwr_baseclasses.h:9627

   --  skipped anonymous struct anon_546

  --_* Class: INotEqual
  --    Body:  RtBody
  --    @Aref INotEqual pwr_sClass_INotEqual
  -- 

   type pwr_sClass_INotEqual is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9641
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9642
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9643
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9644
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9645
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_INotEqual);  -- pwr_baseclasses.h:9646

   --  skipped anonymous struct anon_547

  --_* Class: INotEqual
  --    Body:  DevBody
  --    @Aref INotEqual pwr_sdClass_INotEqual
  -- 

   type pwr_sdClass_INotEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9654
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_INotEqual);  -- pwr_baseclasses.h:9655

   --  skipped anonymous struct anon_548

  --_* Class: Int64toI
  --    Body:  RtBody
  --    @Aref Int64toI pwr_sClass_Int64toI
  -- 

   type pwr_sClass_Int64toI is record
      InP : access pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:9669
      c_In : aliased pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:9670
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9671
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Int64toI);  -- pwr_baseclasses.h:9672

   --  skipped anonymous struct anon_549

  --_* Class: Int64toI
  --    Body:  DevBody
  --    @Aref Int64toI pwr_sdClass_Int64toI
  -- 

   type pwr_sdClass_Int64toI is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9680
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Int64toI);  -- pwr_baseclasses.h:9681

   --  skipped anonymous struct anon_550

  --_* Class: Inv
  --    Body:  RtBody
  --    @Aref Inv pwr_sClass_inv
  -- 

   type pwr_sClass_inv is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9695
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9696
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9697
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_inv);  -- pwr_baseclasses.h:9698

   --  skipped anonymous struct anon_551

  --_* Class: Inv
  --    Body:  DevBody
  --    @Aref Inv pwr_sdClass_Inv
  -- 

   type pwr_sdClass_Inv is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9706
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Inv);  -- pwr_baseclasses.h:9707

   --  skipped anonymous struct anon_552

  --_* Class: Io
  --    Body:  RtBody
  --    @Aref Io pwr_sClass_Io
  -- 

   type pwr_sClass_Io is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:9721
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9722
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9723
      ActualValue : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9724
      InitialValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9725
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9726
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9727
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9728
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:9729
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:9730
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9731
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9732
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:9733
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:9734
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Io);  -- pwr_baseclasses.h:9735

   --  skipped anonymous struct anon_553

  --_* Class: IoArea
  --    Body:  RtBody
  --    @Aref IoArea pwr_sClass_IoArea
  -- 

   type pwr_sClass_IoArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IoArea is record
      Value : aliased pwr_sClass_IoArea_Value_array;  -- pwr_baseclasses.h:9749
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IoArea);  -- pwr_baseclasses.h:9750

   --  skipped anonymous struct anon_554

  --_* Class: IOHandler
  --    Body:  RtBody
  --    @Aref IOHandler pwr_sClass_IOHandler
  -- 

   type pwr_sClass_IOHandler is record
      CycleTimeBus : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9764
      CycleTimeSerial : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9765
      IOReadWriteFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9766
      IOSimulFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9767
      DiCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9768
      DoCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9769
      AiCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9770
      AoCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9771
      AvCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9772
      DvCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9773
      CoCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9774
      IiCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9775
      IoCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9776
      IvCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9777
      BiCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9778
      BoCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9779
      BiSize : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9780
      BoSize : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:9781
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IOHandler);  -- pwr_baseclasses.h:9782

   --  skipped anonymous struct anon_555

  --_* Class: IpCollect
  --    Body:  RtBody
  --    @Aref IpCollect pwr_sClass_IpCollect
  -- 

   type pwr_sClass_IpCollect_Ip_array is array (0 .. 23) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IpCollect is record
      IpIn1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9796
      IpIn1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9797
      IpIn2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9798
      IpIn2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9799
      IpIn3P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9800
      IpIn3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9801
      IpIn4P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9802
      IpIn4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9803
      IpIn5P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9804
      IpIn5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9805
      IpIn6P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9806
      IpIn6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9807
      IpIn7P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9808
      IpIn7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9809
      IpIn8P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9810
      IpIn8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9811
      IpIn9P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9812
      IpIn9 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9813
      IpIn10P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9814
      IpIn10 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9815
      IpIn11P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9816
      IpIn11 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9817
      IpIn12P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9818
      IpIn12 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9819
      IpIn13P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9820
      IpIn13 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9821
      IpIn14P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9822
      IpIn14 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9823
      IpIn15P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9824
      IpIn15 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9825
      IpIn16P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9826
      IpIn16 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9827
      IpIn17P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9828
      IpIn17 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9829
      IpIn18P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9830
      IpIn18 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9831
      IpIn19P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9832
      IpIn19 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9833
      IpIn20P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9834
      IpIn20 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9835
      IpIn21P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9836
      IpIn21 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9837
      IpIn22P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9838
      IpIn22 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9839
      IpIn23P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9840
      IpIn23 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9841
      IpIn24P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9842
      IpIn24 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9843
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9844
      Ip : aliased pwr_sClass_IpCollect_Ip_array;  -- pwr_baseclasses.h:9845
      OutDataP : System.Address;  -- pwr_baseclasses.h:9846
      OutData_ObjId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:9847
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IpCollect);  -- pwr_baseclasses.h:9848

   --  skipped anonymous struct anon_556

  --_* Class: IpCollect
  --    Body:  DevBody
  --    @Aref IpCollect pwr_sdClass_IpCollect
  -- 

   type pwr_sdClass_IpCollect is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9856
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IpCollect);  -- pwr_baseclasses.h:9857

   --  skipped anonymous struct anon_557

  --_* Class: IpDistribute
  --    Body:  RtBody
  --    @Aref IpDistribute pwr_sClass_IpDistribute
  -- 

   type pwr_sClass_IpDistribute is record
      DataInP : System.Address;  -- pwr_baseclasses.h:9871
      DataIn : System.Address;  -- pwr_baseclasses.h:9872
      IpOut1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9873
      IpOut2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9874
      IpOut3 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9875
      IpOut4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9876
      IpOut5 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9877
      IpOut6 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9878
      IpOut7 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9879
      IpOut8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9880
      IpOut9 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9881
      IpOut10 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9882
      IpOut11 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9883
      IpOut12 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9884
      IpOut13 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9885
      IpOut14 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9886
      IpOut15 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9887
      IpOut16 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9888
      IpOut17 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9889
      IpOut18 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9890
      IpOut19 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9891
      IpOut20 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9892
      IpOut21 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9893
      IpOut22 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9894
      IpOut23 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9895
      IpOut24 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9896
      MaxIndex : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9897
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IpDistribute);  -- pwr_baseclasses.h:9898

   --  skipped anonymous struct anon_558

  --_* Class: IpDistribute
  --    Body:  DevBody
  --    @Aref IpDistribute pwr_sdClass_IpDistribute
  -- 

   type pwr_sdClass_IpDistribute is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9906
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_IpDistribute);  -- pwr_baseclasses.h:9907

   --  skipped anonymous struct anon_559

  --_* Class: ISel
  --    Body:  RtBody
  --    @Aref ISel pwr_sClass_ISel
  -- 

   type pwr_sClass_ISel is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9921
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9922
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9923
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9924
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9925
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:9926
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9927
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ISel);  -- pwr_baseclasses.h:9928

   --  skipped anonymous struct anon_560

  --_* Class: ISel
  --    Body:  DevBody
  --    @Aref ISel pwr_sdClass_ISel
  -- 

   type pwr_sdClass_ISel is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9936
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ISel);  -- pwr_baseclasses.h:9937

   --  skipped anonymous struct anon_561

  --_* Class: ISub
  --    Body:  RtBody
  --    @Aref ISub pwr_sClass_ISub
  -- 

   type pwr_sClass_ISub is record
      In1P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9951
      In1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9952
      In2P : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9953
      In2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9954
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9955
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ISub);  -- pwr_baseclasses.h:9956

   --  skipped anonymous struct anon_562

  --_* Class: ISub
  --    Body:  DevBody
  --    @Aref ISub pwr_sdClass_ISub
  -- 

   type pwr_sdClass_ISub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9964
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ISub);  -- pwr_baseclasses.h:9965

   --  skipped anonymous struct anon_563

  --_* Class: ItoA
  --    Body:  RtBody
  --    @Aref ItoA pwr_sClass_ItoA
  -- 

   type pwr_sClass_ItoA is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9979
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:9980
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:9981
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ItoA);  -- pwr_baseclasses.h:9982

   --  skipped anonymous struct anon_564

  --_* Class: ItoA
  --    Body:  DevBody
  --    @Aref ItoA pwr_sdClass_ItoA
  -- 

   type pwr_sdClass_ItoA is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:9990
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ItoA);  -- pwr_baseclasses.h:9991

   --  skipped anonymous struct anon_565

  --_* Class: ItoInt64
  --    Body:  RtBody
  --    @Aref ItoInt64 pwr_sClass_ItoInt64
  -- 

   type pwr_sClass_ItoInt64 is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10005
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10006
      ActVal : aliased pwr_h.Class_pwr_tInt64.pwr_tInt64;  -- pwr_baseclasses.h:10007
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ItoInt64);  -- pwr_baseclasses.h:10008

   --  skipped anonymous struct anon_566

  --_* Class: ItoInt64
  --    Body:  DevBody
  --    @Aref ItoInt64 pwr_sdClass_ItoInt64
  -- 

   type pwr_sdClass_ItoInt64 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10016
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ItoInt64);  -- pwr_baseclasses.h:10017

   --  skipped anonymous struct anon_567

  --_* Class: ItoStr
  --    Body:  RtBody
  --    @Aref ItoStr pwr_sClass_ItoStr
  -- 

   type pwr_sClass_ItoStr is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10031
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10032
      Format : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10033
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10034
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ItoStr);  -- pwr_baseclasses.h:10035

   --  skipped anonymous struct anon_568

  --_* Class: ItoStr
  --    Body:  DevBody
  --    @Aref ItoStr pwr_sdClass_ItoStr
  -- 

   type pwr_sdClass_ItoStr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10043
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ItoStr);  -- pwr_baseclasses.h:10044

   --  skipped anonymous struct anon_569

  --_* Class: ItoUInt32
  --    Body:  RtBody
  --    @Aref ItoUInt32 pwr_sClass_ItoUInt32
  -- 

   type pwr_sClass_ItoUInt32 is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10058
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10059
      ActVal : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10060
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ItoUInt32);  -- pwr_baseclasses.h:10061

   --  skipped anonymous struct anon_570

  --_* Class: ItoUInt32
  --    Body:  DevBody
  --    @Aref ItoUInt32 pwr_sdClass_ItoUInt32
  -- 

   type pwr_sdClass_ItoUInt32 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10069
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ItoUInt32);  -- pwr_baseclasses.h:10070

   --  skipped anonymous struct anon_571

  --_* Class: ItoUInt64
  --    Body:  RtBody
  --    @Aref ItoUInt64 pwr_sClass_ItoUInt64
  -- 

   type pwr_sClass_ItoUInt64 is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10084
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10085
      ActVal : aliased pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:10086
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ItoUInt64);  -- pwr_baseclasses.h:10087

   --  skipped anonymous struct anon_572

  --_* Class: ItoUInt64
  --    Body:  DevBody
  --    @Aref ItoUInt64 pwr_sdClass_ItoUInt64
  -- 

   type pwr_sdClass_ItoUInt64 is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10095
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ItoUInt64);  -- pwr_baseclasses.h:10096

   --  skipped anonymous struct anon_573

  --_* Class: Iv
  --    Body:  RtBody
  --    @Aref Iv pwr_sClass_Iv
  -- 

   type pwr_sClass_Iv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10110
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10111
      ActualValue : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10112
      InitialValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10113
      PresMaxLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10114
      PresMinLimit : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10115
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:10116
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:10117
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10118
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:10119
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:10120
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:10121
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10122
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Iv);  -- pwr_baseclasses.h:10123

   --  skipped anonymous struct anon_574

  --_* Class: IvArea
  --    Body:  RtBody
  --    @Aref IvArea pwr_sClass_IvArea
  -- 

   type pwr_sClass_IvArea_Value_array is array (0 .. 0) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_IvArea is record
      Value : aliased pwr_sClass_IvArea_Value_array;  -- pwr_baseclasses.h:10137
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_IvArea);  -- pwr_baseclasses.h:10138

   --  skipped anonymous struct anon_575

  --_* Class: LessEqual
  --    Body:  RtBody
  --    @Aref LessEqual pwr_sClass_LessEqual
  -- 

   type pwr_sClass_LessEqual is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10152
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10153
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10154
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10155
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10156
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_LessEqual);  -- pwr_baseclasses.h:10157

   --  skipped anonymous struct anon_576

  --_* Class: LessEqual
  --    Body:  DevBody
  --    @Aref LessEqual pwr_sdClass_LessEqual
  -- 

   type pwr_sdClass_LessEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10165
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_LessEqual);  -- pwr_baseclasses.h:10166

   --  skipped anonymous struct anon_577

  --_* Class: LessThan
  --    Body:  RtBody
  --    @Aref LessThan pwr_sClass_LessThan
  -- 

   type pwr_sClass_LessThan is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10180
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10181
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10182
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10183
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10184
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_LessThan);  -- pwr_baseclasses.h:10185

   --  skipped anonymous struct anon_578

  --_* Class: LessThan
  --    Body:  DevBody
  --    @Aref LessThan pwr_sdClass_LessThan
  -- 

   type pwr_sdClass_LessThan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10193
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_LessThan);  -- pwr_baseclasses.h:10194

   --  skipped anonymous struct anon_579

  --_* Class: Limit
  --    Body:  RtBody
  --    @Aref Limit pwr_sClass_limit
  -- 

   type pwr_sClass_limit is record
      MaxP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10208
      Max : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10209
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10210
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10211
      MinP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10212
      Min : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10213
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10214
      High : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10215
      Low : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10216
      AccMax : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10217
      AccMin : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10218
      MinmaxC : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10219
      MaxmaxC : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10220
      MinminC : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10221
      MaxMinC : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10222
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_limit);  -- pwr_baseclasses.h:10223

   --  skipped anonymous struct anon_580

  --_* Class: Limit
  --    Body:  DevBody
  --    @Aref Limit pwr_sdClass_Limit
  -- 

   type pwr_sdClass_Limit is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10231
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Limit);  -- pwr_baseclasses.h:10232

   --  skipped anonymous struct anon_581

  --_* Class: ListConfig
  --    Body:  DevBody
  --    @Aref ListConfig pwr_sdClass_ListConfig
  -- 

   type pwr_sdClass_ListConfig is record
      LandscapePageRows : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10246
      PortraitPageRows : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10247
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ListConfig);  -- pwr_baseclasses.h:10248

   --  skipped anonymous struct anon_582

  --_* Class: ListDescriptor
  --    Body:  DevBody
  --    @Aref ListDescriptor pwr_sdClass_ListDescriptor
  -- 

   type pwr_sdClass_ListDescriptor is record
      Title : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10262
      PageHeader : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10263
      Crossreference : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10264
      Externreference : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:10265
      Deep : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10266
      AlphaOrder : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:10267
      NoPrint : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10268
      NoPrintIfNoList : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10269
      Full : aliased pwr_h.pwr_tMask;  -- pwr_baseclasses.h:10270
      Landscape : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10271
      PageBreak : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:10272
      RowsToPageBreak : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10273
      ClearRowsPre : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10274
      ClearRowsPost : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10275
      ClearRowsPreList : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10276
      ClearRowsPostList : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10277
      ColumnHeader : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10278
      ColHead_u_u_u_u_u : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10279
      TableOfContents : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:10280
      TCSegments : aliased pwr_h.pwr_tUInt8;  -- pwr_baseclasses.h:10281
      TCMarginString : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:10282
      Hierarchyobject : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10283
      Name : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10284
      Class : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10285
      Parameter : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:10286
      P1Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10287
      P1ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10288
      P1MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10289
      P1PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10290
      P1CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10291
      P1SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10292
      P1Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10293
      P2Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10294
      P2ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10295
      P2MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10296
      P2PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10297
      P2CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10298
      P2SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10299
      P2Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10300
      P3Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10301
      P3ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10302
      P3MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10303
      P3PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10304
      P3CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10305
      P3SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10306
      P3Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10307
      P4Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10308
      P4ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10309
      P4MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10310
      P4PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10311
      P4CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10312
      P4SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10313
      P4Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10314
      P5Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10315
      P5ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10316
      P5MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10317
      P5PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10318
      P5CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10319
      P5SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10320
      P5Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10321
      P6Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10322
      P6ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10323
      P6MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10324
      P6PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10325
      P6CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10326
      P6SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10327
      P6Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10328
      P7Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10329
      P7ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10330
      P7MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10331
      P7PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10332
      P7CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10333
      P7SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10334
      P7Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10335
      P8Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10336
      P8ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10337
      P8MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10338
      P8PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10339
      P8CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10340
      P8SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10341
      P8Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10342
      P9Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10343
      P9ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10344
      P9MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10345
      P9PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10346
      P9CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10347
      P9SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10348
      P9Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10349
      P10Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10350
      P10ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10351
      P10MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10352
      P10PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10353
      P10CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10354
      P10SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10355
      P10Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10356
      P11Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10357
      P11ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10358
      P11MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10359
      P11PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10360
      P11CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10361
      P11SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10362
      P11Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10363
      P12Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10364
      P12ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10365
      P12MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10366
      P12PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10367
      P12CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10368
      P12SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10369
      P12Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10370
      P13Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10371
      P13ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10372
      P13MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10373
      P13PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10374
      P13CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10375
      P13SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10376
      P13Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10377
      P14Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10378
      P14ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10379
      P14MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10380
      P14PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10381
      P14CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10382
      P14SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10383
      P14Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10384
      P15Parameter : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10385
      P15ColumnHeader : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10386
      P15MarginString : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:10387
      P15PrintParName : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10388
      P15CarriageRet : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10389
      P15SizeTabs : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10390
      P15Segments : aliased pwr_h.pwr_tInt16;  -- pwr_baseclasses.h:10391
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ListDescriptor);  -- pwr_baseclasses.h:10392

   --  skipped anonymous struct anon_583

  --_* Class: Ln
  --    Body:  RtBody
  --    @Aref Ln pwr_sClass_Ln
  -- 

   type pwr_sClass_Ln is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10406
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10407
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10408
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10409
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10410
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Ln);  -- pwr_baseclasses.h:10411

   --  skipped anonymous struct anon_584

  --_* Class: Ln
  --    Body:  DevBody
  --    @Aref Ln pwr_sdClass_Ln
  -- 

   type pwr_sdClass_Ln is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10419
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Ln);  -- pwr_baseclasses.h:10420

   --  skipped anonymous struct anon_585

  --_* Class: LocalTime
  --    Body:  RtBody
  --    @Aref LocalTime pwr_sClass_LocalTime
  -- 

   type pwr_sClass_LocalTime is record
      TimeP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:10434
      Time : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:10435
      Second : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10436
      Minute : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10437
      Hour : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10438
      MDay : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10439
      Month : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10440
      Year : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10441
      WDay : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10442
      YDay : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10443
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_LocalTime);  -- pwr_baseclasses.h:10444

   --  skipped anonymous struct anon_586

  --_* Class: LocalTime
  --    Body:  DevBody
  --    @Aref LocalTime pwr_sdClass_LocalTime
  -- 

   type pwr_sdClass_LocalTime is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10452
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_LocalTime);  -- pwr_baseclasses.h:10453

   --  skipped anonymous struct anon_587

  --_* Class: Log
  --    Body:  RtBody
  --    @Aref Log pwr_sClass_Log
  -- 

   type pwr_sClass_Log is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10467
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10468
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10469
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10470
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10471
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Log);  -- pwr_baseclasses.h:10472

   --  skipped anonymous struct anon_588

  --_* Class: Log
  --    Body:  DevBody
  --    @Aref Log pwr_sdClass_Log
  -- 

   type pwr_sdClass_Log is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10480
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Log);  -- pwr_baseclasses.h:10481

   --  skipped anonymous struct anon_589

  --_* Class: LOrder
  --    Body:  RtBody
  --    @Aref LOrder pwr_sClass_lorder
  -- 

   type pwr_sClass_lorder_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_lorder is record
      Status : aliased pwr_sClass_lorder_Status_array;  -- pwr_baseclasses.h:10495
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10496
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10497
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10498
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10499
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10500
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10501
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10502
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:10503
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10504
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10505
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10506
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_lorder);  -- pwr_baseclasses.h:10507

   --  skipped anonymous struct anon_590

  --_* Class: MaskToD
  --    Body:  RtBody
  --    @Aref MaskToD pwr_sClass_MaskToD
  -- 

   type pwr_sClass_MaskToD is record
      MaskP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10521
      Mask : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10522
      od1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10523
      od2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10524
      od3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10525
      od4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10526
      od5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10527
      od6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10528
      od7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10529
      od8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10530
      od9 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10531
      od10 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10532
      od11 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10533
      od12 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10534
      od13 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10535
      od14 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10536
      od15 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10537
      od16 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10538
      od17 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10539
      od18 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10540
      od19 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10541
      od20 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10542
      od21 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10543
      od22 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10544
      od23 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10545
      od24 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10546
      od25 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10547
      od26 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10548
      od27 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10549
      od28 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10550
      od29 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10551
      od30 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10552
      od31 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10553
      od32 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10554
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_MaskToD);  -- pwr_baseclasses.h:10555

   --  skipped anonymous struct anon_591

  --_* Class: MaskToD
  --    Body:  DevBody
  --    @Aref MaskToD pwr_sdClass_MaskToD
  -- 

   type pwr_sdClass_MaskToD is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10563
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_MaskToD);  -- pwr_baseclasses.h:10564

   --  skipped anonymous struct anon_592

  --_* Class: Max
  --    Body:  RtBody
  --    @Aref Max pwr_sClass_Max
  -- 

   type pwr_sClass_Max is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10578
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10579
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10580
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10581
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10582
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10583
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10584
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10585
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10586
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10587
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10588
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10589
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10590
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10591
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10592
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10593
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10594
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Max);  -- pwr_baseclasses.h:10595

   --  skipped anonymous struct anon_593

  --_* Class: Max
  --    Body:  DevBody
  --    @Aref Max pwr_sdClass_Max
  -- 

   type pwr_sdClass_Max is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10603
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Max);  -- pwr_baseclasses.h:10604

   --  skipped anonymous struct anon_594

  --_* Class: Maxmin
  --    Body:  RtBody
  --    @Aref Maxmin pwr_sClass_maxmin
  -- 

   type pwr_sClass_maxmin is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10618
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10619
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10620
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10621
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10622
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10623
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10624
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10625
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10626
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10627
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10628
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10629
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10630
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10631
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10632
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10633
      MaxVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10634
      MinVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10635
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_maxmin);  -- pwr_baseclasses.h:10636

   --  skipped anonymous struct anon_595

  --_* Class: Maxmin
  --    Body:  DevBody
  --    @Aref Maxmin pwr_sdClass_Maxmin
  -- 

   type pwr_sdClass_Maxmin is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10644
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Maxmin);  -- pwr_baseclasses.h:10645

   --  skipped anonymous struct anon_596

  --_* Class: MessageHandler
  --    Body:  RtBody
  --    @Aref MessageHandler pwr_sClass_MessageHandler
  -- 

   type pwr_sClass_MessageHandler is record
      OutunitServer : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10659
      BlockFile : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10660
      EventLogSize : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10661
      EventListSize : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10662
      MaxApplAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10663
      DetectTimer : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10664
      MessageTimer : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10665
      AlarmFirstIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10666
      AlarmLastIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10667
      AlarmCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10668
      AlarmMaxCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10669
      BlockFirstIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10670
      BlockLastIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10671
      BlockCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10672
      BlockMaxCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10673
      EventFirstIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10674
      EventLastIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10675
      EventCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10676
      EventMaxCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10677
      FreeCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10678
      ScanCycleSup : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10679
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_MessageHandler);  -- pwr_baseclasses.h:10680

   --  skipped anonymous struct anon_597

  --_* Class: Min
  --    Body:  RtBody
  --    @Aref Min pwr_sClass_Min
  -- 

   type pwr_sClass_Min is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10694
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10695
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10696
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10697
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10698
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10699
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10700
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10701
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10702
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10703
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10704
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10705
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10706
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10707
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10708
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10709
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10710
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Min);  -- pwr_baseclasses.h:10711

   --  skipped anonymous struct anon_598

  --_* Class: Min
  --    Body:  DevBody
  --    @Aref Min pwr_sdClass_Min
  -- 

   type pwr_sdClass_Min is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10719
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Min);  -- pwr_baseclasses.h:10720

   --  skipped anonymous struct anon_599

  --_* Class: Mod
  --    Body:  RtBody
  --    @Aref Mod pwr_sClass_Mod
  -- 

   type pwr_sClass_Mod is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10734
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10735
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10736
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10737
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10738
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Mod);  -- pwr_baseclasses.h:10739

   --  skipped anonymous struct anon_600

  --_* Class: Mod
  --    Body:  DevBody
  --    @Aref Mod pwr_sdClass_Mod
  -- 

   type pwr_sdClass_Mod is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10747
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Mod);  -- pwr_baseclasses.h:10748

   --  skipped anonymous struct anon_601

  --_* Class: Mode
  --    Body:  RtBody
  --    @Aref Mode pwr_sClass_mode
  -- 

   type pwr_sClass_mode is record
      XSetValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10762
      XSetVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10763
      ProcValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10764
      ProcVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10765
      XForcValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10766
      XForcVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10767
      Forc1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10768
      Forc1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10769
      Forc2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10770
      Forc2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10771
      OutValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10772
      OutVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10773
      SetVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10774
      ForcVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10775
      Force : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10776
      AutMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10777
      CascMod : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10778
      ManMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10779
      OpMod : aliased pwr_tPidOpModeEnum;  -- pwr_baseclasses.h:10780
      AccMod : aliased pwr_tPidModeEnum;  -- pwr_baseclasses.h:10781
      AccOut : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10782
      MinOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10783
      MaxOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10784
      AccSet : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10785
      MinSet : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10786
      MaxSet : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10787
      SetMaxShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10788
      SetMinShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10789
      OutMaxShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10790
      OutMinShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10791
      SetEngUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:10792
      OutEngUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:10793
      PidObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:10794
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_mode);  -- pwr_baseclasses.h:10795

   --  skipped anonymous struct anon_602

  --_* Class: Mode
  --    Body:  DevBody
  --    @Aref Mode pwr_sdClass_Mode
  -- 

   type pwr_sdClass_Mode is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10803
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Mode);  -- pwr_baseclasses.h:10804

   --  skipped anonymous struct anon_603

  --_* Class: Mul
  --    Body:  RtBody
  --    @Aref Mul pwr_sClass_Mul
  -- 

   type pwr_sClass_Mul is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10818
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10819
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10820
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10821
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10822
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10823
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10824
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10825
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10826
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10827
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10828
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10829
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10830
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10831
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10832
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10833
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10834
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Mul);  -- pwr_baseclasses.h:10835

   --  skipped anonymous struct anon_604

  --_* Class: Mul
  --    Body:  DevBody
  --    @Aref Mul pwr_sdClass_Mul
  -- 

   type pwr_sdClass_Mul is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10843
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Mul);  -- pwr_baseclasses.h:10844

   --  skipped anonymous struct anon_605

  --_* Class: Mux
  --    Body:  RtBody
  --    @Aref Mux pwr_sClass_Mux
  -- 

   type pwr_sClass_Mux is record
      IndexP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10858
      Index : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10859
      In0P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10860
      In0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10861
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10862
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10863
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10864
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10865
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10866
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10867
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10868
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10869
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10870
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10871
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10872
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10873
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10874
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10875
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10876
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10877
      In9P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10878
      In9 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10879
      In10P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10880
      In10 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10881
      In11P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10882
      In11 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10883
      In12P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10884
      In12 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10885
      In13P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10886
      In13 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10887
      In14P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10888
      In14 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10889
      In15P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10890
      In15 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10891
      In16P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10892
      In16 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10893
      In17P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10894
      In17 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10895
      In18P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10896
      In18 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10897
      In19P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10898
      In19 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10899
      In20P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10900
      In20 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10901
      In21P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10902
      In21 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10903
      In22P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10904
      In22 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10905
      In23P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10906
      In23 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10907
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10908
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Mux);  -- pwr_baseclasses.h:10909

   --  skipped anonymous struct anon_606

  --_* Class: Mux
  --    Body:  DevBody
  --    @Aref Mux pwr_sdClass_Mux
  -- 

   type pwr_sdClass_Mux is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10917
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Mux);  -- pwr_baseclasses.h:10918

   --  skipped anonymous struct anon_607

  --_* Class: MValve
  --    Body:  RtBody
  --    @Aref MValve pwr_sClass_mvalve
  -- 

   type pwr_sClass_mvalve is record
      AutoOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10932
      AutoOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10933
      AutoCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10934
      AutoClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10935
      EndOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10936
      EndOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10937
      EndCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10938
      EndClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10939
      ConOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10940
      ConOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10941
      ConCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10942
      ConClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10943
      LocalP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10944
      Local : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10945
      LocalOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10946
      LocalOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10947
      LocalCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10948
      LocalClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10949
      LocalStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10950
      LocalStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10951
      SafeOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10952
      SafeOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10953
      SafeCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10954
      SafeClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10955
      SafeStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10956
      SafeStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10957
      ProdOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10958
      ProdOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10959
      ProdCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10960
      ProdClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10961
      ProdStopP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10962
      ProdStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10963
      ManMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10964
      OrderOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10965
      OrderClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10966
      IndOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10967
      IndClosed : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10968
      Alarm1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10969
      Alarm2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10970
      Alarm3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10971
      Alarm4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10972
      Alarm5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10973
      Alarm6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10974
      SumAlarm : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10975
      Ctime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10976
      RunTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10977
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10978
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10979
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:10980
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10981
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:10982
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10983
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:10984
      ManAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10985
      Status : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:10986
      ManOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10987
      ManClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10988
      ManStop : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:10989
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_mvalve);  -- pwr_baseclasses.h:10990

   --  skipped anonymous struct anon_608

  --_* Class: MValve
  --    Body:  DevBody
  --    @Aref MValve pwr_sdClass_MValve
  -- 

   type pwr_sdClass_MValve is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:10998
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_MValve);  -- pwr_baseclasses.h:10999

   --  skipped anonymous struct anon_609

  --_* Class: NameToStr
  --    Body:  RtBody
  --    @Aref NameToStr pwr_sClass_NameToStr
  -- 

   type pwr_sClass_NameToStr is record
      c_Out : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11013
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_NameToStr);  -- pwr_baseclasses.h:11014

   --  skipped anonymous struct anon_610

  --_* Class: NameToStr
  --    Body:  DevBody
  --    @Aref NameToStr pwr_sdClass_NameToStr
  -- 

   type pwr_sdClass_NameToStr is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11022
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11023
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11024
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_NameToStr);  -- pwr_baseclasses.h:11025

   --  skipped anonymous struct anon_611

  --_* Class: NodeConfig
  --    Body:  RtBody
  --    @Aref NodeConfig pwr_sClass_NodeConfig
  -- 

   type pwr_sClass_NodeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11039
      NodeName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11040
      OperatingSystem : aliased pwr_h.pwr_tOpSysEnum;  -- pwr_baseclasses.h:11041
      BootNode : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11042
      BusNumber : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11043
      Address : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11044
      Port : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11045
      SimulateSingleProcess : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11046
      SimulateSingleScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11047
      DistributeDisable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11048
      RemoteAccessType : aliased pwr_tRemoteShellEnum;  -- pwr_baseclasses.h:11049
      QComMinResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11050
      QComMaxResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11051
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_NodeConfig);  -- pwr_baseclasses.h:11052

   --  skipped anonymous struct anon_612

  --_* Class: NodeLinkSup
  --    Body:  RtBody
  --    @Aref NodeLinkSup pwr_sClass_NodeLinkSup
  -- 

   type pwr_sClass_NodeLinkSup is record
      Node : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11066
      TimeoutTime : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11067
      SubscriptionInterval : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11068
      LinkUp : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11069
      UpTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11070
      DownTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11071
      UpCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11072
      SubId : aliased pwr_h.pwr_tRefId;  -- pwr_baseclasses.h:11073
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11074
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11075
      Action : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11076
      Acked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11077
      Blocked : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11078
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11079
      DetectOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11080
      DetectText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11081
      ReturnText : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11082
      EventType : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11083
      EventPriority : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11084
      EventFlags : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11085
      Sound : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11086
      MoreText : aliased pwr_h.pwr_tText256;  -- pwr_baseclasses.h:11087
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:11088
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11089
      AlarmStatus : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11090
      AlarmCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11091
      DetectCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11092
      DetectSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11093
      DetectTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11094
      ReturnCheck : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11095
      ReturnSend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11096
      ReturnTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11097
      AckTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11098
      AckOutunit : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11099
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11100
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11101
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11102
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11103
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11104
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11105
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11106
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11107
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11108
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11109
      SystemStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:11110
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_NodeLinkSup);  -- pwr_baseclasses.h:11111

   --  skipped anonymous struct anon_613

  --_* Class: NotEqual
  --    Body:  RtBody
  --    @Aref NotEqual pwr_sClass_NotEqual
  -- 

   type pwr_sClass_NotEqual is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11125
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11126
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11127
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11128
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11129
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_NotEqual);  -- pwr_baseclasses.h:11130

   --  skipped anonymous struct anon_614

  --_* Class: NotEqual
  --    Body:  DevBody
  --    @Aref NotEqual pwr_sdClass_NotEqual
  -- 

   type pwr_sdClass_NotEqual is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11138
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_NotEqual);  -- pwr_baseclasses.h:11139

   --  skipped anonymous struct anon_615

  --_* Class: Odd
  --    Body:  RtBody
  --    @Aref Odd pwr_sClass_Odd
  -- 

   type pwr_sClass_Odd is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11153
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11154
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11155
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Odd);  -- pwr_baseclasses.h:11156

   --  skipped anonymous struct anon_616

  --_* Class: Odd
  --    Body:  DevBody
  --    @Aref Odd pwr_sdClass_Odd
  -- 

   type pwr_sdClass_Odd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11164
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Odd);  -- pwr_baseclasses.h:11165

   --  skipped anonymous struct anon_617

  --_* Class: OidArray100
  --    Body:  RtBody
  --    @Aref OidArray100 pwr_sClass_OidArray100
  -- 

   type pwr_sClass_OidArray100_Value_array is array (0 .. 99) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_OidArray100 is record
      Value : aliased pwr_sClass_OidArray100_Value_array;  -- pwr_baseclasses.h:11179
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_OidArray100);  -- pwr_baseclasses.h:11180

   --  skipped anonymous struct anon_618

  --_* Class: OpAppl
  --    Body:  RtBody
  --    @Aref OpAppl pwr_sClass_OpAppl
  -- 

   type pwr_sClass_OpAppl is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11194
      FileName : aliased pwr_h.pwr_tString132;  -- pwr_baseclasses.h:11195
      Display : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11196
      AutoStart : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11197
      Arg : aliased pwr_h.pwr_tString132;  -- pwr_baseclasses.h:11198
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_OpAppl);  -- pwr_baseclasses.h:11199

   --  skipped anonymous struct anon_619

  --_* Class: OpApplMsg
  --    Body:  RtBody
  --    @Aref OpApplMsg pwr_sClass_OpApplMsg
  -- 

   type pwr_sClass_OpApplMsg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11213
      OpApplObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11214
      Id : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11215
      Msg : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11216
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_OpApplMsg);  -- pwr_baseclasses.h:11217

   --  skipped anonymous struct anon_620

  --_* Class: OpPlace
  --    Body:  RtBody
  --    @Aref OpPlace pwr_sClass_OpPlace
  -- 

   type pwr_sClass_OpPlace_AutoStart_array is array (0 .. 24) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_OpPlace_FastAvail_array is array (0 .. 24) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_OpPlace_EventSelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_OpPlace_AlarmViews_array is array (0 .. 24) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_OpPlace is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11231
      UserName : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:11232
      DedicatedOpsysUser : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:11233
      Display : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11234
      Language : aliased pwr_tLanguageEnum;  -- pwr_baseclasses.h:11235
      StartJavaProcess : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11236
      AutoStart : aliased pwr_sClass_OpPlace_AutoStart_array;  -- pwr_baseclasses.h:11237
      FastAvail : aliased pwr_sClass_OpPlace_FastAvail_array;  -- pwr_baseclasses.h:11238
      OpWindPop : aliased pwr_tOpWindPopMask;  -- pwr_baseclasses.h:11239
      OpWindLayout : aliased pwr_tOpWindLayoutMask;  -- pwr_baseclasses.h:11240
      OpWindEventNameSegments : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11241
      AlarmBell : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11242
      BellDelay : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11243
      AttachAudio : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11244
      Options : aliased pwr_tOpPlaceOptionsMask;  -- pwr_baseclasses.h:11245
      MaxNoOfAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11246
      MaxNoOfEvents : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11247
      SelectListIsUpdated : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11248
      EventSelectList : aliased pwr_sClass_OpPlace_EventSelectList_array;  -- pwr_baseclasses.h:11249
      EventListEvents : aliased pwr_tEventListMask;  -- pwr_baseclasses.h:11250
      AlarmViews : aliased pwr_sClass_OpPlace_AlarmViews_array;  -- pwr_baseclasses.h:11251
      SetupScript : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11252
      Printer : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11253
      OpNumber : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11254
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_OpPlace);  -- pwr_baseclasses.h:11255

   --  skipped anonymous struct anon_621

  --_* Class: Or
  --    Body:  RtBody
  --    @Aref Or pwr_sClass_or
  -- 

   type pwr_sClass_or is record
      In1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11269
      In1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11270
      In2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11271
      In2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11272
      In3P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11273
      In3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11274
      In4P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11275
      In4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11276
      In5P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11277
      In5 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11278
      In6P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11279
      In6 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11280
      In7P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11281
      In7 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11282
      In8P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11283
      In8 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11284
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11285
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_or);  -- pwr_baseclasses.h:11286

   --  skipped anonymous struct anon_622

  --_* Class: Or
  --    Body:  DevBody
  --    @Aref Or pwr_sdClass_Or
  -- 

   type pwr_sdClass_Or is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11294
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Or);  -- pwr_baseclasses.h:11295

   --  skipped anonymous struct anon_623

  --_* Class: Order
  --    Body:  RtBody
  --    @Aref Order pwr_sClass_order
  -- 

   type pwr_sClass_order_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_order is record
      StepP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11309
      Step : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11310
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11311
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11312
      Status : aliased pwr_sClass_order_Status_array;  -- pwr_baseclasses.h:11313
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_order);  -- pwr_baseclasses.h:11314

   --  skipped anonymous struct anon_624

  --_* Class: Order
  --    Body:  DevBody
  --    @Aref Order pwr_sdClass_Order
  -- 

   type pwr_sdClass_Order is record
      Attr1 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11322
      AttrTime1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11323
      Attr2 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11324
      AttrTime2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11325
      Attr3 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11326
      AttrTime3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11327
      Attr4 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11328
      AttrTime4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11329
      Attr5 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11330
      AttrTime5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11331
      Attr6 : aliased pwr_h.pwr_tChar;  -- pwr_baseclasses.h:11332
      AttrTime6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11333
      ShowAttrTime : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11334
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11335
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Order);  -- pwr_baseclasses.h:11336

   --  skipped anonymous struct anon_625

  --_* Class: OrderAct
  --    Body:  RtBody
  --    @Aref OrderAct pwr_sClass_OrderAct
  -- 

   type pwr_sClass_OrderAct_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_OrderAct is record
      Status : aliased pwr_sClass_OrderAct_Status_array;  -- pwr_baseclasses.h:11350
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_OrderAct);  -- pwr_baseclasses.h:11351

   --  skipped anonymous struct anon_626

  --_* Class: OrderAct
  --    Body:  DevBody
  --    @Aref OrderAct pwr_sdClass_OrderAct
  -- 

   type pwr_sdClass_OrderAct is record
      OrderObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11359
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11360
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_OrderAct);  -- pwr_baseclasses.h:11361

   --  skipped anonymous struct anon_627

  --_* Class: Out2P
  --    Body:  RtBody
  --    @Aref Out2P pwr_sClass_out2p
  -- 

   type pwr_sClass_out2p is record
      OutValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11375
      OutVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11376
      Order : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11377
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11378
      MaxOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11379
      MinOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11380
      Period : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11381
      RunTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11382
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_out2p);  -- pwr_baseclasses.h:11383

   --  skipped anonymous struct anon_628

  --_* Class: Out2P
  --    Body:  DevBody
  --    @Aref Out2P pwr_sdClass_Out2P
  -- 

   type pwr_sdClass_Out2P is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11391
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Out2P);  -- pwr_baseclasses.h:11392

   --  skipped anonymous struct anon_629

  --_* Class: PackAttrRef
  --    Body:  RtBody
  --    @Aref PackAttrRef pwr_sClass_PackAttrRef
  -- 

   type pwr_sClass_PackAttrRef is record
      AttrRef : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11406
      Value : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:11407
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PackAttrRef);  -- pwr_baseclasses.h:11408

   --  skipped anonymous struct anon_630

  --_* Class: PackAttrRef10
  --    Body:  RtBody
  --    @Aref PackAttrRef10 pwr_sClass_PackAttrRef10
  -- 

   type pwr_sClass_PackAttrRef10_AttrRef_array is array (0 .. 9) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_PackAttrRef10_Value_array is array (0 .. 9) of aliased pwr_h.pwr_tFloat64;
   type pwr_sClass_PackAttrRef10 is record
      AttrRef : aliased pwr_sClass_PackAttrRef10_AttrRef_array;  -- pwr_baseclasses.h:11422
      Value : aliased pwr_sClass_PackAttrRef10_Value_array;  -- pwr_baseclasses.h:11423
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PackAttrRef10);  -- pwr_baseclasses.h:11424

   --  skipped anonymous struct anon_631

  --_* Class: PackOperator
  --    Body:  RtBody
  --    @Aref PackOperator pwr_sClass_PackOperator
  -- 

   type pwr_sClass_PackOperator is record
      Msg : aliased pwr_h.pwr_tString132;  -- pwr_baseclasses.h:11438
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PackOperator);  -- pwr_baseclasses.h:11439

   --  skipped anonymous struct anon_632

  --_* Class: PackTest
  --    Body:  RtBody
  --    @Aref PackTest pwr_sClass_PackTest
  -- 

   type pwr_sClass_PackTest is record
      Str40Val : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:11453
      DoubleVal : aliased pwr_h.pwr_tFloat64;  -- pwr_baseclasses.h:11454
      FloatVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11455
      UIntVal : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11456
      IntVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11457
      BooleanVal : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11458
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PackTest);  -- pwr_baseclasses.h:11459

   --  skipped anonymous struct anon_633

  --_* Class: PageRef
  --    Body:  DevBody
  --    @Aref PageRef pwr_sdClass_PageRef
  -- 

   type pwr_sdClass_PageRef is record
      PageAttr : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11473
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11474
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PageRef);  -- pwr_baseclasses.h:11475

   --  skipped anonymous struct anon_634

  --_* Class: Pd_7435_26
  --    Body:  RtBody
  --    @Aref Pd_7435_26 pwr_sClass_Pd_7435_26
  -- 

   type pwr_sClass_Pd_7435_26 is record
      IOSysType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:11489
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11490
      DevName : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:11491
      DevNumber : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:11492
      ErrorCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11493
      ErrorSoftLimit : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11494
      ErrorHardLimit : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11495
      DevPolyType : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:11496
      DevPolyCoef0 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11497
      DevPolyCoef1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11498
      MaxNoOfChannels : aliased pwr_h.pwr_tUInt16;  -- pwr_baseclasses.h:11499
      CardAddress : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11500
      Process : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11501
      ThreadObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11502
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Pd_7435_26);  -- pwr_baseclasses.h:11503

   --  skipped anonymous struct anon_635

  --_* Class: Pd_7435_26
  --    Body:  DevBody
  --    @Aref Pd_7435_26 pwr_sdClass_Pd_7435_26
  -- 

   type pwr_sdClass_Pd_7435_26 is record
      ChannelAllocation : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11511
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Pd_7435_26);  -- pwr_baseclasses.h:11512

   --  skipped anonymous struct anon_636

  --_* Class: PID
  --    Body:  RtBody
  --    @Aref PID pwr_sClass_pid
  -- 

   type pwr_sClass_pid is record
      ProcValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11526
      ProcVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11527
      SetValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11528
      SetVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11529
      BiasP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11530
      Bias : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11531
      ForcValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11532
      ForcVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11533
      ForceP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11534
      Force : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11535
      IntOffP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11536
      IntOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11537
      OutVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11538
      OutChange : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11539
      ControlDiff : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11540
      EndMax : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11541
      EndMin : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11542
      PidAlg : aliased pwr_tPidAlgEnum;  -- pwr_baseclasses.h:11543
      Gain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11544
      IntTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11545
      DerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11546
      DerGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11547
      Inverse : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11548
      BiasGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11549
      MinOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11550
      MaxOut : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11551
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11552
      AccGain : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11553
      AccInt : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11554
      AccDer : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11555
      AccDGain : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11556
      AccBias : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11557
      AccBGain : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11558
      MinGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11559
      MaxGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11560
      MinInt : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11561
      MaxInt : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11562
      MinDer : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11563
      MaxDer : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11564
      MinDGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11565
      MaxDGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11566
      MinBias : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11567
      MaxBias : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11568
      MinBGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11569
      MaxBGain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11570
      SetMaxShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11571
      SetMinShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11572
      OutMaxShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11573
      OutMinShow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11574
      SetEngUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:11575
      OutEngUnit : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:11576
      ModeObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11577
      EndHys : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11578
      FiltDer : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11579
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_pid);  -- pwr_baseclasses.h:11580

   --  skipped anonymous struct anon_637

  --_* Class: PID
  --    Body:  DevBody
  --    @Aref PID pwr_sdClass_PID
  -- 

   type pwr_sdClass_PID is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11588
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PID);  -- pwr_baseclasses.h:11589

   --  skipped anonymous struct anon_638

  --_* Class: PiPos
  --    Body:  RtBody
  --    @Aref PiPos pwr_sClass_pipos
  -- 

   type pwr_sClass_pipos is record
      PulsInP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11603
      PulsIn : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11604
      CalPos1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11605
      CalPos1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11606
      CalOrder1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11607
      CalOrder1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11608
      CalPos2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11609
      CalPos2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11610
      CalOrder2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11611
      CalOrder2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11612
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11613
      Gain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11614
      PICal1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11615
      CalOrder1Old : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11616
      CalOrder2Old : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11617
      PosCal1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11618
      PosCal2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11619
      AccCalPos1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11620
      AccCalOrder1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11621
      AccCalPos2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11622
      AccCalOrder2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11623
      MinCalPos1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11624
      MaxCalPos1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11625
      MinCalPos2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11626
      MaxCalPos2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11627
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_pipos);  -- pwr_baseclasses.h:11628

   --  skipped anonymous struct anon_639

  --_* Class: PiPos
  --    Body:  DevBody
  --    @Aref PiPos pwr_sdClass_PiPos
  -- 

   type pwr_sdClass_PiPos is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11636
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PiPos);  -- pwr_baseclasses.h:11637

   --  skipped anonymous struct anon_640

  --_* Class: PiSpeed
  --    Body:  RtBody
  --    @Aref PiSpeed pwr_sClass_pispeed
  -- 

   type pwr_sClass_pispeed is record
      PulsInP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11651
      PulsIn : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11652
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11653
      Gain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11654
      TimFact : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11655
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11656
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_pispeed);  -- pwr_baseclasses.h:11657

   --  skipped anonymous struct anon_641

  --_* Class: PiSpeed
  --    Body:  DevBody
  --    @Aref PiSpeed pwr_sdClass_PiSpeed
  -- 

   type pwr_sdClass_PiSpeed is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11665
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PiSpeed);  -- pwr_baseclasses.h:11666

   --  skipped anonymous struct anon_642

  --_* Class: PlcPgm
  --    Body:  RtBody
  --    @Aref PlcPgm pwr_sClass_plc
  -- 

   type pwr_sClass_plc is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11680
      ThreadObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11681
      ConfigurationStatus : aliased pwr_class_h.pwr_tConfigStatusEnum;  -- pwr_baseclasses.h:11682
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_plc);  -- pwr_baseclasses.h:11683

   --  skipped anonymous struct anon_643

  --_* Class: PlcPgm
  --    Body:  DevBody
  --    @Aref PlcPgm pwr_sdClass_PlcPgm
  -- 

   type pwr_sdClass_PlcPgm is record
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11691
      ResetObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11692
      ExecuteOrder : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11693
      PlcPgm : aliased pwr_class_h.pwr_sPlcProgram;  -- pwr_baseclasses.h:11694
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PlcPgm);  -- pwr_baseclasses.h:11695

   --  skipped anonymous struct anon_644

  --_* Class: PlcProcess
  --    Body:  RtBody
  --    @Aref PlcProcess pwr_sClass_PlcProcess
  -- 

   type pwr_sClass_PlcProcess_PlcThreadObjects_array is array (0 .. 19) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_PlcProcess is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11709
      Prio : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11710
      StartWithDebug : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11711
      SubscriptionInterval : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11712
      CpuMask : aliased pwr_h.pwr_tMask;  -- pwr_baseclasses.h:11713
      BootVersion : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11714
      CurVersion : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11715
      StartTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:11716
      StopTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:11717
      StallTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:11718
      LastChgTime : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11719
      ChgCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11720
      TimerStart : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11721
      PlcThreadObjects : aliased pwr_sClass_PlcProcess_PlcThreadObjects_array;  -- pwr_baseclasses.h:11722
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PlcProcess);  -- pwr_baseclasses.h:11723

   --  skipped anonymous struct anon_645

  --_* Class: PlcProcess
  --    Body:  DevBody
  --    @Aref PlcProcess pwr_sdClass_PlcProcess
  -- 

   type pwr_sdClass_PlcProcess is record
      BuildCmd : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11731
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PlcProcess);  -- pwr_baseclasses.h:11732

   --  skipped anonymous struct anon_646

  --  Class: PlcTemplate
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: PlcTemplate
  --    Body:  DevBody
  --    @Aref PlcTemplate pwr_sdClass_PlcTemplate
  -- 

   type pwr_sdClass_PlcTemplate is record
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11751
      ResetObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11752
      ExecuteOrder : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11753
      PlcPgm : aliased pwr_class_h.pwr_sPlcProgram;  -- pwr_baseclasses.h:11754
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PlcTemplate);  -- pwr_baseclasses.h:11755

   --  skipped anonymous struct anon_647

  --_* Class: PlcThread
  --    Body:  RtBody
  --    @Aref PlcThread pwr_sClass_PlcThread
  -- 

   type pwr_sClass_PlcThread is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11769
      Prio : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11770
      Options : aliased pwr_tThreadOptionsMask;  -- pwr_baseclasses.h:11771
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11772
      ActualScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11773
      ScanTimeMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11774
      ScanTimeMean : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11775
      ScanTimeMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11776
      ScanTimeMeanCount : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11777
      Count : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11778
      Last : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11779
      Sum : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11780
      Min : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11781
      Mean : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11782
      Coverage : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11783
      Max : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11784
      Count_1_8 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11785
      Count_1_4 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11786
      Count_1_2 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11787
      Count_1_1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11788
      Count_2_1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11789
      Count_4_1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11790
      Count_8_1 : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11791
      CountHigh : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11792
      SlipCount : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11793
      Limit_1_8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11794
      Limit_1_4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11795
      Limit_1_2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11796
      Limit_1_1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11797
      Limit_2_1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11798
      Limit_4_1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11799
      Limit_8_1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11800
      Dlid : aliased pwr_h.pwr_tRefId;  -- pwr_baseclasses.h:11801
      ScanTimeStart : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:11802
      TimerStart : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11803
      IoProcess : aliased pwr_h.pwr_tEnum;  -- pwr_baseclasses.h:11804
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PlcThread);  -- pwr_baseclasses.h:11805

   --  skipped anonymous struct anon_648

  --_* Class: PlotGroup
  --    Body:  RtBody
  --    @Aref PlotGroup pwr_sClass_PlotGroup
  -- 

   type pwr_sClass_PlotGroup_YObjectName_array is array (0 .. 19) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_PlotGroup_YUnit_array is array (0 .. 19, 0 .. 7) of aliased char;
   type pwr_sClass_PlotGroup_YMaxValue_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_PlotGroup_YMinValue_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_PlotGroup_YTickmajor_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_PlotGroup_YTickminor_array is array (0 .. 19) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_PlotGroup is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11819
      Title : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:11820
      Trend : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11821
      YObjectName : aliased pwr_sClass_PlotGroup_YObjectName_array;  -- pwr_baseclasses.h:11822
      YUnit : aliased pwr_sClass_PlotGroup_YUnit_array;  -- pwr_baseclasses.h:11823
      YMaxValue : aliased pwr_sClass_PlotGroup_YMaxValue_array;  -- pwr_baseclasses.h:11824
      YMinValue : aliased pwr_sClass_PlotGroup_YMinValue_array;  -- pwr_baseclasses.h:11825
      YTickmajor : aliased pwr_sClass_PlotGroup_YTickmajor_array;  -- pwr_baseclasses.h:11826
      YTickminor : aliased pwr_sClass_PlotGroup_YTickminor_array;  -- pwr_baseclasses.h:11827
      XMaxValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11828
      XMinValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11829
      XShiftVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11830
      XTickmajor : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11831
      XTickminor : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11832
      NumPoints : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11833
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:11834
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PlotGroup);  -- pwr_baseclasses.h:11835

   --  skipped anonymous struct anon_649

  --_* Class: Po
  --    Body:  RtBody
  --    @Aref Po pwr_sClass_Po
  -- 

   type pwr_sClass_Po is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11849
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11850
      ValueIndex : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11851
      ActualValue : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11852
      SigValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11853
      DefGraph : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11854
      DefTrend : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11855
      HelpTopic : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:11856
      DataSheet : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:11857
      CircuitDiagram : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:11858
      Photo : aliased pwr_h.pwr_tURL;  -- pwr_baseclasses.h:11859
      Note : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:11860
      PulseLength : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11861
      PosFlank : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11862
      PosPulse : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11863
      ResetActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11864
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Po);  -- pwr_baseclasses.h:11865

   --  skipped anonymous struct anon_650

  --_* Class: Point
  --    Body:  DevBody
  --    @Aref Point pwr_sdClass_Point
  -- 

   type pwr_sdClass_Point is record
      In1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11879
      In1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11880
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11881
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Point);  -- pwr_baseclasses.h:11882

   --  skipped anonymous struct anon_651

  --_* Class: POrder
  --    Body:  RtBody
  --    @Aref POrder pwr_sClass_porder
  -- 

   type pwr_sClass_porder_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_porder is record
      Status : aliased pwr_sClass_porder_Status_array;  -- pwr_baseclasses.h:11896
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11897
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_porder);  -- pwr_baseclasses.h:11898

   --  skipped anonymous struct anon_652

  --_* Class: Pos3P
  --    Body:  RtBody
  --    @Aref Pos3P pwr_sClass_pos3p
  -- 

   type pwr_sClass_pos3p is record
      OutValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11912
      OutVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11913
      PosP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11914
      Pos : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11915
      Open : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11916
      Close : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11917
      Gain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11918
      ErrSta : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11919
      ErrSto : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11920
      OpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11921
      CloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11922
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11923
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11924
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11925
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11926
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11927
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11928
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11929
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_pos3p);  -- pwr_baseclasses.h:11930

   --  skipped anonymous struct anon_653

  --_* Class: Pos3P
  --    Body:  DevBody
  --    @Aref Pos3P pwr_sdClass_Pos3P
  -- 

   type pwr_sdClass_Pos3P is record
      DoOpen : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11938
      DoClose : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:11939
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11940
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Pos3P);  -- pwr_baseclasses.h:11941

   --  skipped anonymous struct anon_654

  --_* Class: Posit
  --    Body:  RtBody
  --    @Aref Posit pwr_sClass_posit
  -- 

   type pwr_sClass_posit is record
      PosValP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11955
      PosVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11956
      SetPosP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11957
      SetPos : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11958
      AutoPosP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11959
      AutoPos : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11960
      ResetP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11961
      Reset : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11962
      ManMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11963
      PosOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11964
      Order1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11965
      Order2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11966
      InPlace : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11967
      PosError : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11968
      DeadZone1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11969
      DeadZone2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11970
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11971
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11972
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:11973
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11974
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11975
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:11976
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:11977
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11978
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11979
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11980
      ManAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11981
      ShowMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11982
      ShowMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11983
      SetAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:11984
      SetMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11985
      SetMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:11986
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_posit);  -- pwr_baseclasses.h:11987

   --  skipped anonymous struct anon_655

  --_* Class: Posit
  --    Body:  DevBody
  --    @Aref Posit pwr_sdClass_Posit
  -- 

   type pwr_sdClass_Posit is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:11995
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Posit);  -- pwr_baseclasses.h:11996

   --  skipped anonymous struct anon_656

  --_* Class: PostConfig
  --    Body:  RtBody
  --    @Aref PostConfig pwr_sClass_PostConfig
  -- 

   type pwr_sClass_PostConfig_EventSelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_PostConfig_Symbols_array is array (0 .. 19) of aliased pwr_sClass_SymbolDefinition;
   type pwr_sClass_PostConfig is record
      EmailCmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12010
      SMS_Cmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12011
      EventSelectList : aliased pwr_sClass_PostConfig_EventSelectList_array;  -- pwr_baseclasses.h:12012
      Symbols : aliased pwr_sClass_PostConfig_Symbols_array;  -- pwr_baseclasses.h:12013
      Language : aliased pwr_tLanguageEnum;  -- pwr_baseclasses.h:12014
      Options : aliased pwr_tPostOptionsMask;  -- pwr_baseclasses.h:12015
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12016
      SentSMS : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12017
      SentEmail : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12018
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12019
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PostConfig);  -- pwr_baseclasses.h:12020

   --  skipped anonymous struct anon_657

  --_* Class: ProjectReg
  --    Body:  RtBody
  --    @Aref ProjectReg pwr_sClass_ProjectReg
  -- 

   type pwr_sClass_ProjectReg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12034
      Project : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:12035
      Version : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:12036
      Path : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12037
      CopyFrom : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12038
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ProjectReg);  -- pwr_baseclasses.h:12039

   --  skipped anonymous struct anon_658

  --_* Class: Pulse
  --    Body:  RtBody
  --    @Aref Pulse pwr_sClass_pulse
  -- 

   type pwr_sClass_pulse is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12053
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12054
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12055
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12056
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12057
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12058
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12059
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12060
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12061
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12062
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12063
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12064
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12065
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12066
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_pulse);  -- pwr_baseclasses.h:12067

   --  skipped anonymous struct anon_659

  --_* Class: Pulse
  --    Body:  DevBody
  --    @Aref Pulse pwr_sdClass_Pulse
  -- 

   type pwr_sdClass_Pulse is record
      ShowTimerTime : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12075
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12076
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Pulse);  -- pwr_baseclasses.h:12077

   --  skipped anonymous struct anon_660

  --_* Class: PulseTrain
  --    Body:  RtBody
  --    @Aref PulseTrain pwr_sClass_PulseTrain
  -- 

   type pwr_sClass_PulseTrain is record
      P30s : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12091
      P10s : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12092
      P5s : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12093
      P2s : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12094
      P1s : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12095
      P500ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12096
      P200ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12097
      P100ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12098
      P50ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12099
      P20ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12100
      P10ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12101
      P5ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12102
      P2ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12103
      P1ms : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12104
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_PulseTrain);  -- pwr_baseclasses.h:12105

   --  skipped anonymous struct anon_661

  --_* Class: PulseTrain
  --    Body:  DevBody
  --    @Aref PulseTrain pwr_sdClass_PulseTrain
  -- 

   type pwr_sdClass_PulseTrain is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12113
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_PulseTrain);  -- pwr_baseclasses.h:12114

   --  skipped anonymous struct anon_662

  --_* Class: Queue
  --    Body:  RtBody
  --    @Aref Queue pwr_sClass_Queue
  -- 

   type pwr_sClass_Queue is record
      Address : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12128
      Global : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12129
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Queue);  -- pwr_baseclasses.h:12130

   --  skipped anonymous struct anon_663

  --_* Class: Ramp
  --    Body:  RtBody
  --    @Aref Ramp pwr_sClass_ramp
  -- 

   type pwr_sClass_ramp is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12144
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12145
      FeedBP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12146
      FeedB : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12147
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12148
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12149
      RampUp : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12150
      RampDown : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12151
      RampUpAbs : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12152
      AccUp : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12153
      AccDown : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12154
      MinUp : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12155
      MaxUp : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12156
      MinDown : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12157
      MaxDown : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12158
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ramp);  -- pwr_baseclasses.h:12159

   --  skipped anonymous struct anon_664

  --_* Class: Ramp
  --    Body:  DevBody
  --    @Aref Ramp pwr_sdClass_Ramp
  -- 

   type pwr_sdClass_Ramp is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12167
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Ramp);  -- pwr_baseclasses.h:12168

   --  skipped anonymous struct anon_665

  --_* Class: Report
  --    Body:  RtBody
  --    @Aref Report pwr_sClass_Report
  -- 

   type pwr_sClass_Report is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12182
      Subject : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12183
      TemplateFile : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12184
      TargetFile : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12185
      Media : aliased pwr_tReportMediaMask;  -- pwr_baseclasses.h:12186
      DocumentFormat : aliased pwr_tDocumentFormatEnum;  -- pwr_baseclasses.h:12187
      Recipient : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:12188
      Periodicity : aliased pwr_tPeriodicEnum;  -- pwr_baseclasses.h:12189
      TimeOffset : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:12190
      Trigger : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12191
      EmailCmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12192
      SMS_Cmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12193
      PrintCmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12194
      Sent : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12195
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Report);  -- pwr_baseclasses.h:12196

   --  skipped anonymous struct anon_666

  --_* Class: ReportConfig
  --    Body:  RtBody
  --    @Aref ReportConfig pwr_sClass_ReportConfig
  -- 

   type pwr_sClass_ReportConfig_Symbols_array is array (0 .. 19) of aliased pwr_sClass_SymbolDefinition;
   type pwr_sClass_ReportConfig is record
      EmailCmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12210
      SMS_Cmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12211
      PrintCmd : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12212
      Symbols : aliased pwr_sClass_ReportConfig_Symbols_array;  -- pwr_baseclasses.h:12213
      Language : aliased pwr_tLanguageEnum;  -- pwr_baseclasses.h:12214
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12215
      SentSMS : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12216
      SentEmail : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12217
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12218
      Options : aliased pwr_tPostOptionsMask;  -- pwr_baseclasses.h:12219
      Display : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12220
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ReportConfig);  -- pwr_baseclasses.h:12221

   --  skipped anonymous struct anon_667

  --  Class: ResDattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: ResDattr
  --    Body:  DevBody
  --    @Aref ResDattr pwr_sdClass_ResDattr
  -- 

   type pwr_sdClass_ResDattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:12240
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12241
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ResDattr);  -- pwr_baseclasses.h:12242

   --  skipped anonymous struct anon_668

  --_* Class: ResDi
  --    Body:  RtBody
  --    @Aref ResDi pwr_sClass_resdi
  -- 

   type pwr_sClass_resdi is record
      ActualValueP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12256
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12257
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_resdi);  -- pwr_baseclasses.h:12258

   --  skipped anonymous struct anon_669

  --_* Class: ResDi
  --    Body:  DevBody
  --    @Aref ResDi pwr_sdClass_ResDi
  -- 

   type pwr_sdClass_ResDi is record
      DiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12266
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12267
      DiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12268
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12269
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12270
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12271
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ResDi);  -- pwr_baseclasses.h:12272

   --  skipped anonymous struct anon_670

  --  Class: ResDo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: ResDo
  --    Body:  DevBody
  --    @Aref ResDo pwr_sdClass_ResDo
  -- 

   type pwr_sdClass_ResDo is record
      DoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12291
      DoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12292
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12293
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12294
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12295
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12296
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ResDo);  -- pwr_baseclasses.h:12297

   --  skipped anonymous struct anon_671

  --  Class: ResDp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: ResDp
  --    Body:  DevBody
  --    @Aref ResDp pwr_sdClass_ResDp
  -- 

   type pwr_sdClass_ResDp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12316
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12317
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12318
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ResDp);  -- pwr_baseclasses.h:12319

   --  skipped anonymous struct anon_672

  --  Class: ResDv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: ResDv
  --    Body:  DevBody
  --    @Aref ResDv pwr_sdClass_ResDv
  -- 

   type pwr_sdClass_ResDv is record
      DvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12338
      DvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12339
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12340
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ResDv);  -- pwr_baseclasses.h:12341

   --  skipped anonymous struct anon_673

  --_* Class: Reset_SO
  --    Body:  RtBody
  --    @Aref Reset_SO pwr_sClass_reset_so
  -- 

   type pwr_sClass_reset_so is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12355
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12356
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_reset_so);  -- pwr_baseclasses.h:12357

   --  skipped anonymous struct anon_674

  --_* Class: Reset_SO
  --    Body:  DevBody
  --    @Aref Reset_SO pwr_sdClass_Reset_SO
  -- 

   type pwr_sdClass_Reset_SO is record
      OrderObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12365
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12366
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Reset_SO);  -- pwr_baseclasses.h:12367

   --  skipped anonymous struct anon_675

  --_* Class: RootVolumeConfig
  --    Body:  RtBody
  --    @Aref RootVolumeConfig pwr_sClass_RootVolumeConfig
  -- 

   type pwr_sClass_RootVolumeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12381
      Database : aliased pwr_tVolumeDatabaseEnum;  -- pwr_baseclasses.h:12382
      Server : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:12383
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_RootVolumeConfig);  -- pwr_baseclasses.h:12384

   --  skipped anonymous struct anon_676

  --_* Class: RootVolumeLoad
  --    Body:  RtBody
  --    @Aref RootVolumeLoad pwr_sClass_RootVolumeLoad
  -- 

   type pwr_sClass_RootVolumeLoad is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12398
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_RootVolumeLoad);  -- pwr_baseclasses.h:12399

   --  skipped anonymous struct anon_677

  --_* Class: RttConfig
  --    Body:  RtBody
  --    @Aref RttConfig pwr_sClass_RttConfig
  -- 

   type pwr_sClass_RttConfig_EventSelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_RttConfig is record
      AlarmAutoLoad : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12413
      AlarmMessage : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12414
      AlarmBeep : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12415
      DescriptionOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12416
      DefaultDirectory : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12417
      SymbolFileName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12418
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12419
      MaxNoOfAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12420
      MaxNoOfEvents : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12421
      EventSelectList : aliased pwr_sClass_RttConfig_EventSelectList_array;  -- pwr_baseclasses.h:12422
      EventListEvents : aliased pwr_tEventListMask;  -- pwr_baseclasses.h:12423
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_RttConfig);  -- pwr_baseclasses.h:12424

   --  skipped anonymous struct anon_678

  --_* Class: SArray100
  --    Body:  RtBody
  --    @Aref SArray100 pwr_sClass_SArray100
  -- 

   type pwr_sClass_SArray100_Value_array is array (0 .. 99, 0 .. 79) of aliased char;
   type pwr_sClass_SArray100 is record
      Value : aliased pwr_sClass_SArray100_Value_array;  -- pwr_baseclasses.h:12438
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SArray100);  -- pwr_baseclasses.h:12439

   --  skipped anonymous struct anon_679

  --_* Class: SArray500
  --    Body:  RtBody
  --    @Aref SArray500 pwr_sClass_SArray500
  -- 

   type pwr_sClass_SArray500_Value_array is array (0 .. 499, 0 .. 79) of aliased char;
   type pwr_sClass_SArray500 is record
      Value : aliased pwr_sClass_SArray500_Value_array;  -- pwr_baseclasses.h:12453
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SArray500);  -- pwr_baseclasses.h:12454

   --  skipped anonymous struct anon_680

  --_* Class: ScanTime
  --    Body:  RtBody
  --    @Aref ScanTime pwr_sClass_ScanTime
  -- 

   type pwr_sClass_ScanTime is record
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12468
      Time : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12469
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ScanTime);  -- pwr_baseclasses.h:12470

   --  skipped anonymous struct anon_681

  --_* Class: ScanTime
  --    Body:  DevBody
  --    @Aref ScanTime pwr_sdClass_ScanTime
  -- 

   type pwr_sdClass_ScanTime is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12478
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ScanTime);  -- pwr_baseclasses.h:12479

   --  skipped anonymous struct anon_682

  --_* Class: Select
  --    Body:  RtBody
  --    @Aref Select pwr_sClass_select
  -- 

   type pwr_sClass_select is record
      HighP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12493
      High : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12494
      LowP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12495
      Low : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12496
      ControlP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12497
      Control : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12498
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12499
      NotActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12500
      AccHigh : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12501
      AccLow : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12502
      AccCon : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12503
      MinHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12504
      MaxHigh : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12505
      MinLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12506
      MaxLow : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12507
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_select);  -- pwr_baseclasses.h:12508

   --  skipped anonymous struct anon_683

  --_* Class: Select
  --    Body:  DevBody
  --    @Aref Select pwr_sdClass_Select
  -- 

   type pwr_sdClass_Select is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12516
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Select);  -- pwr_baseclasses.h:12517

   --  skipped anonymous struct anon_684

  --_* Class: SetCond
  --    Body:  RtBody
  --    @Aref SetCond pwr_sClass_setcond
  -- 

   type pwr_sClass_setcond is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12531
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12532
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_setcond);  -- pwr_baseclasses.h:12533

   --  skipped anonymous struct anon_685

  --_* Class: SetCond
  --    Body:  DevBody
  --    @Aref SetCond pwr_sdClass_SetCond
  -- 

   type pwr_sdClass_SetCond is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12541
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetCond);  -- pwr_baseclasses.h:12542

   --  skipped anonymous struct anon_686

  --  Class: SetDattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: SetDattr
  --    Body:  DevBody
  --    @Aref SetDattr pwr_sdClass_SetDattr
  -- 

   type pwr_sdClass_SetDattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:12561
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12562
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetDattr);  -- pwr_baseclasses.h:12563

   --  skipped anonymous struct anon_687

  --_* Class: SetDi
  --    Body:  RtBody
  --    @Aref SetDi pwr_sClass_setdi
  -- 

   type pwr_sClass_setdi is record
      ActualValueP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12577
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12578
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_setdi);  -- pwr_baseclasses.h:12579

   --  skipped anonymous struct anon_688

  --_* Class: SetDi
  --    Body:  DevBody
  --    @Aref SetDi pwr_sdClass_SetDi
  -- 

   type pwr_sdClass_SetDi is record
      DiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12587
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12588
      DiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12589
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12590
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12591
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12592
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetDi);  -- pwr_baseclasses.h:12593

   --  skipped anonymous struct anon_689

  --  Class: SetDo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: SetDo
  --    Body:  DevBody
  --    @Aref SetDo pwr_sdClass_SetDo
  -- 

   type pwr_sdClass_SetDo is record
      DoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12612
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12613
      DoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12614
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12615
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12616
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12617
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetDo);  -- pwr_baseclasses.h:12618

   --  skipped anonymous struct anon_690

  --  Class: SetDp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: SetDp
  --    Body:  DevBody
  --    @Aref SetDp pwr_sdClass_SetDp
  -- 

   type pwr_sdClass_SetDp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12637
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12638
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12639
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetDp);  -- pwr_baseclasses.h:12640

   --  skipped anonymous struct anon_691

  --  Class: SetDv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: SetDv
  --    Body:  DevBody
  --    @Aref SetDv pwr_sdClass_SetDv
  -- 

   type pwr_sdClass_SetDv is record
      DvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12659
      DvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12660
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12661
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SetDv);  -- pwr_baseclasses.h:12662

   --  skipped anonymous struct anon_692

  --_* Class: SevHist
  --    Body:  RtBody
  --    @Aref SevHist pwr_sClass_SevHist
  -- 

   type pwr_sClass_SevHist is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12676
      Attribute : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12677
      ThreadObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12678
      StorageTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:12679
      DeadBand : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12680
      Options : aliased pwr_tSevHistOptionsMask;  -- pwr_baseclasses.h:12681
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12682
      Trigger : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12683
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:12684
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevHist);  -- pwr_baseclasses.h:12685

   --  skipped anonymous struct anon_693

  --_* Class: SevHistEvents
  --    Body:  RtBody
  --    @Aref SevHistEvents pwr_sClass_SevHistEvents
  -- 

   type pwr_sClass_SevHistEvents_EventSelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_SevHistEvents is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12699
      EventSelectList : aliased pwr_sClass_SevHistEvents_EventSelectList_array;  -- pwr_baseclasses.h:12700
      EventTypes : aliased pwr_tEventListMask;  -- pwr_baseclasses.h:12701
      ThreadObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12702
      StorageTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:12703
      Options : aliased pwr_tSevHistOptionsMask;  -- pwr_baseclasses.h:12704
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12705
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevHistEvents);  -- pwr_baseclasses.h:12706

   --  skipped anonymous struct anon_694

  --_* Class: SevHistMonitor
  --    Body:  RtBody
  --    @Aref SevHistMonitor pwr_sClass_SevHistMonitor
  -- 

   type pwr_sClass_SevHistMonitor_ThreadObjects_array is array (0 .. 19) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_SevHistMonitor is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12720
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12721
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12722
      ThreadObjects : aliased pwr_sClass_SevHistMonitor_ThreadObjects_array;  -- pwr_baseclasses.h:12723
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevHistMonitor);  -- pwr_baseclasses.h:12724

   --  skipped anonymous struct anon_695

  --_* Class: SevHistObject
  --    Body:  RtBody
  --    @Aref SevHistObject pwr_sClass_SevHistObject
  -- 

   type pwr_sClass_SevHistObject is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12738
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:12739
      ThreadObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12740
      StorageTime : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:12741
      DeadBand : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12742
      Options : aliased pwr_tSevHistOptionsMask;  -- pwr_baseclasses.h:12743
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12744
      Trigger : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12745
      Layout : aliased pwr_tCurveLayoutMask;  -- pwr_baseclasses.h:12746
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevHistObject);  -- pwr_baseclasses.h:12747

   --  skipped anonymous struct anon_696

  --_* Class: SevHistThread
  --    Body:  RtBody
  --    @Aref SevHistThread pwr_sClass_SevHistThread
  -- 

   type pwr_sClass_SevHistThread is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12761
      ServerNode : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:12762
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12763
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12764
      NoOfItems : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12765
      ScanCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12766
      SendCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12767
      ErrorCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12768
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevHistThread);  -- pwr_baseclasses.h:12769

   --  skipped anonymous struct anon_697

  --_* Class: SevNodeConfig
  --    Body:  RtBody
  --    @Aref SevNodeConfig pwr_sClass_SevNodeConfig
  -- 

   type pwr_sClass_SevNodeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12783
      NodeName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12784
      OperatingSystem : aliased pwr_h.pwr_tOpSysEnum;  -- pwr_baseclasses.h:12785
      BootNode : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12786
      Address : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:12787
      Port : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12788
      Volume : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12789
      DistributeDisable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12790
      RemoteAccessType : aliased pwr_tRemoteShellEnum;  -- pwr_baseclasses.h:12791
      QComMinResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12792
      QComMaxResendTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12793
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevNodeConfig);  -- pwr_baseclasses.h:12794

   --  skipped anonymous struct anon_698

  --_* Class: SevServer
  --    Body:  RtBody
  --    @Aref SevServer pwr_sClass_SevServer
  -- 

   type pwr_sClass_SevServer is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12808
      Database : aliased pwr_tSevDatabaseEnum;  -- pwr_baseclasses.h:12809
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SevServer);  -- pwr_baseclasses.h:12810

   --  skipped anonymous struct anon_699

  --_* Class: SharedVolumeConfig
  --    Body:  RtBody
  --    @Aref SharedVolumeConfig pwr_sClass_SharedVolumeConfig
  -- 

   type pwr_sClass_SharedVolumeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12824
      Database : aliased pwr_tVolumeDatabaseEnum;  -- pwr_baseclasses.h:12825
      Server : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:12826
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SharedVolumeConfig);  -- pwr_baseclasses.h:12827

   --  skipped anonymous struct anon_700

  --_* Class: SharedVolumeLoad
  --    Body:  RtBody
  --    @Aref SharedVolumeLoad pwr_sClass_SharedVolumeLoad
  -- 

   type pwr_sClass_SharedVolumeLoad is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12841
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SharedVolumeLoad);  -- pwr_baseclasses.h:12842

   --  skipped anonymous struct anon_701

  --_* Class: ShowPlcAttr
  --    Body:  DevBody
  --    @Aref ShowPlcAttr pwr_sdClass_ShowPlcAttr
  -- 

   type pwr_sdClass_ShowPlcAttr is record
      Node : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12856
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12857
      ResetObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:12858
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12859
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ShowPlcAttr);  -- pwr_baseclasses.h:12860

   --  skipped anonymous struct anon_702

  --_* Class: SimulateConfig
  --    Body:  RtBody
  --    @Aref SimulateConfig pwr_sClass_SimulateConfig
  -- 

   type pwr_sClass_SimulateConfig_PlcThreads_array is array (0 .. 29) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_SimulateConfig_ThreadSelected_array is array (0 .. 29) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_SimulateConfig_ThreadStatus_array is array (0 .. 29) of aliased pwr_h.pwr_tStatus;
   type pwr_sClass_SimulateConfig_PlcPgm_array is array (0 .. 199) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_SimulateConfig_PlcPgmSelected_array is array (0 .. 199) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_SimulateConfig_PlcPgmThreadStatus_array is array (0 .. 199) of aliased pwr_h.pwr_tStatus;
   type pwr_sClass_SimulateConfig_PlcPgmStatus_array is array (0 .. 199) of aliased pwr_h.pwr_tStatus;
   type pwr_sClass_SimulateConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12874
      Disable : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12875
      InitDone : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12876
      Status : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12877
      Message : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12878
      PlcHalt : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12879
      PlcHaltOrder : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12880
      PlcHaltStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12881
      PlcContinue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12882
      PlcContinueOrder : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12883
      PlcContinueStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12884
      PlcStep : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12885
      PlcStepOrder : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12886
      PlcStepStatus : aliased pwr_h.pwr_tStatus;  -- pwr_baseclasses.h:12887
      PlcLoadOrder : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12888
      LoadFile : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:12889
      Load : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12890
      Store : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12891
      PlcThreads : aliased pwr_sClass_SimulateConfig_PlcThreads_array;  -- pwr_baseclasses.h:12892
      ThreadSelected : aliased pwr_sClass_SimulateConfig_ThreadSelected_array;  -- pwr_baseclasses.h:12893
      ThreadStatus : aliased pwr_sClass_SimulateConfig_ThreadStatus_array;  -- pwr_baseclasses.h:12894
      SelectAllThreads : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12895
      ClearAllThreads : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12896
      PlcPgm : aliased pwr_sClass_SimulateConfig_PlcPgm_array;  -- pwr_baseclasses.h:12897
      PlcPgmSelected : aliased pwr_sClass_SimulateConfig_PlcPgmSelected_array;  -- pwr_baseclasses.h:12898
      PlcPgmThreadStatus : aliased pwr_sClass_SimulateConfig_PlcPgmThreadStatus_array;  -- pwr_baseclasses.h:12899
      PlcPgmStatus : aliased pwr_sClass_SimulateConfig_PlcPgmStatus_array;  -- pwr_baseclasses.h:12900
      SelectAllPlcPgm : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12901
      ClearAllPlcPgm : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12902
      PlcPgmScanOn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12903
      PlcPgmScanOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12904
      Reset : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12905
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SimulateConfig);  -- pwr_baseclasses.h:12906

   --  skipped anonymous struct anon_703

  --_* Class: Sin
  --    Body:  RtBody
  --    @Aref Sin pwr_sClass_Sin
  -- 

   type pwr_sClass_Sin is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12920
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12921
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12922
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12923
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12924
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Sin);  -- pwr_baseclasses.h:12925

   --  skipped anonymous struct anon_704

  --_* Class: Sin
  --    Body:  DevBody
  --    @Aref Sin pwr_sdClass_Sin
  -- 

   type pwr_sdClass_Sin is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:12933
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Sin);  -- pwr_baseclasses.h:12934

   --  skipped anonymous struct anon_705

  --_* Class: SOrder
  --    Body:  RtBody
  --    @Aref SOrder pwr_sClass_sorder
  -- 

   type pwr_sClass_sorder_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_sorder is record
      Status : aliased pwr_sClass_sorder_Status_array;  -- pwr_baseclasses.h:12948
      Reset : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12949
      Old : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12950
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_sorder);  -- pwr_baseclasses.h:12951

   --  skipped anonymous struct anon_706

  --_* Class: Sound
  --    Body:  RtBody
  --    @Aref Sound pwr_sClass_Sound
  -- 

   type pwr_sClass_Sound_ToneTable_array is array (0 .. 7) of aliased pwr_h.pwr_tUInt32;
   type pwr_sClass_Sound_VolumeTable_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_Sound is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12965
      Source : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:12966
      Prio : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:12967
      BaseTone : aliased pwr_tAudioToneEnum;  -- pwr_baseclasses.h:12968
      ToneTable : aliased pwr_sClass_Sound_ToneTable_array;  -- pwr_baseclasses.h:12969
      VolumeTable : aliased pwr_sClass_Sound_VolumeTable_array;  -- pwr_baseclasses.h:12970
      Volume : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12971
      Attack : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12972
      Decay : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12973
      Sustain : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12974
      Release : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12975
      Length : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12976
      Tremolo : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12977
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Sound);  -- pwr_baseclasses.h:12978

   --  skipped anonymous struct anon_707

  --_* Class: SoundSeqElem
  --    Body:  RtBody
  --    @Aref SoundSeqElem pwr_sClass_SoundSeqElem
  -- 

   type pwr_sClass_SoundSeqElem is record
      Used : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:12992
      SoundIdx : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:12993
      StartTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12994
      EndTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12995
      VolumeRight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12996
      VolumeLeft : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:12997
      Tone : aliased pwr_tAudioToneEnum;  -- pwr_baseclasses.h:12998
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SoundSeqElem);  -- pwr_baseclasses.h:12999

   --  skipped anonymous struct anon_708

  --_* Class: SoundSequence
  --    Body:  RtBody
  --    @Aref SoundSequence pwr_sClass_SoundSequence
  -- 

   type pwr_sClass_SoundSequence_SoundObject_array is array (0 .. 2) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_SoundSequence_SequenceTable_array is array (0 .. 19) of aliased pwr_sClass_SoundSeqElem;
   type pwr_sClass_SoundSequence is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:13013
      SoundObject : aliased pwr_sClass_SoundSequence_SoundObject_array;  -- pwr_baseclasses.h:13014
      Prio : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13015
      Length : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13016
      Echo : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13017
      SequenceTable : aliased pwr_sClass_SoundSequence_SequenceTable_array;  -- pwr_baseclasses.h:13018
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SoundSequence);  -- pwr_baseclasses.h:13019

   --  skipped anonymous struct anon_709

  --_* Class: Speed
  --    Body:  RtBody
  --    @Aref Speed pwr_sClass_speed
  -- 

   type pwr_sClass_speed is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13033
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13034
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13035
      TimFact : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13036
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13037
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_speed);  -- pwr_baseclasses.h:13038

   --  skipped anonymous struct anon_710

  --_* Class: Speed
  --    Body:  DevBody
  --    @Aref Speed pwr_sdClass_Speed
  -- 

   type pwr_sdClass_Speed is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13046
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Speed);  -- pwr_baseclasses.h:13047

   --  skipped anonymous struct anon_711

  --_* Class: Sqrt
  --    Body:  RtBody
  --    @Aref Sqrt pwr_sClass_Sqrt
  -- 

   type pwr_sClass_Sqrt is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13061
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13062
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13063
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13064
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13065
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Sqrt);  -- pwr_baseclasses.h:13066

   --  skipped anonymous struct anon_712

  --_* Class: Sqrt
  --    Body:  DevBody
  --    @Aref Sqrt pwr_sdClass_Sqrt
  -- 

   type pwr_sdClass_Sqrt is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13074
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Sqrt);  -- pwr_baseclasses.h:13075

   --  skipped anonymous struct anon_713

  --_* Class: SR_R
  --    Body:  RtBody
  --    @Aref SR_R pwr_sClass_sr_r
  -- 

   type pwr_sClass_sr_r is record
      setP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13089
      set : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13090
      resetP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13091
      reset : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13092
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13093
      Acc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13094
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_sr_r);  -- pwr_baseclasses.h:13095

   --  skipped anonymous struct anon_714

  --_* Class: SR_R
  --    Body:  DevBody
  --    @Aref SR_R pwr_sdClass_SR_R
  -- 

   type pwr_sdClass_SR_R is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13103
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SR_R);  -- pwr_baseclasses.h:13104

   --  skipped anonymous struct anon_715

  --_* Class: SR_S
  --    Body:  RtBody
  --    @Aref SR_S pwr_sClass_sr_s
  -- 

   type pwr_sClass_sr_s is record
      setP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13118
      set : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13119
      resetP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13120
      reset : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13121
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13122
      Acc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13123
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_sr_s);  -- pwr_baseclasses.h:13124

   --  skipped anonymous struct anon_716

  --_* Class: SR_S
  --    Body:  DevBody
  --    @Aref SR_S pwr_sdClass_SR_S
  -- 

   type pwr_sdClass_SR_S is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13132
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SR_S);  -- pwr_baseclasses.h:13133

   --  skipped anonymous struct anon_717

  --_* Class: SsBegin
  --    Body:  RtBody
  --    @Aref SsBegin pwr_sClass_ssbegin
  -- 

   type pwr_sClass_ssbegin_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_ssbegin is record
      StatusIn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13147
      Status : aliased pwr_sClass_ssbegin_Status_array;  -- pwr_baseclasses.h:13148
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13149
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ssbegin);  -- pwr_baseclasses.h:13150

   --  skipped anonymous struct anon_718

  --_* Class: SsBegin
  --    Body:  DevBody
  --    @Aref SsBegin pwr_sdClass_SsBegin
  -- 

   type pwr_sdClass_SsBegin is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13158
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SsBegin);  -- pwr_baseclasses.h:13159

   --  skipped anonymous struct anon_719

  --_* Class: SsEnd
  --    Body:  RtBody
  --    @Aref SsEnd pwr_sClass_ssend
  -- 

   type pwr_sClass_ssend_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_ssend is record
      StatusIn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13173
      Status : aliased pwr_sClass_ssend_Status_array;  -- pwr_baseclasses.h:13174
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_ssend);  -- pwr_baseclasses.h:13175

   --  skipped anonymous struct anon_720

  --_* Class: SsEnd
  --    Body:  DevBody
  --    @Aref SsEnd pwr_sdClass_SsEnd
  -- 

   type pwr_sdClass_SsEnd is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13183
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SsEnd);  -- pwr_baseclasses.h:13184

   --  skipped anonymous struct anon_721

  --_* Class: StatusServerConfig
  --    Body:  RtBody
  --    @Aref StatusServerConfig pwr_sClass_StatusServerConfig
  -- 

   type pwr_sClass_StatusServerConfig_UserStatus_array is array (0 .. 4) of aliased pwr_h.pwr_tStatus;
   type pwr_sClass_StatusServerConfig_UserStatusStr_array is array (0 .. 4, 0 .. 79) of aliased char;
   type pwr_sClass_StatusServerConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:13198
      UserStatus : aliased pwr_sClass_StatusServerConfig_UserStatus_array;  -- pwr_baseclasses.h:13199
      UserStatusStr : aliased pwr_sClass_StatusServerConfig_UserStatusStr_array;  -- pwr_baseclasses.h:13200
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StatusServerConfig);  -- pwr_baseclasses.h:13201

   --  skipped anonymous struct anon_722

  --_* Class: Step
  --    Body:  RtBody
  --    @Aref Step pwr_sClass_step
  -- 

   type pwr_sClass_step_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_step is record
      StatusIn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13215
      StatusOut : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13216
      Status : aliased pwr_sClass_step_Status_array;  -- pwr_baseclasses.h:13217
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_step);  -- pwr_baseclasses.h:13218

   --  skipped anonymous struct anon_723

  --_* Class: Step
  --    Body:  DevBody
  --    @Aref Step pwr_sdClass_Step
  -- 

   type pwr_sdClass_Step is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13226
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Step);  -- pwr_baseclasses.h:13227

   --  skipped anonymous struct anon_724

  --_* Class: StepConv
  --    Body:  DevBody
  --    @Aref StepConv pwr_sdClass_StepConv
  -- 

   type pwr_sdClass_StepConv is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:13241
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StepConv);  -- pwr_baseclasses.h:13242

   --  skipped anonymous struct anon_725

  --_* Class: StepDiv
  --    Body:  DevBody
  --    @Aref StepDiv pwr_sdClass_StepDiv
  -- 

   type pwr_sdClass_StepDiv is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:13256
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StepDiv);  -- pwr_baseclasses.h:13257

   --  skipped anonymous struct anon_726

  --  Class: StoAattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoAattr
  --    Body:  DevBody
  --    @Aref StoAattr pwr_sdClass_StoAattr
  -- 

   type pwr_sdClass_StoAattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:13276
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13277
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAattr);  -- pwr_baseclasses.h:13278

   --  skipped anonymous struct anon_727

  --_* Class: StoAgeneric
  --    Body:  DevBody
  --    @Aref StoAgeneric pwr_sdClass_StoAgeneric
  -- 

   type pwr_sdClass_StoAgeneric is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13292
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13293
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13294
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAgeneric);  -- pwr_baseclasses.h:13295

   --  skipped anonymous struct anon_728

  --_* Class: StoAi
  --    Body:  RtBody
  --    @Aref StoAi pwr_sClass_stoai
  -- 

   type pwr_sClass_stoai is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13309
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13310
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_stoai);  -- pwr_baseclasses.h:13311

   --  skipped anonymous struct anon_729

  --_* Class: StoAi
  --    Body:  DevBody
  --    @Aref StoAi pwr_sdClass_StoAi
  -- 

   type pwr_sdClass_StoAi is record
      AiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13319
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13320
      AiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13321
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13322
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13323
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13324
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAi);  -- pwr_baseclasses.h:13325

   --  skipped anonymous struct anon_730

  --  Class: StoAo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoAo
  --    Body:  DevBody
  --    @Aref StoAo pwr_sdClass_StoAo
  -- 

   type pwr_sdClass_StoAo is record
      AoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13344
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13345
      AoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13346
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13347
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13348
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13349
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAo);  -- pwr_baseclasses.h:13350

   --  skipped anonymous struct anon_731

  --  Class: StoAp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoAp
  --    Body:  DevBody
  --    @Aref StoAp pwr_sdClass_StoAp
  -- 

   type pwr_sdClass_StoAp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13369
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13370
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13371
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAp);  -- pwr_baseclasses.h:13372

   --  skipped anonymous struct anon_732

  --_* Class: StoApPtr
  --    Body:  RtBody
  --    @Aref StoApPtr pwr_sClass_StoApPtr
  -- 

   type pwr_sClass_StoApPtr is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13386
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13387
      ApPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13388
      Ptr : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13389
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoApPtr);  -- pwr_baseclasses.h:13390

   --  skipped anonymous struct anon_733

  --_* Class: StoApPtr
  --    Body:  DevBody
  --    @Aref StoApPtr pwr_sdClass_StoApPtr
  -- 

   type pwr_sdClass_StoApPtr is record
      ApPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13398
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13399
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoApPtr);  -- pwr_baseclasses.h:13400

   --  skipped anonymous struct anon_734

  --_* Class: StoATgeneric
  --    Body:  DevBody
  --    @Aref StoATgeneric pwr_sdClass_StoATgeneric
  -- 

   type pwr_sdClass_StoATgeneric is record
      InP : access pwr_h.pwr_tTime;  -- pwr_baseclasses.h:13414
      c_In : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:13415
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13416
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoATgeneric);  -- pwr_baseclasses.h:13417

   --  skipped anonymous struct anon_735

  --  Class: StoAtoIp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoAtoIp
  --    Body:  DevBody
  --    @Aref StoAtoIp pwr_sdClass_StoAtoIp
  -- 

   type pwr_sdClass_StoAtoIp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13436
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13437
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13438
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAtoIp);  -- pwr_baseclasses.h:13439

   --  skipped anonymous struct anon_736

  --  Class: StoATp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoATp
  --    Body:  DevBody
  --    @Aref StoATp pwr_sdClass_StoATp
  -- 

   type pwr_sdClass_StoATp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13458
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13459
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13460
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoATp);  -- pwr_baseclasses.h:13461

   --  skipped anonymous struct anon_737

  --  Class: StoATv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoATv
  --    Body:  DevBody
  --    @Aref StoATv pwr_sdClass_StoATv
  -- 

   type pwr_sdClass_StoATv is record
      ATvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13480
      ATvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13481
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13482
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoATv);  -- pwr_baseclasses.h:13483

   --  skipped anonymous struct anon_738

  --  Class: StoAv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoAv
  --    Body:  DevBody
  --    @Aref StoAv pwr_sdClass_StoAv
  -- 

   type pwr_sdClass_StoAv is record
      AvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13502
      AvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13503
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13504
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoAv);  -- pwr_baseclasses.h:13505

   --  skipped anonymous struct anon_739

  --_* Class: StoBiFloat32
  --    Body:  RtBody
  --    @Aref StoBiFloat32 pwr_sClass_StoBiFloat32
  -- 

   type pwr_sClass_StoBiFloat32 is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13519
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13520
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoBiFloat32);  -- pwr_baseclasses.h:13521

   --  skipped anonymous struct anon_740

  --_* Class: StoBiFloat32
  --    Body:  DevBody
  --    @Aref StoBiFloat32 pwr_sdClass_StoBiFloat32
  -- 

   type pwr_sdClass_StoBiFloat32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13529
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13530
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13531
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13532
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13533
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13534
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBiFloat32);  -- pwr_baseclasses.h:13535

   --  skipped anonymous struct anon_741

  --_* Class: StoBiInt32
  --    Body:  RtBody
  --    @Aref StoBiInt32 pwr_sClass_StoBiInt32
  -- 

   type pwr_sClass_StoBiInt32 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13549
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13550
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoBiInt32);  -- pwr_baseclasses.h:13551

   --  skipped anonymous struct anon_742

  --_* Class: StoBiInt32
  --    Body:  DevBody
  --    @Aref StoBiInt32 pwr_sdClass_StoBiInt32
  -- 

   type pwr_sdClass_StoBiInt32 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13559
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13560
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13561
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13562
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13563
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13564
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBiInt32);  -- pwr_baseclasses.h:13565

   --  skipped anonymous struct anon_743

  --  Class: StoBiString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoBiString80
  --    Body:  DevBody
  --    @Aref StoBiString80 pwr_sdClass_StoBiString80
  -- 

   type pwr_sdClass_StoBiString80 is record
      BiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13584
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13585
      BiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13586
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13587
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13588
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13589
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBiString80);  -- pwr_baseclasses.h:13590

   --  skipped anonymous struct anon_744

  --_* Class: StoBoFloat32
  --    Body:  RtBody
  --    @Aref StoBoFloat32 pwr_sClass_StoBoFloat32
  -- 

   type pwr_sClass_StoBoFloat32 is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13604
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:13605
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoBoFloat32);  -- pwr_baseclasses.h:13606

   --  skipped anonymous struct anon_745

  --_* Class: StoBoFloat32
  --    Body:  DevBody
  --    @Aref StoBoFloat32 pwr_sdClass_StoBoFloat32
  -- 

   type pwr_sdClass_StoBoFloat32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13614
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13615
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13616
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13617
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13618
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13619
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBoFloat32);  -- pwr_baseclasses.h:13620

   --  skipped anonymous struct anon_746

  --_* Class: StoBoInt32
  --    Body:  RtBody
  --    @Aref StoBoInt32 pwr_sClass_StoBoInt32
  -- 

   type pwr_sClass_StoBoInt32 is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13634
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13635
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoBoInt32);  -- pwr_baseclasses.h:13636

   --  skipped anonymous struct anon_747

  --_* Class: StoBoInt32
  --    Body:  DevBody
  --    @Aref StoBoInt32 pwr_sdClass_StoBoInt32
  -- 

   type pwr_sdClass_StoBoInt32 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13644
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13645
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13646
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13647
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13648
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13649
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBoInt32);  -- pwr_baseclasses.h:13650

   --  skipped anonymous struct anon_748

  --  Class: StoBoString80
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoBoString80
  --    Body:  DevBody
  --    @Aref StoBoString80 pwr_sdClass_StoBoString80
  -- 

   type pwr_sdClass_StoBoString80 is record
      BoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13669
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13670
      BoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13671
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13672
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13673
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13674
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoBoString80);  -- pwr_baseclasses.h:13675

   --  skipped anonymous struct anon_749

  --  Class: StoDattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDattr
  --    Body:  DevBody
  --    @Aref StoDattr pwr_sdClass_StoDattr
  -- 

   type pwr_sdClass_StoDattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:13694
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13695
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDattr);  -- pwr_baseclasses.h:13696

   --  skipped anonymous struct anon_750

  --_* Class: StoDgeneric
  --    Body:  DevBody
  --    @Aref StoDgeneric pwr_sdClass_StoDgeneric
  -- 

   type pwr_sdClass_StoDgeneric is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13710
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13711
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13712
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDgeneric);  -- pwr_baseclasses.h:13713

   --  skipped anonymous struct anon_751

  --_* Class: StoDi
  --    Body:  RtBody
  --    @Aref StoDi pwr_sClass_stodi
  -- 

   type pwr_sClass_stodi is record
      ActualValueP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13727
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13728
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_stodi);  -- pwr_baseclasses.h:13729

   --  skipped anonymous struct anon_752

  --_* Class: StoDi
  --    Body:  DevBody
  --    @Aref StoDi pwr_sdClass_StoDi
  -- 

   type pwr_sdClass_StoDi is record
      DiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13737
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13738
      DiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13739
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13740
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13741
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13742
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDi);  -- pwr_baseclasses.h:13743

   --  skipped anonymous struct anon_753

  --  Class: StoDo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDo
  --    Body:  DevBody
  --    @Aref StoDo pwr_sdClass_StoDo
  -- 

   type pwr_sdClass_StoDo is record
      DoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13762
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13763
      DoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13764
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13765
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13766
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13767
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDo);  -- pwr_baseclasses.h:13768

   --  skipped anonymous struct anon_754

  --  Class: StoDp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDp
  --    Body:  DevBody
  --    @Aref StoDp pwr_sdClass_StoDp
  -- 

   type pwr_sdClass_StoDp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13787
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13788
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13789
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDp);  -- pwr_baseclasses.h:13790

   --  skipped anonymous struct anon_755

  --_* Class: StoDpPtr
  --    Body:  RtBody
  --    @Aref StoDpPtr pwr_sClass_StoDpPtr
  -- 

   type pwr_sClass_StoDpPtr is record
      InP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13804
      c_In : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13805
      DpPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13806
      Ptr : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13807
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoDpPtr);  -- pwr_baseclasses.h:13808

   --  skipped anonymous struct anon_756

  --_* Class: StoDpPtr
  --    Body:  DevBody
  --    @Aref StoDpPtr pwr_sdClass_StoDpPtr
  -- 

   type pwr_sdClass_StoDpPtr is record
      DpPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13816
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13817
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDpPtr);  -- pwr_baseclasses.h:13818

   --  skipped anonymous struct anon_757

  --_* Class: StoDTgeneric
  --    Body:  DevBody
  --    @Aref StoDTgeneric pwr_sdClass_StoDTgeneric
  -- 

   type pwr_sdClass_StoDTgeneric is record
      InP : access pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:13832
      c_In : aliased pwr_h.pwr_tDeltaTime;  -- pwr_baseclasses.h:13833
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13834
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDTgeneric);  -- pwr_baseclasses.h:13835

   --  skipped anonymous struct anon_758

  --  Class: StoDTp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDTp
  --    Body:  DevBody
  --    @Aref StoDTp pwr_sdClass_StoDTp
  -- 

   type pwr_sdClass_StoDTp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13854
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13855
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13856
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDTp);  -- pwr_baseclasses.h:13857

   --  skipped anonymous struct anon_759

  --  Class: StoDTv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDTv
  --    Body:  DevBody
  --    @Aref StoDTv pwr_sdClass_StoDTv
  -- 

   type pwr_sdClass_StoDTv is record
      DTvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13876
      DTvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13877
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13878
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDTv);  -- pwr_baseclasses.h:13879

   --  skipped anonymous struct anon_760

  --  Class: StoDv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoDv
  --    Body:  DevBody
  --    @Aref StoDv pwr_sdClass_StoDv
  -- 

   type pwr_sdClass_StoDv is record
      DvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13898
      DvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13899
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13900
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoDv);  -- pwr_baseclasses.h:13901

   --  skipped anonymous struct anon_761

  --  Class: StoIattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoIattr
  --    Body:  DevBody
  --    @Aref StoIattr pwr_sdClass_StoIattr
  -- 

   type pwr_sdClass_StoIattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:13920
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13921
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIattr);  -- pwr_baseclasses.h:13922

   --  skipped anonymous struct anon_762

  --_* Class: StoIgeneric
  --    Body:  DevBody
  --    @Aref StoIgeneric pwr_sdClass_StoIgeneric
  -- 

   type pwr_sdClass_StoIgeneric is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13936
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13937
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13938
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIgeneric);  -- pwr_baseclasses.h:13939

   --  skipped anonymous struct anon_763

  --_* Class: StoIi
  --    Body:  RtBody
  --    @Aref StoIi pwr_sClass_stoii
  -- 

   type pwr_sClass_stoii is record
      ActualValueP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13953
      ActualValue : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13954
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_stoii);  -- pwr_baseclasses.h:13955

   --  skipped anonymous struct anon_764

  --_* Class: StoIi
  --    Body:  DevBody
  --    @Aref StoIi pwr_sdClass_StoIi
  -- 

   type pwr_sdClass_StoIi is record
      IiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13963
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13964
      IiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13965
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13966
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13967
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13968
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIi);  -- pwr_baseclasses.h:13969

   --  skipped anonymous struct anon_765

  --  Class: StoIo
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoIo
  --    Body:  DevBody
  --    @Aref StoIo pwr_sdClass_StoIo
  -- 

   type pwr_sdClass_StoIo is record
      IoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13988
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:13989
      IoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13990
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:13991
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:13992
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:13993
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIo);  -- pwr_baseclasses.h:13994

   --  skipped anonymous struct anon_766

  --  Class: StoIp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoIp
  --    Body:  DevBody
  --    @Aref StoIp pwr_sdClass_StoIp
  -- 

   type pwr_sdClass_StoIp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14013
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14014
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14015
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIp);  -- pwr_baseclasses.h:14016

   --  skipped anonymous struct anon_767

  --_* Class: StoIpPtr
  --    Body:  RtBody
  --    @Aref StoIpPtr pwr_sClass_StoIpPtr
  -- 

   type pwr_sClass_StoIpPtr is record
      InP : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14030
      c_In : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14031
      IpPtrObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14032
      Ptr : access pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14033
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoIpPtr);  -- pwr_baseclasses.h:14034

   --  skipped anonymous struct anon_768

  --_* Class: StoIpPtr
  --    Body:  DevBody
  --    @Aref StoIpPtr pwr_sdClass_StoIpPtr
  -- 

   type pwr_sdClass_StoIpPtr is record
      IpPtrObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14042
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14043
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIpPtr);  -- pwr_baseclasses.h:14044

   --  skipped anonymous struct anon_769

  --  Class: StoIv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoIv
  --    Body:  DevBody
  --    @Aref StoIv pwr_sdClass_StoIv
  -- 

   type pwr_sdClass_StoIv is record
      IvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14063
      IvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14064
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14065
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoIv);  -- pwr_baseclasses.h:14066

   --  skipped anonymous struct anon_770

  --  Class: StoNumSp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoNumSp
  --    Body:  DevBody
  --    @Aref StoNumSp pwr_sdClass_StoNumSp
  -- 

   type pwr_sdClass_StoNumSp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14085
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14086
      NumberOfChar : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14087
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14088
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoNumSp);  -- pwr_baseclasses.h:14089

   --  skipped anonymous struct anon_771

  --_* Class: StoPi
  --    Body:  RtBody
  --    @Aref StoPi pwr_sClass_stopi
  -- 

   type pwr_sClass_stopi is record
      ActualValueP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14103
      ActualValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14104
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_stopi);  -- pwr_baseclasses.h:14105

   --  skipped anonymous struct anon_772

  --_* Class: StoPi
  --    Body:  DevBody
  --    @Aref StoPi pwr_sdClass_StoPi
  -- 

   type pwr_sdClass_StoPi is record
      CoObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14113
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14114
      CoObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14115
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14116
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14117
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14118
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoPi);  -- pwr_baseclasses.h:14119

   --  skipped anonymous struct anon_773

  --_* Class: Store
  --    Body:  RtBody
  --    @Aref Store pwr_sClass_Store
  -- 

   type pwr_sClass_Store is record
      StoreAll : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14133
      StoreType : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14134
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14135
      DataBase : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14136
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Store);  -- pwr_baseclasses.h:14137

   --  skipped anonymous struct anon_774

  --_* Class: StoreFormat
  --    Body:  RtBody
  --    @Aref StoreFormat pwr_sClass_StoreFormat
  -- 

   type pwr_sClass_StoreFormat is record
      StoreCommand : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:14151
      TableName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14152
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoreFormat);  -- pwr_baseclasses.h:14153

   --  skipped anonymous struct anon_775

  --_* Class: StoreTrig
  --    Body:  RtBody
  --    @Aref StoreTrig pwr_sClass_StoreTrig
  -- 

   type pwr_sClass_StoreTrig_References_array is array (0 .. 19) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_StoreTrig_StoreObject_array is array (0 .. 1) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_StoreTrig is record
      Trigged : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14167
      References : aliased pwr_sClass_StoreTrig_References_array;  -- pwr_baseclasses.h:14168
      FormatObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:14169
      StoreObject : aliased pwr_sClass_StoreTrig_StoreObject_array;  -- pwr_baseclasses.h:14170
      Identifier : aliased pwr_h.pwr_tString16;  -- pwr_baseclasses.h:14171
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StoreTrig);  -- pwr_baseclasses.h:14172

   --  skipped anonymous struct anon_776

  --  Class: StoSattr
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoSattr
  --    Body:  DevBody
  --    @Aref StoSattr pwr_sdClass_StoSattr
  -- 

   type pwr_sdClass_StoSattr is record
      attr : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:14191
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14192
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoSattr);  -- pwr_baseclasses.h:14193

   --  skipped anonymous struct anon_777

  --_* Class: StoSgeneric
  --    Body:  DevBody
  --    @Aref StoSgeneric pwr_sdClass_StoSgeneric
  -- 

   type pwr_sdClass_StoSgeneric is record
      InP : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14207
      c_In : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14208
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14209
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoSgeneric);  -- pwr_baseclasses.h:14210

   --  skipped anonymous struct anon_778

  --  Class: StoSp
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoSp
  --    Body:  DevBody
  --    @Aref StoSp pwr_sdClass_StoSp
  -- 

   type pwr_sdClass_StoSp is record
      Object : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14229
      ObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14230
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14231
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoSp);  -- pwr_baseclasses.h:14232

   --  skipped anonymous struct anon_779

  --  Class: StoSv
  --    Body:  RtBody
  --    Body is virtual
  -- 

  --_* Class: StoSv
  --    Body:  DevBody
  --    @Aref StoSv pwr_sdClass_StoSv
  -- 

   type pwr_sdClass_StoSv is record
      SvObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14251
      SvObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14252
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14253
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StoSv);  -- pwr_baseclasses.h:14254

   --  skipped anonymous struct anon_780

  --_* Class: Strcat
  --    Body:  RtBody
  --    @Aref Strcat pwr_sClass_Strcat
  -- 

   type pwr_sClass_Strcat is record
      Str1P : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14268
      Str1 : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14269
      Str2P : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14270
      Str2 : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14271
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14272
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Strcat);  -- pwr_baseclasses.h:14273

   --  skipped anonymous struct anon_781

  --_* Class: Strcat
  --    Body:  DevBody
  --    @Aref Strcat pwr_sdClass_Strcat
  -- 

   type pwr_sdClass_Strcat is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14281
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Strcat);  -- pwr_baseclasses.h:14282

   --  skipped anonymous struct anon_782

  --_* Class: StrToEnum
  --    Body:  RtBody
  --    @Aref StrToEnum pwr_sClass_StrToEnum
  -- 

   type pwr_sClass_StrToEnum is record
      StrP : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14296
      Str : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14297
      TypeId : aliased pwr_h.pwr_tTypeId;  -- pwr_baseclasses.h:14298
      EnumDefP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14299
      EnumDefRows : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14300
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14301
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_StrToEnum);  -- pwr_baseclasses.h:14302

   --  skipped anonymous struct anon_783

  --_* Class: StrToEnum
  --    Body:  DevBody
  --    @Aref StrToEnum pwr_sdClass_StrToEnum
  -- 

   type pwr_sdClass_StrToEnum is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14310
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_StrToEnum);  -- pwr_baseclasses.h:14311

   --  skipped anonymous struct anon_784

  --_* Class: Sub
  --    Body:  RtBody
  --    @Aref Sub pwr_sClass_Sub
  -- 

   type pwr_sClass_Sub is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14325
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14326
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14327
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14328
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14329
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Sub);  -- pwr_baseclasses.h:14330

   --  skipped anonymous struct anon_785

  --_* Class: Sub
  --    Body:  DevBody
  --    @Aref Sub pwr_sdClass_Sub
  -- 

   type pwr_sdClass_Sub is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14338
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Sub);  -- pwr_baseclasses.h:14339

   --  skipped anonymous struct anon_786

  --_* Class: SubStep
  --    Body:  RtBody
  --    @Aref SubStep pwr_sClass_substep
  -- 

   type pwr_sClass_substep_Status_array is array (0 .. 1) of aliased pwr_h.pwr_tBoolean;
   type pwr_sClass_substep is record
      StatusIn : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14353
      StatusOut : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14354
      Status : aliased pwr_sClass_substep_Status_array;  -- pwr_baseclasses.h:14355
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_substep);  -- pwr_baseclasses.h:14356

   --  skipped anonymous struct anon_787

  --_* Class: SubStep
  --    Body:  DevBody
  --    @Aref SubStep pwr_sdClass_SubStep
  -- 

   type pwr_sdClass_SubStep is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14364
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SubStep);  -- pwr_baseclasses.h:14365

   --  skipped anonymous struct anon_788

  --_* Class: SubStr
  --    Body:  RtBody
  --    @Aref SubStr pwr_sClass_SubStr
  -- 

   type pwr_sClass_SubStr is record
      InP : access pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14379
      c_In : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14380
      Start : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14381
      Length : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14382
      ActVal : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14383
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SubStr);  -- pwr_baseclasses.h:14384

   --  skipped anonymous struct anon_789

  --_* Class: SubStr
  --    Body:  DevBody
  --    @Aref SubStr pwr_sdClass_SubStr
  -- 

   type pwr_sdClass_SubStr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14392
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_SubStr);  -- pwr_baseclasses.h:14393

   --  skipped anonymous struct anon_790

  --_* Class: SubVolumeConfig
  --    Body:  RtBody
  --    @Aref SubVolumeConfig pwr_sClass_SubVolumeConfig
  -- 

   type pwr_sClass_SubVolumeConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14407
      Database : aliased pwr_tVolumeDatabaseEnum;  -- pwr_baseclasses.h:14408
      Server : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:14409
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SubVolumeConfig);  -- pwr_baseclasses.h:14410

   --  skipped anonymous struct anon_791

  --_* Class: SubVolumeLoad
  --    Body:  RtBody
  --    @Aref SubVolumeLoad pwr_sClass_SubVolumeLoad
  -- 

   type pwr_sClass_SubVolumeLoad is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14424
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SubVolumeLoad);  -- pwr_baseclasses.h:14425

   --  skipped anonymous struct anon_792

  --_* Class: Sum
  --    Body:  RtBody
  --    @Aref Sum pwr_sClass_sum
  -- 

   type pwr_sClass_sum_FVect_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_sum_AccFact_array is array (0 .. 7) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_sum_MinFact_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_sum_MaxFact_array is array (0 .. 7) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_sum is record
      In1P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14439
      In1 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14440
      In2P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14441
      In2 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14442
      In3P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14443
      In3 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14444
      In4P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14445
      In4 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14446
      In5P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14447
      In5 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14448
      In6P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14449
      In6 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14450
      In7P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14451
      In7 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14452
      In8P : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14453
      In8 : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14454
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14455
      Const : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14456
      FVect : aliased pwr_sClass_sum_FVect_array;  -- pwr_baseclasses.h:14457
      AccConst : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14458
      MinConst : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14459
      MaxConst : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14460
      AccFact : aliased pwr_sClass_sum_AccFact_array;  -- pwr_baseclasses.h:14461
      MinFact : aliased pwr_sClass_sum_MinFact_array;  -- pwr_baseclasses.h:14462
      MaxFact : aliased pwr_sClass_sum_MaxFact_array;  -- pwr_baseclasses.h:14463
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_sum);  -- pwr_baseclasses.h:14464

   --  skipped anonymous struct anon_793

  --_* Class: Sum
  --    Body:  DevBody
  --    @Aref Sum pwr_sdClass_Sum
  -- 

   type pwr_sdClass_Sum is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14472
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Sum);  -- pwr_baseclasses.h:14473

   --  skipped anonymous struct anon_794

  --_* Class: Sv
  --    Body:  RtBody
  --    @Aref Sv pwr_sClass_Sv
  -- 

   type pwr_sClass_Sv is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14487
      ActualValue : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14488
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Sv);  -- pwr_baseclasses.h:14489

   --  skipped anonymous struct anon_795

  --_* Class: SysMonConfig
  --    Body:  RtBody
  --    @Aref SysMonConfig pwr_sClass_SysMonConfig
  -- 

   type pwr_sClass_SysMonConfig_DiskSupObjects_array is array (0 .. 24) of aliased pwr_h.pwr_tObjid;
   type pwr_sClass_SysMonConfig is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14503
      ScanTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14504
      DiskSupObjects : aliased pwr_sClass_SysMonConfig_DiskSupObjects_array;  -- pwr_baseclasses.h:14505
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SysMonConfig);  -- pwr_baseclasses.h:14506

   --  skipped anonymous struct anon_796

  --_* Class: SystemGroupReg
  --    Body:  RtBody
  --    @Aref SystemGroupReg pwr_sClass_SystemGroupReg
  -- 

   type pwr_sClass_SystemGroupReg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14520
      Attributes : aliased pwr_tSysGroupAttrMask;  -- pwr_baseclasses.h:14521
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_SystemGroupReg);  -- pwr_baseclasses.h:14522

   --  skipped anonymous struct anon_797

  --_* Class: Table
  --    Body:  RtBody
  --    @Aref Table pwr_sClass_table
  -- 

   type pwr_sClass_table_TabVect_array is array (0 .. 100) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_table is record
      TabVect : aliased pwr_sClass_table_TabVect_array;  -- pwr_baseclasses.h:14536
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_table);  -- pwr_baseclasses.h:14537

   --  skipped anonymous struct anon_798

  --_* Class: Table
  --    Body:  DevBody
  --    @Aref Table pwr_sdClass_Table
  -- 

   type pwr_sdClass_Table is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14545
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Table);  -- pwr_baseclasses.h:14546

   --  skipped anonymous struct anon_799

  --_* Class: Tan
  --    Body:  RtBody
  --    @Aref Tan pwr_sClass_Tan
  -- 

   type pwr_sClass_Tan is record
      inP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14560
      c_in : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14561
      FactorIn : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14562
      FactorVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14563
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14564
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_Tan);  -- pwr_baseclasses.h:14565

   --  skipped anonymous struct anon_800

  --_* Class: Tan
  --    Body:  DevBody
  --    @Aref Tan pwr_sdClass_Tan
  -- 

   type pwr_sdClass_Tan is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14573
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Tan);  -- pwr_baseclasses.h:14574

   --  skipped anonymous struct anon_801

  --_* Class: Text
  --    Body:  DevBody
  --    @Aref Text pwr_sdClass_Text
  -- 

   type pwr_sdClass_Text is record
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14588
      TextAttribute : aliased pwr_tTextAttrEnum;  -- pwr_baseclasses.h:14589
      FrameAttribute : aliased pwr_tFrameAttrEnum;  -- pwr_baseclasses.h:14590
      FrameWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14591
      FrameHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14592
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14593
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Text);  -- pwr_baseclasses.h:14594

   --  skipped anonymous struct anon_802

  --_* Class: Timer
  --    Body:  RtBody
  --    @Aref Timer pwr_sClass_timer
  -- 

   type pwr_sClass_timer is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14608
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14609
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14610
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14611
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14612
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14613
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14614
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14615
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14616
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14617
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:14618
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14619
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14620
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14621
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_timer);  -- pwr_baseclasses.h:14622

   --  skipped anonymous struct anon_803

  --_* Class: Timer
  --    Body:  DevBody
  --    @Aref Timer pwr_sdClass_Timer
  -- 

   type pwr_sdClass_Timer is record
      ShowTimerTime : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14630
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14631
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Timer);  -- pwr_baseclasses.h:14632

   --  skipped anonymous struct anon_804

  --_* Class: Timint
  --    Body:  RtBody
  --    @Aref Timint pwr_sClass_timint
  -- 

   type pwr_sClass_timint is record
      InP : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14646
      c_In : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14647
      ClearP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14648
      Clear : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14649
      ActVal : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14650
      TimFact : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14651
      ScanTime : access pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14652
      AccVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14653
      OldAcc : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14654
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_timint);  -- pwr_baseclasses.h:14655

   --  skipped anonymous struct anon_805

  --_* Class: Timint
  --    Body:  DevBody
  --    @Aref Timint pwr_sdClass_Timint
  -- 

   type pwr_sdClass_Timint is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14663
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Timint);  -- pwr_baseclasses.h:14664

   --  skipped anonymous struct anon_806

  --_* Class: Title
  --    Body:  DevBody
  --    @Aref Title pwr_sdClass_Title
  -- 

   type pwr_sdClass_Title is record
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14678
      TextAttribute : aliased pwr_tTextAttrEnum;  -- pwr_baseclasses.h:14679
      FrameAttribute : aliased pwr_tFrameAttrEnum;  -- pwr_baseclasses.h:14680
      FrameWidth : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14681
      FrameHeight : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14682
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14683
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Title);  -- pwr_baseclasses.h:14684

   --  skipped anonymous struct anon_807

  --_* Class: ToggleDi
  --    Body:  RtBody
  --    @Aref ToggleDi pwr_sClass_toggledi
  -- 

   type pwr_sClass_toggledi is record
      ActualValueP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14698
      ActualValue : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14699
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_toggledi);  -- pwr_baseclasses.h:14700

   --  skipped anonymous struct anon_808

  --_* Class: ToggleDi
  --    Body:  DevBody
  --    @Aref ToggleDi pwr_sdClass_ToggleDi
  -- 

   type pwr_sdClass_ToggleDi is record
      DiObject : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14708
      SigChanCon : aliased pwr_h.pwr_sAttrRef;  -- pwr_baseclasses.h:14709
      DiObjectSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14710
      ShowSigChanCon : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14711
      SigChanConSegments : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14712
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14713
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_ToggleDi);  -- pwr_baseclasses.h:14714

   --  skipped anonymous struct anon_809

  --_* Class: Trans
  --    Body:  RtBody
  --    @Aref Trans pwr_sClass_trans
  -- 

   type pwr_sClass_trans is record
      InStepP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14728
      InStep : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14729
      OutStepP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14730
      OutStep : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14731
      CondP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14732
      Cond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14733
      ActOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14734
      Man : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14735
      OpCond : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14736
      Acc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14737
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_trans);  -- pwr_baseclasses.h:14738

   --  skipped anonymous struct anon_810

  --_* Class: Trans
  --    Body:  DevBody
  --    @Aref Trans pwr_sdClass_Trans
  -- 

   type pwr_sdClass_Trans is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14746
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Trans);  -- pwr_baseclasses.h:14747

   --  skipped anonymous struct anon_811

  --_* Class: TransConv
  --    Body:  DevBody
  --    @Aref TransConv pwr_sdClass_TransConv
  -- 

   type pwr_sdClass_TransConv is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:14761
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_TransConv);  -- pwr_baseclasses.h:14762

   --  skipped anonymous struct anon_812

  --_* Class: TransDiv
  --    Body:  DevBody
  --    @Aref TransDiv pwr_sdClass_TransDiv
  -- 

   type pwr_sdClass_TransDiv is record
      PlcCon : aliased pwr_class_h.pwr_sPlcConnection;  -- pwr_baseclasses.h:14776
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_TransDiv);  -- pwr_baseclasses.h:14777

   --  skipped anonymous struct anon_813

  --_* Class: True
  --    Body:  RtBody
  --    @Aref True pwr_sClass_True
  -- 

   type pwr_sClass_True is record
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14791
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_True);  -- pwr_baseclasses.h:14792

   --  skipped anonymous struct anon_814

  --_* Class: True
  --    Body:  DevBody
  --    @Aref True pwr_sdClass_True
  -- 

   type pwr_sdClass_True is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14800
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_True);  -- pwr_baseclasses.h:14801

   --  skipped anonymous struct anon_815

  --_* Class: UInt32toI
  --    Body:  RtBody
  --    @Aref UInt32toI pwr_sClass_UInt32toI
  -- 

   type pwr_sClass_UInt32toI is record
      InP : access pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14815
      c_In : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14816
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14817
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_UInt32toI);  -- pwr_baseclasses.h:14818

   --  skipped anonymous struct anon_816

  --_* Class: UInt32toI
  --    Body:  DevBody
  --    @Aref UInt32toI pwr_sdClass_UInt32toI
  -- 

   type pwr_sdClass_UInt32toI is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14826
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_UInt32toI);  -- pwr_baseclasses.h:14827

   --  skipped anonymous struct anon_817

  --_* Class: UInt64toI
  --    Body:  RtBody
  --    @Aref UInt64toI pwr_sClass_UInt64toI
  -- 

   type pwr_sClass_UInt64toI is record
      InP : access pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:14841
      c_In : aliased pwr_h.pwr_tUInt64;  -- pwr_baseclasses.h:14842
      ActVal : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14843
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_UInt64toI);  -- pwr_baseclasses.h:14844

   --  skipped anonymous struct anon_818

  --_* Class: UInt64toI
  --    Body:  DevBody
  --    @Aref UInt64toI pwr_sdClass_UInt64toI
  -- 

   type pwr_sdClass_UInt64toI is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14852
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_UInt64toI);  -- pwr_baseclasses.h:14853

   --  skipped anonymous struct anon_819

  --_* Class: User
  --    Body:  RtBody
  --    @Aref User pwr_sClass_User
  -- 

   type pwr_sClass_User_SelectList_array is array (0 .. 19, 0 .. 79) of aliased char;
   type pwr_sClass_User_FastAvail_array is array (0 .. 14) of aliased pwr_h.pwr_sAttrRef;
   type pwr_sClass_User_PrivObjList_array is array (0 .. 9, 0 .. 79) of aliased char;
   type pwr_sClass_User_PrivList_array is array (0 .. 9) of aliased pwr_h.pwr_tInt32;
   type pwr_sClass_User is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14867
      UserName : aliased pwr_h.pwr_tString32;  -- pwr_baseclasses.h:14868
      OpNumber : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14869
      NoOfAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14870
      MaxNoOfAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14871
      NoOfEvents : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14872
      MaxNoOfEvents : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14873
      SelectListIsUpdated : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14874
      SelectList : aliased pwr_sClass_User_SelectList_array;  -- pwr_baseclasses.h:14875
      FastAvail : aliased pwr_sClass_User_FastAvail_array;  -- pwr_baseclasses.h:14876
      NoFastAvail : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14877
      PrivObjList : aliased pwr_sClass_User_PrivObjList_array;  -- pwr_baseclasses.h:14878
      PrivList : aliased pwr_sClass_User_PrivList_array;  -- pwr_baseclasses.h:14879
      NoPriv : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14880
      NavigatorWritePriv : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14881
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_User);  -- pwr_baseclasses.h:14882

   --  skipped anonymous struct anon_820

  --_* Class: UserReg
  --    Body:  RtBody
  --    @Aref UserReg pwr_sClass_UserReg
  -- 

   type pwr_sClass_UserReg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14896
      Password : aliased pwr_h.pwr_tProString40;  -- pwr_baseclasses.h:14897
      Privileges : aliased pwr_class_h.pwr_tPrivMask;  -- pwr_baseclasses.h:14898
      FullName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14899
      Email : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14900
      Phone : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:14901
      Sms : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:14902
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_UserReg);  -- pwr_baseclasses.h:14903

   --  skipped anonymous struct anon_821

  --_* Class: Valve
  --    Body:  RtBody
  --    @Aref Valve pwr_sClass_valve
  -- 

   type pwr_sClass_valve is record
      AutoOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14917
      AutoOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14918
      EndOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14919
      EndOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14920
      EndCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14921
      EndClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14922
      LocalP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14923
      Local : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14924
      LocalOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14925
      LocalOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14926
      LocalCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14927
      LocalClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14928
      SafeOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14929
      SafeOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14930
      SafeCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14931
      SafeClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14932
      ProdOpenP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14933
      ProdOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14934
      ProdCloseP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14935
      ProdClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14936
      ManMode : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14937
      OrderOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14938
      IndOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14939
      IndClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14940
      Alarm1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14941
      Alarm2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14942
      Alarm3 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14943
      Alarm4 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14944
      SumAlarm : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14945
      ManOpen : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14946
      ManClose : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14947
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14948
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14949
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14950
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14951
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:14952
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:14953
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:14954
      ManAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14955
      Status : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:14956
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_valve);  -- pwr_baseclasses.h:14957

   --  skipped anonymous struct anon_822

  --_* Class: Valve
  --    Body:  DevBody
  --    @Aref Valve pwr_sdClass_Valve
  -- 

   type pwr_sdClass_Valve is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:14965
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Valve);  -- pwr_baseclasses.h:14966

   --  skipped anonymous struct anon_823

  --_* Class: VolumeDistribute
  --    Body:  RtBody
  --    @Aref VolumeDistribute pwr_sClass_VolumeDistribute
  -- 

   type pwr_sClass_VolumeDistribute is record
      TargetNode : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14980
      TargetProject : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14981
      TargetOpSys : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14982
      AccessType : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14983
      LocalPath : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:14984
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_VolumeDistribute);  -- pwr_baseclasses.h:14985

   --  skipped anonymous struct anon_824

  --_* Class: VolumeLoad
  --    Body:  DevBody
  --    @Aref VolumeLoad pwr_sdClass_VolumeLoad
  -- 

   type pwr_sdClass_VolumeLoad is record
      VolumeId : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:14999
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_VolumeLoad);  -- pwr_baseclasses.h:15000

   --  skipped anonymous struct anon_825

  --_* Class: VolumeReg
  --    Body:  RtBody
  --    @Aref VolumeReg pwr_sClass_VolumeReg
  -- 

   type pwr_sClass_VolumeReg is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15014
      VolumeId : aliased pwr_h.pwr_tVolumeId;  -- pwr_baseclasses.h:15015
      Project : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15016
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_VolumeReg);  -- pwr_baseclasses.h:15017

   --  skipped anonymous struct anon_826

  --_* Class: Wait
  --    Body:  RtBody
  --    @Aref Wait pwr_sClass_wait
  -- 

   type pwr_sClass_wait is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15031
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15032
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15033
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15034
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15035
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15036
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15037
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15038
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15039
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15040
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:15041
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15042
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15043
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15044
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_wait);  -- pwr_baseclasses.h:15045

   --  skipped anonymous struct anon_827

  --_* Class: Wait
  --    Body:  DevBody
  --    @Aref Wait pwr_sdClass_Wait
  -- 

   type pwr_sdClass_Wait is record
      ShowTimerTime : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15053
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:15054
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Wait);  -- pwr_baseclasses.h:15055

   --  skipped anonymous struct anon_828

  --_* Class: Waith
  --    Body:  RtBody
  --    @Aref Waith pwr_sClass_waith
  -- 

   type pwr_sClass_waith is record
      inP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15069
      c_in : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15070
      hldP : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15071
      hld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15072
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15073
      StatusOld : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15074
      CountOld : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15075
      TimerFlag : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15076
      TimerNext : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15077
      TimerCount : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15078
      TimerDO : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15079
      TimerTime : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15080
      TimerDODum : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15081
      TimerObjDId : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:15082
      TimerAcc : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15083
      TimerMin : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15084
      TimerMax : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15085
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_waith);  -- pwr_baseclasses.h:15086

   --  skipped anonymous struct anon_829

  --_* Class: Waith
  --    Body:  DevBody
  --    @Aref Waith pwr_sdClass_Waith
  -- 

   type pwr_sdClass_Waith is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:15094
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_Waith);  -- pwr_baseclasses.h:15095

   --  skipped anonymous struct anon_830

  --_* Class: WbEnvironment
  --    Body:  RtBody
  --    @Aref WbEnvironment pwr_sClass_WbEnvironment
  -- 

   type pwr_sClass_WbEnvironment_Path_array is array (0 .. 19, 0 .. 79) of aliased char;
   type pwr_sClass_WbEnvironment is record
      Path : aliased pwr_sClass_WbEnvironment_Path_array;  -- pwr_baseclasses.h:15109
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_WbEnvironment);  -- pwr_baseclasses.h:15110

   --  skipped anonymous struct anon_831

  --_* Class: WebBrowserConfig
  --    Body:  RtBody
  --    @Aref WebBrowserConfig pwr_sClass_WebBrowserConfig
  -- 

   type pwr_sClass_WebBrowserConfig_URL_Symbols_array is array (0 .. 9, 0 .. 79) of aliased char;
   type pwr_sClass_WebBrowserConfig is record
      WebBrowser : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:15124
      URL_Symbols : aliased pwr_sClass_WebBrowserConfig_URL_Symbols_array;  -- pwr_baseclasses.h:15125
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_WebBrowserConfig);  -- pwr_baseclasses.h:15126

   --  skipped anonymous struct anon_832

  --_* Class: WebGraph
  --    Body:  RtBody
  --    @Aref WebGraph pwr_sClass_WebGraph
  -- 

   type pwr_sClass_WebGraph is record
      Name : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15140
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15141
      WebTarget : aliased pwr_tWebTargetEnum;  -- pwr_baseclasses.h:15142
      ConfigurationStatus : aliased pwr_class_h.pwr_tConfigStatusEnum;  -- pwr_baseclasses.h:15143
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_WebGraph);  -- pwr_baseclasses.h:15144

   --  skipped anonymous struct anon_833

  --_* Class: WebHandler
  --    Body:  RtBody
  --    @Aref WebHandler pwr_sClass_WebHandler
  -- 

   type pwr_sClass_WebHandler_EventSelectList_array is array (0 .. 39, 0 .. 79) of aliased char;
   type pwr_sClass_WebHandler is record
      MaxConnections : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15158
      CurrentConnections : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15159
      FileName : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15160
      Title : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15161
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15162
      EnableLanguage : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15163
      EnableLogin : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15164
      EnableAlarmList : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15165
      EnableEventLog : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15166
      EnableNavigator : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15167
      DisableHelp : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15168
      DisableProview : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15169
      UserObject : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:15170
      Language : aliased pwr_tLanguageEnum;  -- pwr_baseclasses.h:15171
      StyleSheet : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15172
      StartURL : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15173
      LoadArchives : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:15174
      PwrHost : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15175
      AppletSignature : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15176
      EventSelectList : aliased pwr_sClass_WebHandler_EventSelectList_array;  -- pwr_baseclasses.h:15177
      MaxNoOfAlarms : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15178
      MaxNoOfEvents : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15179
      AppUseWebDir : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15180
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_WebHandler);  -- pwr_baseclasses.h:15181

   --  skipped anonymous struct anon_834

  --_* Class: WebLink
  --    Body:  RtBody
  --    @Aref WebLink pwr_sClass_WebLink
  -- 

   type pwr_sClass_WebLink is record
      URL : aliased pwr_h.pwr_tString256;  -- pwr_baseclasses.h:15195
      Text : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15196
      WebTarget : aliased pwr_tWebTargetEnum;  -- pwr_baseclasses.h:15197
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_WebLink);  -- pwr_baseclasses.h:15198

   --  skipped anonymous struct anon_835

  --_* Class: WindowCond
  --    Body:  RtBody
  --    @Aref WindowCond pwr_sClass_windowcond
  -- 

   type pwr_sClass_windowcond is record
      ScanOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15212
      Version : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15213
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_windowcond);  -- pwr_baseclasses.h:15214

   --  skipped anonymous struct anon_836

  --_* Class: WindowCond
  --    Body:  DevBody
  --    @Aref WindowCond pwr_sdClass_WindowCond
  -- 

   type pwr_sdClass_WindowCond is record
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15222
      Compiled : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15223
      PlcWindow : aliased pwr_class_h.pwr_sPlcWindow;  -- pwr_baseclasses.h:15224
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_WindowCond);  -- pwr_baseclasses.h:15225

   --  skipped anonymous struct anon_837

  --_* Class: WindowOrderact
  --    Body:  RtBody
  --    @Aref WindowOrderact pwr_sClass_windoworderact
  -- 

   type pwr_sClass_windoworderact is record
      ScanOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15239
      Version : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15240
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_windoworderact);  -- pwr_baseclasses.h:15241

   --  skipped anonymous struct anon_838

  --_* Class: WindowOrderact
  --    Body:  DevBody
  --    @Aref WindowOrderact pwr_sdClass_WindowOrderact
  -- 

   type pwr_sdClass_WindowOrderact is record
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15249
      Compiled : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15250
      PlcWindow : aliased pwr_class_h.pwr_sPlcWindow;  -- pwr_baseclasses.h:15251
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_WindowOrderact);  -- pwr_baseclasses.h:15252

   --  skipped anonymous struct anon_839

  --_* Class: WindowPlc
  --    Body:  RtBody
  --    @Aref WindowPlc pwr_sClass_windowplc
  -- 

   type pwr_sClass_windowplc is record
      ScanOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15266
      Version : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15267
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_windowplc);  -- pwr_baseclasses.h:15268

   --  skipped anonymous struct anon_840

  --_* Class: WindowPlc
  --    Body:  DevBody
  --    @Aref WindowPlc pwr_sdClass_WindowPlc
  -- 

   type pwr_sdClass_WindowPlc is record
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15276
      Compiled : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15277
      PlcWindow : aliased pwr_class_h.pwr_sPlcWindow;  -- pwr_baseclasses.h:15278
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_WindowPlc);  -- pwr_baseclasses.h:15279

   --  skipped anonymous struct anon_841

  --_* Class: WindowSubstep
  --    Body:  RtBody
  --    @Aref WindowSubstep pwr_sClass_windowsubstep
  -- 

   type pwr_sClass_windowsubstep is record
      ScanOff : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15293
      Version : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15294
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_windowsubstep);  -- pwr_baseclasses.h:15295

   --  skipped anonymous struct anon_842

  --_* Class: WindowSubstep
  --    Body:  DevBody
  --    @Aref WindowSubstep pwr_sdClass_WindowSubstep
  -- 

   type pwr_sdClass_WindowSubstep is record
      Modified : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15303
      Compiled : aliased pwr_h.pwr_tTime;  -- pwr_baseclasses.h:15304
      PlcWindow : aliased pwr_class_h.pwr_sPlcWindow;  -- pwr_baseclasses.h:15305
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_WindowSubstep);  -- pwr_baseclasses.h:15306

   --  skipped anonymous struct anon_843

  --_* Class: XOr
  --    Body:  RtBody
  --    @Aref XOr pwr_sClass_xor
  -- 

   type pwr_sClass_xor is record
      In1P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15320
      In1 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15321
      In2P : access pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15322
      In2 : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15323
      Status : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15324
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_xor);  -- pwr_baseclasses.h:15325

   --  skipped anonymous struct anon_844

  --_* Class: XOr
  --    Body:  DevBody
  --    @Aref XOr pwr_sdClass_XOr
  -- 

   type pwr_sdClass_XOr is record
      PlcNode : aliased pwr_class_h.pwr_sPlcNode;  -- pwr_baseclasses.h:15333
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sdClass_XOr);  -- pwr_baseclasses.h:15334

   --  skipped anonymous struct anon_845

  --_* Class: XttGraph
  --    Body:  RtBody
  --    @Aref XttGraph pwr_sClass_XttGraph
  -- 

   type pwr_sClass_XttGraph is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15348
      Action : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15349
      Title : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:15350
      ButtonText : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:15351
      UpdateInterval : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15352
      X : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15353
      Y : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15354
      Width : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15355
      Height : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15356
      Object : aliased pwr_h.pwr_tObjid;  -- pwr_baseclasses.h:15357
      Options : aliased pwr_tXttGraphOptionsMask;  -- pwr_baseclasses.h:15358
      ConfigurationStatus : aliased pwr_class_h.pwr_tConfigStatusEnum;  -- pwr_baseclasses.h:15359
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_XttGraph);  -- pwr_baseclasses.h:15360

   --  skipped anonymous struct anon_846

  --_* Class: XttMultiView
  --    Body:  RtBody
  --    @Aref XttMultiView pwr_sClass_XttMultiView
  -- 

   type pwr_sClass_XttMultiView_Action_array is array (0 .. 24) of aliased pwr_sClass_MultiViewElement;
   type pwr_sClass_XttMultiView is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15374
      Layout : aliased pwr_tMultiViewLayoutEnum;  -- pwr_baseclasses.h:15375
      Columns : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15376
      Rows : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15377
      Action : aliased pwr_sClass_XttMultiView_Action_array;  -- pwr_baseclasses.h:15378
      Title : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:15379
      ButtonText : aliased pwr_h.pwr_tString40;  -- pwr_baseclasses.h:15380
      X : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15381
      Y : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15382
      Width : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15383
      Height : aliased pwr_h.pwr_tInt32;  -- pwr_baseclasses.h:15384
      Options : aliased pwr_tMultiViewOptionsMask;  -- pwr_baseclasses.h:15385
      ConfigurationStatus : aliased pwr_class_h.pwr_tConfigStatusEnum;  -- pwr_baseclasses.h:15386
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_XttMultiView);  -- pwr_baseclasses.h:15387

   --  skipped anonymous struct anon_847

  --_* Class: XyCurve
  --    Body:  RtBody
  --    @Aref XyCurve pwr_sClass_XyCurve
  -- 

   type pwr_sClass_XyCurve_XValue_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_XyCurve_YValue_array is array (0 .. 99) of aliased pwr_h.pwr_tFloat32;
   type pwr_sClass_XyCurve is record
      Description : aliased pwr_h.pwr_tString80;  -- pwr_baseclasses.h:15401
      XValue : aliased pwr_sClass_XyCurve_XValue_array;  -- pwr_baseclasses.h:15402
      YValue : aliased pwr_sClass_XyCurve_YValue_array;  -- pwr_baseclasses.h:15403
      XMinValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15404
      XMaxValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15405
      YMinValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15406
      YMaxValue : aliased pwr_h.pwr_tFloat32;  -- pwr_baseclasses.h:15407
      NoOfPoints : aliased pwr_h.pwr_tUInt32;  -- pwr_baseclasses.h:15408
      Update : aliased pwr_h.pwr_tBoolean;  -- pwr_baseclasses.h:15409
   end record;
   pragma Convention (C_Pass_By_Copy, pwr_sClass_XyCurve);  -- pwr_baseclasses.h:15410

   --  skipped anonymous struct anon_848

end pwr_baseclasses_h;
