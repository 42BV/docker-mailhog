[![Docker Build Statu](https://img.shields.io/docker/build/42bv/mailhog.svg)](https://hub.docker.com/r/42bv/mailhog/builds/) ![Docker Stars](https://img.shields.io/docker/stars/42bv/mailhog.svg) [![Docker Pulls](https://img.shields.io/docker/pulls/42bv/mailhog.svg)](https://hub.docker.com/r/42bv/mailhog/) 

[![MailHog](https://github.com/42BV/docker-mailhog/blob/master/logo.png?raw=true)](https://github.com/mailhog/MailHog) 

# Docker - MailHog

The populair [MailHog](https://github.com/mailhog/MailHog) smtp server with a REST API and Web UI in a Docker container.

- [mhsendmail](https://github.com/mailhog/mhsendmail) is included for sending test mails.
- Optional save the messages to disk.
- Based on the official [golang:alpine](https://hub.docker.com/_/golang/) image.

---

## Supported tags and Dockerfile

- `latest`


## Pull  

Get the latest version:
```
docker pull 42bv/mailhog:latest
```

## Build  

Clone the repository:
```
git clone git@github.com:42BV/docker-mailhog.git
cd docker-mailhog
```

Build the current Dockerfile  and tag the image:   
```
docker build -t mailhog .
```

Build with a specific environment variable, for example STORAGE:   
```
docker build --build-arg STORAGE=memory -t mailhog .
```

## Run
  
Run with default settings:
```
docker run --rm -d -p 587:587 -p 8025:8025 --name mailhog 42bv/mailhog
```

Run with volume mounted to save messages to disk in Maildir format: 
```
docker run -d -p 587:587 -p 8025:8025 -v $PWD/Maildir:/srv/Maildir --name mailhog 42bv/mailhog
```

---

## Deployment

For a production deployment you probably want to utilize a supervisor process to monitor the Docker container. 

For a standalone installation, one of the most simple solutions is to use [systemd](https://www.freedesktop.org/wiki/Software/systemd/), which comes pre-installed with most modern Linux installations.

#### Requirements

* systemd
* docker

#### Installation

Place the systemd unit `mailhog.service` file in `/etc/systemd/system/`
```
[Unit]
Description=MailHog
BindsTo==docker.service
After=docker.service
Documentation="https://github.com/42BV/docker-mailhog"

[Service]
Restart=always
RestartSec=3
ExecStartPre=-/usr/bin/docker rm -f mailhog
ExecStart=/usr/bin/docker run --rm -p 587:587 -p 8025:8025 --name mailhog 42bv/mailhog:latest
ExecStop=-/usr/bin/docker stop mailhog
ExecStopPost=-/usr/bin/docker rm -f mailhog

[Install]
WantedBy=multi-user.target
```

Reload systemd, scanning for new or changed units:
```
systemctl daemon-reload
```

Start a unit immediately:
```
systemctl start mailhog
```

Enable the service to be started on bootup:
```
systemctl enable mailhog
```

---

## Usage

### MailHog UI

#### Default
Once the container is running you can access the web UI at [http://localhost:8025](http://localhost:8025). 

#### Customize
You can change the mapped port by running the container with `-p 8000:8025` instead, or by building the Dockerfile with the `--build-arg UI_PORT=8000` for example.

### Sending mails

#### mhsendmail

A sendmail replacement which forwards mail to an SMTP server. This tool is include in the Docker image. 

Use mhsendmail for sending test mails to your running MailHog instance:

```
docker exec -i mailhog mhsendmail --smtp-addr="localhost:587" <<EOF 
From: Me <me@example.com>
To: You <you@example.com>
Subject: Test Message

Hello there!
EOF
```

### REST API

See the REST API documentation for more info.

* [APIv2](https://github.com/mailhog/MailHog/blob/master/docs/APIv2.md)
* [APIv1](https://github.com/mailhog/MailHog/blob/master/docs/APIv1.md)

#### Curl

Search messages for containing a string, for example "Hello":
```
curl -X "GET" http://localhost:8025/api/v2/search?kind=containing&query=Hello 
```

Delete all Messages:
```
curl -X "DELETE" http://localhost:8025/api/v1/messages
```

### Project Integration

#### Configuration

Configure your application to use MailHog for SMTP delivery.

| Property  | Value     | Note     |
|:--------- |:--------- | :------- |
| HOSTNAME  | localhost | required |
| PORT      | 587       | required |
| USERNAME  |           | ignored  |
| PASSWORD  |           | ignored  |
| TLS       |           | ignored  |
| SSL       |           | ignored  |

#### Libraries

* [APIv2 library for NodeJS](https://github.com/blueimp/mailhog-node)

### Issues and limitations

* No SSL or TLS support yet
* No Java client yet

---

## License

Released under the [MIT license](https://github.com/42BV/docker-mailhog/blob/master/LICENSE.md).