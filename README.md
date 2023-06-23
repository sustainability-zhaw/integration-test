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

## Cloning Services

```
docker compose run clone-services
```

## Debugging services

Explain `.dev` overrides
