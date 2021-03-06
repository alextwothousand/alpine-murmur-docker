#
# Dockerfile for murmur
#

FROM alpine 
MAINTAINER alex2000 <me@alexdev.site>

ENV MM_VERSION 1.2.17
ENV MM_FILE murmur-static_x86-${MM_VERSION}.tar.bz2
ENV MM_URL https://github.com/mumble-voip/mumble/releases/download/${MM_VERSION}/${MM_FILE}
ENV PORT 64738

WORKDIR /etc/murmur

RUN \
	set -xe \
	&& apk add --no-cache curl tar \
	&& curl -sSL ${MM_URL} | tar xj --strip 1 \
	&& mv murmur.x86 /usr/local/bin/murmur \
	&& apk del curl tar

VOLUME /etc/murmur

EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

CMD ["murmur", "-fg", "-ini", "/etc/murmur/murmur.ini"]
