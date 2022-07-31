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
    curl -o /tmp/sonarr.tar.gz -sSL "https://download.sonarr.tv/v3/main/$APP_VERSION/Sonarr.main.$APP_VERSION.linux.tar.gz" && \

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

    # Install Mono
    apt-get install -y --no-install-recommends \
        mono-runtime \
        ca-certificates-mono \
        libmono-cil-dev && \

    # Install sqlite
    apt-get install -y --no-install-recommends \
        sqlite3 && \

    # Install mediainfo
    apt-get install -y --no-install-recommends \
        mediainfo && \

    # Install chromaprint/fpcalc
    apt-get install -y --no-install-recommends \
        libchromaprint-tools && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

COPY --chown=sonarr:sonarr --from=dl /userfs /

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
