# syntax=docker/dockerfile:1.7-labs

FROM python:alpine

RUN apk update && apk add --no-cache \
  git \
  cmake \
  build-base \
  pkgconfig \
  ffmpeg-dev \
  opus-dev \
  libvpx-dev \
  libsrtp-dev \
  openssl-dev

RUN git clone https://github.com/google/crc32c \
    && cd crc32c \
    && git submodule update --init --recursive \
    && mkdir build \
    && cd build \
    && cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCRC32C_BUILD_TESTS=no \
        -DCRC32C_BUILD_BENCHMARKS=no \
        -DBUILD_SHARED_LIBS=yes \
        .. \
    && make all install

RUN pip3 install keepercommander

ENTRYPOINT ["/usr/local/bin/keeper"]
