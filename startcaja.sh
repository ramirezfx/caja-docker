#!/bin/bash

HOME="$(echo ~)"

set -e

if [[ -n "$(docker ps -qaf 'name=ramirezfx/caja:latest')" ]]; then
	docker restart ramirezfx/caja:latest
else
	USER_UID=$(id -u)
	USER_GID=$(id -g)
	xhost +local:docker

	docker run --shm-size=2g --rm \
                --security-opt seccomp=unconfined \
		--env=USER_UID=$USER_UID \
		--env=USER_GID=$USER_GID \
		--env=DISPLAY=unix$DISPLAY \
		-v ${HOME}/docker/caja-home:/home/caja \
                -v ${HOME}/docker/sync:/sync \
		--volume=/tmp/.X11-unix:/tmp/.X11-unix:ro \
		--volume=/run/user/$USER_UID/pulse:/run/pulse:ro \
		--name caja \
		ramirezfx/caja:latest
fi
