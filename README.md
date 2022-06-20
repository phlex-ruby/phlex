# Phlex [WIP]



### Basic Component

You can define a component by subclassing `Phlex::Component` and defining a `template` method. Within this method, you can build HTML with simple block syntax.

```ruby
class NavComponent < Phlex::Component
  def template
    nav id: "main_nav" do
      ul do
        li { a "Home", href: "/" }
        li { a "About", href: "/about" }
        li { a "Contact", href: "/contact" }
      end
    end
  end
end
```

### Attributes

Components can accept arguments by defining an initializer.

```ruby
class MessageComponent < Phlex::Component
  def initialize(name:)
    @name = name
  end

  def template
    h1 "Hello #{@name}"
  end
end
```

The default initialiser sets each keyword argument to an instance variable, so this above could be re-written to call `super` instead.

```ruby
class MessageComponent < Phlex::Component
  def initialize(name:)
    super
  end

  def template
    h1 "Hello #{@name}"
  end
end
```

### Content

Components can optionally accept embedded contents which they can render into a tag.

```ruby
class CardComponent < Phlex::Component
  def template(&)
    div class: "p-5 rounded drop-shadow", &
  end
end
```

Or inline

```ruby
class CardComponent < Phlex::Component
  def initialize(title:)
    super
  end

  def template(&)
    div class: "p-5 rounded drop-shadow" do
      h1 @title
      render &
    end
  end
end
```

### Nested components

Components can be nested inside other components.

```ruby
class NavComponent < Phlex::Component
  def initialize(links:)
    super
  end

  def template
    nav do
      ul do
        @links.each do |label, link|
          component Nav::ItemComponent, label:, link:
        end
      end
    end
  end
end

class Nav::ItemComponent < Phlex::Component
  def initialize(label:, link:)
    super
  end

  def template
    a label, href: link
  end
end
```

Instance variables are accessible deep inside tag blocks, because blocks are evaluated in the context of the defining component.

```ruby
class NestedComponent < Phlex::Component
  def initialize(text:)
    super
  end

  def template
    div { h1 @text }
  end
end
```

Instance variables are also copied down to components embedded inside them unless there is a naming conflict.

```ruby
class ArticlesComponent < Phlex::Component
  def initialize(articles:)
    super
  end

  def template
    component CardComponent, title: "Articles" do
      @articles.each do |article|
        h2 article.title
        text article.content
      end
    end
  end
end
```

# Pages

A `Phlex::Page` is a `Phlex::Component` though pages might some extra features in the future.

```ruby
class Article::IndexPage < Phlex::Page
  def initialize(articles:)
    super
  end

  def template
    component Layout, title: "All Articles" do
      component Article::TableComponent, articles: @articles
    end
  end
end
```

# Examples

A component that renders the status of an article in a colour-coded badge using `ecase` and `literal_enums` .

```ruby
class Article
  class StatusBadgeComponent < Phlex::Component
    def initialize(article)
      @status = article.status
    end

    def template
      div t("issue.status.#{@status.value}"), class: ["rounded", "text-sm"] + colors
    end

    def colors
      ecase @status, Status do
        on(Status::Accepted) { ["bg-green-100", "text-green-800"] }
        on(Status::Rejected) { ["bg-red-100", "text-red-800"] }
      end
    end
  end
end
```

A component that lets you build tables with procs for column content

```ruby
module Sharp
  class Table
    class Fabricator < Phlex::Component
      def initialize(resources)
        @resources = resources
        @columns = {}
      end

      def template(&)
        render(&)

        component Table do
          component Head do
            component Row do
              @columns.keys.each do |header|
                component Header do
                  text header
                end
              end
            end
          end

          component Body do
            @resources.each do |resource|
              component Row do
                @columns.values.each do |value|
                  component Column do
                    render(resource, &value)
                  end
                end
              end
            end
          end
        end
      end

      def column(name, &block)
        @columns[name] = block
      end
    end
  end
end
```

This could be used like this and the proc would be called for each row with the resource.

```ruby
component Sharp::Table::Fabricator, @requests do
  column("Created") { text _1.created_at }
  column("Updated") { text _1.updated_at }
  column("UUID") { text _1.uuid }
  column("Requestee at") { text _1.requested_at }
  column("Subject ID") { text _1.subject_id }
end
```





## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phlex'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install phlex

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/phlex. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/phlex/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Phlex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/phlex/blob/master/CODE_OF_CONDUCT.md).
