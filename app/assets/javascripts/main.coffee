# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.fn.observeMouseOut = (options)->
  $object = $(this)

  $(document).on 'mouseup', (event)->
    #$containers = $("div.notification-container")
    $containers = $object.filter(":visible")

    out_of_container = true
    in_container = !out_of_container
    $context_container = null
    $containers.each (index, element)->
      $element = $(element)
      cond1 = !$element.is(event.target)
      cond2 = $element.has(event.target).length is 0
      out_of_container = cond1 && cond2
      in_container = !out_of_container

      if out_of_container
        $context_container = $element
      else
        return false
    #console.log("mouseup: in: #{in_container}; out: #{out_of_container}")
    if out_of_container
      $containers.trigger('mouseUpOut')

(($) ->
  $.fn.getCursorPosition = ->
    input = @get(0)
    if !input
      return
    # No (input) element found
    if 'selectionStart' in input
      # Standard-compliant browsers
      return input.selectionStart
    else if document.selection
      # IE
      input.focus()
      sel = document.selection.createRange()
      selLen = document.selection.createRange().text.length
      sel.moveStart 'character', -input.value.length
      return sel.text.length - selLen
    return

  return
) jQuery




$(document).ready ->
#  init multiple select
  $('select.ud-multiple').SumoSelect outerHtml: false

  $('select.sort-by, select.view-mode').SumoSelect
    captionHtml: '<p class=\'CaptionCont SlectBox\'><label></label></p>'
    wrapperHtml: '<div class="SumoSelect GraySelect">'
    outerHtml: '<div class="SumoSelectOuter GraySelectOuter">'
    selectFirstIfBlank: true

#clear form
  $('a.clear-form').click ->
    $formWrap = $(this).closest('form')
    $items = $formWrap.find('ul.options li')
    $items.removeClass('selected')
    $captionSelect = $formWrap.find('p.CaptionCont span')
    $captionSelect.text('')

#  set sumo select in true
#  $('.ud-multiple').SumoSelect okCancelInMulti: true

# binder for clear form if click on clear form button
  $('p.ud-s-clear a').on 'click', ->
#   for sumoselect
#    $('select.ud-multiple')[0].sumo.unSelectAll()
#    $('select.ud-multiple')[0].sumo.reload()

#    clear standart inputs and textarea
    range_age = $("#ud-range-age-slide")
    range_age.slider("values", 0, range_age.attr('data-min-val'))
    range_age.slider("values", 1, range_age.attr('data-max-val'))
    $('#lsf-age-min').val range_age.attr('data-min-val')
    $('#lsf-age-max').val range_age.attr('data-max-val')

    range_height = $("#ud-range-height-slide")
    range_height.slider("values", 0, range_height.attr('data-min-val'))
    range_height.slider("values", 1, range_height.attr('data-max-val'))
    $('#lsf-height-min').val range_height.attr('data-min-val')
    $('#lsf-height-max').val range_height.attr('data-max-val')


    range_weight = $("#ud-range-weight-slide")
    range_weight.slider("values", 0, range_weight.attr('data-min-val'))
    range_weight.slider("values", 1, range_weight.attr('data-max-val'))
    $('#lsf-weight-min').val range_weight.attr('data-min-val')
    $('#lsf-weight-max').val range_weight.attr('data-max-val')

#  countect for enter characters
  max_symbols = 1000
  editor_state = {
    chars_length: null
  }

  $('body')
      .on 'focus', '[contenteditable]', ()->
          $this = $(this)
          $this.data 'before', $this.html()
          return $this
      .on 'blur keyup keydown paste input', '[contenteditable]', (event)->
          $this = $(this)
          if $this.text().length >= max_symbols && event.which != undefined && ((event.which >= 48 && event.which <=90) || (event.which >= 96 && event.which <= 105))
            event.preventDefault()
          if $this.data('before') isnt $this.html()
              $this.data 'before', $this.html()
              $this.trigger('change')
          return $this
  getCaretPosition = (editableDiv) ->
    caretPos = 0
    sel = undefined
    range = undefined
    if window.getSelection
      sel = window.getSelection()
      if sel.rangeCount
        range = sel.getRangeAt(0)
        if range.commonAncestorContainer.parentNode == editableDiv
          caretPos = range.endOffset
    else if document.selection and document.selection.createRange
      range = document.selection.createRange()
      if range.parentElement() == editableDiv
        tempEl = document.createElement('span')
        editableDiv.insertBefore tempEl, editableDiv.firstChild
        tempRange = range.duplicate()
        tempRange.moveToElementText tempEl
        tempRange.setEndPoint 'EndToEnd', range
        caretPos = tempRange.text.length
    caretPos


  $('section[contenteditable]').on "change", (event)->
    $area = $(@)
    $wrap = $(@).closest('.ud-message-wrap')
    $label_count = $wrap.find('.ud-ce-label span')

    #editor_state.chars_length = $area.text().length
    chars_length = $area.text().length
    $area.data('chars_length', chars_length )
    $label_count.text($area.text().length)
    event.preventDefault()

# mailbox text input
  $('.ud-message-wrap .image-popup-one-item a').click ->
    $get_user_mb_id = $(@).closest('.reveal-modal').attr('data-user-id')
    $wrap = $("#{$get_user_mb_id}")
    $attach_wrap = $wrap.find('.ud-e-attachment-wrap')
    $image_object = $(@).parent().html()
    $attach_wrap.append($image_object)

#    $('#AddAPictures').trigger 'reveal:close'
    $('#AddAPictures').foundation 'reveal', 'close'
  $('.ud-smiles-inner a img').click ->
    alert 'smile'



# tripadvisor finding girl
  $('.t-result-finding-wrap .trf-choose-girl').click ->
    $wrap = $(@).closest('.t-result-finding-wrap')
    $girls = $wrap.find('.trf-one-girl-wrap')
    $currentGirlWrap = $(@).closest('.trf-one-girl-wrap')

    $nextStep = $wrap.find('.t-button-step-wrap')

    $girls.hide()
    $currentGirlWrap.show()
    $currentGirlWrap.addClass('selected-girl')
    $nextStep.show()


# tripadvisor
  $('.tbag-thumbs-wrap .image').click (e)->
    e.preventDefault()

    $wrapper = $(@).closest('.t-book-apartment-gallery-wrap')
    $previewWrap = $wrapper.find('.tbag-image')
    $hrefData = $(@).parent().attr('data-href')

    $thisStyle = $(this).attr("style")
    $previewWrap.attr style: $thisStyle
    $previewWrap.parent().attr href: $hrefData

    $('.tbag-thumbs-wrap a').removeClass('active')
    $(@).parent().addClass(' active')

  $('.t-prev-step-wrap a').click ->
    $wrap = $(@).closest('.ud-tabs-wrap')
    $tabHeader = $wrap.find('.ud-tab-link')
    $tabs = $wrap.find('.ud-tab')

    $('.tripadvisor-page-wrap .ud-tab-link').removeClass('active')
    $tabs.hide()
    if $(@).hasClass('t-step-one')
      $tabHeader.eq(0).addClass(' active')
      $tabs.eq(0).show()
      $('.trf-one-girl-wrap').show()
      $('.trf-one-girl-wrap').removeClass('selected-girl')
    if $(@).hasClass('t-step-two')
      $tabHeader.eq(1).addClass(' active')
      $tabs.eq(1).show()

  $('.t-button-step-wrap a').click ->
    $wrap = $(@).closest('.ud-tabs-wrap')
    $tabHeader = $wrap.find('.ud-tab-link')
    $tabs = $wrap.find('.ud-tab')

    $('.tripadvisor-page-wrap .ud-tab-link').removeClass('active')
    $tabs.hide()
    if $(@).hasClass('tm-step-two')
      $tabHeader.eq(1).addClass(' active')
      $tabs.eq(1).show()
    if $(@).hasClass('tm-step-three')
      $tabHeader.eq(2).addClass(' active')
      $tabs.eq(2).show()

# datepicker
  $('.datepicker').datepicker
    showOn: 'button'
    buttonImage: 'assets/UAD-calendar.png'
    buttonImageOnly: true
    buttonText: 'Select date'
  $('.datepicker.hasDatepicker').on 'click', ()->
    $(this).next().trigger('click')

# init tabs
  $('.ud-tab').hide()
  $('.ud-tab').first().show()
  $('.ud-tab-link').first().addClass('active')

#  $('.ud-tab-link').click ->
#    current_position = $(@).index()
#    $wrap = $(@).closest('.ud-tabs-wrap')
#    $form_wrap = $wrap.find('.ud-tab')
#
#    $('.ud-tab-link').removeClass('active')
#    $(@).addClass('active')
#
#    $('.ud-tab').hide()
#    $form_wrap.eq(current_position).show()

# edit changes informations
  $('.p-edit-iam').click (e)->
    e.preventDefault()
    $wrap = $(@).closest('form')
    if $wrap.hasClass('p-editing-form')
      $wrap.removeClass('p-editing-form')
    else
      $wrap.addClass('p-editing-form')
    $('.p-input-preview').hide()
    $('.p-input-edit').show()
    $(@).addClass('hide')
    $saveButton = $wrap.find('.special-text-shadow.p-save-iam')
    $saveButton.removeClass('hide')

# save changes informations
  $('.p-save-iam').click (e)->
    e.preventDefault()
    $wrap = $(@).closest('form')
    if $wrap.hasClass('p-editing-form')
      $wrap.removeClass('p-editing-form')
    else
      $wrap.addClass('p-editing-form')
    $('.p-input-preview').show()
    $('.p-input-edit').hide()
    $(@).addClass('hide')
    $editButton = $wrap.find('.p-edit-iam')
    $editButton.removeClass('hide')


#  image gallery
  $("a.fancy_gallery").fancybox
    beforeShow : ->
      @.title = (@.title ? '' + @.title + '' : '') + ' ' + (@.index + 1) + '/' + @.group.length
      return

#  profile edit and save field
  $('.p-input-preview div').click ->
    $wrap = $(@).closest('.p-input-wrap')
    $editField = $wrap.find('.p-input-edit')
    $previewField = $wrap.find('.p-input-preview')

    $('.p-input-edit').hide()
    $('.p-input-preview').show()
    $previewField.hide()
    $editField.show()

  $('.p-input-edit .pi-apply-button').click ->
    $wrap = $(@).closest('.p-input-wrap')
    $editField = $wrap.find('.p-input-edit')
    $previewField = $wrap.find('.p-input-preview')

    $editFieldInput = $wrap.find('input').val()
#    alert 'value: '+$editFieldInput
    $previewFieldInput = $wrap.find('p')
    $previewFieldInput.text($editFieldInput)

    $previewField.show()
    $editField.hide()

#  observe mouse
  $('.l-header-login-form-inner').on 'mouseUpOut', ()->
    $(@).addClass('hide')
  $('.l-header-login-form-inner').observeMouseOut()
#  form forgot password
  $('a.ud-landing-forgot-password').click (e)->
    e.preventDefault()
    $wrap = $(@).closest('.lf-fp-popup-wrap')
    $forgot_password = $wrap.find('.l-hlf-forgot-password')
    $login_form = $wrap.find('.l-header-login-form')

    $forgot_password.removeClass('hide')
    $login_form.addClass('hide')

  $('a.ud-lfp-back').click (e)->
    e.preventDefault()
    $wrap = $(@).closest('.lf-fp-popup-wrap')
    $forgot_password = $wrap.find('.l-hlf-forgot-password')
    $login_form = $wrap.find('.l-header-login-form')

    $forgot_password.addClass('hide')
    $login_form.removeClass('hide')


#  range slide initialize
  if typeof $.fn.slider == 'function'
    $ ->
      $('#ud-range-age-slide').slider
        range: true
        min: 18
        max: 65
        values: [
          18
          65
        ]
        slide: (event, ui) ->
          # field min value
          $('#lsf-age-min').val ui.values[0]
          # field max value
          $('#lsf-age-max').val ui.values[1]
          return

      # set default value
      $('#lsf-age-min').val $('#ud-range-age-slide').slider('values', 0)
      $('#lsf-age-max').val $('#ud-range-age-slide').slider('values', 1)
      return

#  $('#lsf-age-min').change ->
#    $('#ud-range-slide').slider 'value', parseInt(@value)
#    return

    $ ->
      $('#ud-range-height-slide').slider
        range: true
        min: 135
        max: 200
        values: [
          135
          200
        ]
        slide: (event, ui) ->
          # field min value
          $('#lsf-height-min').val ui.values[0]
          # field max value
          $('#lsf-height-max').val ui.values[1]
          return

      # set default value
      $('#lsf-height-min').val $('#ud-range-height-slide').slider('values', 0)
      $('#lsf-height-max').val $('#ud-range-height-slide').slider('values', 1)
      return

    $ ->
      $('#ud-range-weight-slide').slider
        range: true
        min: 40
        max: 150
        values: [
          40
          150
        ]
        slide: (event, ui) ->
          # field min value
          $('#lsf-weight-min').val ui.values[0]
          # field max value
          $('#lsf-weight-max').val ui.values[1]
          return

      # set default value
      $('#lsf-weight-min').val $('#ud-range-weight-slide').slider('values', 0)
      $('#lsf-weight-max').val $('#ud-range-weight-slide').slider('values', 1)
      return


#  landing banner registration form
  $('.ud-gender-input input:radio').change ->
    $wrap = $(@).closest('form')
    $input_for_female = $wrap.find('.lbf-for-fame-only')

    if $(@).val() == 'male'
      $input_for_female.addClass('hide')
    else if $(@).val() == 'female'
      $input_for_female.removeClass('hide')



# lading banner form
  $('.lbf-tumbler').click ->

    current_position = $(@).index()
    $wrap = $(@).closest('.l-banner-login-form')
    $form_wrap = $wrap.find('.lbf-form-wrap')

    $('.lbf-tumbler').removeClass('lbf-active')
    $(@).addClass('lbf-active')

    $('.lbf-form-wrap').addClass('hide')
    $form_wrap.eq(current_position).removeClass('hide')


#  landing binder header login form
  $('a.l-open-lhf-button').click ->
    if $('.l-header-login-form-inner').hasClass('hide')
      $('.l-header-login-form-inner').removeClass('hide')
    else
      $('.l-header-login-form-inner').addClass('hide')

# landing who is online
  owl1 = $("ul#diamonds-online-carousel")
  owl1.owlCarousel
    pagination: false,
    navigation: false,
    items: 6 #10 items above 1000px browser width
    itemsMobile: false # itemsMobile disabled - inherit from itemsTablet option
    autoPlay : false

# landing index banner
#  $('ul#index-banner').bxSlider
##    auto: true
#    pause: 6000
#    onSliderLoad: ->
#      $('.lb-about-profile').addClass('animated fadeInUp')
  $("ul#index-banner").bxSlider
    auto: true,
    mode: 'fade',
    pause: 6000,
    controls: false,
#    pagerCustom: "ul#bx_thumb",
    onSliderLoad: ->
      $('.lb-about-profile').addClass('animated fadeInUp')
#      $('.title_layer_2').addClass('animated slideInRight')
#      setTimeout (->
#        $('.main_banner_order_button').addClass('animated slideInDown')
#        #do something special
#      ), 2400

# landing couple stories
  $('#l-couple-stories ul').bxSlider()
#    controls: false
#    auto: true
#    pause: 6000
#    speed: 1000
#    touchEnabled:false
#    pagerCustom: 'ul#pagers-index-banner'

# mailbox sent
  $('.ud-sent-wrap a.send-group-mail').click ->
    $wrap = $(@).closest('.ud-sent-wrap')
    $send_gm_before = $wrap.find('.send-group-mail-wrap')
    $send_gm_after = $wrap.find('.send-group-mail-finish-wrap')

    $send_gm_before.hide()
    $send_gm_after.show()


# gits inbox tabs
  $('.ud-inbox-page-wrap .ud-inbox-tab').click ->
    current_position = $(this).index()
    $head_tabs = $(this)
    $wrap = $(this).closest('.ud-inbox-page-wrap')
    $('.ud-inbox-page-wrap .ud-inbox-tab').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.ud-inbox-one-tab-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#  mailbox show browse file
  $('.ud-has-attached-file .ua-tumbler').click ->
    $wrap = $(this).closest('.ud-has-attached-file')
    $block = $wrap.find('.ud-attached-wrap')
    $block.show()

#  mail box
  $('.ui-message-main-wrap b, .ui-message-main-wrap p.ud-text-message').click ->
    $wrapper = $(this).closest('.ud-message-one-block-wrap')
    $editMessage = $wrapper.find('.ud-inbox-sent-message')
    $subMesssageWrapper = $wrapper.find('.ud-inbox-message-sub-block-wrap')

    $('.ud-inbox-sent-message, .ud-inbox-message-sub-block-wrap').addClass('hide')
    $('.ud-message-one-block-wrap').removeClass('ud-opened-message-block')
    $wrapper.addClass('ud-opened-message-block')

    $subMesssageWrapper.removeClass('hide')
    $editMessage.removeClass('hide')



  $('.ud-inbox-message-wrap a.m-send').click ->
    $wrapper = $(this).closest('.ud-message-one-block-wrap')
    $editMessage = $wrapper.find('.ud-inbox-sent-message')
    $subMesssageWrapper = $wrapper.find('.ud-inbox-message-sub-block-wrap')
    $('.ud-message-one-block-wrap').removeClass('ud-opened-message-block')
    $subMesssageWrapper.addClass('hide')
    $editMessage.addClass('hide')

#  gift sub rules tabs
  $('ul.gift-rule-tabs li').click (e)->
    e.preventDefault()
    current_position = $(this).index()
    $wrapper = $(this).closest('.gift-rules')
    $tabHeader = $wrapper.find('li')
    $tabHeader.removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrapper.find('.g-rules-one-rule')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')


#gift preview image in popup
  $('.gift-popup-images-wrap .gift-image-thumb').click ->
    $wrapper = $(this).closest('.gift-popup-images-wrap')
    $previewWrap = $wrapper.find('.gift-image-preview')
    $thumbButtons = $wrapper.find('.gift-image-thumb')
    $thisStyle = $(this).attr("style")
    $previewWrap.attr style: $thisStyle
    $thumbButtons.removeClass('active')
    $(this).addClass('active')


# gits catalog tabs
  $('.gc-wrap .gcw-link-wrap').click ->
    current_position = $(this).index()
    $head_tabs = $(this)
    $wrap = $(this).closest('.gc-wrap')
    $('.gc-wrap .gcw-link-wrap').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.gc-catalog-one-tab-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')


#  gifts main tabs
  $('.gift-tab').click ->
    current_position = $(this).index()
    $head_tabs = $(this)
    $wrap = $(this).closest('.gifts-page-wrap')
    $('.gifts-header-wrap .gift-tab').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.gift-one-page')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#  binder for click on button a.read-all-rules
  $('a.read-all-rules').click (e)->
    e.preventDefault()

    $('.gift-tab').removeClass('active')
    $('.gift-tab-rules').addClass('active')

    $('.gift-one-page').addClass('hide')
    $('.gift-rules').removeClass('hide')



#  binder for strat web cam chat
  $('a.ud-start-cam').click ->
    $wrapper = $(this).closest('.video-chat-window')
    $welcome = $wrapper.find('.vcw-welcome')
    $wcw = $wrapper.find('.vcw-inner')
    if $wcw.hasClass('hide')
      $wcw.removeClass('hide')
      $welcome.addClass('hide')
#  stop web cam chat
  $('a.ud-stop-cam').click ->
    $wrapper = $(this).closest('.video-chat-window')
    $welcome = $wrapper.find('.vcw-welcome')
    $wcw = $wrapper.find('.vcw-inner')
    if $welcome.hasClass('hide')
      $welcome.removeClass('hide')
      $wcw.addClass('hide')
# binder for web cam chat fullmode
  $('a.ud-fullscreen-mode').click ->
    $wrapper = $(this).closest('.main-block-wrap')
    $wrapper.addClass('live-cam-full-mode')
# minimize
  $('a.ud-minimize-mode').click ->
    $wrapper = $(this).closest('.main-block-wrap')
    $wrapper.removeClass('live-cam-full-mode')

# bimder stop cam in full mode
  $('a.ud-minimize-stop-cam').click ->
    $mainWrapper = $(this).closest('.main-block-wrap')
    $mainWrapper.removeClass('live-cam-full-mode')
    $wrapper = $(this).closest('.video-chat-window')
    $welcome = $wrapper.find('.vcw-welcome')
    $wcw = $wrapper.find('.vcw-inner')
    if !$mainWrapper.hasClass('live-cam-full-mode')
      if $welcome.hasClass('hide')
        $welcome.removeClass('hide')
        $wcw.addClass('hide')




#  live chat toombler
  $('.horizontal-layout-button').click ->
    $wrapper = $(this).closest('.main-block-wrap')
    $tumbler = $('.live-chat-tumblers .tumbler')
    $tumbler.removeClass('active')
    $(this).addClass('active')
    if $wrapper.hasClass('vertical-layout')
      $wrapper.removeClass('vertical-layout')
    $wrapper.addClass('horizontal-layout')
  $('.vertical-layout-button').click ->
    $wrapper = $(this).closest('.main-block-wrap')
    $tumbler = $('.live-chat-tumblers .tumbler')
    $tumbler.removeClass('active')
    $(this).addClass('active')
    if $wrapper.hasClass('horizontal-layout')
      $wrapper.removeClass('horizontal-layout')
    $wrapper.addClass('vertical-layout')

# binder for frends list minimizate maximizate
  $('.ordered-list-wrap img.diamond-logo').click ->
    $wrapper = $(this).closest('.ordered-list-wrap')
    if $wrapper.hasClass('minimizate')
      $wrapper.removeClass('minimizate')
    else
      $wrapper.addClass('minimizate')
  $('.ordered-list-wrap img.diamond-logo-mobile').click ->
    $wrapper = $(this).closest('.ordered-list-wrap')
    if $wrapper.hasClass('maxinmizate')
      $wrapper.removeClass('maxinmizate')
    else
      $wrapper.addClass('maxinmizate')

# dismiss message on frendlie list
  $('.ol-start-chart-footer a.dismiss').click ->
    $wrapper = $(this).closest('.ol-start-chat')
    $frendContainer = $wrapper.find('.one-item')
    $thisContainer = $wrapper.find('.ol-start-chat-wrap')
    $thisContainer.toggleClass('hide')
    $frendContainer.toggleClass('hide')


#  $('#SocialRegistration').foundation('reveal', 'open')

#  init index page tabs wooman
  $('.favorites-nav-wrap:not(.settings-nav-wrap) .favorites-nav li').click ->
    current_position = $(this).index()

    $head_tabs = $(this)
    $wrap = $(this).closest('.favorites-woman-wrap')
    $('.favorites-nav li').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.tab-item-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#  init index page tabs man
  $('.favorites-nav-wrap:not(.settings-nav-wrap) .favorites-nav li').click ->
    current_position = $(this).index()

    $head_tabs = $(this)
    $wrap = $(this).closest('.favorites-man-wrap')
    $('.favorites-nav li').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.tab-item-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#small search form height binder
  $isExpendeForm = false
  $('.advanced-form-wrap .wrap h4').click ->
    $wrap = $(this).closest('.advanced-form-wrap')
    $form = $wrap.find('.advanced-form')

    if $isExpendeForm == false
      $form.addClass('extend-form')
      $isExpendeForm = true
    else
      $form.removeClass('extend-form')
      $isExpendeForm = false

#  search header form
  $('li.search a').click ->
    $wrap = $(this).closest('.header-navigation')
    $search = $(this).parent()
    if $search.hasClass('open')
      $search.removeClass('open')
    else
      $search.addClass('open')
    if $wrap.hasClass('open-search')
      $wrap.removeClass('open-search')
    else
      $wrap.addClass('open-search')

# disable scroll when mouse over an absolute div
  $('#notifications-panel').bind 'mousewheel DOMMouseScroll', (e) ->
    scrollTo = null
    if e.type == 'mousewheel'
      scrollTo = e.originalEvent.wheelDelta * -1
    else if e.type == 'DOMMouseScroll'
      scrollTo = 40 * e.originalEvent.detail
    if scrollTo
      e.preventDefault()
      $(this).scrollTop scrollTo + $(this).scrollTop()
    return


  $menuWrap = $('.main-menu-wrap')
  if $(window).width() <= 1024
    $menuWrap.addClass('mobile-menu')

#    main-menu binder
  $(".button-menu a.desktop").click ->
    $('body').removeClass('opened-main-menu')
    if $menuWrap.hasClass('open-menu')
      $menuWrap.removeClass('open-menu')
      $('body').addClass('closed-main-menu')
      $(this).removeClass('open')
    else
      $menuWrap.addClass('open-menu')
      $('body').removeClass('closed-main-menu')
      $(this).addClass("open")

# main-menu mobile binder
  $(".button-menu a.mobile").click ->
    if $('body').hasClass('opened-main-menu')
      $('body').removeClass('opened-main-menu')
      $(this).removeClass('open')
    else
      $('body').addClass('opened-main-menu')
      $(this).addClass('open')



  $('select.view-mode').change ->
    $wrapper = $(this).closest('.ordered-list-wrap')
    if $(this).val() == 'minimize'
      $wrapper.addClass('minimizate')

    else if $(this).val() == 'fullscreen'
      $wrapper.removeClass('minimizate')




# click event to scroll to top
  $(".scrollToTop").click ->
    $("html, body").animate
      scrollTop: 0
    , 800
    false



#notification popup
  $('.notification-link').click (event)->
    $wrap = $(this).closest('.notification-wrap')
    $container = $wrap.find('.notification-container').filter(":not(:visible)")
    $container.fadeIn 300

  $notification_containers = $("div.notification-container")
  $notification_containers.on "mouseUpOut", ()->
    $containers = $(this)
    console.log("hello")
    $containers.fadeOut duration: 300

  $notification_containers.observeMouseOut()

#  $(window).resize ->
#    footerHeight = $('.landing-page-wrap .l-footer-wrap').outerHeight()
#    stickFooterPush = $('.l-registration-push').height(footerHeight)
#    $('.landing-wrap').css 'marginBottom': '-' + footerHeight + 'px'
#    return
#  $(window).resize()
#  return

$(window).resize ->
  if $(window).width() >= 1445
    if $(".button-menu a.mobile").hasClass('open')
      $(".button-menu a.mobile").removeClass('open')
  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('.l-footer-wrap').offset().top
  fh = $('.l-footer-wrap').height()

  action = ot - wh
  if st >= action
    $('.ordered-list-wrap').addClass('fixed-to-footer')
  else
    $('.ordered-list-wrap').removeClass('fixed-to-footer')

lastScrollTop = 0
$(window).scroll (event) ->
  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('.l-footer-wrap').offset().top

  action = ot - wh
  if st >= action
    $('.ordered-list-wrap').addClass('fixed-to-footer')
  else
    $('.ordered-list-wrap').removeClass('fixed-to-footer')

  if st > lastScrollTop
    # downscroll code
    $('body').addClass 'hide-header'
  else
    # upscroll code
    $('body').removeClass 'hide-header'
  lastScrollTop = st


