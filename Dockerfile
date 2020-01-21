FROM debian:9.11-slim AS debian-updated

LABEL maintainer="hola@jesusgomez.io"

RUN apt-get update

#
# netcat openbsd stage
#
FROM debian-updated AS nc

# default version
ARG NETCAT_OPENBSD_VERSION=1.130-3

RUN apt-get install -y --no-install-recommends \
    netcat-openbsd=$NETCAT_OPENBSD_VERSION \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/nc"]

#
# netcat traditional stage
#
FROM debian-updated AS nc-traditional

# default version
ARG NETCAT_TRADITIONAL_VERSION=1.10-41+b1

RUN apt-get install -y --no-install-recommends \
    netcat-traditional=$NETCAT_TRADITIONAL_VERSION \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/nc"]

#
# ncat builder stage
#
FROM debian-updated AS ncat-builder

# default version
ARG NCAT_VERSION=7.80

ADD https://nmap.org/dist/nmap-$NCAT_VERSION.tar.bz2 /tmp

RUN apt-get install -y --no-install-recommends \
    bison \
    bzip2 \
    build-essential \
    flex

RUN cd /tmp \
  && bzip2 -cd nmap-$NCAT_VERSION.tar.bz2 | tar xvf - \
  && cd nmap-$NCAT_VERSION \
  && ./configure \
    --without-zenmap \
    --without-liblua \
    --without-nmap-update \
    --without-libssh2 \
    --without-nping \
    --without-ndiff \
    --without-openssl \
  && make \
  && make install \
  && mv /tmp/nmap-$NCAT_VERSION/ncat/ncat /ncat

#
# ncat stage
#
FROM debian:9.11-slim AS ncat

COPY --from=ncat-builder /ncat /ncat

ENTRYPOINT ["/ncat"]
