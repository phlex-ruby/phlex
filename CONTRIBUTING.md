# Contributing to Phlex

## Priorities

We’re trying to provide the best possible developer experience for the people using Phlex in their apps and the best possible performance for the users of those apps.

Phlex is incredibly complex and requires a lot of meta-programming but when you use it, it feels simple. Phlex views feel like plain old Ruby objects. You just subclass and define a couple of methods. That’s it. That’s how it should be.

## Setup

- Install dependencies `bundle install`
- Run the tests `bundle exec sus`
- Run Rubocop and auto-correct `bundle exec rubocop -A`

## Tests

New tests should be written using [GreenDots](https://github.com/joeldrapper/green_dots) and placed in the `gd` folder. You can run these tests with:

```
bundle exec gd gd
```

Joel maintains GreenDots itself, so if you run into any issues, please reach out to him by creating an issue in the GreenDots repo so he can improve the framework.

Previously, we used **[Sus](https://github.com/ioquatix/sus)**. Sus tests are in the `test` folder and can be run with:

```
bundle exec sus
```

## Documentation

Documentation is deployed when it’s merged into the `latest` branch with a release. But you can build and preview the docs locally by running `bin/docs`.
