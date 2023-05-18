# tds/tf2-srcds

A fork of leighmacdonald/base-srcds:latest with very very minor edits.

- Additional env vars for more launch options
- Persistent and read/writable volumes for configs, logs, maps (for adding additional maps), and sourcemod itself (for adding mods on your own)

## Sample docker-compose.yaml

    version: "3.4"  
    services:  
      server:  
        image: "tds/tf2-srcds:latest"  
        restart: "unless-stopped"  
        ports:  
        - "27015:27015"  
        - "27015:27015/udp"  
        - "27020:27020/udp"  
        environment:  
        SRCDS_HOSTNAME: '"Test Server, Please Ignore"'  
        SRCDS_STARTMAP: "pl_badwater"  
        SRCDS_MAXPLAYERS: 24  
        SRCDS_REIGON: 0
        SRCDS_TAGS: '"thederpysage"'
        SRCDS_PW: "CHANGEME"
        SRCDS_RCONPW: "CHANGEME"
        volumes:
        - cfg:/home/steam/tf-dedicated/tf/cfg
        - logs:/home/steam/tf-dedicated/tf/logs
        - maps:/home/steam/tf-dedicated/tf/maps
        - sourcemod:/home/steam/tf-dedicated/tf/addons/sourcemod
    volumes:
      cfg:
      logs:
      maps:
      sourcemod:
