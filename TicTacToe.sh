#!/bin/bash

declare -a ARRAY
COUNT=0

# Initialize the board
for (( n=0; n<=8; n++ ))
do
  ARRAY[$n]=$n
done

TURN="X"

# Game loop
while :
do
  clear
  echo -e "  ${ARRAY[0]} | ${ARRAY[1]} | ${ARRAY[2]}"
  echo -e " ---+---+---"
  echo -e "  ${ARRAY[3]} | ${ARRAY[4]} | ${ARRAY[5]}"
  echo -e " ---+---+---"
  echo -e "  ${ARRAY[6]} | ${ARRAY[7]} | ${ARRAY[8]}"
  echo -e "\nIt's $TURN's turn. \nEnter the number of the cell: "
  
  read CELL

  if (! ((CELL >= 0 && CELL <= 8)) ) || ( [ ${ARRAY[CELL]} = "X" ] || [ ${ARRAY[CELL]} = "O" ] ); then
    echo -e "Invalid cell number or the cell is already occupied. Try again. \n"
    sleep 2
    continue
  fi

  ARRAY[CELL]=$TURN
  ((COUNT+=1))

  if [ "$TURN" = "X" ]; then
    TURN="O"
  else
    TURN="X"
  fi

  # Check for win condition
  for LINE in 012 345 678 036 147 258 048 246; do
    pos1=${ARRAY[${LINE:0:1}]}
    pos2=${ARRAY[${LINE:1:1}]}
    pos3=${ARRAY[${LINE:2:1}]}

    CHECK=$pos1$pos2$pos3
    if [ "$CHECK" = "XXX" ]; then
      echo "Player X wins!"
      exit 0
    fi
    if [ "$CHECK" = "OOO" ]; then
      echo "Player O wins!"
      exit 0
    fi
  done

  if [ $COUNT -eq 9 ]; then
    echo "The game is a draw."
    exit 0
  fi
done