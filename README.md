# Integration Test

A set of docker compose configurations to localy test and verify the interplay of all services.

## Prerequisite

- Docker Compsoe >= 2.20.0

## Configurations

### Configs

Non sensitive configuration is read from  the `configs` directory. Defaults for testing are already provided.

### Secrets

Sensitive configuration like keys and credentials are read from the `secrets` directory. The `secrets-exmple` directory can be copied and renamed to `secrets`. 

You will need to provide your own keys and credentials. Look at the GitHub repository of the individual services for more information.

## Getting Started

### 1. Initializing Database

Run this once before starting the system for the first time to install the schema and load required data.

```
docker compose run --rm dgraph-schema
```

### 2. Clone services (Optional)

To use the `compose.build.yaml` or `compose.mount.yaml` override clone all or some services so that they are a sibling directory of this project.

### 3. Starting the system

The system can be started in different configurations depending on the combination of overrides and profiles used.

Below are the most commonly used system configurations to start the `full` system. For an overview of available profiles see [Profiles](#Profiles).

#### Use the latest stable docker images from GitHub

```
docker compose --profile full up -d
```

#### Use the latest stable docker images and mount local source code

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

|Service|full|frontend|backend|init|
|-|----|--------|-------|---------|
|reverse-proxy|:white_check_mark:|:white_check_mark:|:white_check_mark:||
|database|:white_check_mark:|:white_check_mark:|:white_check_mark:|:white_check_mark:|
|dgraph-schema||||:white_check_mark:|
|graphiql|:white_check_mark:|:white_check_mark:|:white_check_mark:||
|sustainability-dashboard|:white_check_mark:|:white_check_mark:|||
|download-gateway|:white_check_mark:||:white_check_mark:||
|message-queue|:white_check_mark:||:white_check_mark:||
|keyword-webhook|:white_check_mark:||:white_check_mark:||
|sdg-indexer|:white_check_mark:||:white_check_mark:||
|extraction-dspace|:white_check_mark:||:white_check_mark:||
|extraction-projects|:white_check_mark:||:white_check_mark:||
|ad-resolve|:white_check_mark:||:white_check_mark:||
|resolver-classification|:white_check_mark:||:white_check_mark:||
|resolver-department|:white_check_mark:||:white_check_mark:||

## Adding a new Service 

Any new service should:

- Add a service entry in compose.yaml and overrides.
- Have the `full` profile, along with any other appropriate profiles assigned.
- Add configuration files for testing in the [configs](configs/) directory.
- Add example secrets in the [secrets-example](secrets-example/) directory.
- Add a message queue user and permission entry under [definition.json](configs/message-queue/definitions.json) if using message queue.
  - Tip: Duplicate entry of another service and change the name. These are all test users with the same password `guest`.
- Add a message queue entry under [definitions.json](configs/message-queue/definitions.json) if owning any message queues.

### Frontend Service

A frontend service has an endpoint in the reverse proxy of the system. 

All frontend services have to provide a http endpoint for the user interaction. 

This endpoint has to be configured with an appropriately prefixed path in the reverse proxy.

Check `configs/reverse-proxy/Caddyfile` for examples. 

### Backend Serivce

A backend service is a service that communicates only to the database and is triggered by other services.

Backend Services are loosely coupled and communicate via a so called message queue. Such services require access to the message queue. Therefore, all backend services need (a) a service-specific user account with the message queue and (b) the privileges to access the message queue. This needs to be configured in `secrets/message-queue/definitions-users .json` in section `users` for the service accounts and in section `permissions`.
