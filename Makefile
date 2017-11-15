IMAGE='dseg/node6-python2-pip-yarn-alpine'
VERSION='1.1.8'

default: run

run: build

publish:
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest	

build: Dockerfile
	docker build -t $(IMAGE):$(VERSION) .
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
