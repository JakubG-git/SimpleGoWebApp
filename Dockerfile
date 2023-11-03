FROM golang AS build
LABEL authors="Jakub"

RUN mkdir /app

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main

FROM scratch AS bin
COPY --from=build /app/main /bin/main
EXPOSE 8080
ENTRYPOINT ["/bin/main"]