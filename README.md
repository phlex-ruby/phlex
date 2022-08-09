<img alt="Phlex logo" src="phlex_logo.png" width="250" />

It’s time for a new way to compose views in Ruby, using... ✨**Ruby**.✨ We don’t need another templating language. With Phlex, you can write small, reusable view components using simple Ruby Objects and templates composed of Ruby blocks.

> **Warning**
>
> _Phlex is still in early development and should not be used in production yet._


### The Road to 1.0

Phlex is licenced under MIT and is being developed in the open by [Joel Drapper](https://github.com/joeldrapper). The plan is to release a stable `1.0` version in the next few months.

If you want to help out, you can contribute by opening an issue or PR. You can also [book a pairing session](https://savvycal.com/joeldrapper/pair) with me. If you work for a company that would benefit from Phlex, I accept [sponsorships](https://github.com/sponsors/joeldrapper) through GitHub.

# Usage

### Basic Component

You can define a component by subclassing `Phlex::Component` and defining a `template` method where you can build HTML with simple block syntax. Each HTML tag is a method that accepts keyword arguments for its attributes. Text content can be passed as the first positional argument or alternatively, you can open a block to create nested HTML tags.

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

### Component Attributes

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

The default initialiser inherited from `Phlex::Component` sets each keyword argument to an instance variable, so the above could be re-written to call `super` instead.

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

Components, like tags, can accept nested contents as a block given to `template`, which they can then yield or pass to another tag.

Here the content is passed to a `div` tag:

```ruby
class CardComponent < Phlex::Component
  def template(&)
    div class: "rounded drop-shadow p-5", &
  end
end
```

Here the content is yielded inside a `div` tag right after an `h1` tag.

```ruby
class CardComponent < Phlex::Component
  def initialize(title:)
    super
  end

  def template(&)
    div class: "rounded drop-shadow p-5" do
      h1 @title
      content(&)
    end
  end
end
```

### Nested components

Components can be nested inside other components too.

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
    li { a label, href: link }
  end
end
```

Instance variables and methods from the components are accessible deep inside nested components and tag blocks because blocks capture their context for execution.

```ruby
class ArticlesComponent < Phlex::Component
  def initialize(articles:)
    super
  end

  def template
    component CardComponent, title: "Articles" do
      @articles.each do |article|
        h2 @article.title
        text @article.content
      end
    end
  end
end
```

### Advanced components with DSLs

Becuase components accept blocks, it’s really easy to define advanced components with their own DSLs. Take, for instance, this table fabricator component that lets you define rows / columns with headers using blocks.

```ruby
component Table::Fabricator, @articles, layout: :column do |t|
  t.data "Title" { a _1.title, href: article_path(_1) }
  t.text_data("Author", &:author)
  t.text_data("Published", &:published_at)
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



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Phlex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/phlex/blob/master/CODE_OF_CONDUCT.md).


## Credits

Logo design sponsored by [Logology](https://www.logology.co).
