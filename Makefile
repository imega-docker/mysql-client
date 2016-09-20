# Build rootfs for mysql-client

DOCKER_RM = false

build:
	@docker run --rm \
		-v $(CURDIR)/runner:/runner \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/src:/src \
		imega/base-builder \
		--packages="mysql-client busybox"

test:
	@docker build -t imega/mysql-client:test .

	@docker run -d --name server_db imega/mysql

	@docker run --rm=$(DOCKER_RM) \
		-v $(CURDIR)/tests:/data \
		--link server_db:server \
		imega/mysql-client:test \
		mysql --host=server -e "source /data/dump.sql"

.PHONY: build
