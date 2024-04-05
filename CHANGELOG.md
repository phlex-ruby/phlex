# Changelog

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.10.0] 2024-04-05

- [Added] new `Phlex::CSV` class for streaming CSV views
- [Added] new (experimental) `Phlex::Kit` for collections of components
- [Added] support for selective rendering
- [Changed] `mix` does a better job when mixing different types of attributes
- [Changed] Phlex will now try to call `to_s` on attribute values
- [Changed] No runtime dependencies
- [Deprecated] `Phlex::HTML#param`, (`<param>`) tags have been deprecated
- [Deprecated] Defining the `template` method is now deprecated. You should define `view_template` instead. In Phlex 2.0, the `template` method will render a `<template>` tag.

# [1.9.1] 2024-03-11

- Security update

## [1.9.0] 2024-11-24

- Improved documentation
- Fixed an issue with flushing to the buffer while capturing
- Added `<canvas>` element
- Very minor performance improvements by using `block` instead of `block_given?` where a block has already been captured
- `Integer` objects are now handled by the `format_object` method, which you can override to customise how various objects are rendered
- You can now use `render` with `String` and `Method` objects

## [1.8.1] 2023-04-19

### Fixed

- Rendering a component with a false `render?` predicate should return an empty String rather than `nil`.

## [1.8.0] 2023-04-19

### Changed

- Support `Integer` and `Float` attribute values, and fall back to calling `to_str` on other objects.

## [1.7.0] 2023-04-18

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

---

Before this changelog was introduced, changes were logged in the [release notes](https://github.com/phlex-ruby/phlex/releases).
