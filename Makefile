
PREFIX="bin"

all: minibench

${PREFIX}:
	mkdir ${PREFIX}

%: %.cu
	nvcc $^ -o $@

test: minibench
	minibench trace

install: minibench | ${PREFIX}
	mv $< ${PREFIX}

clean:
	rm -f minibench ${PREFIX}/minibench

docker-build:
	docker build -t bentsherman/minibench .

docker-push: docker-build
	docker push bentsherman/minibench

docker-test: docker-build
	docker run --rm bentsherman/minibench minibench trace

docker-clean:
	docker image rm -f bentsherman/minibench
