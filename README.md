# Integration-Test

A set of environments to test the interplay of the different components of the SDG Dashboard

## Getting started

### Run the latest containers to have a look. 

```
docker compose -f all.yaml up
```

### Run a frontend development environment with all bells and whistles.

```
docker compose -f dev-frontend-all.yaml up
```

### Run a frontend development environment with the bare minimum.

```
docker compose -f dev-frontend.yaml up
```

### Run the backend from source 

```
docker compose -f build-backend.yaml up --build
```

## Purpose

This repository contains a number of docker compose stacks for local development and integration testing. It comes with two types of stacks: 

- container stacks - stacks for integration testing only that pull all containers from their primary container registries.
- build stacks - stacks for integrated development that **depend on local repositories**

All stacks create a caddy reverse proxy on port `8080` and provide a Graphiql frontend on the [`/graphiql/` endpoint](http://localhost:8080/graphiql/) to check the database. Stacks with backend components also expose the RabbitMQ management UI on the [`/rabbitmq/` endpoint](http://localhost:8080/rabbitmq/). This allows to monitor the messaging. The frontend stacks provide access to the [dashboard](http://localhost:8080/dashboard/) as well as to dgraph's DQL UI `ratel` on the [`/ratel/` endpoint](http://localhost:8080/ratel/).

### Container Stacks

There are four flavours of container stacks

- `all.yaml` - runs the full system with active directory resolving
- `noad.yaml` - same as `all.yaml` but *without* active directory resolving
- `backend.yaml` - runs only the backend services 
- `frontend.yaml` - runs the frontend and the dgraph data-store

### Build and Development Stacks

The build and develoment stacks depend on the other repositories. These stacks expect the repositories to be fully in place to initiate a `docker build` process.

The following stacks are available: 

- `build-all.yaml` - build and run all containers of the system locally. 
- `build-backend.yaml` - build and run only the backend containers. 
- `build-frontend.yaml` - build and run only the frontend containers. 
- `dev-frontend.yaml` - same as build-frondend, but links the frontend files into a special caddy helper.
- `dev-frontend-all.yaml` - same as build-all, but links the frontend files into a special caddy helper.

It is mandatory to clone the following repositories into the same parent directory as the repository to which this file belongs. 

| Directory | all | backend | frontend |
| :--- | :---: | :---: | :---: |
| [../ad-resolver](https://github.com/sustainability-zhaw/ad-resolver) | ✅ | ✅ | | 
| [../dgraph-schema](https://github.com/sustainability-zhaw/dgraph-schema) | ✅ | ✅ | ✅ | 
| [../extraction-dspace](https://github.com/sustainability-zhaw/extraction-dspace) | ✅ | ✅ | | 
| [../extraction-projects](https://github.com/sustainability-zhaw/extraction-projects) | ✅ | ✅ | | 
| [../keyword-webhook](https://github.com/sustainability-zhaw/keyword-webhook) | ✅ | ✅ | ✅ | 
| [../sdg-indexer](https://github.com/sustainability-zhaw/sdg-indexer) | ✅ | ✅ | | 
| [../sustainability-dashboard](https://github.com/sustainability-zhaw/sustainability-dashboard) | ✅ | | ✅ | 

Note that the `ad-resolver` requires a connection password that is passed through an env-file. For more information, please consult the [ad-resolver](https://github.com/sustainability-zhaw/ad-resolver) repo.

Note that the `extraction-projects` requires an API key that is passed through an env-file. For more information, please consult the [extraction-projects](https://github.com/sustainability-zhaw/extraction-projects) repo.

