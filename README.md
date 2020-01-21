# Netcat Docker

All netcat Debian versions Dockerized.

The version _netcat_ referers to _netcat-openbsd_. It includes:


## netcat-openbsd

> This package contains the OpenBSD rewrite of netcat, including support for IPv6, proxies, and Unix sockets.

Package under development <https://tracker.debian.org/pkg/netcat-openbsd>.

<https://packages.debian.org/jessie/netcat-openbsd>


## netcat-traditional

> This is the "classic" netcat, written by _Hobbit_. It lacks many features found in netcat-openbsd.

Abandoned package <https://tracker.debian.org/pkg/netcat>.

<https://packages.debian.org/jessie/netcat-traditional>


## ncat

> Ncat is a reimplementation of the currently splintered and reasonably
> unmaintained Netcat family.  Ncat will do pretty much everything that
> all the other Netcat's do, all in one place.  Plus it has the added
> benefit of spanky new features and ongoing development.

Package under development.

<https://svn.nmap.org/nmap/ncat/docs/README>


## Usage

-   netcat-openbsd `docker run -it --rm jesugmz/nc -h`

-   netcat-traditional `docker run -it --rm jesugmz/nc-traditional -h`

-   ncat `docker run -it --rm jesugmz/ncat -h`

To use Netcat in the [host network](https://docs.docker.com/network/network-tutorial-host/) include `--network host` in your Docker run command as follow (being 192.168.10.20 the host IP):

```sh
$ docker run -it --rm --network host jesugmz/nc -zv 192.168.10.20 80
Connection to 192.168.10.20 80 port [tcp/*] succeeded!
```
