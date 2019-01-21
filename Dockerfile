FROM stlouisn/mono:latest

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

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

    # Install temporary-tools
    apt-get install -y --no-install-recommends \
        dirmngr \
        gnupg && \

    # Add sonarr apt-repository
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
    echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list && \

    # Update apt-cache
    apt-get update && \

    # Install sonarr
    apt-get install -y --no-install-recommends \
        nzbdrone && \
    chown -R sonarr:sonarr /opt/NzbDrone && \

    # Remove temporary-tools
    apt-get purge -y \
        dirmngr \
        gnupg && \

    # Clean apt-cache
    apt autoremove -y --purge && \
    apt autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/log/*

VOLUME /var/lib/sonarr

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
