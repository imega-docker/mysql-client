BUILDER_VER = 1.9.6
IMAGE=imega/mysql-client
TAG=latest

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
	@docker run --rm -it --link=server_db:server_db \
		imega/mysql-client:test mysql \
		--host=server_db \
		--database=imega \
		--user=root \
		--password=qwerty \
		--execute="select 100 hundred" | grep 100

clean:
	@-docker rm -fv server_db

release:
	@docker login --username $(DOCKER_USER) --password $(DOCKER_PASS)
	@docker push $(IMAGE):$(TAG)
	@docker push $(IMAGE):latest

.PHONY: build
