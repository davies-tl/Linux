#!/bin/sh

#shell name: phonesys
#This shell manages a phone book for the user.

if [ $# -eq 1 ]
then
     phonebook=$1 #allows for file to be entered as a command line argument
else
     echo -e "What is the name of your phonebook? \c"
     read phonebook
fi

touch $phonebook #creates new file if none exists
choice=0

while [ $choice -ne 5 ]
do
     echo "1) add an entry"
     echo "2) delete an entry"
     echo "3) list file or entry"
     echo "4) change entry"
     echo "5) exit system"
     echo "What is your choice?"

     read choice

     case $choice in
          1) loop="y"
             while [ $loop = "y" ]
             do
                  echo -e "Enter name to add: \c"
                  read name
                  echo -e "Enter phone number to add: \c"
                  read number

                  echo -e "The added entry would be \"$name:$number\""
                  echo -e "Is this correct? Type \"y\" for yes, or \"n\" for no: \c"
                  read write
                       until [ $write = "y" ] || [ $write = "n" ]
                       do
                            echo -e "Please type either \"y\" or \"n\": \c"
                            read write
                            continue
                       done

                  if [ $write = "y" ]
                  then
                       echo $name":"$number >> $phonebook #appends new contact to end of file
                       sort -t: -k1,1 -k2,2 -o $phonebook $phonebook #re-sorts the document to A-Z, 1-9
                  fi

                  echo -e "Would you like to add another? Type \"y\" for yes, or \"n\" for no: \c"
                  read loop
                       until [ $loop = "y" ] || [ $loop = "n" ]
                       do
                            echo -e "Please type either \"y\" or \"n\" \c"
                            read loop
                            continue
                       done
             done

             echo "Press ENTER for main menu"
             read
             continue;;
          2) loop="y"
             while [ $loop = "y" ]
             do
                  echo -e "Enter name to delete: \c"
                  read name
                  
                  grep -i "$name" $phonebook > output.temp #prints/redirects lines with name entered to file

                  if [ -s output.temp ] #-s option checks that file is not empty; size is not 0
                  then
                       grep -in "$name" $phonebook #prints lines with entered name from file
                  
                       echo -e "Which line will be deleted? \c"
                       read line  
                   
                       sed -n "$line"'p' "$phonebook" > output.temp #saves selected line for later output
                       echo "$( < output.temp) has been deleted!" #redirects file as command line argument for the echo command; outputs the information stored in file earlier

                       sed -i "$line"'d' "$phonebook" #deletes the selected line number
                  else
                       echo "Error: no matching entries. Please try again."
                       continue
                  fi

                  rm output.temp #removes temporary file to save space

                  echo -e "Would you like to delete another? Type \"y\" for yes, or \"n\" for no: \c"
                  read loop
                       until [ $loop = "y" ] || [ $loop = "n" ]
                       do
                            echo -e "Please type either \"y\" or \"n\": \c"
                            read loop
                            continue
                       done
             done
             
             echo "Press ENTER for main menu"
             read
             continue;;
          3) echo "1) list entree"
             echo "2) list file"
             echo -e "Please make a choice: \c"

             read subchoice
 
             case $subchoice in
                  1) echo -e "Enter name to list: \c"
                     read name
                 
                     grep -i "$name" $phonebook > output.temp

                     if [ -s output.temp ]
                     then
                          grep -in "$name" $phonebook
                     else
                          echo "Error: no matching entries. Please try again."
                          continue
                     fi
                     
                     rm output.temp;;
                  2) echo -e "In a few seconds, the whole file is about to be opened as read-only. Either use the scroll bar or arrows to navigate; once done, please type \"q\" to quit/exit the file viewer."
                     sleep 10
                     less $phonebook;;
                  *[a-z]* | *[A-Z]* | *) echo "Error: the choice entered is not recognized. Please try again."
                                 choice=0
                                 continue;;
             esac
             
             echo "Press ENTER for main menu"
             read
             continue;;
      
          4) loop="y"
             while [ $loop = "y" ]
             do
                  echo -e "Enter name to change: \c"
                  read name
                  
                  grep -i "$name" $phonebook > output.temp

                  if [ -s output.temp ]
                  then
                       grep -in "$name" $phonebook
                  
                       echo -e "Which line will be changed? \c"
                       read line  
                   
                       sed -n "$line"'p' "$phonebook" > output.temp

                       echo "1) change name"
                       echo "2) change number"
                       echo -e "Please make a choice: \c"

                       read subchoice
                       case $subchoice in
                            1) cut -d: -f2 output.temp > output.temp2 #cuts number field and saves to temp file
                               echo -e "What is the new name? \c"
                               read newname
                               echo "$newname" > output.temp1;; #gets new name and saves to other temp file
                            2) cut -d: -f1 output.temp > output.temp1 #cuts name field and saves to temp file
                               echo -e "What is the new number? \c"
                               read newnumber
                               echo "$newnumber" > output.temp2;; #gets new number and saves to other temp file
                            *[a-z]* | *[A-Z]* | *) echo "Error: the choice entered is not recognized. Please try again."
                                                   choice=0
                                                   continue;;
                       esac

                       echo -e "The new entry is \c"
                       paste -d: output.temp1 output.temp2 #pastes name and number with ':' delimiter

                       sed -i "$line"'d' "$phonebook" #delete original line before sorting

                       paste -d: output.temp1 output.temp2 >> $phonebook #saves the new entry to the file
                       sort -t: -k1,1 -k2,2 -o $phonebook $phonebook #again, sorts back to A-Z, 1-9
                  
                       rm output.tem* #wild card allows us to delete all three temporary files
                  else
                       echo "Error: no matching entries. Please try again."
                       continue
                  fi

                  echo -e "Would you like to change another? Type \"y\" for yes, or \"n\" for no: \c"
                  read loop
                       until [ $loop = "y" ] || [ $loop = "n" ]
                       do
                            echo -e "Please type either \"y\" or \"n\": \c"
                            read loop
                            continue
                       done
             done
             
             echo "Press ENTER for main menu"
             read
             continue;;
          5) break;;
          *[a-z]* | *[A-Z]* | *) echo "Error: the choice entered is not recognized. Please try again."
                                 choice=0
                                 continue;;
     esac

     read choice
done

if [ $choice -eq 5 ]
then
     exit 0
fi
