#!/bin/sh

#shell name: greetings
#This shell takes command line arguments and displays a greeting after a certain time.

       if  [ $#  -ge  2 ]
       then
         case $1 in
         *[a-z]* | *[A-Z]* ) echo "Sorry, $1 is not a number."
                            loop=y
                            while [ $loop = "y" ]
                            do
                               echo "Please enter a time in seconds \c"
                               read seconds
                               case $seconds in
                                *[a-z]* | *[A-Z]* )  continue;;
                                *) loop=n ;;
                              esac
                            done
                            sleep $seconds
                            shift
                            banner $*;;
        *[0-9]* ) sleep $1
            	 shift
            	 banner $*;;
	* ) echo "Sorry, $1 is not a number."
                            loop=y
                            while [ $loop = "y" ]
                            do
                               echo "Please enter a time in seconds \c"
                               read seconds
                               case $seconds in
                                *[a-z]* | *[A-Z]* )  continue;;
                                *) loop=n ;;
                              esac
                            done
                            sleep $seconds
                            shift
			    banner $*;;

         esac
      else
         echo "Usage: greeting seconds  word(s)"       
      fi  
