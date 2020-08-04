DOCKER_IMAGE_COMMIT=$1
FLUENTD_HOST=$2

CONTAINER_NAME="demo_backend"

# Remove old container
echo "Remove old container"
docker ps | grep $CONTAINER_NAME && docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME || if [ $? -eq 1 ]; then echo "Container $CONTAINER_NAME doesn't exists"; fi

# Create and run new container
echo "Use new image: $DOCKER_IMAGE_COMMIT"
docker run -d \
-p 0.0.0.0:8000:8000 \
--restart=always \
--name $CONTAINER_NAME \
--hostname $CONTAINER_NAME \
--env-file /evano-configs/docker-env/default.env \
--env-file /evano-configs/docker-env/demo_backend.env \
--network traefik-net \
$DOCKER_IMAGE_COMMIT