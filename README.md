<div align="center">

# asdf-gnumake [![Build](https://github.com/yacchi/asdf-gnumake/actions/workflows/build.yml/badge.svg)](https://github.com/yacchi/asdf-gnumake/actions/workflows/build.yml) [![Lint](https://github.com/yacchi/asdf-gnumake/actions/workflows/lint.yml/badge.svg)](https://github.com/yacchi/asdf-gnumake/actions/workflows/lint.yml)


[gnumake](https://www.gnu.org/software/make/manual/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add gnumake
# or
asdf plugin add gnumake https://github.com/yacchi/asdf-gnumake.git
```

gnumake:

```shell
# Show all installable versions
asdf list-all gnumake

# Install specific version
asdf install gnumake latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gnumake latest

# Now gnumake commands are available
make --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/yacchi/asdf-gnumake/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Yasunori Fujie](https://github.com/yacchi/)
