module Components
  class Layout < Phlex::Component
    register_element :style

    def initialize(title:)
      super
    end

    def template(&)
      html do
        head do
          meta charset: "utf-8"
          title @title
          link href: "/application.css", rel: "stylesheet"
          style { _raw Rouge::Theme.find("github").render(scope: '.highlight') }
        end

        body class: "p-12" do
          div class: "max-w-screen-lg mx-auto grid grid-cols-4 gap-10" do
            header class: "col-span-1" do
              a(href: "/") { img src: "/assets/logo.png", width: "150" }

              # ul do
              #   li { a "Introduction", href: "/" }
              #   li { a "Getting started", href: "/" }
              #   li { a "Building advanced components", href: "/" }
              #   li { a "Testing components", href: "/" }
              #   li { a "Rails", href: "/" }
              #   li { a "Source Code", href: "/" }
              # end
            end

            main(class: "col-span-3", &)

            footer class: "text-sm text-right col-span-4 py-10"
          end
        end
      end
    end
  end
end
