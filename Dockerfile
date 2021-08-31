FROM nvidia/cuda:10.0-devel
MAINTAINER Ben Shealy <btsheal@clemson.edu>

# install minibench from build context
WORKDIR /opt/minibench

COPY . .

# build minibench
RUN make