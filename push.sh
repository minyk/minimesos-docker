#!/bin/bash

if [ "${MINIMESOS_DOCKER_VERSION}" == "" ]
then
  echo "Please set MINIMESOS_DOCKER_VERSION before building"
  exit 1
fi

echo Pushing minyk/mesos-base:${MINIMESOS_DOCKER_VERSION}
docker push minyk/mesos-base:${MINIMESOS_DOCKER_VERSION} || exit $?

pushImage() {
  MESOS_VERSION=$1
  MESOSPHERE_TAG=$2

  for role in agent master; do
    echo
    echo Pushing minyk/mesos-${role}:${MESOS_VERSION}-${MINIMESOS_DOCKER_VERSION}
    docker push minyk/mesos-${role}:${MESOS_VERSION}-${MINIMESOS_DOCKER_VERSION} || exit $?
  done

}

#            Mesos version  Mesosphere tag
pushImage "1.2.1"	  	 "2.0.1"
