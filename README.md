# docker-jupyterlab

A Docker container for [Jupyterlab](https://github.com/jupyterlab/jupyterlab) with Python 3 and  R notebooks.


## Build instructions 

* Clone the repository `git clone git@github.com:lmoran/docker-jupyterlab.git`
* Build the image `docker build -t jupyterlab:latest docker-jupyterlab`


## Run instructions 

Create container with a password ot be used for authentiaction (it returns the contained ID):
`docker create --env JL_PASSWD=<password> jupyterlab:0.2.1`

FIXME: the password setting mechanism does not work, hence JL_PASSWD could be left empty, disabling authentication, as in:
`docker create --env JL_PASSWD= jupyterlab:0.2.1`

Start the container using the container ID grabbed from the previous command:
`docker start <container id>`

The IP address used by the container can be grabbed with:
`docker inspect <container id> | grep IPAddress`

The JupyterLab can now be enjoyed by pointing your browser at:
`http://<ip address>:8888/lab`

To modify a running container, a shell can be opened with:
`docker exec -ti <container id> /bin/bash`


# Securing the container via BASIC auth

Generate password hashes with
`mkpasswd -m sha-512 <passwd>`

...substitute the hashes below (and the back-end IP address), and run it:
```
sudo apt-get install -y haproxy -y
HAPCFG=/etc/haproxy/haproxy.cfg
echo 'userlist UsersFor_Ops' | sudo tee --append ${HAPCFG}
echo '   group AdminGroup users lmorandini,pgreenwood' | sudo tee --append ${HAPCFG}
echo '   user lmorandini password $6$Bo2DvCbJfY6s$Gun2cFDvJL70wJZVszh9amgTqbX0vPfjB8JbF.6zT6.qQ8XP4mo2JkbIWCy75CMqJQBvWQmhZ1Yp3n4cTqahF0'  | sudo tee --append ${HAPCFG}
echo '   user pgreenwood password $6$YBvUSvOkYDmP$iWXpO2OSd.7dbl8NOrJfuhk7OTqVeobrNw8z5inIwJFR9U6Q2RIA1ip1YetTsJOYI7Dm5j7pyuzac7BBmwg8b/'  | sudo tee --append ${HAPCFG}
echo 'frontend http' | sudo tee --append ${HAPCFG} 
echo '   bind 0.0.0.0:8889' | sudo tee --append ${HAPCFG}
echo '   use_backend jupyterlab' | sudo tee --append ${HAPCFG}
echo 'backend jupyterlab' | sudo tee --append ${HAPCFG} 
echo '   server localhost 172.17.0.2:8888'  | sudo tee --append ${HAPCFG} 
echo '   acl AuthOkay_Ops http_auth(UsersFor_Ops)'  | sudo tee --append ${HAPCFG}
echo '   http-request auth realm MyAuthRealm if !AuthOkay_Ops'  | sudo tee --append ${HAPCFG}
sudo service haproxy restart
```
