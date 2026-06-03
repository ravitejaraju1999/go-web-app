from golang:1.22.5-alpine as base
workdir /app
copy go.mod .

run go mod download
copy . .

run go build -o main .

#final stage
from gcr.io/distroless/base

copy --from=base /app/main .

copy --from=base /app/static ./static

expose 8080

cmd ["/main"]



