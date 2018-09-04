#!/bin/bash
APPNAME="babel-scaffold"
echo $1 $2

run() {
    echo "docker run -it \
        $cond \
        --name=$APPNAME \
        -p $PORT:$PORT \
        -d \
        --restart=unless-stopped $APPNAME"
}

if [ $1 == "local" ]
  then

    cond="--net='host'"

    export $(egrep -v '^#' .env.dev | xargs)
    cp .env.dev .env

    if [ $2 == "deploy" ]
      then
        docker build -t $APPNAME .
        docker stop $APPNAME
        docker rm $APPNAME
        eval $(run)
    fi

    if [ $2 == "stop" ]
      then
        docker stop $APPNAME
    fi

    if [ $2 == "exec" ]
      then
        docker exec -it $APPNAME $3
    fi

    if [ $2 == "start" ]
      then
        docker start $APPNAME
    fi

    if [ $2 == "logs" ]
      then
        docker logs -f $APPNAME
    fi
fi

if [ $1 == "stage" ]
  then
    env=.env.stage
    cond="--net='host'"
elif [ $1 == "prod" ]
  then
    env=.env.prod
else
  exit
fi

export $(egrep -v '^#' $env | xargs)

if [ $2 == "deploy" ]
  then
    ssh -tt $HOST "mkdir $APPNAME && cd $APPNAME && sudo chmod 777 * -R"
    rsync --progress --exclude-from '.deployignore' -avz -e "ssh" . $HOST:$APPNAME
    ssh -tt $HOST "cd $APPNAME && cp $env .env"
    ssh -tt $HOST "cd $APPNAME && docker build -t $APPNAME ."
    ssh -tt $HOST "cd $APPNAME && docker stop $APPNAME"
    ssh -tt $HOST "cd $APPNAME && docker rm $APPNAME"
    ssh -tt $HOST "cd $APPNAME && $(run)"
    ssh -tt $HOST "docker logs -f $APPNAME"
fi

if [ $2 == "stop" ]
  then
    ssh -tt $HOST "docker stop $APPNAME"
fi

if [ $2 == "exec" ]
  then
    ssh -tt $HOST "docker exec -it $APPNAME $3"
fi

if [ $2 == "start" ]
  then
    ssh -tt $HOST "cd $APPNAME && docker start $APPNAME"
fi

if [ $2 == "logs" ]
  then
    ssh -tt $HOST "docker logs -f $APPNAME"
fi
