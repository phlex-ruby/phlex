# frozen_string_literal: true

module Phlex
  module Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    LEFT = "<"
    RIGHT = ">"
    CLOSE_LEFT = "</"
    CLOSE_VOID_RIGHT = " />"

    EQUALS_QUOTE = '="'
    QUOTE = '"'

    DOCTYPE = "<!DOCTYPE html>"

    EVENT_ATTRIBUTES = %i[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }

    STANDARD_ELEMENTS = %w[
      a
      abbr
      address
      article
      aside
      b
      bdi
      bdo
      blockquote
      body
      button
      caption
      cite
      code
      colgroup
      data
      datalist
      dd
      del
      details
      dfn
      dialog
      div
      dl
      dt
      em
      fieldset
      figcaption
      figure
      footer
      form
      h1
      h2
      h3
      h4
      h5
      h6
      head
      header
      html
      i
      iframe
      ins
      kbd
      label
      legend
      li
      main
      map
      mark
      menuitem
      meter
      nav
      noscript
      object
      ol
      optgroup
      option
      output
      p
      picture
      pre
      progress
      q
      rp
      rt
      ruby
      s
      samp
      script
      section
      select
      slot
      small
      span
      strong
      sub
      summary
      sup
      table
      tbody
      td
      textarea
      tfoot
      th
      thead
      time
      title
      tr
      u
      ul
      video
      wbr
    ].freeze

    VOID_ELEMENTS = %w[
      area
      embed
      img
      input
      link
      meta
      param
      track
      col
    ].freeze
  end
end
