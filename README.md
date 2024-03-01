# Docker PHP, Nginx, [MySQL | MariaDB | PostgreSQL]

> Only for DEV, not for production!

| 	        | 	                                              |
|:---------|:-----------------------------------------------|
| PHP      | `PHP 8.2`, `PHP 8.3`                           |
| Database | `MySQL 8.0`, `MariaDB 11.3.2`, `PostgreSQL 16` |
| Server   | `Nginx 1.25`, `nginx-proxy 1.5`                |
| Tools    | `XDebug 3.3.1`, `Adminer`                      |

## Setup

See virtual hosts `NGINX_VIRTUAL_HOST`, `ADMINER_VIRTUAL_HOST` in the `.env` file.

Add lines to the `/etc/hosts` file corresponding to the virtual hosts:

```
127.0.0.1 symfony.test
127.0.0.1 adminer.test
```

```
git clone git@github.com:amberlex78/symfony-docker.git && cd symfony-docker
```

```
make install
```

```
make test
```

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