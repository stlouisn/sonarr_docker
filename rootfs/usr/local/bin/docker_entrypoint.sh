#!/bin/bash

#=========================================================================================

# Fix user and group ownerships for '/config'
chown -R sonarr:sonarr /config

# Delete PID if it exists
if
    [ -e "/config/sonarr.pid" ]
then
    rm -f /config/sonarr.pid
fi

#=========================================================================================

# Start sonarr in console mode
exec gosu sonarr \
    /Sonarr/Sonarr -nobrowser -data=/config
