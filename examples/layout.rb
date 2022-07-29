module Example
  class LayoutComponent < Phlex::Component
    def initialize(title: "Example")
      super
    end

    def template(&)
      html do
        head do
          title @title
          meta name: "viewport", content: "width=device-width,initial-scale=1"
          link href: "/assets/tailwind.css", rel: "stylesheet"
        end

        body.bg_zinc_100 do
          nav.p_5 id: "main_nav" do
            ul do
              li.p_5 { a "Home", href: "/" }
              li.p_5 { a "About", href: "/about" }
              li.p_5 { a "Contact", href: "/contact" }
            end
          end

          div.container.mx_auto.p_5(&)
        end
      end
    end
  end
end
