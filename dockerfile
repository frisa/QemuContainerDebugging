FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install gawk wget git-core
RUN apt-get -y install diffstat unzip texinfo build-essential
RUN apt-get -y install chrpath socat cpio
RUN apt-get -y install debianutils iputils-ping
RUN apt-get -y install libsdl1.2-dev xterm tar locales
RUN apt-get -y install xz-utils
RUN apt-get -y install python-is-python3 python3 python3-pip python3-pexpect
RUN apt-get -y install groovy
#RUN apt-get -y install gcc-multilib

RUN rm /bin/sh && ln -s bash /bin/sh
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "Creating developer user"
RUN useradd -ms /bin/bash developer
RUN echo "developer   ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER developer
ENV BUILD_INPUT_DIR /home/developer/yocto/input
ENV BUILD_OUTPUT_DIR /home/developer/yocto/output
RUN mkdir -p $BUILD_INPUT_DIR
RUN mkdir -p $BUILD_OUTPUT_DIR

WORKDIR $BUILD_INPUT_DIR
RUN git clone git://git.yoctoproject.org/poky
WORKDIR $BUILD_INPUT_DIR/poky
RUN git checkout jethro

WORKDIR $BUILD_OUTPUT_DIR
#ENV TEMPLATECONF=$BUILD_INPUT_DIR/$PROJECT/sources/meta-$PROJECT/custom
CMD source $BUILD_INPUT_DIR/poky/sources/poky/oe-init-build-env build && bitbake test-image
