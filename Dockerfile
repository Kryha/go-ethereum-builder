FROM ethereum/client-go:latest as watcher

FROM golang:alpine

RUN apk add --no-cache git gcc libc-dev make protobuf nodejs npm wget

RUN go get github.com/ethereum/go-ethereum

RUN wget -qO- https://api.github.com/repos/ethereum/solidity/releases/latest| \
    grep "browser_download_url"|grep "solc-static-linux"| cut -d '"' -f 4| wget -qi - -O /usr/bin/solc
RUN chmod +x /usr/bin/solc

RUN cd $GOPATH/src/github.com/ethereum/go-ethereum/ && make devtools