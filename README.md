# asdf-make [![Build](https://github.com/yacchi/asdf-make/actions/workflows/build.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/build.yml) [![Lint](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml)

[GNU Make](https://www.gnu.org/software/make/) plugin for the [asdf version manager](https://asdf-vm.com).

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- A C compiler

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
* `MAKE_CHECK_SIGNATURES` - `strict` is default. Other values are `no`.
* `MAKE_PRINT_BUILD_LOG` - `no` is default. Other value are `yes`.
* `MAKE_BUILD_OPTIONS` - `--with-guile=no` is default.

# Contributing
Contributions of any kind welcome! See the [contributing guide](contributing.md).

# License
See [LICENSE](https://github.com/yacchi/asdf-make/blob/main/LICENSE) © [Yasunori Fujie](https://github.com/yacchi/)
