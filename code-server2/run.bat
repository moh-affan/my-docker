docker run -d --name=code-server-2 -e PUID=1000 -e PGID=1000 -e TZ=Asia/Jakarta -p 8443:8443 -v /d/coder2:/config lscr.io/linuxserver/code-server:latest