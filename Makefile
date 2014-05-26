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