#!/bin/sh
#
# Script to build images
#

: ${PROJECT_NAME:='nginx-uwsgi'}
. ./lib.sh

set -e

REPO='muccg'

docker_options

info "${DOCKER_BUILD_OPTS}"


# build sub dirs
for dir in */
do
    version=${dir%*/}
    image="${DOCKER_IMAGE}:${version}"
    echo "################################################################### ${image}"

    # blindly pull what we are trying to build, warm up cache
    docker pull ${image} || true

    # build
    docker build ${DOCKER_BUILD_OPTS} -t ${image} ${version}
    docker build ${DOCKER_BUILD_OPTS} -t ${image}-${DATE} ${version}

    docker inspect ${image}

    # push
    if [ ${DOCKER_USE_HUB} = "1" ]; then
        _ci_docker_login
        docker push ${image}
        docker push ${image}-${DATE}
    fi
done
