#!/bin/bash

#Test NGINX-APACHE- any webserver

#Extraemos ruta donde se ejecuta y cargamos Variables
CMD=$(echo $0 | awk -F/ '{print $NF}')
PRG=$(echo $0 | sed "s/\/${CMD}//")

#Servidores
SERVERS=${PRG}/nginx.txt

#Temporal
TMPFILE=/tmp/test_nginx.log

#URL
URLS=${PRG}/url.txt


#Log Temporal
TMPDATA=/tmp/test_nginx.$$

#Tiempo en segundos para limitar fallos CURL
CURLTOUT=10
CURLMTIME=20

function RecuperaHttp ()
{

DATA=$(curl -s --connect-timeout ${CURLTOUT} -m ${CURLMTIME} -w "\n%{speed_download}\n%{size_download}\n%{time_connect}\n%{time_namelookup}\n%{time_pretransfer}\n%{time_starttransfer}\n%{time_total}" -H "Host: $2" $1/$4)

#echo "curl -s -w \n%{speed_download}\n%{size_download}\n%{time_connect}\n%{time_namelookup}\n%{time_pretransfer}\n%{time_starttransfer}\n%{time_total} -H Host: $2 $1/$4"

VALORES=$(echo "${DATA}" | tail -7)
echo  $1 $2$4 $3 ${VALORES}

LOG=$(echo "/tmp/$1_$2.log" | tr -d '\r')
echo "${DATA}" > ${LOG}
#speed_download
#size_download
#time_connect
#time_namelookup
#time_pretransfer
#time_starttransfer
#time_total

}
ProcesaServidores ()
{
#Procesamos cada Servidores
while read LINEA
do
  
  #No procesamos comentarios
  echo "${LINEA}" | grep -q "^#" 
  if test $? -ne 0
  then 
    HOST=$(echo ${LINEA}  | awk -F: '{print $1}')
    NAMESERVER=$(echo ${LINEA}  | awk -F: '{print $2}')
    
    #Verificamos tenemos pagina profunda en vez de host
    echo "$1" | grep -q -v /
    if test $? -eq 0
    then
      # Servidor URL a recuperar
      RecuperaHttp "${HOST}" "$1" "${NAMESERVER}"
    else
      NHOST=$(echo $1 | awk -F/ '{print $1}')
      NURL=$(echo $1 | sed -e "s/${NHOST}//g")
      RecuperaHttp "${HOST}" "${NHOST}" "${NAMESERVER}" "${NURL}"
    fi
    
   #exit
  fi
done < ${SERVERS}
} #EndFunction


#########
# PRINCIPAL

#Redirigimos salida
exec 6>&1
exec > ${TMPDATA}


echo "IP URL SERVIDOR SPEED SIZE TCONNECT TDNS TPRETRANS TSTART TOTAL"

#Procesamos cada URL
while read URL
do
  #No procesamos comentarios
  echo "${URL}" | grep -q "^#" 
  if test $? -ne 0
  then 
    
    ProcesaServidores "${URL}"
    echo "-------------"
    
    #exit
  fi
done < ${URLS}

exec 1>&6 6>&-
cat  ${TMPDATA} | column -t > ${TMPFILE}
cat ${TMPFILE}
rm ${TMPDATA} 2>/dev/null
