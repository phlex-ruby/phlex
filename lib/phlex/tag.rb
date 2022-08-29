# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
  using Overrides::Symbol::Name
end

module Phlex
  module Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    RIGHT = ">"
    CLOSE_VOID_RIGHT = " />"

    EQUALS_QUOTE = '="'
    QUOTE = '"'

    DOCTYPE = "<!DOCTYPE html>"

    EVENT_ATTRIBUTES = %i[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

    STANDARD_ELEMENTS = %i[a abbr address article aside b bdi bdo blockquote body button caption cite code colgroup data datalist dd del details dfn dialog div dl dt em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header html i iframe ins kbd label legend li main map mark menuitem meter nav noscript object ol optgroup option output p picture pre progress q rp rt ruby s samp script section select slot small span strong style sub summary sup table tbody td textarea tfoot th thead time title tr u ul video wbr].freeze

    VOID_ELEMENTS = %i[area embed img input link meta param track col].freeze

    def register_element(element, tag: element.name.gsub(Tag::UNDERSCORE, Tag::DASH))
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{element}(content = nil, _name: nil, **kwargs, &block)
          raise ArgumentError if content && block_given?

          if kwargs.length > 0
            @_target << "<#{tag}"
            _attributes(kwargs)
            @_target << Tag::RIGHT
          else
            @_target << "<#{tag}>"
          end

          if block_given?
            content(&block)
          else
            text content if content
          end

          @_target << "</#{tag}>"
        end
      RUBY
    end

    def register_void_element(element, tag: element.name.gsub(Tag::UNDERSCORE, Tag::DASH))
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{element}(**kwargs)
          if kwargs.length > 0
            @_target << "<#{tag}"
            _attributes(kwargs)
            @_target << Tag::CLOSE_VOID_RIGHT
          else
            @_target << "<#{tag} />"
          end
        end
      RUBY
    end
  end
end
