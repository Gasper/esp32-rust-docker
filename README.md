# ESP32 Rust toolchain

This repository contains a Dockerfile, which packages tools required to build programs for Espressif's ESP32 chips in Rust.

The docker image includes modified Rust compiler, which supports Xtensa architecture used on ESP32, Xargo tool for cross-compilation and other required tools, such as linker and debugger.

The image is build in multiple stages to minimize the size, which ends up at around 2.5GB (900MB compressed).

## Usage

To compile Rust programs for ESP32, first pull the image:
```
$ docker pull gaspert/esp32-rust
```
and start it in interactive mode with a volume (`-v <full path to local source code>:/home/workspace`) e.g.:
```
$ docker run -it --rm -v /home/user/xtensa-rust-quickstart:/home/workspace esp-rs
```
The docker will start a shell, which has access to all the tools. To build the program simply run:
```
$ xargo build
```

## More on ESP32 and Rust
For more info on using Rust for ESP32, see:
- hello world repository: https://github.com/MabezDev/xtensa-rust-quickstart
- esp-rs organization: https://github.com/esp-rs
- examples in esp32-hal: https://github.com/esp-rs/esp32-hal/tree/master/examples
- rust embedded book: https://rust-embedded.github.io/book/