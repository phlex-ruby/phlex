# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- `SGML#render` can now render lambdas with zero or one arguments. Previously, it could only render lambdas with exactly one argument. Note: it could always render Procs with any number of arguments. When an argument is accepted, the `self` of component rendering it is yielded to Proc.

***

Before this changelog was introduced, changes were logged in the [release notes](https://github.com/phlex-ruby/phlex/releases).
