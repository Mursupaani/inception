# Developer Documentation

## Setting Up the Environment
To set up this project from a fresh clone, you must configure the local environment:

### 1. Prerequisites
Ensure the host machine (or virtual machine) has the following installed:
* `docker` (Engine)
* `docker compose` (Plugin)
* `make`

### 2. Host Routing
Add the domain to your local host resolution so it points to the local loopback address:
```bash
sudo nano /etc/hosts
# Add the following line:
127.0.0.1    anpollan.42.fr
```

### 3. Environment Variables
```
DOMAIN_NAME=anpollan.42.fr
WORDPRESS_TITLE=inception
WORDPRESS_DB_NAME=inception
WORDPRESS_DB_USER=anpollan
WORDPRESS_USER=anpollan_editor
WORDPRESS_USER_EMAIL=antti.pollanen89@gmail.com
WORDPRESS_ADMIN=boss_anpollan
WORDPRESS_ADMIN_EMAIL=anpollan@student.hive.fi
WORDPRESS_DB_HOST=mariadb
```

### 4. Secrets Directory
Create a secrets/ folder at the root of the project and populate it with four text files:
```
- db_password.txt
- db_root_password.txt
- wp_admin_password.txt
- wp_user_password.txt
```

### 5. Configuration Files
Before building, verify that the following custom configuration files are present in the repository. These files override the default Alpine package configurations:
```
- NGINX: srcs/requirements/nginx/conf/nginx_config.conf
(Defines the TLSv1.2/1.3 server block, port 443 listening, and FastCGI routing to WordPress).
```
```
- MariaDB: srcs/requirements/mariadb/conf/mariadb_config.cnf
(Configures the database host, port 3306, and networking bindings).
```
```
- WordPress (PHP-FPM): srcs/requirements/wordpress/conf/www.conf
(Configures the PHP FastCGI Process Manager to listen on port 9000 and handle child processes).
```

### 6. Building and Launching
The build process is completely automated via the Makefile. Running make at the root of the repository will:
```
1. Create the necessary physical data directories on the host machine.

2. Execute docker compose -f ./srcs/docker-compose.yml up --build.

3. Prompt Docker Compose to automatically build the Alpine-based images using their respective Dockerfiles, run the entrypoint setup scripts, and start the containers.
```
### 7. Container and Volume Management
```
You can manage the stack using the provided Makefile commands or raw Docker commands:
- View logs: make logs (or docker compose -f ./srcs/docker-compose.yml logs -f)
- Check status: make status (or docker compose -f ./srcs/docker-compose.yml ps)
- Enter a container shell: docker exec -it <container_name> sh
- List Docker volumes: docker volume ls
- Inspect a specific volume: docker volume inspect <volume_name>
```

### 8. Data Persistence
```
Because Docker containers are ephemeral, all critical data is persisted on the host machine using bind-mounted local volumes.

- MariaDB Data: Stored on the host at /home/anpollan/data/mariadb/. This ensures the database is not wiped when the MariaDB container restarts or is rebuilt.

- WordPress Files: Stored on the host at /home/anpollan/data/wordpress/. This ensures themes, plugins, and core files are retained across container lifecycles.

These paths are securely mapped into the containers using local volume drivers defined directly within the docker-compose.yml file.
```