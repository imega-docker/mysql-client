BUILDER_VER = 1.9.6
IMAGE=imega/mysql-client
TAG=latest

release: TAG=$(shell curl --silent "https://raw.githubusercontent.com/alpinelinux/aports/master/main/mariadb/APKBUILD" | grep pkgver= | sed 's/pkgver=//g')
release: build
	@docker pull $(IMAGE):${TAG} || ( \
		docker push $(IMAGE):$(TAG) && \
		docker push $(IMAGE):latest \
	)

build: buildfs test
	@docker build -t $(IMAGE):$(TAG) .
	@docker tag $(IMAGE):$(TAG) $(IMAGE):latest

buildfs:
	@docker run --rm \
		-v $(CURDIR)/runner:/runner \
		-v $(CURDIR)/build:/build \
		-v $(CURDIR)/src:/src \
		imega/base-builder:$(BUILDER_VER) \
		--packages="mysql-client@edge-main busybox"

test: clean
	@docker build -t $(IMAGE):test .
	@docker run -d -e MYSQL_ROOT_PASSWORD=qwerty \
		-v $(CURDIR)/schemas:/docker-entrypoint-initdb.d \
		--name server_db \
		mysql:5.7.19
	@docker run --rm -t --link=server_db:server_db \
		imega/mysql-client:test mysql \
		--host=server_db \
		--database=imega \
		--user=root \
		--password=qwerty \
		--execute="select 100 hundred" | grep 100

clean:
	@-docker rm -fv server_db

.PHONY: build
