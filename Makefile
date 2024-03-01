# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php-fpm

# Executables
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer

# Misc
.DEFAULT_GOAL = help
.PHONY        : help install bash composer console test restart rebuild build up down start  phpstan cs-diff cs-fix composer-validate

##
##—————————————————————————————— The Symfony Docker Makefile
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##—————————————————————————————— App
install: ## Install App
	@$(DOCKER_COMP) build --pull #--no-cache
	@$(DOCKER_COMP) up --detach
	@$(COMPOSER) install

bash: ## Bash
	@$(PHP_CONT) bash

composer: ## Run composer (Example: make composer c='req symfony/uid')
	@$(COMPOSER) $(c)

console: ## Run console (Example: make console c=debug:route)
	@$(PHP) bin/console $(c)

test: ## Run all tests
	@$(PHP) bin/phpunit $(c)

clean: ## Clear App cache (env=dev)
	@$(PHP) bin/console cache:clear --env=dev

##—————————————————————————————— Docker
restart: stop start ## Restart the Docker containers (stop start)
rebuild: down build up ## Rebuild the Docker containers (down build up)

build: ## Build Docker images
	@$(DOCKER_COMP) build

up: ## Start Docker containers in detached mode
	@$(DOCKER_COMP) up --detach

down: ## Stop and remove Docker containers and orphaned volumes
	@$(DOCKER_COMP) down --remove-orphans

start: ## Start Docker containers
	@${DOCKER_COMP} start

stop: ## Stop Docker containers
	@${DOCKER_COMP} stop

##—————————————————————————————— Static code analysis
phpstan: ## Run the static analysis of code.
	@${PHP_CONT} vendor/bin/phpstan analyse -c phpstan.neon
	@${PHP_CONT} vendor/bin/phpstan clear-result-cache

cs-diff: ## Show coding standards problems (without making changes)
	@${PHP_CONT} vendor/bin/php-cs-fixer fix --dry-run --diff

cs-fix: ## Fix as much coding standards problems
	@${PHP_CONT} vendor/bin/php-cs-fixer fix

composer-validate: ## Validate your composer.json file
	${PHP_CONT} composer validate
