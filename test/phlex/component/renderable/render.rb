# frozen_string_literal: true

require "test_helper"

describe Phlex::Component do
  extend ComponentHelper

  with "#render" do
    with "another component" do
      other_component = Class.new Phlex::Component do
        def template(&block)
          div(&block)
        end
      end

      with "markup" do
        component do
          define_method :template do
            render(other_component.new) do
              h1 "Hi!"
            end
          end
        end

        it "works" do
          expect(output).to be == "<div><h1>Hi!</h1></div>"
        end
      end

      with "text" do
        component do
          define_method :template do
            render(other_component.new) { "Hello world!" }
          end
        end

        it "works" do
          expect(output).to be == "<div>Hello world!</div>"
        end
      end
    end
  end
end
