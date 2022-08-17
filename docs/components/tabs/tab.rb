module Components
  class Tabs
    class Tab < Phlex::Component
      def initialize(name:, checked:)
        super
      end

      def template(&)
        input class: "opacity-0 fixed peer", type: "radio", name: @_parent.unique_identifier, id: unique_identifier, checked: @checked

        label @name, id: "#{unique_identifier}-label", for: unique_identifier, role: "tab", aria_controls: "#{unique_identifier}-panel", class: "order-1 py-2 px-5 bg-white text-sm border border-b-0 border-l-0 font-medium first-of-type:border-l first-of-type:rounded-tl last-of-type:rounded-tr before:absolute before:w-full before:ring before:h-full before:left-0 before:top-0 before:hidden before:rounded peer-focus:before:block cursor-pointer"

        div id: "#{unique_identifier}-panel", role: "tabpanel", aria_labelledby: "#{unique_identifier}-label", class: "tab hidden order-2 w-full border rounded-b rounded-tr overflow-hidden", &
      end

      def unique_identifier
        @unique_identifier ||= SecureRandom.hex
      end
    end
  end
end
