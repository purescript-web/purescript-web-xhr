# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:

New features:

Bugfixes:

Other improvements:

## [v5.0.1](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v5.0.1) - 2023-03-20

Bugfixes:
- Passing `Nothing` for the `filename` parameter to `appendBlob` and `setBlob` has the effect of using the filename from the `File` object, rather than making filename equal to `"null"`. (#23 by @fsoikin)

## [v5.0.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v5.0.0) - 2022-04-27

Breaking changes:
- Migrate FFI to ES modules (#21 by @JordanMartinez)

New features:

Bugfixes:

Other improvements:

## [v4.1.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v4.1.0) - 2021-05-06

New features:
- Exported `fromFormElement` (#19 by @JordanMartinez)

Other improvements:
- Fixed warnings revealed by v0.14.1 PS release (#19 by @JordanMartinez)

## [v4.0.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v4.0.0) - 2021-02-26

Breaking changes:
- Added support for PureScript 0.14 and dropped support for all previous versions (#10)

New features:
- Added roles declarations to forbid unsafe coercions (#7)
- Can create a new `FormData` from `HTMLFormElement` (#15)

Bugfixes:
- Access the "timeout" property instead of "statusText" in `timeout` (#12)

Other improvements:
- Migrated CI to GitHub Actions and updated installation instructions to use Spago (#8)
- Added a CHANGELOG.md file and pull request template (#13, #14)
- Remove duplicated `exports.lengthComputable` (#16)

## [v3.0.2](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v3.0.2) - 2019-08-18

- Raised upper bound for `purescript-web-dom`

## [v3.0.1](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v3.0.1) - 2019-06-02

- Updated dependency ranges for compatibility with latest `purescript-web-dom`

## [v3.0.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v3.0.0) - 2019-02-23

- Bumped `-web-events` dependency, `Event.defaultPrevented` is now effectful.

## [v2.0.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v2.0.0) - 2018-05-25

- Updated for PureScript 0.12

## [v1.1.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v1.1.0) - 2018-03-17

- Added `sendArrayView`

## [v1.0.0](https://github.com/purescript-web/purescript-web-xhr/releases/tag/v1.0.0) - 2017-12-24

- Initial release
