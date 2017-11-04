set terminal png size 1280,800 enhanced font ",18"
#set terminal pngcairo size 1280,800 enhanced
set output "timediff.png"

set grid

# Add a vertical dotted line at x=0 to show centre (mean) of distribution.
set yzeroaxis

# Each bar is half the (visual) width of its x-range.
set boxwidth 0.5 absolute
set style fill solid 1.0 noborder

bin_width = 1;

bin_number(x) = floor(x/bin_width)

rounded(x) = bin_width * ( bin_number(x) + 0.0 )
set title 'Period of the bundles'
set xlabel 'Time [s]'
set ylabel 'Number of bundles'
plot '/Users/giulio/Desktop/interval_clean' using (rounded($1)):(1) smooth frequency with boxes linecolor rgb 'blue' notitle



set output "time.png"
set grid
set yrange [0:20]

f(x) = a + b*x + c*cos(x) + d*cos(x)**2 + e*cos(x)**3
fit f(x) '/Users/giulio/Desktop/interval_clean' via a,b,c,d,e

plot '/Users/giulio/Desktop/interval_clean' using 1 with line notitle,\
f(x) with line lc rgb "green" lw 2 title "fit"
