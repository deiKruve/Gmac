pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package rt_qcom_msg_h is


   QCOM_FACILITY : constant := 2065;  --  rt_qcom_msg.h:4
   QCOM_u_SUCCESS : constant := 135364617;  --  rt_qcom_msg.h:5
   QCOM_u_NYI : constant := 135364628;  --  rt_qcom_msg.h:6
   QCOM_u_ALLOCQUOTA : constant := 135364636;  --  rt_qcom_msg.h:7
   QCOM_u_NOFORWARDQ : constant := 135364642;  --  rt_qcom_msg.h:8
   QCOM_u_ALRBOUND : constant := 135364650;  --  rt_qcom_msg.h:9
   QCOM_u_NOQ : constant := 135364658;  --  rt_qcom_msg.h:10
   QCOM_u_ALLRCONNECTED : constant := 135364666;  --  rt_qcom_msg.h:11
   QCOM_u_QALLREXIST : constant := 135364674;  --  rt_qcom_msg.h:12
   QCOM_u_NOLINK : constant := 135364682;  --  rt_qcom_msg.h:13
   QCOM_u_LINKDOWN : constant := 135364690;  --  rt_qcom_msg.h:14
   QCOM_u_NOTBOUND : constant := 135364698;  --  rt_qcom_msg.h:15
   QCOM_u_WEIRD : constant := 135364706;  --  rt_qcom_msg.h:16
   QCOM_u_BUFOVRUN : constant := 135364714;  --  rt_qcom_msg.h:17
   QCOM_u_INVNID : constant := 135364722;  --  rt_qcom_msg.h:18
   QCOM_u_REVLEVEL : constant := 135364730;  --  rt_qcom_msg.h:19
   QCOM_u_QEMPTY : constant := 135364738;  --  rt_qcom_msg.h:20
   QCOM_u_NOTBINDABLE : constant := 135364746;  --  rt_qcom_msg.h:21
   QCOM_u_NOTOWNED : constant := 135364754;  --  rt_qcom_msg.h:22
   QCOM_u_BOUND : constant := 135364762;  --  rt_qcom_msg.h:23
   QCOM_u_NOTALLOC : constant := 135364770;  --  rt_qcom_msg.h:24
   QCOM_u_NULLBUFF : constant := 135364778;  --  rt_qcom_msg.h:25
   QCOM_u_QTYPE : constant := 135364786;  --  rt_qcom_msg.h:26
   QCOM_u_INITED : constant := 135364794;  --  rt_qcom_msg.h:27
   QCOM_u_BADARG : constant := 135364802;  --  rt_qcom_msg.h:28
   QCOM_u_NOSUCHNODE : constant := 135364810;  --  rt_qcom_msg.h:29
   QCOM_u_NO_NODE : constant := 135364818;  --  rt_qcom_msg.h:30
   QCOM_u_TMO : constant := 135364826;  --  rt_qcom_msg.h:31
   QCOM_u_QNOTLOCAL : constant := 135364834;  --  rt_qcom_msg.h:32
   QCOM_u_NOEXPORT : constant := 135364842;  --  rt_qcom_msg.h:33
   QCOM_u_HIGHTMO : constant := 135364850;  --  rt_qcom_msg.h:34
   QCOM_u_NOTINITED : constant := 135364858;  --  rt_qcom_msg.h:35
   QCOM_u_ALLRATTACHED : constant := 135364866;  --  rt_qcom_msg.h:36
   QCOM_u_NOTATTACHABLE : constant := 135364874;  --  rt_qcom_msg.h:37
   QCOM_u_DOWN : constant := 135364880;  --  rt_qcom_msg.h:38

end rt_qcom_msg_h;
