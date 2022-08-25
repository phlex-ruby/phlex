module Example
  class Page < Phlex::Component
    def template
      render LayoutComponent.new do
        H1 "Hi"

        5.times do
          DIV do
            10.times do
              A "Test", href: "something", unique: SecureRandom.uuid
            end
          end
        end

        TABLE do
          THEAD do
            10.times do
              TR do
                TH "Hi"
              end
            end
          end

          TBODY do
            100.times do
              TR class: "a b c d e f g", id: "something" do
                10.times do
                  TD class: "f g h i j k l" do
                    SPAN "Test"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
