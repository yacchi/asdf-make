# Contributing

Contributions welcome!

## Setup development environment
1. Install `asdf` tools
    ```shell
    asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git
    asdf plugin add shfmt https://github.com/luizm/asdf-shfmt.git
    asdf install
    ```
2. Develop!
3. Lint & Format
    ```shell
    ./scripts/shellcheck.bash
    ./scripts/shfmt.bash
    ```
4. PR changes

## Testing Locally
```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test gnumake https://github.com/yacchi/asdf-gnumake.git "make --version"
```

Tests are automatically run in GitHub Actions on push and PR.
