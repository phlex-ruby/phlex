module Components
  class Layout < Phlex::Component
    register_element :style

    def initialize(title:)
      super
    end

    def template(&)
      doctype

      HTML do
        HEAD do
          META charset: "utf-8"
          TITLE @title
          LINK href: "/application.css", rel: "stylesheet"
          STYLE { _raw Rouge::Theme.find("github").render(scope: '.highlight') }
        end

        BODY class: "p-12" do
          DIV class: "max-w-screen-lg mx-auto grid grid-cols-4 gap-10" do
            HEADER class: "col-span-1" do
              A(href: "/", class: "block") { IMG src: "/assets/logo.png", width: "150" }

              NAV do
                UL do
                  LI { A "Introduction", href: "/" }
                  LI { A "Templates", href: "/templates" }
                  LI { A "Components", href: "/components" }
                  LI { A "Source code", href: "https://github.com/joeldrapper/phlex" }
                end
              end
            end

            MAIN(class: "col-span-3", &)

            FOOTER class: "text-sm text-right col-span-4 py-10"
          end
        end
      end
    end
  end
end
