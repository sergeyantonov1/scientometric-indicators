class Dropdown
  constructor: (el) ->
    @$el = $(el)

    @_init()

  _init: ->
    @$el.multiselect
      columns: 1
      search: true
      placeholder: "Select authors"


new Dropdown(el) for el in $("#select-authors")
