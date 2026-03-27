# DEAW03 TareaEvaluativa2 - Alternativas de acceso a un servidor Apache

docker build -t deaw03 .
docker run -d -p 80:80 -p 443:443 -p 21:21 -p 2222:22 -p 60000-60010:60000-60010 --name server_deaw deaw03
