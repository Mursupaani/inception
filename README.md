*This project has been created as part of the 42 curriculum by anpollan*

## Description
Inception is a System Administration project that aims to broaden knowledge of virtualized infrastructure using Docker. The goal is to set up a small, fully functional, and secure internal network composed of different services running in dedicated containers. 

The infrastructure is built using the penultimate stable version of Alpine Linux and includes:
- **NGINX**: A web server acting as the sole entrypoint via port 443, secured with TLSv1.2/TLSv1.3.
- **WordPress + PHP-FPM**: The content management system generating the website.
- **MariaDB**: The database storing the website's data.

## Technical Comparisons
* **Virtual Machines vs Docker:** A Virtual Machine (VM) virtualizes entire hardware, requiring a full guest operating system for every instance, which consumes significant CPU and RAM. Docker virtualizes only the OS kernel. Containers share the host's kernel but run in isolated user spaces, making them much faster to boot and significantly more lightweight.
* **Secrets vs Environment Variables:** Environment variables are often visible to any process running inside the container and can be exposed if someone runs `docker inspect`. Docker Secrets are much more secure because they mount the sensitive data directly into the container as temporary, read-only files in an in-memory filesystem (tmpfs), keeping them hidden from the environment.
* **Docker Network vs Host Network:** Using the Host network removes isolation, binding the container directly to the host machine's network interfaces (e.g., exposing port 3306 directly on the host). A Docker Bridge Network isolates the containers in their own private internal network. They can communicate with each other using internal DNS, but the host and outside world cannot reach them unless specific ports (like 443) are explicitly published.
* **Docker Volumes vs Bind Mounts:** Standard Docker Volumes are managed entirely by Docker and stored in Docker's internal directory structure (usually `/var/lib/docker/volumes`), abstracting the exact host path away from the user. Bind Mounts map a specific, exact path on the host machine (e.g., `/home/anpollan/data`) directly into a container directory. This project uses local driver options to mount specific host directories to ensure data persistence even if containers are destroyed.

## Instructions
To build and launch the project:
1. Ensure your `/etc/hosts` file routes `anpollan.42.fr` to `127.0.0.1`.
2. Ensure you have the required `.env` file in `./srcs/` and your passwords inside the `./secrets/` directory.
3. Run the following command at the root of the repository:
   ```bash
   make
4. To stop the containers without destroying the data, run:
   ```bash
    make down
5. To completely remove the containers, networks and all persistnet data, run:
   ```bash
    make fclean

## Resources
Docker Official Documentation: Docker Compose, Secrets, Volumes, and Networks.
https://docs.docker.com/compose/
https://docs.docker.com/engine/swarm/secrets/
https://docs.docker.com/engine/storage/volumes/
https://docs.docker.com/compose/how-tos/networking/  

https://dev.to/alejiri/docker-nginx-wordpress-mariadb-tutorial-inception42-1eok  
https://github.com/TanjaMenkovic/inception  

AI Usage: AI was utilized during this project heavily to...
