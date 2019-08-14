#!/bin/sh -x

function test_binary_image() {
  local name="s2i-binary"

  docker build . -t ${name} --no-cache

  s2i build --copy example/artifacts/ ${name} ${name}-hello-world

  local port="8080"

  local container_id=$(docker run --name ${name}-hello-world-test -d -p ${port} ${name}-hello-world)
  echo $container_id
  # sleep is required because after docker run returns, the container is up but our server may not quite be yet
  sleep 10
  local http_port="$(docker port ${container_id} ${port}|sed 's/0.0.0.0://')"
  local http_reply=$(curl --silent --show-error http://localhost:$http_port/hello)
  echo $http_reply
  if [ "$http_reply" =  "world" ]; then
    echo "APP TEST PASSED"
    docker rm -f ${container_id}
    return 0
  else
    echo "APP TEST FAILED"
    docker logs ${container_id}
    docker rm -f ${container_id}
    return -123
  fi
}

test_binary_image
