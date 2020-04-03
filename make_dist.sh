#!/bin/sh

VERSION=`cat VERSION`
BUILD_DIR=icecast_vidmon-$VERSION

ln -s . $BUILD_DIR

tar -zvcf icecast_vidmon-`cat VERSION`.tar.gz $BUILD_DIR/ChangeLog $BUILD_DIR/daemon-reload.sh $BUILD_DIR/icecast_vidmon-sample.conf $BUILD_DIR/icecast_vidmon.service $BUILD_DIR/icecast_vidmon.sh $BUILD_DIR/icecast_vidmon.spec $BUILD_DIR/make_dist.sh $BUILD_DIR/Makefile $BUILD_DIR/VERSION

rm -f $BUILD_DIR
