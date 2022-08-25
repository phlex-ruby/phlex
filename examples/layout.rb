module Example
  class LayoutComponent < Phlex::Component
    def initialize(title: "Example")
      super
    end

    def template(&block)
      HTML do
        HEAD do
          TITLE @title
          META name: "viewport", content: "width=device-width,initial-scale=1"
          LINK href: "/assets/tailwind.css", rel: "stylesheet"
        end

        BODY class: "bg-zinc-100" do
          NAV class: "p-5", id: "main_nav" do
            UL do
              LI(class: "p-5") { A "Home", href: "/" }
              LI(class: "p-5") { A "About", href: "/about" }
              LI(class: "p-5") { A "Contact", href: "/contact" }
            end
          end

          DIV class: "container mx-auto p-5", &block
        end
      end
    end
  end
end
