#! /bin/bash
CONTAINER_NAME=$1
DOCKER_IMAGE_COMMIT=$2

WDIR=`dirname "$(readlink -f "$0")"`

# Remove old container
echo "Remove old container"
docker ps | grep $CONTAINER_NAME && docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME || if [ $? -eq 1 ]; then echo "Container $CONTAINER_NAME doesn't exists"; fi

# Create and run new container
echo "Use new image: $DOCKER_IMAGE_COMMIT"
docker run -d \
--restart=always \
--name $CONTAINER_NAME \
--env-file $WDIR/env/prod.env \
--hostname $CONTAINER_NAME \
--network traefik-net \
--label "traefik.enable=true" \
--label "traefik.docker.network=traefik-net" \
--label "traefik.http.routers.$CONTAINER_NAME.rule=Host(\`example.com\`)" \
--label "traefik.http.routers.$CONTAINER_NAME.entrypoints=https" \
--label "traefik.http.routers.$CONTAINER_NAME.tls=true" \
--label "traefik.http.services.$CONTAINER_NAME.loadbalancer.server.port=4000" \
$DOCKER_IMAGE_COMMIT