build:
	docker build -t sminnee/silverstripe-lamp .

push: build
	docker push sminnee/silverstripe-lamp
