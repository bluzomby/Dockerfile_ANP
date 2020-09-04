# ANP Dockerfile
This Dockerfile creates an Ubuntu 18.04 container with the required tools and network settings and compiles the project.
## DISCLAIMER
I assume no responsibility. Run at your own risk. Has not been tested extensively.
## Instructions
You obviously need Docker installed for any of this to work.

First, we need to make a Docker network so we can use a bridge. 

```bash
docker network create \
-o "com.docker.network.bridge.name"="anp_bridge" \
anp_network
```

Next, move the Dockerfile into your ANP project directory and build the container.

```bash
docker build -t anp .
```

Finally, we can run the container.

```bash
docker run -it \
--network=anp_network \
--privileged \
--cap-add=NET_ADMIN \
--device /dev/net/tun:/dev/net/tun \
--rm \
--name anp-running anp 
```

This creates a container and runs the setup scrips described in the README of the ANP code. It should drop you into a bash session where you can run the anp server or whatever you want to do.

If you need to open another terminal in the running container you can use `docker exec` as so:

```bash
docker exec -it anp-running bash 
```
