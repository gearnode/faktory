FROM ubuntu:20.04

LABEL vendor="contribsys"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y ca-certificates \
                       redis \
                       socat && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean -y

COPY ./faktory /

RUN mkdir -p /root/.faktory/db \
             /var/lib/faktory/db \
             /etc/faktory

EXPOSE 7419 7420

CMD ["/faktory", "-w", "0.0.0.0:7420", "-b", "0.0.0.0:7419", "-e", "development"]
