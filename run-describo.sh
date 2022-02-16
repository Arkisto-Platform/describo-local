#!/bin/bash

GITHUB_RAW_ENDPOINT="https://raw.githubusercontent.com/Arkisto-Platform/describo-local/master"
FILES="
    docker-compose.yml 
    describo-configuration.json 
    nginx.conf 
"

setup() {
    mkdir -p $PWD/describo-local && cd $PWD/describo-local
    mkdir -p reva-configuration

    # get all the required bits
    echo "Retrieving configuration"
    for file in $FILES ; do
        if [ ! -f "describo-local/${file}" ] ; then
            curl --silent --output "./${file}" "${GITHUB_RAW_ENDPOINT}/${file}"
        fi
    done

    echo "Setting up"
    if [ -z $USER ] ; then
        echo "$USER unset. Exiting."
        exit -1
    fi
    if [ -z $HOME ] ; then
        echo "$HOME unset. Exiting."
        exit -1
    fi
    echo "HOME=\"$HOME\"" > ./.env
    echo "USER=\"$USER\"" >> ./.env
    mkdir -p ./profiles
}

start() {
    [[ ! -d "${PWD}/describo-local" ]] && setup && cd ..
	cd describo-local
    docker-compose up -d
    sleep 5
}

stop() {
	cd describo-local
    docker-compose stop
    docker-compose rm -f 
}

message() {
cat <<EOF

    This script will run a local version of the Describo application on your
    computer. Docker is required and all configuration will be downloaded from
    Github.

    The script will setup a folder in the current directory called "describo-local"
    and it will operate inside that folder.

EOF
read -p 'Do you want to continue? y|N ' response
if [ $response != "y" ]; then
    exit
fi
}

message_started() {
cat <<EOF

    Describo is now running at http://localhost (open up a browser and type that in).

    Log in with:
     - username: admin
     - password: admin

    The folder available inside describo is:
     - $PWD/data/admin

    You can copy files and folders into there and then annotate them inside describo.

    When you're done, stop describo with:
     - $0 stop

    Next time - start it up with:
    - $0 start

    To update describo do (whilst not running):
     - $0 update

     This script will make your home directory accessible inside describo.

    **STOP! THIS COMES WITH NO GUARANTEES THAT YOU WON'T LOSE YOUR DATA**

EOF
}

if [ -z $(which docker) ] ; then
    echo "Can't find docker. Is it installed? Exiting."
    exit -1
fi
if [ -z $(which docker-compose) ] ; then
    echo "Can't find docker-compose. Is it installed? Exiting."
    exit -1
fi
echo

case "$1" in
    start)
        message
        start
        message_started
        ;;
    stop)
        stop
        ;;
    update)
        message
        setup
        echo "Updating images"
        docker pull -q arkisto/describo-online-api:latest
        docker pull -q arkisto/describo-online-ui:latest
        docker pull -q postgres:13-alpine
        ;;
    *)
       echo "Usage: $0 {start|stop|update}"
       ;;
esac

exit 0