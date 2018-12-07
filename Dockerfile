FROM python:alpine3.6

MAINTAINER Brian Dwyer

# Update PIP & Install PIPEnv
RUN python -m pip install --upgrade pip \
    && python -m pip install --upgrade pipenv \
    && rm -rf ~/.cache/pip

# Update & Install Ruby
RUN apk update && apk upgrade \
    && apk add --no-cache bash ca-certificates git ruby ruby-json wget \
    && echo 'gem: --no-document' > /etc/gemrc

# Install Berkshelf
RUN apk add --no-cache --virtual .build-deps ruby-dev build-base \
    && gem install berkshelf \
    && apk del .build-deps \
    && rm -rf ~/.gem
