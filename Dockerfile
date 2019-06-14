FROM golang:1.12

ARG GIT_CHECKOUT_ARGS=v0.35.0

COPY scripts/run-gaia.sh /usr/local/bin

COPY seed/ /tmp/seed/

RUN mkdir -p $GOPATH/src/github.com/cosmos && \
    cd $GOPATH/src/github.com/cosmos && \
    git clone https://github.com/cosmos/cosmos-sdk && \
    cd cosmos-sdk && git checkout $GIT_CHECKOUT_ARGS

RUN cd $GOPATH/src/github.com/cosmos/cosmos-sdk && \
    make tools && \
    make install && \
    chmod +x /usr/local/bin/run-gaia.sh

EXPOSE 26656
EXPOSE 26657

CMD ["/bin/bash", "/usr/local/bin/run-gaia.sh"]
