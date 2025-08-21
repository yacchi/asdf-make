# Changelog

## [2.2.0](https://github.com/yacchi/asdf-make/compare/v2.1.0...v2.2.0) (2025-08-21)


### Features

* add MAKE_CUSTOM_MIRROR environment variable to specify mirror ([87eda8d](https://github.com/yacchi/asdf-make/commit/87eda8d76458425b2e1331c6e15ab75121efcb8f))
* add MAKE_CUSTOM_MIRROR environment variable to use GNU mirror [#23](https://github.com/yacchi/asdf-make/issues/23) ([b0aa63a](https://github.com/yacchi/asdf-make/commit/b0aa63a7410bfdadcc4062db52263d3a637e13ed))

## [2.1.0](https://github.com/yacchi/asdf-make/compare/v2.0.0...v2.1.0) (2024-06-26)


### Features

* add jp README ([2f12c4d](https://github.com/yacchi/asdf-make/commit/2f12c4d09083e41c6eaeaef196ce6d8f1a96ff79))

## [2.0.0](https://github.com/yacchi/asdf-make/compare/v1.2.0...v2.0.0) (2023-10-25)


### ⚠ BREAKING CHANGES

* change name of custom configuration env
* rename project

### Features

* add support output build log and enabled this option on actions ([129ee70](https://github.com/yacchi/asdf-make/commit/129ee706509b1883051f36b70b264377c4496719))
* change matrix of plugin_test version ([2c6fcf9](https://github.com/yacchi/asdf-make/commit/2c6fcf9138ec543a9cd05d7f5ab2c157e094059e))
* **README:** Add instructions for importing GPG public key [#13](https://github.com/yacchi/asdf-make/issues/13) ([6b28f6e](https://github.com/yacchi/asdf-make/commit/6b28f6e23b6c7af2abf66d37faf8d0891614b89c))
* remove install dependency on actions ([eca7e1d](https://github.com/yacchi/asdf-make/commit/eca7e1d08d9134929d5789fa6a96340e19b5c03a))


### Bug Fixes

* can not install 3.82 on linux ([62264d3](https://github.com/yacchi/asdf-make/commit/62264d3847ee8bbee7820e187c2e22fdbad23c3f))
* can not install 4.0 ([c8faf82](https://github.com/yacchi/asdf-make/commit/c8faf82b811846946ec76c302ecaf5767d94a70c))
* can not install 4.2.1 or older version on linux ([7df2524](https://github.com/yacchi/asdf-make/commit/7df25249bdb7abaf85a2d0e94ed2844feccc0484))
* cannot install GPG keys on GitHub Actions ([e650265](https://github.com/yacchi/asdf-make/commit/e650265ed9c5addf2dfc0d81fff9acf6762dd8b4))
* install GPG key on CI ([8a0f862](https://github.com/yacchi/asdf-make/commit/8a0f8625120f4b6a88276c32e6b9d52c33014c3e))
* show details of gpg verification error ([81a98ce](https://github.com/yacchi/asdf-make/commit/81a98cef349d62d6320ef563668789ffdff88a10))
* unable to install with the combination of the installed make and target version ([7075ad2](https://github.com/yacchi/asdf-make/commit/7075ad24b6170d37506c59df5e3e2708611bd928))


### Code Refactoring

* rename project ([9fbdb38](https://github.com/yacchi/asdf-make/commit/9fbdb38c6f5e74c8c63d95538d1b008c9a79e75e))

## [1.2.0](https://www.github.com/yacchi/asdf-gnumake/compare/v1.1.0...v1.2.0) (2021-07-09)


### Features

* suppress remove confirmation for downloaded directory ([4d74671](https://www.github.com/yacchi/asdf-gnumake/commit/4d746715e65d05ce2aac60355c31c3ad19ec15ab))


### Bug Fixes

* few dependency in README ([880f4a2](https://www.github.com/yacchi/asdf-gnumake/commit/880f4a253e6a47fd7e921331dabb2872e516448d))
* install error if make is not installed env ([aedbb44](https://www.github.com/yacchi/asdf-gnumake/commit/aedbb44f4139afb06521e57cd02e58df31f12d99))

## [1.1.0](https://www.github.com/yacchi/asdf-gnumake/compare/v1.0.0...v1.1.0) (2021-07-09)


### Features

* enabled build use actions on develop branch ([c12187b](https://www.github.com/yacchi/asdf-gnumake/commit/c12187b75e9a52e07646c01286e22e2b5729f245))


### Bug Fixes

* suppress logs ([4c1cdbb](https://www.github.com/yacchi/asdf-gnumake/commit/4c1cdbbcf0d2ac9efe48f042732d89c0aee0d251))

## 1.0.0 (2021-07-09)


### Features

* initial implementation of GNU Make command ([7eb52af](https://www.github.com/yacchi/asdf-gnumake/commit/7eb52af8a1986af242d693e65f987396213beda9))


### Bug Fixes

* indent for README ([b3310fb](https://www.github.com/yacchi/asdf-gnumake/commit/b3310fb288130211c7de15b06bf7d41cd0733348))
