FROM python:alpine3.6

MAINTAINER Brian Dwyer

# Update & Install Ruby
RUN apk update && apk upgrade \
    && apk add bash ca-certificates ruby ruby-json wget \
    && echo 'gem: --no-document' > /etc/gemrc

# Install Berkshelf
RUN apk add --no-cache --virtual .build-deps ruby-dev build-base \
    && gem install berkshelf \
    && apk del .build-deps
