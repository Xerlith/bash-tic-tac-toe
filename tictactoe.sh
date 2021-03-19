#!/bin/bash

PLANSZA=("0" "0" "0" "0" "0" "0" "0" "0" "0")
GRACZ="2"
RUCH="0"

function wyswietl {
  
  echo "Plansza"
  echo "${PLANSZA[0]} | ${PLANSZA[1]} | ${PLANSZA[2]}"
  echo "${PLANSZA[3]} | ${PLANSZA[4]} | ${PLANSZA[5]}"
  echo "${PLANSZA[6]} | ${PLANSZA[7]} | ${PLANSZA[8]}"
}

function sprawdzWygrana {
if [ $RUCH -ge 9 ]; then
  echo "Remis. Koniec gry"
  read TEMP
  reset
fi

porownajPola 0 1 2
porownajPola 3 4 5
porownajPola 6 7 8
porownajPola 0 4 8
porownajPola 2 4 6
porownajPola 0 3 6
porownajPola 1 4 7
porownajPola 2 5 8
}

function porownajPola (){
  if [[ ${PLANSZA[$1]} -ne "0" && ${PLANSZA[$1]} -eq ${PLANSZA[$2]} && ${PLANSZA[$2]} -eq ${PLANSZA[$3]} ]];
  then 
	wyswietl
	echo "Wygrywa gracz ${PLANSZA[$1]}"
	echo "Koniec gry."
	read TEMP
	reset
  fi
}

function reset {
  PLANSZA=("0" "0" "0" "0" "0" "0" "0" "0" "0")
  RUCH=0
}

function zmienGracza {
 if [ $GRACZ -eq 1 ];
 then
	GRACZ="2"
 else
	GRACZ="1"
 fi 
}

while [ $RUCH -lt "9" ]
do
  wyswietl
  zmienGracza
  echo -e "\n Które pole zaznaczyć dla zawodnika ${GRACZ}"
  read POLE

  if [ $POLE == "" ];
  then
	echo "Złe pole. Kontynuuj..."
	read TEMP
	zmienGracza
	continue
  fi
  if [ ${PLANSZA[$POLE]} != "0" ];
  then 
	echo "Zajęte pole. Kontynuuj..."
	read TEMP
	zmienGracza
	continue
  fi
  
  PLANSZA[$POLE]=$GRACZ
  ((RUCH++))
  sprawdzWygrana
done
