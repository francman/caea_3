#! /bin/sh

#compile and creat an output
gfortran main.f -L/usr/local/lib -lport3 -lm -o part1 -L/usr/local/lib/gcc/9 -lgfortran
