FROM ubuntu:latest

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.42.0

# Install prerequisites
RUN set -eux
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        automake bison \
        ca-certificates \
        flex \
        gcc gawk gperf grep gettext \
        help2man \
        libc6-dev libtool libtool-bin \
        make \
        python2.7 python2.7-dev \
        texinfo \
        wget        

# Install rustup
WORKDIR /tmp
COPY rustup-init .

RUN chmod +x rustup-init
RUN ./rustup-init -y --no-modify-path --profile minimal
RUN rm rustup-init
RUN chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Install xargo
RUN cargo install xargo

# Copy rustc compiler and its source
WORKDIR /usr/local/rust-xtensa/
COPY rustc.tar.gz .

RUN tar -xzf rustc.tar.gz
RUN rm rustc.tar.gz

ENV XARGO_RUST_SRC=/usr/local/rust-xtensa/src \
    RUSTC=/usr/local/rust-xtensa/stage2/bin/rustc \
    RUSTDOC=/usr/local/rust-xtensa/stage2/bin/rustdoc

# Install ESP tools
WORKDIR /usr/local/xtensa-esp32-elf/
COPY xtensa-esp32-elf.tgz .

RUN tar -xzf xtensa-esp32-elf.tgz
RUN rm xtensa-esp32-elf.tgz

ENV PATH=$PATH:/usr/local/xtensa-esp32-elf/xtensa-esp32-elf/bin/

ENTRYPOINT [ "bash" ]
