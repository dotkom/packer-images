# Basline AWS AMI and Azure image
Packer template to build AMI and Azure image to be used as source image for other builds. This 
packer template provides configuration for default services such as consul, vault and ssh. As well 
as defaut user setup.

## Inspec
Chef Inspec is used as a simple sanity check that things are working as expected. 

## Vagrant
The packer template contains a vagrant builder to be used in local testing. This is faster than using the aws build and is nice
to have when changing scripts and other provisioners. To use this your system needs to have Vagrant and VirtualBox installed.
Run with ```packer build -only '*.testing' packer.pkr.hcl```