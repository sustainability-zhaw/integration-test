# Overrides

Docker Compose provides an override mechanism for the main compose file. 
Overrides add, extend, or replace service sepicifications in the main compose
file. Overrides are added sequentially, so later specified overrides can 
replace the definitions in a prior one. 

**This directory is intentionally empty.** Any overrides added to this directory 
will be ignored. 

Each service should come with its specific development overrides in the 
repository's root. This file should be labelled as `docker-compose-override.yaml`. 
This naming has **no technical reason**, but is a convention for better orientation.

**Not all components provide a `docker-compose-override.yaml`, yet.**

Normally a service or component should include its build specifications in the 
override.

Merging overrides is specified in the 
[Docker Documentation](https://docs.docker.com/compose/multiple-compose-files/merge/).

For build specifications it is important to include a **different image name**. 
Otherwise, docker will fetch the image from the respective registry instead of 
building it. 

