class Dropdown
  constructor: (el) ->
    @$el = $(el)

    @_init()

  _init: ->
    @$el.dropdown({
      maxSelections: 5
    })

new Dropdown(el) for el in $(".ui.dropdown")
