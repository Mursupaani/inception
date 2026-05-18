This file is written for another developer who needs to understand the technical structure, build process, and data persistence of your setup.

```markdown
# Developer Documentation

## Setting Up the Environment
To set up this project from a fresh clone, you must configure the local environment:

1. **Host Routing:**

    Add the domain to your local host resolution:

   ```bash
   sudo nano /etc/hosts
   # Add the following line:
   127.0.0.1    anpollan.42.fr

2. **Environment Variables:**

    Create a .env file inside the srcs/ directory containing:

    ```bash
    DOMAIN_NAME=anpollan.42.fr
    WORDPRESS_TITLE=inception
    WORDPRESS_DB_NAME=inception
    WORDPRESS_DB_USER=anpollan
    WORDPRESS_USER=anpollan_editor
    WORDPRESS_USER_EMAIL=antti.pollanen89@gmail.com
    WORDPRESS_ADMIN=boss_anpollan
    WORDPRESS_ADMIN_EMAIL=anpollan@student.hive.fi
    WORDPRESS_DB_HOST=mariadb

3. **Secrets Directory:**

    Create a secrets/ folder at the root of the project and populate it with four text files: db_password.txt, db_root_password.txt, wp_admin_password.txt, and wp_user_password.txt. Place your desired passwords inside them.

4. **Building and Launching:**
    
    The build process is automated via the Makefile. Running make will:

    Create the necessary physical data directories on the host machine.

    Execute docker compose -f ./srcs/docker-compose.yml up --build.

    Docker Compose will automatically build the Alpine-based images using their respective Dockerfiles, run the setup scripts, and start the containers.

5. **Container and Volume Management:**

    Use the following Docker Compose commands inside the srcs/ directory (or use the Makefile equivalents):

    View logs: docker compose logs -f (Append the service name, e.g., nginx, to filter).

    Enter a container: docker exec -it <container_name> sh

    List volumes: docker volume ls

    Inspect a volume: docker volume inspect <volume_name>

6. **Data Persistence:**

    Because Docker containers are ephemeral, all critical data is persisted on the host machine using bind-mounted volumes.

    MariaDB Data: Stored on the host at /home/$(USER)/data/mariadb/. This ensures the database is not wiped when the MariaDB container restarts.

    WordPress Files: Stored on the host at /home/$(USER)/data/wordpress/. This ensures themes, plugins, and core files are retained.

    These paths are securely mapped into the containers using local volume drivers defined in the docker-compose.yml file.
