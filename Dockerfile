# Alpine Linux with OpenJDK 8

FROM openjdk:8-jdk-alpine

# Embulk variables
ENV EMBULK_VERSION=0.9.7 \
    EMBULK_GEM=' \
      embulk-input-mysql \
      embulk-output-bigquery \
      embulk-filter-to_json \
      embulk-output-gcs \
    ' \
    NONEMBULK_GEM=' \
      httpclient \
      signet \
      activesupport \
      perfect_retry \
      httpclient \
    '

# Install packages
    # Required packages. libc6-compat is required for installing embulk gems
ENV PACKAGE=' \
      git \
      curl \
      bash \
      libc6-compat \
    ' \
    # Packages required only for building
    BUILD_PACKAGE='' \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# apk install
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    # Install build packages
    apk add --no-cache ${BUILD_PACKAGE} -t buildpack && \
    # Install required packages
    apk add --no-cache ${PACKAGE} && \
    apk del buildpack --no-cache && \
    rm -rf /tmp/* /var/cache/apk/*

# install embulk
RUN curl -L https://dl.bintray.com/embulk/maven/embulk-${EMBULK_VERSION}.jar -o /opt/embulk/embulk.jar --create-dirs -k && \
    chmod +x -R /opt/embulk

# add embulk to PATH
ENV PATH $PATH:/opt/embulk

# install embulk gems
RUN if [ "$EMBULK_GEM" != "" ]; then embulk.jar gem install ${EMBULK_GEM}; fi
RUN if [ "$NONEMBULK_GEM" != "" ]; then embulk.jar gem install ${NONEMBULK_GEM}; fi

WORKDIR /work
ENTRYPOINT ["java", "-jar", "/opt/embulk/embulk.jar"]
CMD ["--help"]