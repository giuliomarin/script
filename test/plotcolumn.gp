set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "plot.png"
set datafile separator ","
set grid
# set title 'Build time'
set xlabel '# frames tot'
set ylabel 'frame #'
# set y2label 'cmake time [s]'
set ytics
# set y2tics
#set yrange [0:1]
#set xrange [0:14150]
# set autoscale xfix
# set xtics 50
# set mxtics 5
# set grid xtics mxtics lt -1, lt 0
set key left top

#plot '/Volumes/home/giulio/time' using 2:3:(sprintf("(%d)", $1)) with labels point linecolor rgb "blue" offset char 5,0 notitle
#plot '/Users/giulio/Desktop/cmake_build_time' using 2 with linespoints lw 2 title "build time" axes x1y1,\
 '/Users/giulio/Desktop/cmake_build_time' using 1 with linespoints lw 2 title "cmake time" axes x1y2
plot '/data/tmp' using 1:2 with linespoints lw 2 title "frame1", '/data/tmp' using 1:3 with linespoints lw 2 title "frame2", '/data/tmp' using 1:4 with linespoints lw 2 title "frame3"
