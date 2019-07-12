#!/bin/bash

# used to make lvm by loop device
dd   if=/dev/zero    of=/1g.img     bs=10M   count=100
losetup    /dev/loop1   /1g.img
pvcreate   /dev/loop1
vgcreate  vg0   /dev/loop1
lvcreate   -L   512M   -n   lv0   vg0
lvs
mkfs.ext4    /dev/vg0/lv0
mkdir   -pv   /lv0
mount   -v   /dev/vg0/lv0    /lv0
df   -hT

