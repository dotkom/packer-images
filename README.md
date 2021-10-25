# Dotkom's packer monorepo

To build an image use packer, ex. ```packer build image/base```.
Make sure to tag the image as production if it's ready to be used in our actual environment. This can be done in many different ways, AWS cli, AWS Console or ```packer build -var="aws_ami_tags={\"Production\"=true}" images/base``` if you want to tag at build time.

All images will be build and tagged as production when pushing to master.