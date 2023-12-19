# Integration Test

A set of docker compose configurations to localy test and verify the interplay of all services.

## Configurations

### Configs

Non sensitive configuration is read from  the `configs` directory. Defaults for testing are already provided.

### Secrets

Sensitive configuration like keys and credentials are read from the `secrets` directory. The `secrets-exmple` directory can be copied and renamed to `secrets`. 

You will need to provide your own keys and credentials. Look at the GitHub repository of the individual services for more information.

## Getting Started

### 1. Initializing Database

Run this once before starting the system to install the schema and load required data.

```
docker compose run --rm init-database
```

### 2. Starting the system

The system can be started in different configurations depending on the combination of overrides and profiles used.

Below are the most commonly used system configurations to start the `full` system. For an overview of available profiles see [Profiles](#Profiles).

#### Use the latest docker images from GitHub

```
docker compose --profile full up -d
```

#### Use the latest docker images and mount local source code

```
docker compose -f compose.yaml -f compose.mount.yaml --profile full up -d 
```

#### Build images from source

```
docker compose -f compose.yaml -f compose.build.yaml --profile full up -d
```

#### Build images from source and mount local source code

```
docker compose -f compose.yaml -f compose.build.yaml -f compose.mount.yaml --profile full up -d
```

### Shutting down the system

```
docker compose --profile full down
```

## Profiles

| |full|frontend|backend|bootstrap|
|-|----|--------|-------|---------|
|reverse-proxy|:white_check_mark:|:white_check_mark:|:white_check_mark:||
|database|:white_check_mark:|:white_check_mark:|:white_check_mark:|:white_check_mark:|
|graphiql|:white_check_mark:|:white_check_mark:|:white_check_mark:||
|sustainability-dashboard|:white_check_mark:|:white_check_mark:|||
|download-gateway|:white_check_mark:|:white_check_mark:|||
|message-queue|:white_check_mark:||:white_check_mark:||
|keyword-webhook|:white_check_mark:||:white_check_mark:||
|sdg-indexer|:white_check_mark:||:white_check_mark:||
|extraction-dspace|:white_check_mark:||:white_check_mark:||
|extraction-projects|:white_check_mark:||:white_check_mark:||
|ad-resolve|:white_check_mark:||:white_check_mark:||
|resolver-classification|:white_check_mark:||:white_check_mark:||
|resolver-department|:white_check_mark:||:white_check_mark:||
|init-database||||:white_check_mark:|

## Overrides

TODO Explain overrides

### Using overrides for frontend development

The frontend development does not require building of most of the backend services and is basically focused around the static files served by the dashboard container. 

The following command launches the default system and sideloads the local dashboard code. This override allows to edit the source code without building and restarting all containers. 

```
docker compose -f docker-compose.yaml -f ../sustainability-dashboard/docker-compose-override.yaml up -d
```

This assumes that the dashboard repo is in a sibling directory next to the integration tests. 

## Adding a new Service 

Any new service shoud provide an `docker-compose-override.yaml`-file to be used as override for the integration stack. 

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
