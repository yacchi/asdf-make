# asdf-make

[![Build](https://github.com/yacchi/asdf-make/actions/workflows/build.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/build.yml)
[![Lint](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml/badge.svg)](https://github.com/yacchi/asdf-make/actions/workflows/lint.yml)

[asdf version manager](https://asdf-vm.com)用[GNU Make](https://www.gnu.org/software/make/)プラグイン。

# 依存関係

- `bash`, `curl`, `tar`: 汎用のPOSIXユーティリティ
- Cコンパイラあるいはビルド環境(例: build-essentials)

## macOS

- [GnuPG](http://www.gnupg.org) - `brew install gpg`
- Xcodeコマンドラインツール - `xcode-select --install`

## Linux (Debian)

- [GnuPG](http://www.gnupg.org) - `apt-get install gpg`
- [GCC](http://gcc.gnu.org/) - `apt-get install build-essentials`

# インストール

## プラグイン

```shell
asdf plugin add make
# または
asdf plugin add make https://github.com/yacchi/asdf-make.git
```

## GPG公開キーのインポート

`GPG verification error`が発生した場合、キーのインポートが必要です。以下のコマンドを使用してキーをインポートできます。

___キーの追加は自己責任で行ってください。詳細については、GNU Makeプロジェクトのサイトをご参照ください。___

- https://savannah.gnu.org/projects/make
- https://make.mad-scientist.net/
- https://www.gnu.org/software/security/security.html

```shell
gpg --recv-keys 96B047156338B6D4 80CB727A20C79BB2
# または
gpg --keyserver keys.gnupg.net --recv-keys 96B047156338B6D4 80CB727A20C79BB2
# または
gpg --keyserver keyserver.ubuntu.com --recv-keys 96B047156338B6D4 80CB727A20C79BB2
```

## make

```shell
# すべてのインストール可能なバージョンを表示
asdf list-all make
# 特定のバージョンをインストール
asdf install make latest
# グローバルにバージョンを設定（~/ .tool-versionsファイルで）
asdf global make latest
# これでmakeコマンドが利用可能になります
make --version
```

# 設定

[asdf](https://github.com/asdf-vm/asdf)のREADMEを参照し、インストールとバージョンの管理方法についての詳細な指示を確認してください。GNU
Makeを`asdf install`を使ってインストールする際、以下の環境変数でカスタム設定オプションを渡すことができます：

| 環境変数                  | デフォルト値          | 他の値 | 説明       |
|-----------------------|-----------------|-----|----------|
| MAKE_CHECK_SIGNATURES | strict          | no  | GPG署名の検証 |
| MAKE_PRINT_BUILD_LOG  | no              | yes | ビルドログの表示 |
| MAKE_BUILD_OPTIONS    | --with-guile=no |     | ビルドオプション |

# 貢献

どんな貢献も歓迎します! [貢献ガイド](contributing.md)を参照してください。

# ライセンス

[LICENSE](https://github.com/yacchi/asdf-make/blob/main/LICENSE)
を参照してください。© [Yasunori Fujie](https://github.com/yacchi/)
