#! /bin/sh

#compile and creat an output
gfortran -w main.f svdc.f -L/usr/local/lib -lport3 -lm -o part3 -L/usr/local/lib/gcc/9 -lgfortran

#Start program
./part3

#GNU PLOT
gnuplot main.gp