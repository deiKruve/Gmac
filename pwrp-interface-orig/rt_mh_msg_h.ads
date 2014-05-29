pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package rt_mh_msg is


   MH_FACILITY         : constant := 2238;  --  rt_mh_msg.h:4
   MH_u_SUCCESS        : constant := 146702345;  --  rt_mh_msg.h:5
   MH_u_NOMESSAVAIL    : constant := 146702352;  --  rt_mh_msg.h:6
   MH_u_NOSUCHQCOMTYPE : constant := 146702360;  --  rt_mh_msg.h:7
   MH_u_NOSUCHQCOMSUBT : constant := 146702368;  --  rt_mh_msg.h:8
   MH_u_QCOMALLOCMSG   : constant := 146702378;  --  rt_mh_msg.h:9
   MH_u_QCOMBINDQ      : constant := 146702386;  --  rt_mh_msg.h:10
   MH_u_QCOMCONAPPL    : constant := 146702394;  --  rt_mh_msg.h:11
   MH_u_QCOMCONQ       : constant := 146702402;  --  rt_mh_msg.h:12
   MH_u_QCOMCREQ       : constant := 146702410;  --  rt_mh_msg.h:13
   MH_u_QCOMFREEMSG    : constant := 146702418;  --  rt_mh_msg.h:14
   MH_u_QCOMGETMSG     : constant := 146702426;  --  rt_mh_msg.h:15
   MH_u_QCOMGETQID     : constant := 146702434;  --  rt_mh_msg.h:16
   MH_u_QCOMPUTMSG     : constant := 146702442;  --  rt_mh_msg.h:17
   MH_u_QCOMRCVMSG     : constant := 146702450;  --  rt_mh_msg.h:18
   MH_u_QCOMSENDMSG    : constant := 146702458;  --  rt_mh_msg.h:19
   MH_u_FREEMSG        : constant := 146702466;  --  rt_mh_msg.h:20
   MH_u_NOMESSSEND     : constant := 146702472;  --  rt_mh_msg.h:21
   MH_u_ERRMH          : constant := 146702482;  --  rt_mh_msg.h:22
   MH_u_ERRINIT        : constant := 146702490;  --  rt_mh_msg.h:23
   MH_u_GETLOCALOBJ    : constant := 146702499;  --  rt_mh_msg.h:24
   MH_u_NOSUCHDESC     : constant := 146702506;  --  rt_mh_msg.h:25
   MH_u_ERRCREDB       : constant := 146702514;  --  rt_mh_msg.h:26
   MH_u_ERRGDHINI      : constant := 146702522;  --  rt_mh_msg.h:27
   MH_u_ERRGETLIST     : constant := 146702530;  --  rt_mh_msg.h:28
   MH_u_ERRGETPOINTER  : constant := 146702538;  --  rt_mh_msg.h:29
   MH_u_ERRGETOBJID    : constant := 146702546;  --  rt_mh_msg.h:30
   MH_u_ERRGETNEXT     : constant := 146702554;  --  rt_mh_msg.h:31
   MH_u_ERRCREMESS     : constant := 146702562;  --  rt_mh_msg.h:32
   MH_u_ERRSENDMESS    : constant := 146702570;  --  rt_mh_msg.h:33
   MH_u_ERRRECMESS     : constant := 146702578;  --  rt_mh_msg.h:34
   MH_u_ERRWAITANY     : constant := 146702586;  --  rt_mh_msg.h:35
   MH_u_ERRDELMESS     : constant := 146702594;  --  rt_mh_msg.h:36
   MH_u_ERRASCEF       : constant := 146702602;  --  rt_mh_msg.h:37
   MH_u_ALARMLSTFULL   : constant := 146702610;  --  rt_mh_msg.h:38
   MH_u_ERRLSTLOCATE   : constant := 146702618;  --  rt_mh_msg.h:39
   MH_u_ALLRCON        : constant := 146702626;  --  rt_mh_msg.h:40
   MH_u_NOTCONN        : constant := 146702635;  --  rt_mh_msg.h:41
   MH_u_NOOUTUNIT      : constant := 146702642;  --  rt_mh_msg.h:42
   MH_u_ERROR          : constant := 146702650;  --  rt_mh_msg.h:43
   MH_u_LOG            : constant := 146702659;  --  rt_mh_msg.h:44
   MH_u_NOSPACE        : constant := 146702666;  --  rt_mh_msg.h:45
   MH_u_APPLQUOTA      : constant := 146702674;  --  rt_mh_msg.h:46
   MH_u_BADPARAM       : constant := 146702682;  --  rt_mh_msg.h:47
   MH_u_NOAPPL         : constant := 146702690;  --  rt_mh_msg.h:48
   MH_u_EVENTERR       : constant := 146702698;  --  rt_mh_msg.h:49
   MH_u_PROGERR        : constant := 146702706;  --  rt_mh_msg.h:50
   MH_u_NYI            : constant := 146702714;  --  rt_mh_msg.h:51
   MH_u_NONEXALARM     : constant := 146702722;  --  rt_mh_msg.h:52
   MH_u_ALLRET         : constant := 146702731;  --  rt_mh_msg.h:53
   MH_u_NOTOWNED       : constant := 146702738;  --  rt_mh_msg.h:54
   MH_u_VERSION        : constant := 146702746;  --  rt_mh_msg.h:55
   MH_u_SYSTEMID       : constant := 146702754;  --  rt_mh_msg.h:56
   MH_u_NOMOREMSG      : constant := 146702763;  --  rt_mh_msg.h:57
   MH_u_NOSUCHOBJ      : constant := 146702770;  --  rt_mh_msg.h:58
   MH_u_HANDLERDOWN    : constant := 146702778;  --  rt_mh_msg.h:59
   MH_u_XDRFAILED      : constant := 146702786;  --  rt_mh_msg.h:60
   MH_u_XDRUNEXPECT    : constant := 146702794;  --  rt_mh_msg.h:61
   MH_u_TMO            : constant := 146702802;  --  rt_mh_msg.h:62
   MH_u_NOTMNTCLEAN    : constant := 146702808;  --  rt_mh_msg.h:63
   MH_u_IOSTALLED      : constant := 146702820;  --  rt_mh_msg.h:64

end rt_mh_msg;
