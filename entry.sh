#!/bin/bash
#if [ ! -z "$METAMOD_VERSION" ]; then
#        LATESTMM=$(wget -qO- https://mms.alliedmods.net/mmsdrop/"${METAMOD_VERSION}"/mmsource-latest-linux)
#        wget -qO- https://mms.alliedmods.net/mmsdrop/"${METAMOD_VERSION}"/"${LATESTMM}" | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"
#fi
#if [ ! -z "$SOURCEMOD_VERSION" ]; then
#        LATESTSM=$(wget -qO- https://sm.alliedmods.net/smdrop/"${SOURCEMOD_VERSION}"/sourcemod-latest-linux)
#        wget -qO- https://sm.alliedmods.net/smdrop/"${SOURCEMOD_VERSION}"/"${LATESTSM}" | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"
#fi

# wget -qO- "${DLURL}/master/cfg.tar.gz" | tar xvzf - -C "${STEAMAPPDIR}"

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
