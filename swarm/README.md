# Swarm

This folder contains the docker compose file to deploy it to a [docker swarm](https://docs.docker.com/engine/swarm/).

## Structure
To have a view on what is deployed where the compose files are organised like this:
```bash
.
├── <swarm_cluster_name>
│   ├── <stack_name>
│   │   └── compose.yml
```

## Requirments
The computer that deploys the stack to the swarm should have acces to at least one node of the swarm.

It use a dedicated [docker context](https://docs.docker.com/engine/manage-resources/contexts/) and run the dedicated `docker stack deploy` command

## Usage

```bash
docker context create --docker host=ssh://<user>@<ip_of_a_node> <swarm_cluster_name>

docker context use <swarm_cluster_name>

cd <swarm_cluster_name>/<stack>

docker stack deploy  -c compose.yml <stack_name>

```
