FROM golang:alpine

LABEL maintainer="Terence Westphal"

ARG HOSTNAME
ARG SMTP_PORT=587
ARG API_PORT=8025
ARG UI_PORT=8025
ARG STORAGE="maildir"

# Configure MailHog
ENV MH_HOSTNAME="${HOSTNAME}" \
    MH_SMTP_BIND_ADDR="0.0.0.0:${SMTP_PORT}" \
    MH_API_BIND_ADDR="0.0.0.0:${API_PORT}" \
    MH_UI_BIND_ADDR="0.0.0.0:${UI_PORT}" \
    MH_STORAGE="${STORAGE}" \
    MH_MAILDIR_PATH="/srv/Maildir"

# Install dependencies
RUN apk --no-cache add git

# Build and install aMailHog from source
RUN go get github.com/mailhog/MailHog

# Build and install mhsendmail
RUN go get github.com/mailhog/mhsendmail

# Expose Maildir volume
RUN mkdir -p /srv/Maildir;
VOLUME /srv/Maildir

# Expose the SMTP (587) and HTTP (8025) ports:
EXPOSE 587 8025

# Start MailHog server
ENTRYPOINT ["MailHog"]