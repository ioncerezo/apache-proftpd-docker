

1. El Dockerfile permite generar una imagen sin registro de la "deploy key" usada para descargar el contenido del FTP anónimo."

docker build -t deaw03 .


2. Cuando se monta un contenedor con el Dockerfile, cumple con los requisitos iniciales y sitios web.


docker run -d -p 80:80 -p 443:443 -p 21:21 -p 2222:22 -p 60000-60010:60000-60010 --name server_deaw deaw03

http://localhost 

https://www.sitioprimero.com

http://www.sitiosegundo.com

3. Es posible conectarse al servidor FTP desde un cliente FTP Y el FTP anónimo funciona.

En FILEZILLA:

127.0.0.1 anonymous


4. El usuario tunombre1 puede acceder vía FTP a su sitio Web pero no puede loguearse en el sistema.

127.0.0.1 icerezo1

ssh -p 2222 icerezo1@127.0.0.1



5. El usuario tunombre2 puede acceder vía SSH a actualizar su sitio Web pero no mediante FTP.

ssh -p 2222 icerezo2@127.0.0.1
pwd



En FILEZILLA:

127.0.0.1 icerezo2



6. Todos los ficheros que se piden están en un repositorio privado de github y la "Deploy key" proporcionada permite acceder a ellos.



Nota Final (Autoevaluación): 10