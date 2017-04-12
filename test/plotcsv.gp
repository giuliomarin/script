set terminal png size 1280,800 enhanced
#set terminal pngcairo size 1280,800 enhanced
set output "plot.png"
set datafile separator ","
set key autotitle columnhead
#set style fill solid
#set boxwidth 0.5
set grid
#set style data histogram
#set xlabel "Object"
#set ylabel "FN[%]"
#set yrange [-10:10]
#set xrange [-0.5:${xmax}]
#set xtics 1
#set multiplot layout 3, 1 title "regTestSummary" font ",18"
#set title "False Negative Rate"
#N = system("awk 'NR==1{print NF}' filename")
plot for [col=2:10] filename using 1:col with points
#plot filename u 4 with boxes
