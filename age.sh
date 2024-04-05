#!/bin/sh

#shell name: age
#This shell takes the name and age of a user and displays a message accordingly.

name=0
case $1 in
     *[a-z]* | *[A-Z]* ) name=$1;;
     * ) echo "First command line argument must be a name. Please try again."
         read name
esac
echo -n "$name, for a "
if [ $2 -ge 60 ]
then
  echo -n "senior citizen"
elif [ $2 -ge 20 ]
then
  echo -n "mature adult"
else
  echo -n "teenager"
fi
echo ", you are very nice!"
