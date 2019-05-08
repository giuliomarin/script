set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "/Users/giulio/Desktop/delay_hist.png"

set grid

# Add a vertical dotted line at x=0 to show centre (mean) of distribution.
set yzeroaxis

# Each bar is half the (visual) width of its x-range.
set boxwidth 100 absolute
set style fill solid 1.0 noborder

bin_width = 100;

min(x,y) = (x < y) ? x : y
bin_number(x) = floor(min(x, 5000)/bin_width)
rounded(x) = bin_width * ( bin_number(x)  ) + 50

set title "Delay per object at 0.6 m/s [2018/12/12 21:00 - 2018/12/11 11:10]\n"
set xlabel 'Time [ms]'
set ylabel 'Number of delayed objects'
set xrange [0:5100]
set x2range [0:5100*0.6]
set xtics 0,500,5100
set x2tics 0,500*0.6,5100*0.6
set x2label 'Space [mm]'
plot '/Users/giulio/Desktop/toplot' using (rounded($1)):(1) smooth frequency with boxes linecolor rgb 'blue' notitle

set output "/Users/giulio/Desktop/delay_cum.png"
a=6900.0-4500.0
cumulative_sum(x)=(a=a+1,a/6900.0)
set ylabel 'Percentage of total objects'
set yrange [0:1]
set ytics 0,0.1,1
set xrange [0:20100]
set x2range [0:20100*0.6]
set xtics 0,2000,20100
set x2tics 0,2000*0.6,20100*0.6
plot '/Users/giulio/Desktop/toplot' using 1:(cumulative_sum($1)) with lines lw 2 linecolor rgb 'blue' notitle

# set output "time.png"
# set grid
# set yrange [0:20]
#
# f(x) = a + b*x + c*cos(x) + d*cos(x)**2 + e*cos(x)**3
# fit f(x) '/Users/giulio/Desktop/interval_clean' via a,b,c,d,e
#
# plot '/Users/giulio/Desktop/interval_clean' using 1 with line notitle,\
# f(x) with line lc rgb "green" lw 2 title "fit"
