# Contributing to Phlex

## Priorities

We’re trying to provide the best possible developer experience for the people using Phlex in their apps and the best possible performance for the users of those apps.

Phlex is incredibly complex and requires a lot of meta-programming but when you use it, it feels simple. Phlex views feel like plain old Ruby objects. You just subclass and define a couple of methods. That’s it. That’s how it should be.

## Setup

- Install dependencies `bundle install`
- Run the tests `bundle exec sus`
- Run Rubocop and auto-correct `bundle exec rubocop -A`

## Tests

We use the **[Sus](https://github.com/ioquatix/sus)** testing framework. It feels a bit like RSpec with a few small differences. There’s no documentation for Sus at the moment, but you should be able to pick up the basics from reading other tests or looking at the implementation in the Sus repo.

You can run all the tests with `bundle exec sus`.

## Documentation

Documentation is deployed when it’s merged into the `latest` branch with a release. But you can build and preview the docs locally by running `bin/docs`.
