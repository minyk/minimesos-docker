#!/bin/bash

if [ "${MINIMESOS_DOCKER_VERSION}" == "" ]
then
  echo "Please set MINIMESOS_DOCKER_VERSION before building"
  exit 1
fi

buildImage() {
  MESOS_VERSION=$1
  MESOSPHERE_TAG=$2

  for role in agent master; do
    echo
    echo Building minyk/mesos-${role}:${MESOS_VERSION}-${MINIMESOS_DOCKER_VERSION}
    docker build \
      -t minyk/mesos-${role}:${MESOS_VERSION}-${MINIMESOS_DOCKER_VERSION} \
      -f mesos-image/${role}/Dockerfile \
      --build-arg MESOS_VERSION=${MESOS_VERSION}-${MESOSPHERE_TAG} \
      . || exit $?
  done
}

docker build \
  -t minyk/alpine3.3-java8-jre:v1 \
  alpine3.3-java8-jre || exit $?

docker build \
  -t minyk/mesos-base:${MINIMESOS_DOCKER_VERSION} \
  -f base/Dockerfile \
  . || exit $?

#          Mesos version  Mesosphere tag
buildImage "1.2.1"        "2.0.1"
