FROM stlouisn/mono:latest

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \
    export `cat /etc/lsb-release | grep -v DESCRIPTION` && \

    # Update apt-cache
    apt-get update && \

    # Install temporary-tools
    apt-get install -y --no-install-recommends \
        dirmngr \
        gnupg && \

    # Add sonarr apt-repository
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
    echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list && \

    # Add mediaarea repository
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5CDF62C7AE05CC847657390C10E11090EC0E438 && \
    echo "deb https://mediaarea.net/repo/deb/ubuntu ${DISTRIB_CODENAME} main" > /etc/apt/sources.list.d/mediaarea.list && \

    # Update apt-cache
    apt-get update && \

    # Install mediainfo
    apt-get install -y --no-install-recommends \
        mediainfo && \

    # Install sonarr
    apt-get install -y --no-install-recommends \
        nzbdrone && \
    chown -R www-data:www-data /opt/NzbDrone && \

    # Remove temporary-tools
    apt-get purge -y \
        dirmngr \
        gnupg && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

VOLUME /config

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
