#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R sonarr:sonarr /config

# Delete pid if it exists
[[ -e /config/nzbdrone.pid ]] && rm -f /config/nzbdrone.pid

#=========================================================================================

# Start sonarr in console mode
exec gosu sonarr \
    /usr/bin/mono --debug \
    /NzbDrone/NzbDrone.exe -nobrowser -data=/config
