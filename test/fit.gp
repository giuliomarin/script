set terminal png size 1280,800 enhanced font ",18"

set output "fit.png"
set grid
# set yrange [0:20]
set title "std(z) for 21_N_52C" noenhanced
set xlabel "distance [m]"
set ylabel "std(z) [m]"

f(x) = a*x*x + b*x + c
# f(x) = a + b*x + c*cos(x) + d*cos(x)**2 + e*cos(x)**3
fit f(x) '/Users/giulio/Desktop/fit' via a,b,c

plot '/Users/giulio/Desktop/fit' using 1:2 with point notitle lc rgb "blue" ,\
f(x) with line lc rgb "green" lw 2 title "fit"
