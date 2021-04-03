# Dotkom's packer monorepo

To build an image use packer, ex. ```packer build image/base```.
Make sure to tag the image as production if it's ready to be used in our actual environment. Can be done in many different ways,
AWS cli, AWS Console or ```packer build -var="aws_ami_tags={'production'=true}" image/base```

All images will be build and tagged as production when pushing to master. 