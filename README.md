# asdf-make [![Build](https://github.com/yacchi/asdf-make/actions/workflows/build.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/build.yml) [![Lint](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml)

[GNU Make](https://www.gnu.org/software/make/) plugin for the [asdf version manager](https://asdf-vm.com).

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- A C compiler or build environment (e.g. build-essentials).

## macOS

* [GnuPG](http://www.gnupg.org) - `brew install gpg`
* Xcode Command line tools - `xcode-select --install`

## Linux (Debian)

* [GnuPG](http://www.gnupg.org) - `apt-get install gpg`
* [GCC](http://gcc.gnu.org/) - `apt-get install gcc`

# Install

## Plugin

```shell
asdf plugin add make
# or
asdf plugin add make https://github.com/yacchi/asdf-make.git
```

## Import GPG public key

If a `GPG verification error` occurs, key import is required.
The following commands can be used to import keys.

___Adding keys is at your own risk. For more information, please check the GNU Make project's site.___

- https://savannah.gnu.org/projects/make
- https://make.mad-scientist.net/
- https://www.gnu.org/software/security/security.html

```shell
gpg --recv-keys 96B047156338B6D4 80CB727A20C79BB2
# or
gpg --keyserver keys.gnupg.net --recv-keys 96B047156338B6D4 80CB727A20C79BB2
# or
gpg --keyserver keyserver.ubuntu.com --recv-keys 96B047156338B6D4 80CB727A20C79BB2
```

## make

```shell
# Show all installable versions
asdf list-all make

# Install specific version
asdf install make latest

# Set a version globally (on your ~/.tool-versions file)
asdf global make latest

# Now make commands are available
make --version
```

# Use

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

When installing GNU Make using `asdf install`, you can pass custom configure options with the following env vars:

| Environment Variable  | Default Value   | Other Values | Description                |
|-----------------------|-----------------|--------------|----------------------------|
| MAKE_CHECK_SIGNATURES | strict          | no           | GPG signature verification |
| MAKE_PRINT_BUILD_LOG  | no              | yes          | Display build log          |
| MAKE_BUILD_OPTIONS    | --with-guile=no |              | Build options              |

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

# License

See [LICENSE](https://github.com/yacchi/asdf-make/blob/main/LICENSE) © [Yasunori Fujie](https://github.com/yacchi/)
