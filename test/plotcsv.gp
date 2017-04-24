set terminal png size 1280,800 enhanced
#set terminal pngcairo size 1280,800 enhanced
set output "plot.png"
set datafile separator ","
set grid
plot filename using 7:6 with lines
