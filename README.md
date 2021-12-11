[hub]: https://hub.docker.com/r/spritsail/waterfall
[drone]: https://drone.spritsail.io/spritsail/waterfall

# [Spritsail/Waterfall][hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/spritsail/waterfall.svg)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/spritsail/waterfall.svg)][hub]
[![Build Status](https://drone.spritsail.io/api/badges/spritsail/waterfall/status.svg)][drone]

An Alpine Linux based Dockerfile to run the Minecraft server proxy Waterfall
It expects a volume to store data mapped to `/config` in the container. Enjoy!


## Example run command
```
docker run -d --restart=on-failure:10 --name waterfall -v /volumes/waterfall:/config -p 25577:25577 spritsail/waterfall:latest
```
