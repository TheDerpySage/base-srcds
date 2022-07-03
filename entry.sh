#!/bin/bash

dotnet ../DepotDownloader.dll -app "${STEAMAPPID}" -dir "${STEAMAPPDIR}" -max-downloads 16 -max-servers 32

bash ./srcds_run -game "${STEAMAPP}" -console \
                        -usercon \
                        +fps_max "${SRCDS_FPSMAX}" \
                        -tickrate "${SRCDS_TICKRATE}" \
                        -port "${SRCDS_PORT}" \
                        +clientport "${SRCDS_CLIENT_PORT}" \
			+tv_port "${SRCDS_TV_PORT}" \
                        +maxplayers "${SRCDS_MAXPLAYERS}" \
                        +map "${SRCDS_STARTMAP}" \
                        +sv_setsteamaccount "${SRCDS_TOKEN}" \
			+hostname "${SRCDS_HOSTNAME}" \
                        +rcon_password "${SRCDS_RCONPW}" \
                        +sv_password "${SRCDS_PW}" \
                        +sv_region "${SRCDS_REGION}" \
                        +sv_tags "${SRCDS_TAGS}" \
                        -ip "${SRCDS_IP}"


