repo = tabashir
name = hiawatha
fullname = $(repo)/$(name)
vol_dir = /local/docker/volumes
html_dir = /var/www/html

help: env
	@echo "------ targets ------"
	@echo "make build -- build docker images"
	@echo "make refresh -- build docker images (cached)"
	@echo "make start -- run container"
	@echo "make stop -- stop container"

env:
	@echo "------ current variables ------"
	@echo "repo: $(repo)"
	@echo "name: $(name)"
	@echo "fullname: $(fullname)"
	@echo "vol_dir: $(vol_dir)"
	@echo "html_dir: $(html_dir)"

build:
	docker build --no-cache --rm -t $(fullname) .

refresh:
	docker build -t $(fullname) .

start:
	@echo "This is a base image. It is not meant to be run directly!"
	@echo "However, run with: docker run -d --name <sitename> -v $(vol_dir)/sitename:$(html_dir) -v $(vol_dir)/etc/sitename:/etc/sitename -p 50100:80 $(fullname)"

stop:
	docker stop $(name)
	docker ps -aqf "ancestor=$(fullname)" | xargs --no-run-if-empty docker rm

clean:
	docker images -q $(fullname) | xargs --no-run-if-empty docker rmi


