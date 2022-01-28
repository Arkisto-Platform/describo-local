#!/bin/bash

GITHUB_RAW_ENDPOINT="https://raw.githubusercontent.com/Arkisto-Platform/describo-local/master"
FILES="
    docker-compose.yml 
    describo-configuration.json 
    nginx.conf 
    reva-configuration/gateway.toml 
    reva-configuration/groups.json 
    reva-configuration/ocm-providers.json 
    reva-configuration/storage-home.toml 
    reva-configuration/users.json
"

setup() {
    mkdir -p $PWD/describo-local && cd $PWD/describo-local
    mkdir -p reva_configuration

    # get all the required bits
    echo "Retrieving configuration"
    for file in $FILES ; do
        if [ ! -f "describo-local/${file}" ] ; then
            curl --silent --output "$PWD/${file}" "${GITHUB_RAW_ENDPOINT}/${file}"
        fi
    done

    echo "Setting up"
    echo "DATA=\"./\"" > ./.env
    mkdir -p ./data/admin/test
    mkdir -p ./profiles
}

start() {
    [[ ! -d "${PWD}/describo-local" ]] && setup
	cd describo-local
    docker-compose up 
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
        docker pull -q arkisto/describo-reva:latest
        docker pull -q postgres:13-alpine
        ;;
    *)
       echo "Usage: $0 {start|stop|update}"
       ;;
esac

exit 0