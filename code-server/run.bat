docker run -it --name code-server -p 127.0.0.1:8080:8080 -v "/d/coder/.config:/home/coder/.config" -v "/d/coder/projects:/home/coder/project"  -u "1000:1000" -e "DOCKER_USER=affan" codercom/code-server:latest