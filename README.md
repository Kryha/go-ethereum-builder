# go-ethereum-builder

Builder image that significantly speeds up building of ethereum/client-go projects.

Example usage:

```
FROM kryha/go-ethereum-builder as builder

WORKDIR $GOPATH/src/horizon/contracts/
COPY contracts/ .
RUN solc --abi -o abi Forward.sol
RUN abigen -sol Forward.sol -pkg Forward -out forward.go 

WORKDIR $GOPATH/src/horizon/deploy/
COPY deploy/ .
RUN go get -d -v
RUN go build deploy.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /usr/src/horizon

COPY --from=builder /go/src/horizon/deploy/deploy .
```
