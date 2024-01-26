# Integration Test

A set of docker compose configurations to localy test and verify the interplay of all services.

## Configurations

### Configs

Non sensitive configuration is read from  the `configs` directory. Defaults for testing are already provided.

### Secrets

Sensitive configuration like keys and credentials are read from the `secrets` directory. The `secrets-exmple` directory can be copied and renamed to `secrets`. 

You will need to provide your own keys and credentials. Look at the GitHub repository of the individual services for more information.

## Getting Started

### Initializing Database

Run this once before starting the system to install the schema and load required data.

```
docker compose run --rm init-database
```

### Starting the system

There are three docker compose setups provided.

#### Use the latest docker images from GitHub

```
docker compose up -d
```

#### Build images from source

```
docker compose -f docker-compose-build.yaml up -d
```

#### Build images from source and mount local source code

```
docker compose -f docker-compose-mount.yaml up -d
```

### Shutting down the system

```
docker compose down
```

## Cloning Services (Not implemented yet)

```
docker compose run clone-services
```

## Overrides

TODO Explain overrides

### Using overrides for frontend development

The frontend development does not require building of most of the backend services and is basically focused around the static files served by the dashboard container. 

The following command launches the default system and sideloads the local dashboard code. This override allows to edit the source code without building and restarting all containers. 

```
docker compose -f docker-compose.yaml -f overrides/docker-compose-dashboard-code.yaml up -d
```

This assumes that the dashboard repo is in a sibling directory next to the integration tests. 

## Adding a new Service 

### Frontend Service

A frontend service has an endpoint in the reverse proxy of the system. 

All frontend services have to provide a http endpoint for the user interaction. 

This endpoint has to be configured with an appropriately prefixed path in the reverse proxy.

Check `configs/reverse-proxy/Caddyfile` for examples. 

### Backend Serivce

A backend service is a service that communicates only to the database and is triggered by other services.

Backend Services are loosely coupled and communicate via a so called message queue. Such services require access to the message queue. Therefore, all backend services need (a) a service-specific user account with the message queue and (b) the privileges to access the message queue. This needs to be configured in `secrets/message-queue/definitions-users .json` in section `users` for the service accounts and in section `permissions`.

## Service Development

For service development it is recommended to provide a builder override that replaces the service image with a local build specification. Note that for this purpose the image name MUST be changed, too. Otherwise docker will use the original image and not the build. 
