# Integration Test

A set of docker compose configurations to localy test and verify the interplay of all services.

## Requirements

## Overview

### Configurations

### Secrets

## Getting Started

### Use GitHub docker registry images

```
docker compose -f docker-compose.yaml up -d
```

### Build images from source

```
docker compose -f docker-compose.yaml -f docker-compose.build.yaml up -d
```

### Mount local source code

```
docker compose -f docker-compose.yaml -f docker-compose.mount.yaml up -d
```

## Cloning Services

```
docker compose run clone-services
```

## Debugging services

Explain `.dev` overrides


