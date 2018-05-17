# [stackfeed/toolbox](https://hub.docker.com/r/stackfeed/toolbox/) cloud tools docker image

Docker image which bundles cloud automation software used by stackfeed projects.

## Usage

The container is meant to be used with privileges of the "target" user (which is you at your workstation). This will make your experience smoother because you can map volumes with your files, create directories and files in the container and permissions of those can be on par with your host system. So **don't skip** respective *Build dependent container* section.

##  AWS toolbox

 [![](https://images.microbadger.com/badges/version/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own image badge on microbadger.com")

AWS toolbox contains the following tools:

* Terraform **0.11.7**
* kops **1.8.1**
* awscli (*latest at the time of build*)


### Build dependent container (pass the desired build arguments)

```
# Provide host UID and GID for the build
_USER=$(id -un)
_UID=$(id -u)
_GID=$(id -g)

mkdir -p /tmp/stackfeed-toolbox && cd /tmp/stackfeed-toolbox
echo "FROM stackfeed/toolbox:aws" > Dockerfile

docker build --no-cache -t stackbox:aws \
             --build-arg _USER=${_USER} \
             --build-arg _UID=${_UID} \
             --build-arg _GID=${_GID} .

cd - && rm -rf /tmp/stackfeed-toolbox
```

### Using toolbox container


```
# running:
docker run -it --name myproject -v $YOUR_PROJECT_PATH:/code stackbox:aws


# starting and attaching:
docker start myproject
docker attach myproject

# exec another shell process in the container
docker exec -it myproject bash
```

## Notes

### Toolbox volumes
When running the toolbox container we specify the **code** volume it's used to pass your project code into the toolbox container. Also the `/code` directory is set as the WORKDIR for convenience.
