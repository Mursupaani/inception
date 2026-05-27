This file is written for an end-user or system administrator who just needs to know how to use and monitor the stack.

```markdown
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
For security reasons, passwords are not stored in the repository. They are managed via Docker Secrets.
Create the following files and add your desired passwords. If you ever need to change or view the passwords, look inside the `secrets/` folder at the root of the project:
* `secrets/db_password.txt`
* `secrets/db_root_password.txt`
* `secrets/wp_admin_password.txt`
* `secrets/wp_user_password.txt`

## Checking Service Health
To verify that all services are running smoothly, open a terminal in the project directory and run:
* **Check that the services are running correctly:** `make status`
