#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO='muccg'
DATE=`date +%Y.%m.%d`

: ${DOCKER_BUILD_OPTIONS:="--pull=true"}

# build sub dirs
for dir in */
do
    version=${dir%*/}
    image="${REPO}/nginx-uwsgi:${version}"
    echo "################################################################### ${image}"

    # blindly pull what we are trying to build, warm up cache
    docker pull ${image} || true

    # build
    docker build ${DOCKER_BUILD_OPTIONS} -t ${image} ${version}
    docker build ${DOCKER_BUILD_OPTIONS} -t ${image}-${DATE} ${version}

    docker inspect ${image}

    # push
    docker push ${image}
    docker push ${image}-${DATE}
done
