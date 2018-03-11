#!/bin/bash

# Output colors
NORMAL="\\033[0;39m"
BLUE="\\033[1;34m"

# Names to identify images and containers of this app
IMAGE_NAME='babel-scaffold'
CONTAINER_NAME="babel-scaffold"
PORT=8000

log() {
  echo -e "$BLUE > $1 $NORMAL"
}

build() {
    log "Build image"
    docker build -t $IMAGE_NAME .
}

logs() {
    log "Container logs"
    docker logs $IMAGE_NAME
}

tail-logs() {
    log "Container tail logs"
    docker logs -f --tail 100 $IMAGE_NAME
}

build-no-cache() {
    log "Build no-cache image"
    docker build -t $IMAGE_NAME . --no-cache
}

install() {
    log "Installing full application"
    remove
    build
    run
}

run() {
    log "Run container"
    docker run -it -d --name=$CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME
}

restart() {
    log "Restart container"
    docker restart $CONTAINER_NAME
}

stop() {
    log "Stop container"
    docker stop $CONTAINER_NAME
}

start() {
    log "Start container"
    docker start $CONTAINER_NAME
}

remove() {
    log "Removing previous container $CONTAINER_NAME" && \
    docker rm -f $CONTAINER_NAME
}

rmi() {
    log "Remove unused images"
    docker rmi $(docker images -f dangling=true -q) --force
}


help() {
  echo "-------------------------------------------------------------"
  echo "                      commands                               "
  echo "-------------------------------------------------------------"
  echo -e -n "$BLUE"
  echo " - build        build the Docker image"
  echo " - build-nc     build the Docker image with option --no-cache"
  echo " - install      execute full install at once"
  echo " - stop         stop main container"
  echo " - start        start main container"
  echo " - logs         logs container"
  echo " - tail-logs    tail logs container"
  echo " - remove       remove main container"
  echo " - rmi          remove unused Docker images"
  echo " - help         display this help"
  echo -e -n "$NORMAL"
  echo "--------------------------------------------------------------"

}

$*