unset border
set view equal xy
set xtics axis nomirror
set ytics axis nomirror
set size ratio -1
#set size square
set polar
set angles degrees
set grid xtics polar 15
#set zeroaxis
#set logscale xy
set style data line
#set xrange [-2:10]
set rrange [ 0 : 10.0000 ] noreverse nowriteback

plot 'silver2.dat' using 2:3 title 'Nyquist',\
 'silver2.dat' using 7:8 title 'Nyquist loaded'
###plot 'silver2.dat' using 2:3 lc var lw 2 title 'Nyquist',\
#plot 'silver2.dat' using 7:8 lc var lw 2 title 'Nyquist loaded'

pause -1 "Hit return to continue"
