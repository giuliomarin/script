# gnuplot /Users/giulio/git/script/test/plottimestamp.gp
# ssh-cluster 4 "cat ~/log_internet" | awk '{print $1,$2,$4}'> /Users/giulio/Desktop/log_internet_cluster ; gnuplot /Users/giulio/git/script/test/plottimestamp.gp
set terminal png size 1280,800 enhanced font ",10"
# set terminal pngcairo size 1280,800 enhanced
set output "plot.png"
#set datafile separator ","


# set style data fsteps
set xdata time
set timefmt "%Y/%m/%d-%H:%M"
set xrange ["2018/11/08-12:00":"2018/11/12-23:59"]
# set autoscale xfix
set format x "%Y/%m/%d\n%H:%M"
set timefmt "%Y_%m_%d_%H_%M_%S"
set ylabel "Speed [Mbit/s]"
set xlabel "Date"
set grid
set xtics 43200
set mxtics 12
# plot '/Users/giulio/Desktop/log_internet_cluster' using 1:2 with linespoints linecolor rgb "blue" title "Download",\
# '/Users/giulio/Desktop/log_internet_cluster' using 1:3 with linespoints linecolor rgb "red" title "Upload"
plot '/Users/giulio/Desktop/log_internet_cluster' using 1:3 with linespoints linecolor rgb "blue" notitle
