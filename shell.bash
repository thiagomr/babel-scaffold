#!/bin/bash
echo $1 $2
export $(egrep -v '^#' .env.deploy | xargs)

run() {
    echo "docker run -it \
        $cond \
        --name=$appname \
        -p $port:$port \
        -d \
        --restart=unless-stopped $appname"
}

if [ $1 == "local" ]
  then

    cond="--net='host'"
    cp .env.dev .env

    if [ $2 == "deploy" ]
      then
        docker build -t $appname .
        docker stop $appname
        docker rm $appname
        eval $(run)
    fi

    if [ $2 == "stop" ]
      then
        docker stop $appname
    fi

    if [ $2 == "exec" ]
      then
        docker exec -it $appname $3
    fi

    if [ $2 == "start" ]
      then
        docker start $appname
    fi

    if [ $2 == "logs" ]
      then
        docker logs -f $appname
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


if [ $2 == "deploy" ]
  then
    ssh -tt $host "mkdir $appname && cd $appname && sudo chmod 777 * -R"
    rsync --progress --exclude-from '.deployignore' -avz -e "ssh" . $host:$appname
    ssh -tt $host "cd $appname && cp $env .env"
    ssh -tt $host "cd $appname && docker build -t $appname ."
    ssh -tt $host "cd $appname && docker stop $appname"
    ssh -tt $host "cd $appname && docker rm $appname"
    ssh -tt $host "cd $appname && $(run)"
fi

if [ $2 == "stop" ]
  then
    ssh -tt $host "docker stop $appname"
fi

if [ $2 == "exec" ]
  then
    ssh -tt $host "docker exec -it $appname $3"
fi

if [ $2 == "start" ]
  then
    ssh -tt $host "cd $appname && docker start $appname"
fi

if [ $2 == "logs" ]
  then
    ssh -tt $host "docker logs -f $appname"
fi
