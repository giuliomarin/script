# inline cat test.txt | gnuplot -e 'set terminal dumb size 250 50; plot "-" with lines'
# gnuplot -e "filename='file.txt'" /GitHub/script/test/plotcsv.gp
set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "front.png"
#set datafile separator ","
set grid
set title 'Normalized AUC per region (front)'
set xlabel 'minNumPointsPerClustersPerRegion'
set ylabel 'Normalized AUC'
set yrange [0:1]
#set xrange [0:14150]
set autoscale xfix
#set xtics 0.1
#set mxtics 2
#set key left top

#f(x) = a + b*x
#fit f(x) '/Volumes/home/giulio/time' via a,b
#avg(x) = a
#set label sprintf("y=%.2fx+%.2f", b, a) at 100,a front font ",18" offset 0,1

#plot filename using 1 with lines lc rgb 'red' title 'c++ graph',\
# filename using 2 with lines lc rgb 'green' title 'python graph',\
# filename using 3 with lines lc rgb 'blue' title 'python network'
#plot '/Volumes/home/giulio/time' using 2:3:(sprintf("(%d)", $1)) with labels point linecolor rgb "blue" offset char 5,0 notitle
plot 'front/1' using 1:2 with linespoints lw 2 title "1",\
'front/2' using 1:2 with linespoints lw 2 title "2",\
'front/3' using 1:2 with linespoints lw 2 title "3",\
'front/4' using 1:2 with linespoints lw 2 title "4",\
'front/5' using 1:2 with linespoints lw 2 title "5",\
'front/6' using 1:2 with linespoints lw 2 title "6"
#f(x) with line lc rgb "green" lw 2 title "fit"
#avg(x) with line lc rgb "green" lw 2 title "avg"


set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "back.png"
#set datafile separator ","
set grid
set title 'Normalized AUC per region (back)'
set xlabel 'minNumPointsPerClustersPerRegion'
set ylabel 'Normalized AUC'
set yrange [0:1]
#set xrange [0:14150]
set autoscale xfix
#set xtics 0.1
#set mxtics 2
#set key left top

#f(x) = a + b*x
#fit f(x) '/Volumes/home/giulio/time' via a,b
#avg(x) = a
#set label sprintf("y=%.2fx+%.2f", b, a) at 100,a front font ",18" offset 0,1

#plot filename using 1 with lines lc rgb 'red' title 'c++ graph',\
# filename using 2 with lines lc rgb 'green' title 'python graph',\
# filename using 3 with lines lc rgb 'blue' title 'python network'
#plot '/Volumes/home/giulio/time' using 2:3:(sprintf("(%d)", $1)) with labels point linecolor rgb "blue" offset char 5,0 notitle
plot 'back/1' using 1:2 with linespoints lw 2 title "1",\
'back/2' using 1:2 with linespoints lw 2 title "2"
#f(x) with line lc rgb "green" lw 2 title "fit"
#avg(x) with line lc rgb "green" lw 2 title "avg"

set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "right.png"
#set datafile separator ","
set grid
set title 'Normalized AUC per region (right)'
set xlabel 'minNumPointsPerClustersPerRegion'
set ylabel 'Normalized AUC'
set yrange [0:1]
#set xrange [0:14150]
set autoscale xfix
#set xtics 0.1
#set mxtics 2
#set key left top

#f(x) = a + b*x
#fit f(x) '/Volumes/home/giulio/time' via a,b
#avg(x) = a
#set label sprintf("y=%.2fx+%.2f", b, a) at 100,a front font ",18" offset 0,1

#plot filename using 1 with lines lc rgb 'red' title 'c++ graph',\
# filename using 2 with lines lc rgb 'green' title 'python graph',\
# filename using 3 with lines lc rgb 'blue' title 'python network'
#plot '/Volumes/home/giulio/time' using 2:3:(sprintf("(%d)", $1)) with labels point linecolor rgb "blue" offset char 5,0 notitle
plot 'right/0' using 1:2 with linespoints lw 2 title "0",\
'right/1' using 1:2 with linespoints lw 2 title "1"
#f(x) with line lc rgb "green" lw 2 title "fit"
#avg(x) with line lc rgb "green" lw 2 title "avg"
