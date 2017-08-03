[![Docker Build Statu](https://img.shields.io/docker/build/42BV/docker-mailhog.svg)](https://hub.docker.com/r/42BV/docker-mailhog/builds/) ![Docker Stars](https://img.shields.io/docker/stars/42BV/docker-mailhog.svg) [![Docker Pulls](https://img.shields.io/docker/pulls/42BV/docker-mailhog.svg)](https://hub.docker.com/r/42BV/docker-mailhog/) 

[![MailHog](https://github.com/42BV/docker-mailhog/blob/master/logo.png?raw=true)](https://github.com/mailhog/MailHog) 

# Docker - MailHog

- Based on the official [golang:alpine](https://hub.docker.com/_/golang/) image.

## Supported tags and Dockerfile

- `develop` ([Dockerfile](https://raw.githubusercontent.com/42BV/docker-mailhog/develop/Dockerfile))
- `latest`


## Pull  

Get the latest version:
```
docker pull 42bv/mailhog:latest
```

## Build  

Build the current Dockerfile  and tag the image:   
```
docker build -t mailhog .
```

Build with a specific environment variable, for example SMTP_PORT:   
```
docker build --build-arg STORAGE=memory -t mailhog .
```

## Run
  
Run with default settings:
```
docker run -d -p 587:587 -p 8025:8025 --name mailhog 42bv/mailhog
```

Run with volume mounted: 
```
docker run -d -p 587:587 -p 8025:8025 -v $PWD/Maildir:/srv/Maildir --name mailhog 42bv/mailhog
```

