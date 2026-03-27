docker build -t deaw03 .

docker run -d -p 80:80 -p 443:443 -p 21:21 -p 2222:22 -p 60000-60010:60000-60010 --name server_deaw deaw03


https://www.sitioprimero.com


http://www.sitiosegundo.com

ssh -p 2222 icerezo2@127.0.0.1

pwd

ssh -p 2222 icerezo1@127.0.0.1

FILEZILLA

127.0.0.1 icerezo1 icerezo1
127.0.0.1 icerezo2 icerezo2

127.0.0.1 anonymous