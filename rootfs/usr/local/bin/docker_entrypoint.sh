#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R sonarr:sonarr /config

# Delete pid if it exists
[[ -e /config/nzbdrone.pid ]] && rm -f /config/nzbdrone.pid

#=========================================================================================

# Start sonarr in console mode
exec gosu www-data \
    /usr/bin/mono --debug \
    /opt/NzbDrone/NzbDrone.exe -nobrowser -data=/config
