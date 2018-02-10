# Omeka S
Docker image for Omeka S follows official installation guild (https://github.com/omeka/omeka-s/blob/develop/README.md).

## Quick Start
Create a docker-compose.yml file with the following content in any directory.

```
version: '3'

services:
  omeka-s:
    image: infolounge/omeka-s:latest
    ports:
      - 80:80
    depends_on:
      - mysql
    volumes:
      - /some/directory/for/document/root:/var/www/html
    environment:
      OMEKA_S_DB_HOST: mysql
      OMEKA_S_DB_NAME: name
      OMEKA_S_DB_USER: user
      OMEKA_S_DB_PASSWORD: password

  mysql:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: name
      MYSQL_USER: user
      MYSQL_PASSWORD: password
```

Run the docker-compose up [-d] command in the same directory.

## Environment Variables
When you start the infolounge/omeka-s image, you can set the configuration for connecting MySQL server. Only if all of these varaibles are propery set, config/database.ini is automaticaly configured. Otherwise, you should configure manualy after booting the container.

- `OMEKA_S_DB_HOST`: MySQL DB Host
- `OMEKA_S_DB_NAME`: MySQL DB Name
- `OMEKA_S_DB_USER`: MySQL DB User
- `OMEKA_S_DB_PASSWORD`: MySQL DB Password

## Volumes
For persistence, you can mount an arbitrary host directory to `/var/www/html` (document root) as a [data volume](https://docs.docker.com/storage/volumes/).

