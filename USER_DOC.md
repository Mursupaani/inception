# User Documentation

## Provided Services
This infrastructure provides a fully functional, secure web stack known as a LEMP ('L'inux, 'E'nginx, 'M'ySQL), 'P'HP stack:
* **Web Server (NGINX):** Handles incoming web traffic securely over HTTPS.
* **Website (WordPress):** A functional content management system allowing you to publish articles and manage users.
* **Database (MariaDB):** Stores all users, posts, and settings for the WordPress site.

## Starting and Stopping the Project
To manage the infrastructure, use the provided `Makefile` located at the root of the project:
* **Start the project for the first time:** `make` (Creates the containers from the images and runs the services)
* **Start the project for the first time:** `make up` (If you have already created the containers, this starts the services) 
* **Stop the project safely:** `make down` (Leaves your data intact)
* **Wipe the project clean:** `make fclean` (WARNING: This deletes the database and website files!)

## Accessing the Website
* **Public Website:** Open a web browser and navigate to `https://anpollan.42.fr`.
* **Administration Panel:** Navigate to `https://anpollan.42.fr/wp-admin`. 

## Locating and Managing Credentials
To use the project, you have to create a .env file inside the srcs/ directory and have these environment variables defined e.g. as follows:
```
DOMAIN_NAME=anpollan.42.fr
WORDPRESS_TITLE=inception
WORDPRESS_DB_NAME=inception
WORDPRESS_DB_USER=anpollan
WORDPRESS_USER=anpollan_editor
WORDPRESS_USER_EMAIL=anpollan@email.com
WORDPRESS_ADMIN=boss_anpollan
WORDPRESS_ADMIN_EMAIL=anpollan@adminemail.fi
WORDPRESS_DB_HOST=mariadb
```

**Make sure that your /etc/hosts file maps ip 127.0.0.1 to the same DOMAIN_NAME as above e.g.
127.0.0.1 anpollan.42.fr**
```bash
sudo nano /etc/hosts
# Add the following line:
127.0.0.1    anpollan.42.fr
```

For security reasons, passwords are not stored in the repository. They are managed via Docker Secrets.
Create the following files and add your desired passwords. If you ever need to change or view the passwords, look inside the `secrets/` folder at the root of the project:
* `secrets/db_password.txt`
* `secrets/db_root_password.txt`
* `secrets/wp_admin_password.txt`
* `secrets/wp_user_password.txt`

## Checking Service Health
To verify that all services are running smoothly, open a terminal in the project directory and run:
* **Check that the services are running correctly:** `make status`
