
PREFIX="bin"

all: minibench

${PREFIX}:
	mkdir ${PREFIX}

%: %.cpp
	nvcc -x cu -o $@ \
		-gencode=arch=compute_52,code=sm_52 \
		-gencode=arch=compute_60,code=sm_60 \
		-gencode=arch=compute_61,code=sm_61 \
		-gencode=arch=compute_70,code=sm_70 \
		-gencode=arch=compute_75,code=sm_75 \
		-gencode=arch=compute_86,code=sm_86 \
		$^

test: minibench
	minibench trace

install: minibench | ${PREFIX}
	mv $< ${PREFIX}

clean:
	rm -f minibench ${PREFIX}/minibench

docker-build:
	rm -rf .nextflow* trace*
	docker build -t bentsherman/minibench .

docker-push: docker-build
	docker push bentsherman/minibench

docker-test: docker-build
	docker run --rm bentsherman/minibench minibench trace

docker-clean:
	docker image rm -f bentsherman/minibench
