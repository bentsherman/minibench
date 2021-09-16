FROM nvidia/cuda:11.1-devel
MAINTAINER Ben Shealy <btsheal@clemson.edu>

# install minibench from build context
WORKDIR /opt/minibench

COPY . .

# build minibench
RUN make install PREFIX="/usr/local/bin"