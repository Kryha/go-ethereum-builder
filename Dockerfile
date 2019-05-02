FROM golang:1.11-alpine

RUN apk add --no-cache git gcc libc-dev make

RUN go get github.com/ethereum/go-ethereum

RUN wget -q -O /usr/bin/solc https://github.com/ethereum/solidity/releases/download/v0.5.7/solc-static-linux 
RUN chmod +x /usr/bin/solc

RUN cd $GOPATH/src/github.com/ethereum/go-ethereum/ && make && make devtools
