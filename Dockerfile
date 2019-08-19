FROM debian:10

ENV WORKDIR=/tmp

COPY ./setup/*.sh /tmp/
RUN sh setup_essentials.sh

# vim setup

COPY ./.vimrc /tmp/
COPY ./.vim /tmp/
RUN sh setup_vim.sh

# go setup

ENV GOROOT=/usr/local/go
RUN mkdir -p $HOME/environment/go
ENV GOPATH=$HOME/environment/go
RUN sh setup_go.sh
ENV PATH=$PATH:$GOROOT/bin

RUN sh setup_node.sh
