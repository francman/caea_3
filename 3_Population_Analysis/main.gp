set term postscript eps enhanced "Helvetica" 18
set ylabel "Scaled Population x 100,000"
set xlabel "Scaled Year x 10"
set xrange [18.90:20.10]
set yrange [50:300]
set output 'output.eps'
plot 'svd.dat' using 1:2 title "model" w l, \
'svd.dat' using 1:3 title "data" ;
