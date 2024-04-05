#!/bin/sh

#shell name: addall
#This shell takes a list of integers as command line arguments and outputs the sum; the integers and sum will will be appended to the file addall.hst

if [ $# -eq 0 ]
then
     echo "Usage: addall [-h] number-list"
else
     case $1 in
          "-h" ) print=$2
                 shift
                 shift

                 items=$#

                 loop=0
                 sum=0
                 while [ $loop -lt $items ]
                 do
                      echo -e $1 '\c' >> addall.hst
                      sum=`expr $sum + $1`
                      shift
                      loop=`expr $loop + 1`
                 done

                 if [ $items -gt 0 ]
                 then
                      echo ":" $sum >> addall.hst
                      echo "The sum of the given" $items "numbers is" $sum"."
                 fi
                 
                 tail -n$print addall.hst;;
          *[0-9]* ) items=$#

                    loop=0
                    sum=0
                    while [ $loop -lt $items ]
                    do
                         echo -e $1 '\c' >> addall.hst
                         sum=`expr $sum + $1`
                         shift
                         loop=`expr $loop + 1`
                    done
                    echo ":" $sum >> addall.hst
                    echo "The sum of the given" $items "numbers is" $sum".";;
          * ) echo -e "Invalid Option \c"
              echo -e $1;;
     esac
fi
