# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  Phlex::HTML::STANDARD_ELEMENTS.each do |element|
    with "<#{element}> with text content and attributes" do
      component do
        define_method :template do
          send(element, "content", class: "class", id: "id", disabled: true, selected: false)
        end
      end

      it "produces the correct output" do
        expect(output).to be == %{<#{element} class="class" id="id" disabled>content</#{element}>}
      end
    end

    with "<#{element}> with block content and attributes" do
      component do
        define_method :template do
          send(element, class: "class", id: "id", disabled: true, selected: false) { h1 "Hello" }
        end
      end

      it "produces the correct output" do
        expect(output).to be == %{<#{element} class="class" id="id" disabled><h1>Hello</h1></#{element}>}
      end
    end

    with "<#{element}> with block text content and attributes" do
      component do
        define_method :template do
          send(element, class: "class", id: "id", disabled: true, selected: false) { "content" }
        end
      end

      it "produces the correct output" do
        expect(output).to be == %{<#{element} class="class" id="id" disabled>content</#{element}>}
      end
    end
  end

  Phlex::HTML::VOID_ELEMENTS.each do |element|
    with "<#{element}> with attributes" do
      component do
        define_method :template do
          send(element, class: "class", id: "id", disabled: true, selected: false)
        end
      end

      it "produces the correct output" do
        expect(output).to be == %{<#{element} class="class" id="id" disabled />}
      end
    end
  end
end
