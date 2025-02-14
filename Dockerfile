FROM debian:bullseye-slim

ARG PUID=1000

ENV USER steam
ENV HOMEDIR "/home/${USER}"

ENV STEAMAPPID 232250
ENV STEAMAPP tf
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		nano \
		unzip \
		curl \
		locales \
		ca-certificates \
        && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
        && dpkg-reconfigure --frontend=noninteractive locales \
	&& useradd -u "${PUID}" -m "${USER}" \
	&& apt-get update && apt-get install -y wget apt-transport-https && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		aspnetcore-runtime-6.0 \
		ca-certificates \
		lib32z1 \
		libncurses5:i386 \
		libbz2-1.0:i386 \
		lib32gcc-s1 \
		lib32stdc++6 \
		libsdl2-2.0-0:i386 \
		libtinfo5:i386 \
		libcurl3-gnutls:i386

COPY entry.sh ${HOMEDIR}/entry.sh
RUN chmod +x "${HOMEDIR}/entry.sh" \
        && chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh"

USER ${USER}
WORKDIR ${HOMEDIR}

RUN set -x \
	&& wget https://github.com/SteamRE/DepotDownloader/releases/download/DepotDownloader_2.4.7/depotdownloader-2.4.7.zip \
	&& unzip depotdownloader-2.4.7.zip \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& dotnet ./DepotDownloader.dll -app "${STEAMAPPID}" -dir "${STEAMAPPDIR}" -max-downloads 16 -max-servers 32

RUN set -x \
	&& wget -qO- https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1148-linux.tar.gz | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}" \
	&& wget -qO- https://sm.alliedmods.net/smdrop/1.11/sourcemod-1.11.0-git6934-linux.tar.gz | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"

ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=66 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
	SRCDS_HOSTNAME="TF2" \
	SRCDS_STARTMAP="ctf_2fort" \
	SRCDS_MAXPLAYERS=32 \
	SRCDS_REGION=3 \
	SRCDS_TAGS="" \
	SRCDS_RCONPW="changeme" \
	SRCDS_PW="" \
	SRCDS_NET_PUBLIC_ADDRESS="" \
    SRCDS_IP="" \
	SRCDS_TOKEN="" \
	SRCDS_EXTRA_OPTIONS=""

RUN mkdir ${STEAMAPPDIR}/tf/logs

WORKDIR "${STEAMAPPDIR}"

VOLUME ${STEAMAPPDIR}/tf/cfg

VOLUME ${STEAMAPPDIR}/tf/logs

VOLUME ${STEAMAPPDIR}/tf/maps

VOLUME ${STEAMAPPDIR}/tf/addons/sourcemod/

CMD ["bash", "../entry.sh"]

EXPOSE 27015/tcp 27015/udp 27020/udp

