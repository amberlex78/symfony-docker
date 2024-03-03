# Docker PHP, Nginx, [MySQL | MariaDB | PostgreSQL]

> Only for DEV, not for production!

| 	        | 	                                              |
|:---------|:-----------------------------------------------|
| PHP      | `PHP 8.2`, `PHP 8.3`                           |
| Database | `MySQL 8.0`, `MariaDB 11.3.2`, `PostgreSQL 16` |
| Server   | `Nginx 1.25`, `nginx-proxy 1.5`                |
| Tools    | `XDebug 3.3.1`, `Adminer`, `pdAdmin 4`         |

## Setup

> By default will be installed PHP 8.3, PostgreSQL 16, pdAdmin 4

Clone repository:

```
git clone git@github.com:amberlex78/symfony-docker.git && cd symfony-docker
```

Install project:
```
make install
```

## Config

See virtual hosts `NGINX_VIRTUAL_HOST`, `ADMINER_VIRTUAL_HOST` in the `.env` file.

Add lines to the `/etc/hosts` file corresponding to the virtual hosts:

```
127.0.0.1 symfony.test
```
In browser go to the `symfony.test`

![](art/01-symfony-test.png)

In browser go to the `symfony.test/health-check`

![](art/02-health-check.png)

> P.S. My `/etc/hosts` file for different projects:

```
127.0.0.1 example.test
127.0.0.1 project.test

127.0.0.1 symfony.test
127.0.0.1 laravel.test

127.0.0.1 adminer.test
127.0.0.1 pgadmin.test
```

## Connect to Database

### PostgreSQL

In browser go to the `pgadmin.test`

```
Email:    username@example.com
Password: password
```

> These credentials are set in the `compose.override.yaml`

![](art/03-pgAdmin-Login.png)

Then `Add New Server` and fill in the form:

![](art/04-paAdmin-Connection.png)

> These credentials are set in the `.env` file

### MySQL or MariaDB

In browser go to the `adminer.test`

```
Server:   db
Username: username
Password: password
Database: database

```
![](art/05-Adminer-Connection.png)

## Makefile commands

To show available commands, type `make`

---
P.S. My `/etc/hosts` file for different projects:

```
127.0.0.1 example.test
127.0.0.1 project.test

127.0.0.1 symfony.test
127.0.0.1 laravel.test

127.0.0.1 adminer.test
127.0.0.1 pgadmin.test
```