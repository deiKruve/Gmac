
set logscale x
set xlabel "speed. rad/sec"
set ylabel " dB"
set y2label "Phase of A(jw) (degrees)"
set y2tics
#set xtics 1,2,3,4,5,8,10000
set grid xtics mxtics
set grid ytics
set grid y2tics
set style data line
#plot 'silver2.dat' using 1:4 lc var lw 2 title 'open loop response'
plot 'silver2.dat' using 1:4 title 'open loop response' axes x1y1,\
     'silver2.dat' using 1:9 title 'open loop response loaded' axes x1y1,\
     'silver2.dat' using 1:5 title 'closed loop response' axes x1y1,\
     'silver2.dat' using 1:10 title 'closed loop response loaded' axes x1y1,\
     'silver2.dat' using 1:2 title 'phase angle' axes x1y2,\
     'silver2.dat' using 1:7 title 'phase angle loaded' axes x1y2
#plot 'silver2.dat' using 1:5 title 'closed loop response'
pause -1 "Hit return to continue"
