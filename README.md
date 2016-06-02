To start the published container:

    sudo apt-get install docker.io
    sudo docker run -it turiphro/artis-docker-demo

Alternatively, build the container from the Dockerfile:

    sudo apt-get install docker.io
    sudo docker build -t artis .
    sudo docker run -it artis
