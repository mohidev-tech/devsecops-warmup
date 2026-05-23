.PHONY: run test build image scan clean

run:
	go run ./cmd/server

test:
	go test -race -count=1 ./...

build:
	CGO_ENABLED=0 go build -ldflags="-s -w" -o bin/server ./cmd/server

image:
	docker build -t devsecops-warmup:dev .

scan:
	trivy image --severity CRITICAL,HIGH --ignore-unfixed devsecops-warmup:dev

clean:
	rm -rf bin/ dist/
