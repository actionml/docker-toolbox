
# [stackfeed/toolbox](https://hub.docker.com/r/stackfeed/toolbox/) cloud tools docker image

Docker image which bundles cloud automation software used by stackfeed projects.

## Usage

The container is meant to be used with privileges of the "target" user (which is you at your workstation). This will make your experience smoother because you can map volumes with your files, create directories and files in the container and permissions of those can be on par with your host system. So **don't skip** respective *Build dependent container* section.

##  AWS toolbox

 [![](https://images.microbadger.com/badges/version/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own image badge on microbadger.com")

AWS toolbox contains the following tools:

* Terraform **0.11.3**
* kops **1.8.1**
* awscli (*latest at the time of build*)


### Build dependent container (pass the desired build arguments)

```
mkdir -p /tmp/stackfeed-toolbox && cd /tmp/stackfeed-toolbox
echo "FROM stackfeed/toolbox:aws" > Dockerfile

# Change arguments to meet your specific settings!
docker build -t stackbox:aws \
             --build-arg OBUSER=denz \
             --build-arg OBUID=1000 .

cd - && rm -rf /tmp/stackfeed-toolbox
```

### Using toolbox container


```
# running:
docker run -it --name myboxenv1 -v $HOME:/host stackbox:aws


# starting and attaching:
docker start myboxenv1
docker attach myboxenv1

# exec another shell process in the container
docker exec -it myboxenv1 bash
```

## Notes

### Toolbox volumes
When running the toolbox container we specify volume `$HOME:/host`, so that host user's home directory is mapped to the `/host` directory in the container. **DO NOT TRY** *to map user's host home directory to user's container home directory*! This could give you some ease of use (as I supposed), but in fact it will just mess up your container's user environment.
