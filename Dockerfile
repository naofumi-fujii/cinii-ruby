FROM ruby:2.6.1-alpine

ENV LANG C.UTF-8
ENV ROOT_PATH /cinii-ruby

RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH
COPY . $ROOT_PATH

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache --virtual=.build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    apk add --update --no-cache \
      bash \
      git \
      openssh \
      yaml && \
    bundle install -j4 && \
    apk del .build-dependencies

