module Components
  class Tabs
    class Tab < Phlex::Component
      def initialize(name:, content:, checked:)
        super
      end

      def template
        input class: "opacity-0 fixed peer", type: "radio", name: @_parent.object_id, id: object_id, checked: @checked

        label @name, for: object_id, class: "order-1 py-2 px-5 bg-white text-sm border border-b-0 border-l-0 font-medium first-of-type:border-l first-of-type:rounded-tl last-of-type:rounded-tr before:absolute before:w-full before:ring before:h-full before:left-0 before:top-0 before:hidden before:rounded peer-focus:before:block"

        div class: "tab hidden order-2 w-full border rounded-b rounded-tr overflow-hidden", &@content
      end
    end
  end
end
