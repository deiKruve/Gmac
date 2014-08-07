#
#
#
all:
	gnat make -Ppostp.gpr
install: 
	install --owner=root --group=root ./postp /usr/local/bin
uninstall: 
	rm -f /usr/local/bin/postp
edit-post:
	emacs postp.adb ./post/ebwm1-machin.adb ./post/ebwm1-machin.ads ./post/post-scanner.adb ./post/post-scanner.ads ./post/post-parser.adb ./post/post-parser.ads ./post/post.ads ./gnatcoll/gnatcoll-traces.ads
edit-gscan:
	emacs testgscan.adb ./gmactextscan/gmactextscan.ads ./gmactextscan/gmactextscan.adb ./gmactextscan/generic_scanner.ads ./gnatcoll/gnatcoll-traces.ads
edit-silmaril:
	emacs silmatest.adb ./silmaril/silmaril-dll.adb ./silmaril/silmaril-dll.ads ./silmaril/silmaril-file_selector.adb ./silmaril/silmaril-file_selector.ads ./silmaril/silmaril-reader.adb ./silmaril/silmaril-reader.ads ./silmaril/silmaril-tasks.adb ./silmaril/silmaril-tasks.ads ./silmaril/silmaril.ads ./gmactextscan/generic_scanner.ads
edit-luthien:
	emacs ./silmaril/silmaril-dll.ads ./luthien/luthien.ads ./luthien/luthien-dll.adb ./luthien/luthien-dll.ads ./luthien/luthien-dll-bcp.adb ./luthien/luthien-dll-bcp.ads ./luthien/luthien-dll-qcp.adb ./luthien/luthien-dll-qcp.ads ./luthien/luthien-sonja4.adb ./luthien/luthien-sonja4.ads ./luthien/luthien-sonja3.adb ./luthien/luthien-sonja3.ads ./luthien/luthien-sonja3-main.adb ./luthien/luthien-sonja3-main.ads ./luthien/luthien-tasks.adb ./luthien/luthien-tasks.ads sonja3test.adb

edit-beren:
	emacs berentest.adb ./beren/berentest1.ads ./beren/berentest1.adb ./beren/beren-thread.adb ./beren/beren-thread.ads ./beren/beren-hw.adb ./beren/beren-hw.ads ./beren/beren-jog.adb ./beren/beren-jog.ads ./beren/beren-jogobj.adb ./beren/beren-jogobj.ads ./beren/beren-objects.adb ./beren/beren-objects.ads ./beren/beren.ads