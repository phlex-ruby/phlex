# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
  using Overrides::Symbol::Name
end

module Phlex
  module HTML
    DOCTYPE = "<!DOCTYPE html>"

    STANDARD_ELEMENTS = %i[a abbr address article aside b bdi bdo blockquote body button caption cite code colgroup data datalist dd del details dfn dialog div dl dt em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header html i iframe ins kbd label legend li main map mark menuitem meter nav noscript object ol optgroup option output p path picture pre progress q rp rt ruby s samp script section select slot small span strong style sub summary sup svg table tbody td textarea tfoot th thead time title tr u ul video wbr].freeze

    VOID_ELEMENTS = %i[area br embed img input link meta param source track col].freeze

    EVENT_ATTRIBUTES = %w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

    def register_element(element, tag: element.name.tr("_", "-"))
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(content = nil, **attributes, &block)
          if attributes.length > 0
            if content
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << ">" << CGI.escape_html(content) << "</#{tag}>"
            elsif block_given?
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << ">"
              content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << "></#{tag}>"
            end
          else
            if content
              case content
              when String
                @_target << "<#{tag}>" << CGI.escape_html(content) << "</#{tag}>"
              when Symbol
                @_target << "<#{tag}>" << CGI.escape_html(content.name) << "</#{tag}>"
              else
                @_target << "<#{tag}>" << CGI.escape_html(content.to_s) << "</#{tag}>"
              end
            elsif block_given?
              @_target << "<#{tag}>"
              content(&block)
              @_target << "</#{tag}>"
            else
              @_target << "<#{tag}></#{tag}>"
            end
          end

          nil
        end
      RUBY
    end

    def register_void_element(element, tag: element.name.tr("_", "-"))
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        # frozen_string_literal: true

        def #{element}(**attributes)
          if attributes.length > 0
            @_target << "<#{tag}" << (Phlex::ATTRIBUTE_CACHE[attributes.hash] || _attributes(attributes)) << " />"
          else
            @_target << "<#{tag} />"
          end

          nil
        end
      RUBY
    end
  end
end
