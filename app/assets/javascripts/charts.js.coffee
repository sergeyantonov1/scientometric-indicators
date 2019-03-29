# class Charts
#   constructor: (el) ->
#     @$el = $(el)
#     @_options = @$el.data("authors")

#     @_init()

#   _init: ->
#     @$el.selectize
#       options: [
#         {
#           description: 'Nice Guy'
#           name: 'Brian Reavis'
#           imageUrl: 'http://www.fashionspictures.com/wp-content/uploads/2013/11/short-hairstyles-for-a-square-face-42-150x150.jpg'
#         }
#         {
#           description: 'Other nice guy'
#           name: 'Nikola Tesla'
#           imageUrl: 'http://www.fashionspictures.com/wp-content/uploads/2013/11/short-hairstyles-for-a-square-face-42-150x150.jpg'
#         }
#       ]
#       valueField: "authors"
#       labelField: "authors"

#       render: option: (item, escape) ->
#         '<div class="option">' + '<div class="image">' + '<img class="avatar" src="' + item.imageUrl + '" />' + '</div>' + '<div class="text">' + '<span class="name">' + escape(item.name) + '</span>' + '<p class="description">' + escape(item.description) + '</p>' + '</div>' + '</div>'

# new Charts(el) for el in $("[data-authors]")
# $('.email-select').selectize
#   valueField: 'name'
#   labelField: 'name'
#   placeholder: 'Select somebody'
#   options: [
#     {
#       description: 'Nice Guy'
#       name: 'Brian Reavis'
#       imageUrl: 'http://www.fashionspictures.com/wp-content/uploads/2013/11/short-hairstyles-for-a-square-face-42-150x150.jpg'
#     }
#     {
#       description: 'Other nice guy'
#       name: 'Nikola Tesla'
#       imageUrl: 'http://www.fashionspictures.com/wp-content/uploads/2013/11/short-hairstyles-for-a-square-face-42-150x150.jpg'
#     }
#   ]
#   render: option: (item, escape) ->
#     '<div class="option">' + '<div class="image">' + '<img class="avatar" src="' + item.imageUrl + '" />' + '</div>' + '<div class="text">' + '<span class="name">' + escape(item.name) + '</span>' + '<p class="description">' + escape(item.description) + '</p>' + '</div>' + '</div>'
