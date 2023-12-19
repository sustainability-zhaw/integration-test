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

