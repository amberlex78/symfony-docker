# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec php-fpm

# Executables
PHP      = $(PHP_CONT) php
CONSOLE  = @$(PHP) bin/console
PHPUNIT  = @$(PHP) bin/phpunit
COMPOSER = $(PHP_CONT) composer

# Misc
.DEFAULT_GOAL = help
.PHONY        : help install bash composer test console clean route restart rebuild build up down start stop phpstan cs-diff cs-fix composer-validate

##
##—————————————————————————————— The Symfony Docker Makefile
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

##—————————————————————————————— App
install: ## Install App
	@$(DOCKER_COMP) build --pull #--no-cache
	@$(DOCKER_COMP) up --detach
	@$(COMPOSER) install
	@$(MAKE) test

bash: ## Bash
	@$(PHP_CONT) bash

composer: ## Run composer command (Example: make composer c='req symfony/uid')
	@$(COMPOSER) $(c)

test: ## Run all tests (Example specify: make test c=tests/Functional)
	@$(PHPUNIT) $(c)

console: ## Run console (Example: make console c=make:controller)
	@$(CONSOLE) $(c)

clean: ## Clear App cache (env=dev)
	@$(CONSOLE) cache:clear --env=dev

route: ## Lists all your application routes
	@$(CONSOLE) debug:route

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
