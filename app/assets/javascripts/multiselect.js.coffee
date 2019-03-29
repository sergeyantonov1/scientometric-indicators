###*
# Display a nice easy to use multiselect list
# @Version: 2.4.16
# @Author: Patrick Springstubbe
# @Contact: @JediNobleclem
# @Website: springstubbe.us
# @Source: https://github.com/nobleclem/jQuery-MultiSelect
#
# Usage:
#     $('select[multiple]').multiselect();
#     $('select[multiple]').multiselect({ texts: { placeholder: 'Select options' } });
#     $('select[multiple]').multiselect('reload');
#     $('select[multiple]').multiselect( 'loadOptions', [{
#         name   : 'Option Name 1',
#         value  : 'option-value-1',
#         checked: false,
#         attributes : {
#             custom1: 'value1',
#             custom2: 'value2'
#         }
#     },{
#         name   : 'Option Name 2',
#         value  : 'option-value-2',
#         checked: false,
#         attributes : {
#             custom1: 'value1',
#             custom2: 'value2'
#         }
#     }]);
#
#
###

(($) ->
  defaults =
    columns: 1
    search: false
    searchOptions:
      delay: 250
      showOptGroups: false
      searchText: true
      searchValue: false
      onSearch: (element) ->
    texts:
      placeholder: 'Select options'
      search: 'Search'
      selectedOptions: ' selected'
      selectAll: 'Select all'
      unselectAll: 'Unselect all'
      noneSelected: 'None Selected'
    selectAll: false
    selectGroup: false
    minHeight: 200
    maxHeight: null
    maxWidth: null
    maxPlaceholderWidth: null
    maxPlaceholderOpts: 10
    showCheckbox: true
    checkboxAutoFit: false
    optionAttributes: []
    onLoad: (element) ->
    onOptionClick: (element, option) ->
    onControlClose: (element) ->
    onSelectAll: (element, selected) ->
  msCounter = 1
  # counter for each select list
  msOptCounter = 1
  # counter for each option on page
  # FOR LEGACY BROWSERS (talking to you IE8)

  MultiSelect = (element, options) ->
    @element = element
    @options = $.extend(true, {}, defaults, options)
    @updateSelectAll = true
    @updatePlaceholder = true
    @listNumber = msCounter
    msCounter = msCounter + 1
    # increment counter

    ### Make sure its a multiselect list ###

    if !$(@element).attr('multiple')
      throw new Error('[jQuery-MultiSelect] Select list must be a multiselect list in order to use this plugin')

    ### Options validation checks ###

    if @options.search
      if !@options.searchOptions.searchText and !@options.searchOptions.searchValue
        throw new Error('[jQuery-MultiSelect] Either searchText or searchValue should be true.')

    ###* BACKWARDS COMPATIBILITY *###

    if 'placeholder' of @options
      @options.texts.placeholder = @options.placeholder
      delete @options.placeholder
    if 'default' of @options.searchOptions
      @options.texts.search = @options.searchOptions['default']
      delete @options.searchOptions['default']

    ###* END BACKWARDS COMPATIBILITY *###

    # load this instance
    @load()
    return

  if typeof Array::map != 'function'

    Array::map = (callback, thisArg) ->
      if typeof thisArg == 'undefined'
        thisArg = this
      if $.isArray(thisArg) then $.map(thisArg, callback) else []

  if typeof String::trim != 'function'

    String::trim = ->
      @replace /^\s+|\s+$/g, ''

  MultiSelect.prototype =
    load: ->
      `var maxHeight`
      instance = this
      # make sure this is a select list and not loaded
      if instance.element.nodeName != 'SELECT' or $(instance.element).hasClass('jqmsLoaded')
        return true
      # sanity check so we don't double load on a select element
      $(instance.element).addClass('jqmsLoaded ms-list-' + instance.listNumber).data 'plugin_multiselect-instance', instance
      # add option container
      $(instance.element).after '<div id="ms-list-' + instance.listNumber + '" class="ms-options-wrap"><button type="button"><span>None Selected</span></button><div class="ms-options"><ul></ul></div></div>'
      placeholder = $(instance.element).siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> button:first-child')
      optionsWrap = $(instance.element).siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> .ms-options')
      optionsList = optionsWrap.find('> ul')
      # don't show checkbox (add class for css to hide checkboxes)
      if !instance.options.showCheckbox
        optionsWrap.addClass 'hide-checkbox'
      else if instance.options.checkboxAutoFit
        optionsWrap.addClass 'checkbox-autofit'
      # check if list is disabled
      if $(instance.element).prop('disabled')
        placeholder.prop 'disabled', true
      # set placeholder maxWidth
      if instance.options.maxPlaceholderWidth
        placeholder.css 'maxWidth', instance.options.maxPlaceholderWidth
      # override with user defined maxHeight
      if instance.options.maxHeight
        maxHeight = instance.options.maxHeight
      else
        # cacl default maxHeight
        maxHeight = $(window).height() - (optionsWrap.offset().top) + $(window).scrollTop() - 20
      # maxHeight cannot be less than options.minHeight
      maxHeight = if maxHeight < instance.options.minHeight then instance.options.minHeight else maxHeight
      optionsWrap.css
        maxWidth: instance.options.maxWidth
        minHeight: instance.options.minHeight
        maxHeight: maxHeight
      # isolate options scroll
      # @source: https://github.com/nobleclem/jQuery-IsolatedScroll
      optionsWrap.on 'touchmove mousewheel DOMMouseScroll', (e) ->
        if $(this).outerHeight() < $(this)[0].scrollHeight
          e0 = e.originalEvent
          delta = e0.wheelDelta or -e0.detail
          if $(this).outerHeight() + $(this)[0].scrollTop > $(this)[0].scrollHeight
            e.preventDefault()
            @scrollTop += if delta < 0 then 1 else -1
        return
      # hide options menus if click happens off of the list placeholder button
      $(document).off('click.ms-hideopts').on('click.ms-hideopts', (event) ->
        if !$(event.target).closest('.ms-options-wrap').length
          $('.ms-options-wrap.ms-active > .ms-options').each ->
            $(this).closest('.ms-options-wrap').removeClass 'ms-active'
            listID = $(this).closest('.ms-options-wrap').attr('id')
            thisInst = $(this).parent().siblings('.' + listID + '.jqmsLoaded').data('plugin_multiselect-instance')
            # USER CALLBACK
            if typeof thisInst.options.onControlClose == 'function'
              thisInst.options.onControlClose thisInst.element
            return
        # hide open option lists if escape key pressed
        return
      ).on 'keydown', (event) ->
        if (event.keyCode or event.which) == 27
          # esc key
          $(this).trigger 'click.ms-hideopts'
        return
      # handle pressing enter|space while tabbing through
      placeholder.on 'keydown', (event) ->
        code = event.keyCode or event.which
        if code == 13 or code == 32
          # enter OR space
          placeholder.trigger 'mousedown'
        return
      # disable button action
      placeholder.on('mousedown', (event) ->
        `var maxHeight`
        `var maxHeight`
        # ignore if its not a left click
        if event.which and event.which != 1
          return true
        # hide other menus before showing this one
        $('.ms-options-wrap.ms-active').each ->
          if $(this).siblings('.' + $(this).attr('id') + '.jqmsLoaded')[0] != optionsWrap.parent().siblings('.ms-list-' + instance.listNumber + '.jqmsLoaded')[0]
            $(this).removeClass 'ms-active'
            thisInst = $(this).siblings('.' + $(this).attr('id') + '.jqmsLoaded').data('plugin_multiselect-instance')
            # USER CALLBACK
            if typeof thisInst.options.onControlClose == 'function'
              thisInst.options.onControlClose thisInst.element
          return
        # show/hide options
        optionsWrap.closest('.ms-options-wrap').toggleClass 'ms-active'
        # recalculate height
        if optionsWrap.closest('.ms-options-wrap').hasClass('ms-active')
          optionsWrap.css 'maxHeight', ''
          # override with user defined maxHeight
          if instance.options.maxHeight
            maxHeight = instance.options.maxHeight
          else
            # cacl default maxHeight
            maxHeight = $(window).height() - (optionsWrap.offset().top) + $(window).scrollTop() - 20
          if maxHeight
            # maxHeight cannot be less than options.minHeight
            maxHeight = if maxHeight < instance.options.minHeight then instance.options.minHeight else maxHeight
            optionsWrap.css 'maxHeight', maxHeight
        else if typeof instance.options.onControlClose == 'function'
          instance.options.onControlClose instance.element
        return
      ).click (event) ->
        event.preventDefault()
        return
      # add placeholder copy
      if instance.options.texts.placeholder
        placeholder.find('span').text instance.options.texts.placeholder
      # add search box
      if instance.options.search
        optionsList.before '<div class="ms-search"><input type="text" value="" placeholder="' + instance.options.texts.search + '" /></div>'
        search = optionsWrap.find('.ms-search input')
        search.on 'keyup', ->
          # ignore keystrokes that don't make a difference
          if $(this).data('lastsearch') == $(this).val()
            return true
          # pause timeout
          if $(this).data('searchTimeout')
            clearTimeout $(this).data('searchTimeout')
          thisSearchElem = $(this)
          $(this).data 'searchTimeout', setTimeout((->
            thisSearchElem.data 'lastsearch', thisSearchElem.val()
            # USER CALLBACK
            if typeof instance.options.searchOptions.onSearch == 'function'
              instance.options.searchOptions.onSearch instance.element
            # search non optgroup li's
            searchString = $.trim(search.val().toLowerCase())
            if searchString
              optionsList.find('li[data-search-term*="' + searchString + '"]:not(.optgroup)').removeClass 'ms-hidden'
              optionsList.find('li:not([data-search-term*="' + searchString + '"], .optgroup)').addClass 'ms-hidden'
            else
              optionsList.find('.ms-hidden').removeClass 'ms-hidden'
            # show/hide optgroups based on if there are items visible within
            if !instance.options.searchOptions.showOptGroups
              optionsList.find('.optgroup').each ->
                if $(this).find('li:not(.ms-hidden)').length
                  $(this).show()
                else
                  $(this).hide()
                return
            instance._updateSelectAllText()
            return
          ), instance.options.searchOptions.delay)
          return
      # add global select all options
      if instance.options.selectAll
        optionsList.before '<a href="#" class="ms-selectall global">' + instance.options.texts.selectAll + '</a>'
      # handle select all option
      optionsWrap.on 'click', '.ms-selectall', (event) ->
        event.preventDefault()
        instance.updateSelectAll = false
        instance.updatePlaceholder = false
        select = optionsWrap.parent().siblings('.ms-list-' + instance.listNumber + '.jqmsLoaded')
        if $(this).hasClass('global')
          # check if any options are not selected if so then select them
          if optionsList.find('li:not(.optgroup, .selected, .ms-hidden)').length
            # get unselected vals, mark as selected, return val list
            optionsList.find('li:not(.optgroup, .selected, .ms-hidden)').addClass 'selected'
            optionsList.find('li.selected input[type="checkbox"]:not(:disabled)').prop 'checked', true
          else
            optionsList.find('li:not(.optgroup, .ms-hidden).selected').removeClass 'selected'
            optionsList.find('li:not(.optgroup, .ms-hidden, .selected) input[type="checkbox"]:not(:disabled)').prop 'checked', false
        else if $(this).closest('li').hasClass('optgroup')
          optgroup = $(this).closest('li.optgroup')
          # check if any selected if so then select them
          if optgroup.find('li:not(.selected, .ms-hidden)').length
            optgroup.find('li:not(.selected, .ms-hidden)').addClass 'selected'
            optgroup.find('li.selected input[type="checkbox"]:not(:disabled)').prop 'checked', true
          else
            optgroup.find('li:not(.ms-hidden).selected').removeClass 'selected'
            optgroup.find('li:not(.ms-hidden, .selected) input[type="checkbox"]:not(:disabled)').prop 'checked', false
        vals = []
        optionsList.find('li.selected input[type="checkbox"]').each ->
          vals.push $(this).val()
          return
        select.val(vals).trigger 'change'
        instance.updateSelectAll = true
        instance.updatePlaceholder = true
        # USER CALLBACK
        if typeof instance.options.onSelectAll == 'function'
          instance.options.onSelectAll instance.element, vals.length
        instance._updateSelectAllText()
        instance._updatePlaceholderText()
        return
      # add options to wrapper
      options = []
      $(instance.element).children().each ->
        if @nodeName == 'OPTGROUP'
          groupOptions = []
          $(this).children('option').each ->
            thisOptionAtts = {}
            i = 0
            while i < instance.options.optionAttributes.length
              thisOptAttr = instance.options.optionAttributes[i]
              if $(this).attr(thisOptAttr) != undefined
                thisOptionAtts[thisOptAttr] = $(this).attr(thisOptAttr)
              i++
            groupOptions.push
              name: $(this).text()
              value: $(this).val()
              checked: $(this).prop('selected')
              attributes: thisOptionAtts
            return
          options.push
            label: $(this).attr('label')
            options: groupOptions
        else if @nodeName == 'OPTION'
          thisOptionAtts = {}
          i = 0
          while i < instance.options.optionAttributes.length
            thisOptAttr = instance.options.optionAttributes[i]
            if $(this).attr(thisOptAttr) != undefined
              thisOptionAtts[thisOptAttr] = $(this).attr(thisOptAttr)
            i++
          options.push
            name: $(this).text()
            value: $(this).val()
            checked: $(this).prop('selected')
            attributes: thisOptionAtts
        else
          # bad option
          return true
        return
      instance.loadOptions options, true, false
      # BIND SELECT ACTION
      optionsWrap.on 'click', 'input[type="checkbox"]', ->
        $(this).closest('li').toggleClass 'selected'
        select = optionsWrap.parent().siblings('.ms-list-' + instance.listNumber + '.jqmsLoaded')
        # toggle clicked option
        select.find('option[value="' + instance._escapeSelector($(this).val()) + '"]').prop('selected', $(this).is(':checked')).closest('select').trigger 'change'
        # USER CALLBACK
        if typeof instance.options.onOptionClick == 'function'
          instance.options.onOptionClick instance.element, this
        instance._updateSelectAllText()
        instance._updatePlaceholderText()
        return
      # BIND FOCUS EVENT
      optionsWrap.on('focusin', 'input[type="checkbox"]', ->
        $(this).closest('label').addClass 'focused'
        return
      ).on 'focusout', 'input[type="checkbox"]', ->
        $(this).closest('label').removeClass 'focused'
        return
      # USER CALLBACK
      if typeof instance.options.onLoad == 'function'
        instance.options.onLoad instance.element
      # hide native select list
      $(instance.element).hide()
      return
    loadOptions: (options, overwrite, updateSelect) ->
      `var selOption`
      overwrite = if typeof overwrite == 'boolean' then overwrite else true
      updateSelect = if typeof updateSelect == 'boolean' then updateSelect else true
      instance = this
      select = $(instance.element)
      optionsList = select.siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> .ms-options > ul')
      optionsWrap = select.siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> .ms-options')
      if overwrite
        optionsList.find('> li').remove()
        if updateSelect
          select.find('> *').remove()
      containers = []
      for key of options
        # Prevent prototype methods injected into options from being iterated over.
        if !options.hasOwnProperty(key)
          i++
          continue
        thisOption = options[key]
        container = $('<li/>')
        appendContainer = true
        # OPTION
        if thisOption.hasOwnProperty('value')
          if instance.options.showCheckbox and instance.options.checkboxAutoFit
            container.addClass 'ms-reflow'
          # add option to ms dropdown
          instance._addOption container, thisOption
          if updateSelect
            selOption = $('<option value="' + thisOption.value + '">' + thisOption.name + '</option>')
            # add custom user attributes
            if thisOption.hasOwnProperty('attributes') and Object.keys(thisOption.attributes).length
              selOption.attr thisOption.attributes
            # mark option as selected
            if thisOption.checked
              selOption.prop 'selected', true
            select.append selOption
        else if thisOption.hasOwnProperty('options')
          optGroup = $('<optgroup label="' + thisOption.label + '"></optgroup>')
          optionsList.find('> li.optgroup > span.label').each ->
            if $(this).text() == thisOption.label
              container = $(this).closest('.optgroup')
              appendContainer = false
            return
          # prepare to append optgroup to select element
          if updateSelect
            if select.find('optgroup[label="' + thisOption.label + '"]').length
              optGroup = select.find('optgroup[label="' + thisOption.label + '"]')
            else
              select.append optGroup
          # setup container
          if appendContainer
            container.addClass 'optgroup'
            container.append '<span class="label">' + thisOption.label + '</span>'
            container.find('> .label').css clear: 'both'
            # add select all link
            if instance.options.selectGroup
              container.append '<a href="#" class="ms-selectall">' + instance.options.texts.selectAll + '</a>'
            container.append '<ul/>'
          for gKey of thisOption.options
            # Prevent prototype methods injected into options from
            # being iterated over.
            if !thisOption.options.hasOwnProperty(gKey)
              i++
              continue
            thisGOption = thisOption.options[gKey]
            gContainer = $('<li/>')
            if instance.options.showCheckbox and instance.options.checkboxAutoFit
              gContainer.addClass 'ms-reflow'
            # no clue what this is we hit (skip)
            if !thisGOption.hasOwnProperty('value')
              i++
              continue
            instance._addOption gContainer, thisGOption
            container.find('> ul').append gContainer
            # add option to optgroup in select element
            if updateSelect
              selOption = $('<option value="' + thisGOption.value + '">' + thisGOption.name + '</option>')
              # add custom user attributes
              if thisGOption.hasOwnProperty('attributes') and Object.keys(thisGOption.attributes).length
                selOption.attr thisGOption.attributes
              # mark option as selected
              if thisGOption.checked
                selOption.prop 'selected', true
              optGroup.append selOption
        else
          # no clue what this is we hit (skip)
          i++
          continue
        if appendContainer
          containers.push container
      optionsList.append containers
      # pad out label for room for the checkbox
      if instance.options.checkboxAutoFit and instance.options.showCheckbox and !optionsWrap.hasClass('hide-checkbox')
        chkbx = optionsList.find('.ms-reflow:eq(0) input[type="checkbox"]')
        if chkbx.length
          checkboxWidth = chkbx.outerWidth()
          checkboxWidth = if checkboxWidth then checkboxWidth else 15
          optionsList.find('.ms-reflow label').css 'padding-left', parseInt(chkbx.closest('label').css('padding-left')) * 2 + checkboxWidth
          optionsList.find('.ms-reflow').removeClass 'ms-reflow'
      # update placeholder text
      instance._updatePlaceholderText()
      # RESET COLUMN STYLES
      optionsWrap.find('ul').css
        'column-count': ''
        'column-gap': ''
        '-webkit-column-count': ''
        '-webkit-column-gap': ''
        '-moz-column-count': ''
        '-moz-column-gap': ''
      # COLUMNIZE
      if select.find('optgroup').length
        # float non grouped options
        optionsList.find('> li:not(.optgroup)').css
          'float': 'left'
          width: 100 / instance.options.columns + '%'
        # add CSS3 column styles
        optionsList.find('li.optgroup').css(clear: 'both').find('> ul').css
          'column-count': instance.options.columns
          'column-gap': 0
          '-webkit-column-count': instance.options.columns
          '-webkit-column-gap': 0
          '-moz-column-count': instance.options.columns
          '-moz-column-gap': 0
        # for crappy IE versions float grouped options
        if @_ieVersion() and @_ieVersion() < 10
          optionsList.find('li.optgroup > ul > li').css
            'float': 'left'
            width: 100 / instance.options.columns + '%'
      else
        # add CSS3 column styles
        optionsList.css
          'column-count': instance.options.columns
          'column-gap': 0
          '-webkit-column-count': instance.options.columns
          '-webkit-column-gap': 0
          '-moz-column-count': instance.options.columns
          '-moz-column-gap': 0
        # for crappy IE versions float grouped options
        if @_ieVersion() and @_ieVersion() < 10
          optionsList.find('> li').css
            'float': 'left'
            width: 100 / instance.options.columns + '%'
      # update un/select all logic
      instance._updateSelectAllText()
      return
    settings: (options) ->
      @options = $.extend(true, {}, @options, options)
      @reload()
      return
    unload: ->
      $(@element).siblings('#ms-list-' + @listNumber + '.ms-options-wrap').remove()
      $(@element).show ->
        $(this).css('display', '').removeClass 'jqmsLoaded'
        return
      return
    reload: ->
      # remove existing options
      $(@element).siblings('#ms-list-' + @listNumber + '.ms-options-wrap').remove()
      $(@element).removeClass 'jqmsLoaded'
      # load element
      @load()
      return
    reset: ->
      defaultVals = []
      $(@element).find('option').each ->
        if $(this).prop('defaultSelected')
          defaultVals.push $(this).val()
        return
      $(@element).val defaultVals
      @reload()
      return
    disable: (status) ->
      status = if typeof status == 'boolean' then status else true
      $(@element).prop 'disabled', status
      $(@element).siblings('#ms-list-' + @listNumber + '.ms-options-wrap').find('button:first-child').prop 'disabled', status
      return
    _updateSelectAllText: ->
      if !@updateSelectAll
        return
      instance = this
      # select all not used at all so just do nothing
      if !instance.options.selectAll and !instance.options.selectGroup
        return
      optionsWrap = $(instance.element).siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> .ms-options')
      # update un/select all text
      optionsWrap.find('.ms-selectall').each ->
        unselected = $(this).parent().find('li:not(.optgroup,.selected,.ms-hidden)')
        $(this).text if unselected.length then instance.options.texts.selectAll else instance.options.texts.unselectAll
        return
      return
    _updatePlaceholderText: ->
      if !@updatePlaceholder
        return
      instance = this
      select = $(instance.element)
      selectVals = if select.val() then select.val() else []
      placeholder = select.siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> button:first-child')
      placeholderTxt = placeholder.find('span')
      optionsWrap = select.siblings('#ms-list-' + instance.listNumber + '.ms-options-wrap').find('> .ms-options')
      # if there are disabled options get those values as well
      if select.find('option:selected:disabled').length
        selectVals = []
        select.find('option:selected').each ->
          selectVals.push $(this).val()
          return
      # get selected options
      selOpts = []
      for key of selectVals
        # Prevent prototype methods injected into options from being iterated over.
        if !selectVals.hasOwnProperty(key)
          i++
          continue
        selOpts.push $.trim(select.find('option[value="' + instance._escapeSelector(selectVals[key]) + '"]').text())
        if selOpts.length >= instance.options.maxPlaceholderOpts
          break
      # UPDATE PLACEHOLDER TEXT WITH OPTIONS SELECTED
      placeholderTxt.text selOpts.join(', ')
      if selOpts.length
        optionsWrap.closest('.ms-options-wrap').addClass 'ms-has-selections'
      else
        optionsWrap.closest('.ms-options-wrap').removeClass 'ms-has-selections'
      # replace placeholder text
      if !selOpts.length
        placeholderTxt.text instance.options.texts.placeholder
      else if placeholderTxt.width() > placeholder.width() or selOpts.length != selectVals.length
        placeholderTxt.text selectVals.length + instance.options.texts.selectedOptions
      return
    _addOption: (container, option) ->
      instance = this
      thisOption = $('<label/>',
        for: 'ms-opt-' + msOptCounter
        text: option.name)
      thisCheckbox = $('<input>',
        type: 'checkbox'
        title: option.name
        id: 'ms-opt-' + msOptCounter
        value: option.value)
      # add user defined attributes
      if option.hasOwnProperty('attributes') and Object.keys(option.attributes).length
        thisCheckbox.attr option.attributes
      if option.checked
        container.addClass 'default selected'
        thisCheckbox.prop 'checked', true
      thisOption.prepend thisCheckbox
      searchTerm = ''
      if instance.options.searchOptions.searchText
        searchTerm += ' ' + option.name.toLowerCase()
      if instance.options.searchOptions.searchValue
        searchTerm += ' ' + option.value.toLowerCase()
      container.attr('data-search-term', $.trim(searchTerm)).prepend thisOption
      msOptCounter = msOptCounter + 1
      return
    _ieVersion: ->
      myNav = navigator.userAgent.toLowerCase()
      if myNav.indexOf('msie') != -1 then parseInt(myNav.split('msie')[1]) else false
    _escapeSelector: (string) ->
      if typeof $.escapeSelector == 'function'
        $.escapeSelector string
      else
        string.replace /[!"#$%&'()*+,.\/:;<=>?@[\\\]^`{|}~]/g, '\\$&'
  # ENABLE JQUERY PLUGIN FUNCTION

  $.fn.multiselect = (options) ->
    if !@length
      return
    args = arguments
    ret = undefined
    # menuize each list
    if options == undefined or typeof options == 'object'
      return @each(->
        if !$.data(this, 'plugin_multiselect')
          $.data this, 'plugin_multiselect', new MultiSelect(this, options)
        return
      )
    else if typeof options == 'string' and options[0] != '_' and options != 'init'
      @each ->
        instance = $.data(this, 'plugin_multiselect')
        if instance instanceof MultiSelect and typeof instance[options] == 'function'
          ret = instance[options].apply(instance, Array::slice.call(args, 1))
        # special destruct handler
        if options == 'unload'
          $.data this, 'plugin_multiselect', null
        return
      return ret
    return

  return
) jQuery
