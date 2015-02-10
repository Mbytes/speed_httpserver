# test_httpserver

Script para ver los tiempos de respuesta de diferentes servidores web backend 
definidos en el fichero nginx.txt

Para recuperar diferentes URL/DOMINIOS en un entornos VirtualHost

Las URLs estan definidas en el fichero url.txt

Devuelve una tabla por cada URL y servidor, mostrando velocidad de descarga de cada URL y desde
cada servidor web

---------------------------
IP         URL            SERVIDOR  SPEED       SIZE   TCONNECT  TDNS   TPRETRANS  TSTART  TOTAL
127.0.0.1  www.nginx.com  frontal   240435,000  36474  0,040     0,000  0,040      0,107   0,152
127.0.0.1  www.nginx.com  nginxssl  201960,000  36150  0,038     0,000  0,038      0,101   0,179
127.0.0.1  www.nginx.com  ngnix01   192208,000  36150  0,039     0,000  0,039      0,106   0,188
127.0.0.1  www.nginx.com  nginx04   144260,000  36474  0,038     0,000  0,038      0,174   0,253
127.0.0.1  www.nginx.com  nginx08   118584,000  35566  0,041     0,000  0,041      0,216   0,300
-------------
127.0.0.2  es.nginx.com   frontal   240793,000  35859  0,038     0,000  0,038      0,103   0,149
127.0.0.2  es.nginx.com   nginxssl  188830,000  35805  0,039     0,000  0,039      0,111   0,190
127.0.0.2  es.nginx.com   ngnix01   193291,000  35805  0,038     0,000  0,038      0,103   0,185
127.0.0.2  es.nginx.com   nginx04   196730,000  35859  0,040     0,000  0,040      0,104   0,182
127.0.0.2  es.nginx.com   nginx08   117754,000  36595  0,040     0,000  0,040      0,224   0,311
---------------------------

SIZE		Tamaño devuelto
TCONNECT	Tiempo inicio Conexion
TDNS		Tiempo resolucion DNS
TPRETRANS	Tiempo pretransferencia
TSTART		Tiempo Inicio Transferencia
TOTAL		Tiempo Total

SPEED		Velocidad estimada = SIZE/TOTAL
