# Changelog

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

### Changed

- Support `Integer` and `Float` attribute values, and fall back to calling `to_str` on other objects.

## 1.7.0

### Added

- Experimental Smart chunking.

### Changed

- Improved YARD documentation, which is now available here https://rubydoc.info/gems/phlex
- `SGML#render` can now render lambdas with zero or one arguments. Previously, it could only render lambdas with exactly one argument, although it could always render Procs with any number of arguments. When an argument is accepted, the `self` of the component rendering it is yielded to the Proc.
- Raise an error when outputting an unknown object using `SGML#plain`.
- Raise an error when using attribute keys that aren't Strings or Symbols.
- Support Array and Set values for HTML/SVG attributes.

### Removed

- Removed the `menuitem` element as it's a deprecated HTML element.
- Removed the `SGML#text` method. This has been replaced with `SGML#plain`.

***

Before this changelog was introduced, changes were logged in the [release notes](https://github.com/phlex-ruby/phlex/releases).
