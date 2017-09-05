# [stackfeed/toolbox](https://hub.docker.com/r/stackfeed/toolbox/) cloud tools docker image

Docker image which bundles cloud automation software used by stackfeed projects.

## Usage

The container is meant to be used with privileges of the "target" user (which is you at you workstation). This will make your experience smoother because you can map volumes with your files, create directories and files in the container and these permissions can be on par with your system. So **don't skip** respective *Build dependent container* section.

##  AWS toolbox

 [![](https://images.microbadger.com/badges/version/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/stackfeed/toolbox:aws.svg)](https://microbadger.com/images/stackfeed/toolbox:aws "Get your own image badge on microbadger.com")

AWS toolbox contains the following tools:

* Terraform **0.10.3**
* kops **1.7.0** (*latest at the time of build*)
* awcli (*latest at the time of build*)


### Build dependent container (pass the desired build arguments)

```
mkdir -p /tmp/stackfeed-toolbox && cd /tmp/stackfeed-toolbox
echo "FROM stackfeed/toolbox:aws" > Dockerfile

# Change the build argument values as you need!
docker build -t stackbox \
    --build-arg OBUSER=denz \
    --build-arg OBUID=1000 .

cd - && rm -rf /tmp/stackfeed-toolbox
```
