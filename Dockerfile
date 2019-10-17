FROM python:alpine3.6

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="image-build-utils" \
      org.opencontainers.image.authors="Brian Dwyer <bdwyertech@github.com>" \
      org.opencontainers.image.source="https://github.com/bdwyertech/docker-image-build-utils.git" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.created=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/bdwyertech/docker-image-build-utils.git"

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
