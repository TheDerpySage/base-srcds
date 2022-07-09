# tds/base-srcds

A fork of leighmacdonald/base-srcds:latest with very very minor edits.

- Use of the Hostname env var
- Persistent and readable volumes for logs, sm_data, and sm_game
- Embedding the update command before starting the server, streamlining updates.

## Sample docker-compose.yaml

    version: "3.4"  
    services:  
      server:  
        image: "tds/base-srcds:latest"  
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
        SRCDS_PW: ''
        SRCDS_RCONPW: "CHANGEME"
        volumes:
        - logs:/home/steam/tf-dedicated/tf/logs
        - sm_data:/home/steam/tf-dedicated/tf/addons/sourcemod/data
        - sm_game:/home/steam/tf-dedicated/tf/addons/sourcemod/gamedata
    volumes:
      logs:
      sm_data:
      sm_game: