FROM debian:stable-slim
MAINTAINER Pierre Fenoll <pierrefenoll@gmail.com>

WORKDIR /app
COPY . $PWD

RUN set -x \
 && apt update && apt upgrade -y \
 && apt install -y --no-install-recommends \
       gawk git gcc make perl ca-certificates \
       camlp4 \
       wget patch unzip \
       libcairo-dev libgtk2.0-dev \
 && apt clean \
 # && wget https://raw.githubusercontent.com/ocaml/opam/master/shell/opam_installer.sh \
 # && yes | sh ./opam_installer.sh /usr/local/bin \
 # && opam init && opam install -y camlp4 \
 && ./configure --prefix=/usr/local \
 && make depend \
 && make \
 && make opt \
 && make install \
 && rm -rf /app

WORKDIR /workdir
