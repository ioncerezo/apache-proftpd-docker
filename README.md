# Entorno de Servidor Web y FTP con Docker

Este es un proyecto que preparé para la asignatura de Despliegue de Aplicaciones Web (DEAW). Básicamente, es una configuración lista para usar que levanta un servidor web con Apache y un servidor FTP con ProFTPD, todo empaquetado dentro de un contenedor de Docker.

La idea del proyecto era montar un entorno completo que incluyera un par de sitios web virtuales (Virtual Hosts), meterle algo de seguridad configurando certificados TLS, y dejar funcionando el acceso por FTP para gestionar los archivos.

## Qué hay en este repo

He intentado dejar todo bien organizado:

`Dockerfile` y `start.sh`: Estos son los scripts principales para construir la imagen de Docker y arrancar los servicios (Apache y ProFTPD) de golpe.

Configuraciones Web (`sitio1.conf`, `sitio2.conf`: Aquí están definidos los dos Virtual Hosts de Apache para servir las páginas.

Archivos HTML (`index1.html`, `index2.html`): Un par de páginas de inicio súper simples, una para cada sitio, para comprobar que el servidor responde bien.

Configuración FTP (`proftpd.conf`): Todo lo necesario para que el servidor FTP funcione y acepte conexiones.

Certificados y Seguridad (`sitio1.cer, sitio1.key, tls.conf, id_rsa_anonimo`): Para poder probar conexiones seguras por HTTPS y accesos por SSH/FTP, he incluido unos certificados autofirmados y un par de claves.

`/Entrega:` En esta carpeta he metido la versión final con los archivos listos para el despliegue.

## Cómo probarlo en tu equipo

Si quieres levantar este entorno para echarle un ojo, solo necesitas tener instalado Docker.

Clona este repositorio:
```
git clone https://github.com/ioncerezo/apache-proftpd-docker
cd apache-proftpd-docker
```

Crea la imagen de Docker:
```
docker build -t servidor-web-ftp .
```

Arranca el contenedor:
```
docker run -d -p 80:80 -p 443:443 -p 21:21 --name mi-servidor servidor-web-ftp
```

Nota: Asegúrate de no tener nada usando los puertos 80, 443 y 21 en tu ordenador para que no haya conflictos.
