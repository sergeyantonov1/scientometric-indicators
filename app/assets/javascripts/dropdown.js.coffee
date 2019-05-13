class Dropdown
  constructor: (el) ->
    @$el = $(el)

    @_init()

  _init: ->
    @$el.dropdown()

new Dropdown(el) for el in $(".ui.dropdown'")
