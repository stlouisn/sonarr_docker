FROM stlouisn/ubuntu:latest AS dl

ARG TARGETARCH

ARG APP_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN \

    # Update apt-cache
    apt-get update && \

    # Install jq
    apt-get install -y --no-install-recommends \
        curl && \

    # Download Sonarr

        #if [ "arm" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://download.sonarr.tv/v4/main/$APP_VERSION/Sonarr.main.$APP_VERSION.linux-arm.tar.gz" ; fi && \
        if [ "arm" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://github.com/Sonarr/Sonarr/releases/download/v$APP_VERSION/Sonarr.main.$APP_VERSION.linux-arm.tar.gz" ; fi && \

        #if [ "arm64" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://download.sonarr.tv/v4/main/$APP_VERSION/Sonarr.main.$APP_VERSION.linux-arm64.tar.gz" ; fi && \
        if [ "arm64" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://github.com/Sonarr/Sonarr/releases/download/v$APP_VERSION/Sonarr.main.$APP_VERSION.linux-arm64.tar.gz" ; fi && \

        #if [ "amd64" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://download.sonarr.tv/v4/main/$APP_VERSION/Sonarr.main.$APP_VERSION.linux-x64.tar.gz" ; fi && \
        if [ "amd64" = "$TARGETARCH" ] ; then curl -o /tmp/sonarr.tar.gz -sSL "https://github.com/Sonarr/Sonarr/releases/download/v$APP_VERSION/Sonarr.main.$APP_VERSION.linux-x64.tar.gz" ; fi && \

    # Extract Sonarr
    mkdir -p /userfs && \
    tar -xf /tmp/sonarr.tar.gz -C /userfs/ && \

    # Disable Sonarr-Update
    rm -r /userfs/Sonarr/Sonarr.Update/

FROM stlouisn/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

COPY rootfs /

RUN \

    # Create sonarr group
    groupadd \
        --system \
        --gid 10000 \
        sonarr && \

    # Create sonarr user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment sonarr \
        --gid 10000 \
        --uid 10000 \
        sonarr && \

    # Update apt-cache
    apt-get update && \

    # Install sqlite
    apt-get install -y --no-install-recommends \
        sqlite3 && \

    # Install unicode support
    apt-get install -y --no-install-recommends \
        libicu70 && \

    # Install xml command line toolkit
    apt-get install -y --no-install-recommends \
        xmlstarlet && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/man \
        /var/cache \
        /var/lib/apt \
        /var/log/*

COPY --chown=sonarr:sonarr --from=dl /userfs /

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
