#!/bin/ksh

#shell name: games
#This korne shell had a number of games the user can play.

let choice=1

until [ ${choice} == 4 ]
do
     clear

     echo -e "COMPUTER GAMES MENU\n"
     echo "1. CRAPS"
     echo "2. GUESSING GAME"
     echo "3. BLACKJACK"
     echo "4. EXIT"
     echo -e "\nENTER YOUR CHOICE (1, 2, 3, OR 4): \c"
     read choice

     case ${choice} in
          1 ) let loop=1
              while [ ${loop} == 1 ]
              do
                  let i=2
             
                  unset array #clears array data on repeat play
                  typeset -A array[100]

                  clear

                  echo -e "WELCOME TO THE CRAPS TABLE!\n"
                  echo "PLEASE PRESS <ENTER> TO BEGIN"
                  read enter
             
                  let dice1=RANDOM%6+1
                  let dice2=RANDOM%6+1
	          sum=$((${dice1} + ${dice2}))
                  array[1]=${sum}
                  let size=1

                  echo "YOUR FIRST ROLL IS" ${dice1} "AND" ${dice2} "=" ${sum}

                  if [ ${sum} == 7 ] || [ ${sum} == 11 ]
                  then
                       echo "CONGRATULATIONS, YOU WIN!"
                  elif [ ${sum} == 2 ] || [ ${sum} == 3 ] || [ ${sum} == 12 ]
                  then
                       echo "SORRY, YOU LOSE!"
                  else
                       echo "PRESS <ENTER> TO TRY FOR" ${sum} "AGAIN"
                       
                       let sum2=0
                       until [ ${sum} == ${sum2} ] || [ ${sum} == 7 ]
                       do                       
                            read enter
                            let dice1=RANDOM%6+1
                            let dice2=RANDOM%6+1
	                    sum2=$((${dice1} + ${dice2}))
                            array[${i}]=${sum2}
                            i=$((${i} + 1))
                            size=$((${size} + 1))
                     
                            echo "YOU ROLLED" ${dice1} "AND" ${dice2} "=" ${sum2}
                             
                            if [ ${sum} == ${sum2} ]
                            then
                                 echo -e "CONGRATULATIONS, YOU WIN!\n"
                                 size=$((${size} + 1))
                                
                                 let j=1
                                 echo -e "YOUR ROLLS WERE \c"
                                 until [ ${j} == ${size} ]
                                 do
                                      echo -e ${array[${j}]}"\c"
                                      j=$((${j} + 1))
                                      
				      if [ ${j} == ${size} ]
                                      then
                                           break
                                      fi
                                      
                                      echo -e ", \c"
                                 done
                                 break
                            elif [ ${sum2} == 7 ]
                            then
                                 echo -e "SORRY, YOU LOSE!\n"
                                 
                                 array[${i}]=${sum2}
                                 i=$((${i} + 1))
                                 size=$((${size} + 1))
                                 
                                 let j=1
                                 echo -e "YOUR ROLLS WERE \c"
                                 until [ ${j} == ${size} ]
                                 do
                                      echo -e ${array[${j}]}"\c"
                                      j=$((${j} + 1))
                                      
				      if [ ${j} == ${size} ]
                                      then
                                           break
                                      fi
                                      
                                      echo -e ", \c"
                                 done
                                 break
                            else
                                 echo "PRESS <ENTER> TO TRY FOR" ${sum} "AGAIN"
                            fi
                        done
                  fi

                  echo -e "\nDO YOU WANT TO PLAY AGAIN (Y/N)? \c" 
                  read again
                  
                  let loop2=1
                  until [ ${loop2} != 1 ]
                  do
                       case "${again}" in
                            "Y" ) let loop2=0;;
                            "y" ) let loop2=0;;
                            "YES" ) let loop2=0;;
                            "yes" ) let loop2=0;;
                            "Yes" ) let loop2=0;;
                            "N" ) loop=$((${loop} - 1))
                                  let loop2=0;;
                            "n" ) loop=$((${loop} - 1))
                                  let loop2=0;;
                            "NO" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            "no" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            "No" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            * ) echo -e "THE CHOICE ENTERED IS NOT RECOGNIZED, PLEASE TRY AGAIN: \c"
                                read again;;
                       esac
                  done
             done;;
          2 ) let loop=1
              while [ ${loop} == 1 ]
              do
                  clear

                  echo -e "WELCOME TO THE GUESSING GAME!\n"
                  echo "PRIZES:"
                  echo "1. COLOR TV"
                  echo "2. REFRIGERATOR"
                  echo "3. AUTO"
                  echo -e "\nPLEASE ENTER YOUR CHOICE (1, 2, OR 3): \c"
                  read enter

                  if [ ${enter} == 1 ]
                  then
                       let price=RANDOM%301+200
                  elif [ ${enter} == 2 ]
                  then
                       let price=RANDOM%301+600
                  elif [ ${enter} == 3 ]
                  then
                       let price=RANDOM%10001+5000
                  else
                       clear
                       echo "THE CHOICE ENTERED IS NOT RECOGNIZED. PLEASE TYPE <ENTER> TO TRY AGAIN."
                       read
                       continue
                  fi

                  clear
                  echo "YOU HAVE ONE MINUTE TO GUESS THE PRICE OF THE PRIZE."
                  echo -e "\nWHAT IS YOUR FIRST GUESS: \c"
                  read guess
                           
                  case ${guess} in #catches anything but digits
                       *[0-9]* ) ;;
                       * ) echo "ERROR: MUST ENTER A NUMBER, PLEASE TRY AGAIN:"
                           read guess;;
                  esac

                  let timer=$SECONDS

                  until [ ${guess} -eq ${price} ]
                  do
                       while [ ${guess} -gt ${price} ]
                       do
                            echo -e "GUESS LOWER? \c"
                            read guess

                            case ${guess} in
                                 *[0-9]* ) ;;
                                 * ) echo "ERROR: MUST ENTER A NUMBER, PLEASE TRY AGAIN:"
                                     read guess;;
                            esac

                            let timer2=$SECONDS
                            check=$((${timer2} - ${timer}))

                            if [ ${check} -ge 60 ]
                            then
                                 echo -e "\nSORRY, YOU HAVE RUN OUT OF TIME!"
                                 echo "THE PRICE WAS" ${price}
                                 let guess=-1
                                 break
                            fi
                       done

                       if [[ ${guess} = -1 ]]
                       then
                           break
                       fi

                       while [ ${guess} -lt ${price} ]
                       do
                            echo -e "GUESS HIGHER? \c"
                            read guess

                            case ${guess} in
                                 *[0-9]* ) ;;
                                 * ) echo "ERROR: MUST ENTER A NUMBER, PLEASE TRY AGAIN:"
                                     read guess;;
                            esac

                            let timer2=$SECONDS
                            check=$((${timer2} - ${timer}))
                            if [ ${check} -ge 60 ]
                            then
                                 echo -e "\nSORRY, YOU HAVE RUN OUT OF TIME!"
                                 echo "THE PRICE WAS" ${price}
                                 let guess=-1
                                 break
                            fi
                       done

                       if [[ ${guess} = -1 ]]
                       then
                           break
                       fi
                  done

                  if [ ${guess} == ${price} ]
                  then
                       echo -e "\nCONGRATULATIONS, YOU WIN!"
                       echo "THE PRICE WAS" ${price}
                  fi

                  echo -e "\nDO YOU WANT TO PLAY AGAIN (Y/N)? \c" 
                  read again
                  
                  let loop2=1
                  until [ ${loop2} != 1 ]
                  do
                       case "${again}" in
                            "Y" ) let loop2=0;;
                            "y" ) let loop2=0;;
                            "YES" ) let loop2=0;;
                            "yes" ) let loop2=0;;
                            "Yes" ) let loop2=0;;
                            "N" ) let loop=0
                                  let loop2=0;;
                            "n" ) let loop=0
                                  let loop2=0;;
                            "NO" ) let loop=0
                                   let loop2=0;;
                            "no" ) let loop=0
                                   let loop2=0;;
                            "No" ) let loop=0
                                   let loop2=0;;
                            * ) echo -e "THE CHOICE ENTERED IS NOT RECOGNIZED, PLEASE TRY AGAIN: \c"
                                read again;;
                       esac
                  done
             done;;
          3 ) unset array
              typeset -a array=("ACE" 2 3 4 5 6 7 8 9 10 "JACK" "QUEEN" "KING" "ACE" 2 3 4 5 6 7 8 9 10 "JACK" "QUEEN" "KING" "ACE" 2 3 4 5 6 7 8 9 10 "JACK" "QUEEN" "KING" "ACE" 2 3 4 5 6 7 8 9 10 "JACK" "QUEEN" "KING")
              let loop=1

              while [ ${loop} == 1 ]
              do
                  clear

                  echo -e "WELCOME TO THE BLACKJACK TABLE!\n"
                  echo -e "PLEASE PRESS <ENTER> TO BEGIN \c"
                  read enter
             
                  let card1=0
                  while [[ ${card1} = 0 ]]
                  do
                       let index=RANDOM%52+1 
                       card1=${array[${index}]}
                       array[${index}]=0
                  done

                  case ${card1} in
                       "ACE" ) let player1=11;;
                       "JACK" ) let player1=10;;
                       "QUEEN" ) let player1=10;;
                       "KING" ) let player1=10;;
                       * ) player1=$((${card1}));;
                  esac

                  let card2=0
                  while [[ ${card2} = 0 ]]
                  do
                       let index=RANDOM%52+1 
                       card2=${array[${index}]}
                       array[${index}]=0
                  done

                  case ${card2} in
                       "ACE" ) let player2=11;;
                       "JACK" ) let player2=10;;
                       "QUEEN" ) let player2=10;;
                       "KING" ) let player2=10;;
                       * ) player2=$((${card2}));;
                  esac

                  sumP=$((${player1} + ${player2}))

                  let card3=0
                  while [[ ${card3} = 0 ]]
                  do
                       let index=RANDOM%52+1 
                       card3=${array[${index}]}
                       array[${index}]=0
                  done

                  case ${card3} in
                       "ACE" ) let dealer1=11;;
                       "JACK" ) let dealer1=10;;
                       "QUEEN" ) let dealer1=10;;
                       "KING" ) let dealer1=10;;
                       * ) dealer1=$((${card3}));;
                  esac

                  let card4=0
                  while [[ ${card4} = 0 ]]
                  do
                       let index=RANDOM%52+1 
                       card4=${array[${index}]}
                       array[${index}]=0
                  done

                  case ${card4} in
                       "ACE" ) let dealer2=11;;
                       "JACK" ) let dealer2=10;;
                       "QUEEN" ) let dealer2=10;;
                       "KING" ) let dealer2=10;;
                       * ) dealer2=$((${card4}));;
                  esac

                  sumD=$((${dealer1} + ${dealer2}))

                  echo -e "\nYOUR CARDS:" ${card1} "AND" ${card2}
                  if [ ${sumP} -eq ${sumD} ] && [ ${sumP} -eq 21 ]
                  then
                       echo "IT IS A TIE!"
                       echo "DEALER'S CARDS:" ${card3} "AND" ${card4}
                  elif [ ${sumP} -eq 21 ]
                  then
                       echo "CONGRATULATIONS, YOU WON!"
                  elif [ ${sumD} -eq 21 ]
                  then
                       echo "SORRY, YOU LOSE!"
                       echo "DEALER'S CARDS:" ${card3} "AND" ${card4}
                  elif [ ${sumP} -gt 21 ]
                  then
                       echo "BUST! SORRY, YOU LOSE!"
                  elif [ ${sumD} -gt 21 ]
                  then
                       echo "DEALER BUSTS! CONGRATULATIONS, YOU WIN!"
                       echo "DEALER'S CARDS:" ${card3} "AND" ${card4}
                  else
                       let loop2=1
                       until [[ ${loop2} != 1 ]]
                       do
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                            echo -e "\nDO YOU WANT ANOTHER CARD (Y/N)? \c"
                            read another

                            case "${another}" in
                                 "Y" ) let check=1;;
                                 "y" ) let check=1;;
                                 "YES" ) let check=1;;
                                 "yes" ) let check=1;;
                                 "Yes" ) let check=1;;
                                 "N" ) check=0
                                       let loop2=0;;
                                 "n" ) check=0
                                       let loop2=0;;
                                 "NO" ) check=0
                                        let loop2=0;;
                                 "no" ) check=0
                                        let loop2=0;;
                                 "No" ) check=0
                                        let loop2=0;;
                                 * ) echo -e "THE CHOICE ENTERED IS NOT RECOGNIZED, PLEASE TRY AGAIN: \c"
                                     continue;;
                            esac

                            if [ ${check} -eq 1 ]
                            then
                                 let card5=0
                                 while [[ ${card5} = 0 ]]
                                 do
                                      let index=RANDOM%52+1 
                                      card5=${array[${index}]}
                                      array[${index}]=0
                                 done

                                 echo -e "\nYOUR NEW CARD IS:" ${card5} 
                                 case ${card5} in
                                      "ACE" ) echo "DO YOU WANT THE ACE TO COUNT AS ONE (1) OR ELEVEN (11)?"
                                              read ace

                                              let loop3=1
                                              until [[ ${loop3} != 1 ]]
                                              do
                                                   if [[ ${ace} = 1 ]]
                                                   then
                                                        let add=1
                                                        let loop3=0
                                                   elif [[ ${ace} = 11 ]]
                                                   then
                                                        let add=11
                                                        let loop3=0
                                                   else
                                                        echo -e "THE CHOICE ENTERED IS NOT RECOGNIZED, PLEASE TRY AGAIN: \c"
                                                        read ace
                                                   fi
                                              done;;
                                      "JACK" ) let add=10;;
                                      "QUEEN" ) let add=10;;
                                      "KING" ) let add=10;;
                                      * ) add=$((${card5}));;
                                 esac
                       
                                 sumP=$((${sumP} + ${add}))
                                 if [ ${sumP} -eq 21 ]
                                 then
                                      break
                                 elif [ ${sumP} -gt 21 ]
                                 then
                                      break
                                 else
                                      continue
                                 fi
                            fi
                       done

                       until [ ${sumD} -gt 17 ]
                       do
                            let card6=0
                            while [[ ${card6} = 0 ]]
                            do
                                 let index=RANDOM%52+1 
                                 card6=${array[${index}]}
                                 array[${index}]=0
                            done

                            case ${card6} in
                                 "ACE" ) let add=1;;
                                 "JACK" ) let add=10;;
                                 "QUEEN" ) let add=10;;
                                 "KING" ) let add=10;;
                                 * ) add=$((${card6}));;
                            esac

                            sumD=$((${sumD} + ${add}))

                            if [ ${sumD} -eq 21 ]
                            then
                                 break
                            elif [ ${sumD} -gt 21 ]
                            then
                                 break
                            else
                                 continue
                            fi
                       done

                       if [ ${sumP} -eq 21 ]
                       then
                            echo -e "\nCONGRATULATIONS, YOU WON!"
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                       elif [ ${sumP} -gt 21 ]
                       then
                            echo -e "\nBUST! SORRY, YOU LOSE!"
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                       elif [ ${sumD} -eq 21 ]
                       then
                            echo -e "\nSORRY, YOU LOSE!"
                            echo "DEALER'S CARDS' TOTAL VALUE EQUALS:" ${sumD}
                       elif [ ${sumD} -gt 21 ]
                       then
                            echo -e "\nDEALER BUSTS! CONGRATULATIONS, YOU WIN!"
                            echo "DEALER'S CARDS' TOTAL VALUE EQUALS:" ${sumD}
                       elif [ ${sumP} -eq ${sumD} ]
                       then
                            echo -e "\nIT IS A TIE!"
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                            echo "DEALER'S CARDS' TOTAL VALUE EQUALS:" ${sumD}
                       elif [ ${sumP} -gt ${sumD} ]
                       then
                            echo -e "\nCONGRATULATIONS, YOU WON!"
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                            echo "DEALER'S CARDS' TOTAL VALUE EQUALS:" ${sumD}
                       else
                            echo -e "\nSORRY, YOU LOSE!"
                            echo "YOUR CARDS' TOTAL VALUE EQUALS:" ${sumP}
                            echo "DEALER'S CARDS' TOTAL VALUE EQUALS:" ${sumD}
                       fi
                  fi

                  echo -e "\nDO YOU WANT TO PLAY AGAIN (Y/N)? \c" 
                  read again
                  
                  let loop2=1
                  until [ ${loop2} != 1 ]
                  do
                       case "${again}" in
                            "Y" ) let loop2=0;;
                            "y" ) let loop2=0;;
                            "YES" ) let loop2=0;;
                            "yes" ) let loop2=0;;
                            "Yes" ) let loop2=0;;
                            "N" ) loop=$((${loop} - 1))
                                  let loop2=0;;
                            "n" ) loop=$((${loop} - 1))
                                  let loop2=0;;
                            "NO" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            "no" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            "No" ) loop=$((${loop} - 1))
                                   let loop2=0;;
                            * ) echo -e "THE CHOICE ENTERED IS NOT RECOGNIZED, PLEASE TRY AGAIN: \c"
                                read again;;
                       esac
                  done
             done;;
         4 ) clear
             exit;;
         * ) clear
             echo "THE CHOICE ENTERED IS NOT RECOGNIZED. PLEASE TYPE <ENTER> TO TRY AGAIN."
             read;;
     esac
done
