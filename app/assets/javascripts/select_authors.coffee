class SelectAuthors
  constructor: (el) ->
    @$el = $(el)
    @_options = @$el.data("author-list")
    console.log(@_options)

    @_init()

  _init: ->
    @$el.selectize
      options: @options,
      maxItems: null,
      valueField: "authors",
      labelField: "authors",
      plugins: ["remove_button"],
      delimiter: ' ',
      create: true,
      createOnBlur: true,
      persist: false

new SelectAuthors(el) for el in $("[data-author-list]")