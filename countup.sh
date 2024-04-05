#!/bin/sh

#shell name: countup
#This shell takes an integer as $1 and counts up from 1 to that integer.

if [ $# -eq 0 ]
then
     echo -e "Usage: countup [-o -e] number"
else
     case $1 in
          "-e" ) shift
          
                 increment=2
                 while [ $increment -le $1 ]
                 do
                      echo -e $increment '\c'
                      increment=`expr $increment + 2`
                 done
                 
                 echo -e "\n\c";;
          "-o" ) shift     

                 increment=1
                 while [ $increment -le $1 ]
                 do
                      echo -e $increment '\c'
                      increment=`expr $increment + 2`
                 done

                 echo -e "\n\c";;
          *[0-9]* ) increment=1

                    while [ $increment -le $1 ]
                    do
                         echo -e $increment '\c'
                         increment=`expr $increment + 1`
                    done
                    echo -e "\n\c";;
          * ) echo -e "Invalid Option \c"
              echo -e $1;;
     esac
fi
