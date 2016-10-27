# docker-jupyterlab

A Docker container for [Jupyterlab](https://github.com/jupyterlab/jupyterlab) with Python 3 and  R notebooks.


## Build instructions 

* Clone the repository `git clone git@github.com:lmoran/docker-jupyterlab.git`
* Build the image `docker build -t jupyterlab:latest docker-jupyterlab`


## Run instructions 

Create container:
`docker create jupyterlab:latest`

Grab the container ID:
`docker ps --all | grep jupyterlab`

Start the container using the container ID grabbed from the previous command:
`docker start <container id>`

The IP address used by the container can be grabbed with:
`docker inspect <container id> | grep IPAddress`

The JupyterLab can now be enjoyed by pointing your browser at:
`http://<ip address>:8888/lab`

To modify the running container, a shell can be opened with:
`docker exec -ti <container id> /bin/bash`
