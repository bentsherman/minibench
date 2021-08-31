
all: bin/minibench

bin:
	mkdir bin

bin/%: %.cu | bin
	nvcc $^ -o $@

test: bin/minibench
	bin/minibench trace

docker:
	docker build -t bentsherman/minibench .
	docker push bentsherman/minibench

clean:
	rm -f bin/minibench
	docker image rm -f bentsherman/minibench
