FROM golang:1.21 as build
WORKDIR /App
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o main .
#
FROM gcr.io/distroless/base
COPY --from=build /App/main .
COPY --from=build /App/static ./static
EXPOSE 8080
CMD ["./main"]
