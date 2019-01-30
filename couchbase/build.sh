#!/usr/bin/env bash
# Determine what the directory is that comprises your service containing your Docker file.
# This sample assumes the following variables:
IMAGE_NAME="couchbase"
REGISTRY_STAGE_SHORE="stg1.registry.rccl.com:10104"
REGISTRY_STAGE_SHIP="stg-registry.nowlab.tstsh.tstrccl.com:10104"
REGISTRY_TEST_SHIP="tst2-registry.nowlab.tstsh.tstrccl.com:10104"
REGISTRY_TEST_SHORE="rhldcmesboot711.na.rccl.com:5000"
REGISTRY_AL="registry.allure.sh.rccl.com:10104"
REGISTRY_SY="registry.symphony.sh.rccl.com:10104"
VERSION="1.0.10"
# Build your Docker image tagging the image in the following format: registry-name/service-name:commit-id-or-tag-name
# The commit ID has been shortened for readability.
#docker build . -t $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker build . -t $REGISTRY_STAGE_SHIP/$IMAGE_NAME:$VERSION
docker build . -t $REGISTRY_TEST_SHORE/$IMAGE_NAME:$VERSION
#docker build . -t $REGISTRY_TEST_SHIP/$IMAGE_NAME:$VERSION
#docker build . -t $REGISTRY_AL/$IMAGE_NAME:$VERSION
#docker build . -t $REGISTRY_SY/$IMAGE_NAME:$VERSION

# The -t parameter above lets you provide a list of tag names for the build, but for readability, we've split it into two commands.
# Once the build is complete, tag the build again remembering to include the registry name.
# The commit ID has been shortened for readability.
#docker tag $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker tag $REGISTRY_STAGE_SHIP/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
docker tag $REGISTRY_TEST_SHORE/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker tag $REGISTRY_TEST_SHIP/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker tag $REGISTRY_AL/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker tag $REGISTRY_SY/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION

echo "Image Tagged -- $REGISTRY_TEST_SHORE/$IMAGE_NAME:$VERSION $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION "
# If you followed the cert setup instructions, you should be able to push your Docker image.
# Wait patiently for it to go.
#docker push $REGISTRY_STAGE_SHORE/$IMAGE_NAME:$VERSION
#docker push $REGISTRY_STAGE_SHIP/$IMAGE_NAME:$VERSION
docker push $REGISTRY_TEST_SHORE/$IMAGE_NAME:$VERSION
#docker push $REGISTRY_TEST_SHIP/$IMAGE_NAME:$VERSION
#docker push $REGISTRY_AL/$IMAGE_NAME:$VERSION
#docker push $REGISTRY_SY/$IMAGE_NAME:$VERSION

echo " Docker Image Pushed - $REGISTRY_TEST_SHORE/$IMAGE_NAME:$VERSION "
echo
echo "executing: curl -k  https://$REGISTRY_TEST_SHORE/v2/$IMAGE_NAME/tags/list "
# Verify that your image made it onto the server by curling it.
# Get a list of all tags on the server.
#curl https://$REGISTRY_STAGE_SHORE/v2/$IMAGE_NAME/tags/list
#curl https://$REGISTRY_STAGE_SHIP/v2/$IMAGE_NAME/tags/list
#curl https://$REGISTRY_TEST_SHIP/v2/$IMAGE_NAME/tags/list
curl -k  https://$REGISTRY_TEST_SHORE/v2/$IMAGE_NAME/tags/list
#curl https://$REGISTRY_AL/v2/$IMAGE_NAME/tags/list
#curl https://$REGISTRY_SY/v2/$IMAGE_NAME/tags/list
