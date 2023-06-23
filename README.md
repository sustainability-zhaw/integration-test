# Integration Test

A set of docker compose configurations to localy test and verify the interplay of all services.

## Requirements

## Overview

### Configurations

### Secrets

## Getting Started

### Initializing Database

This needs to be run once.

```
docker compose up database-init
```

### Use the latest GitHub docker registry images

```
docker compose up -d
```

### Build images from source

```
docker compose -f docker-compose.build.yaml up -d
```

### Build images and mount local source code

```
docker compose -f docker-compose.mount.yaml up -d
```

## Cloning Services

```
docker compose run clone-services
```

## Debugging services

Explain `.dev` overrides


# TODO:

- [ ] Create health check for database
- [ ] Wait healthy database


