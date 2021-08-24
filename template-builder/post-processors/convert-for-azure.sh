#!/bin/sh
qemu-img convert -f raw -o subformat=fixed -O vpc output-$PKR_SOURCE_NAME/packer-$PKR_SOURCE_NAME output-$PKR_SOURCE_NAME/packer-$PKR_SOURCE_NAME.vhd
