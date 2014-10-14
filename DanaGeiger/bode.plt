
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
#plot 'silver.dat' using 1:4 lc var lw 2 title 'open loop response'
plot 'silver.dat' using 1:4 title 'open loop response' axes x1y1,\
 'silver.dat' using 1:5 title 'closed loop response' axes x1y1,\
 'silver.dat' using 1:2 title 'phase angle' axes x1y2
#plot 'silver.dat' using 1:5 title 'closed loop response'
pause -1 "Hit return to continue"
