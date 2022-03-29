# tds/base-srcds

A fork of leighmacdonald/base-srcds:latest with very very minor edits. Particularly, the hostname in the entry script and using latest stable builds of sourcemod and metamod. 

### Sample docker-compose.yaml
    version: "3.4"  
    services:  
      voov:  
        image: "base-srcds:dev"  
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
        SRCDS_RCONPW: "CHANGEME"
        volumes:
        - logs:/home/steam/tf-dedicated/tf/logs
        - sm_data:/home/steam/tf-dedicated/tf/addons/sourcemod/data
        - sm_game:/home/steam/tf-dedicated/tf/addons/sourcemod/gamedata
    volumes:
      logs:
      sm_data:
      sm_game: