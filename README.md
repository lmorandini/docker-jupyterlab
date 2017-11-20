# docker-jupyterlab

A Docker container for [Jupyterlab](https://github.com/jupyterlab/jupyterlab) with Python 3 and  R notebooks.


## Build instructions 

* Clone the repository `git clone git@github.com:lmoran/docker-jupyterlab.git`
* Build the image `docker build -t jupyterlab:latest docker-jupyterlab`


## Run instructions 

Create container with a password ot be used for authentiaction (it returns the contained ID):
`docker create --env JL_PASSWD=<password> jupyterlab:0.2.0`

FIXME: the password setting mechanism does not work, hence JL_PASSWD could be left empty, disabling authentication, as in:
`docker create --env JL_PASSWD= jupyterlab:0.2.0`

Start the container using the container ID grabbed from the previous command:
`docker start <container id>`

The IP address used by the container can be grabbed with:
`docker inspect <container id> | grep IPAddress`

The JupyterLab can now be enjoyed by pointing your browser at:
`http://<ip address>:8888/lab`

To modify a running container, a shell can be opened with:
`docker exec -ti <container id> /bin/bash`
