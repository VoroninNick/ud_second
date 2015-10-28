# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$.fn.observeMouseOut = (options)->
  $object = $(this)

  $(document).on 'mouseup', (event)->
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

(($) ->

  $.fn.scrollToElement = (el, options) ->
    $el = jQuery(el)
    parentTop = @scrollTop()
    parentBottom = parentTop + @height()
    elTop = $el.position().top
    elBottom = elTop + $el.height() + parentTop
    offset = undefined
    if elBottom >= parentBottom
      # go down
      offset = parentTop + elBottom - parentBottom
      if options
        @animate { scrollTop: offset }, options
      else
        @scrollTop offset
    else if elTop < 0
      # go up
      offset = parentTop + elTop
      if options
        @animate { scrollTop: offset }, options
      else
        @scrollTop offset
    return

  return
) jQuery
#======================================
#  on resize change height livechat
#======================================

setHeight = (column) ->
  maxHeight = 0
  #Get all the element with class = col
  column = $(column)
  column.css 'height', 'auto'
  #Loop all the column
  textChatColumn = $('.lvc-chat-wrap').height()
  $('.lvc-offered-list-inner').height textChatColumn - 38
  $('.lvc-offered-list-wrap').height textChatColumn
  $('.lvc-video-wrap').height textChatColumn

$(document).ready ->
  setHeight '.lvc-coll'
  return
$(window).resize ->
  setHeight '.lvc-coll'
  return


#==============================
#  detect position cursor
#==============================
currentMousePos =
  x: -1
  y: -1

$(document).mousemove (event) ->
  currentMousePos.x = event.pageX
  currentMousePos.y = event.pageY
  dpr     = window.devicePixelRatio

  if(window.location.href.indexOf("live_chat") > -1)
#    console.log('current_position.y' + currentMousePos.y )
    if dpr == 2 || dpr == 1
      if currentMousePos.y < 20
        $('body').removeClass('hide-header')
        $('main.main-block-wrap').removeClass('retina-livechat-page-wrap')
      else if $('header').is(':hover')
#        console.log('hover')
      else
#        console.log('out')
        $('body').addClass('hide-header')
        $('main.main-block-wrap').addClass('retina-livechat-page-wrap')

#============================================================
# sticky friends online sidebar
#============================================================
friends_online = () ->
  window_height = $(window).height()
#  console.log('window height: ', window_height)
  footer_height = $("footer").height()
#  console.log('footer height: ', footer_height)

  offset_top = $('footer').offset().top
#  console.log('offset top: ', offset_top)

#  footer_to_top = $('footer').outerHeight()
#  console.log('footer top: ', footer_to_top)
#  $('.ordered-list-wrap').css 'bottom', footer_height

  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('.l-footer-wrap').offset().top
  fh = $('.l-footer-wrap').height()

#  console.log('scroll top: ', st)



  action = st + wh

#  console.log('scroll top + window height: ', action)

  ol_bottom = action - ot
#  console.log('must be to bottom: ', ol_bottom)
  diff = ot <= action
#  console.log('diff: ', diff)
  if diff
    $('.ordered-list-wrap').css 'bottom', ol_bottom
  else
    $('.ordered-list-wrap').css 'bottom', 0


resetForm = ($form) ->
  $form.find('input, select, textarea').not(':input[type=button], :input[type=submit], :input[type=reset]').val ''

$(document).ready ->
#  group ckeckbox with class radio-checkbox
  $('input.radio-checkbox[type="checkbox"]').on 'change', ->
    $('input[type="checkbox"]').not(this).prop 'checked', false

  $('.ud-inbox-page-wrap').on 'click', '.ud-inbox-mg-button-wrap', () ->
    $this = $(@)
    wrap = $this.closest('.ud-inbox-message-group')

    wrap.addClass('ud-inbox-message-group-expanded')

    wrap.css('height', 'auto')
    wrap.find('.ud-inbox-mg-button-wrap').hide()
    wrap.find('.ud-inbox-message-block-wrap').show()

#  =========================
# callback handler for form submit
#  =========================
  $('form.ud-mt-ajax-send').submit (e) ->
    $this = $(@)
    postData = $this.serializeArray()
    formURL = $this.attr('action')

    $.ajax
      url: formURL
      dataType: 'html'
      type: "POST"
      data: postData
      beforeSend: ->
        alert "before"
      success: ->
        alert "success"
      complete: ->

      error: ->

    e.preventDefault()


  friends_online()

#===========================================
#  smiley
#  ==========================================
  $('body').on "click",".ud-smiles-inner a", ->
    smiley = $(@).children().attr('title')
    if $(@).closest('.ud-input-message-wrap').length >0
      text_input = $(@).closest('.ud-input-message-wrap, .ud-emotion-wrap').find('textarea')
    else if $(@).closest('.ud-emotion-wrap').length >0
      text_input = $(@).closest('.ud-emotion-wrap').find('textarea')

    if (text_input.length == 0)
      text_input = $('#message')
    text_input.val(text_input.val() + " " + smiley + " ")


# ============================================================================
#  timer for chat request frends list
# ============================================================================
  setTimeout(()->
    obj = $('.ol-start-chat-wrap')
    obj.find('.fo-chat-request-one-item')

#    console.log('chat_requests.length'+obj.find('.fo-chat-request-one-item').hasClass('hide').length)
    obj.find('.fo-chat-request-one-item').addClass('hide')

#    console.log('chat_requests.length'+obj.find('.fo-chat-request-one-item').hasClass('hide').length)

    obj.addClass('hide')
    $('section.ordered-list').removeClass('ud-fo-has-chat-request')

    $('section.ordered-list .ud-has-chat-request').addClass('uhcr-hidden')

    $('.ud-chat-request-others').hide()  #hiden chat requests from other pepoples on down page
  , 6000)

# ============================================================================
#  click for show hidden chat request
# ============================================================================
#  $('li.ud-has-chat-request .one-item .avatar').click ->
#    alert 'test'
  $('section.ordered-list').on 'click', 'li.ud-has-chat-request .one-item .avatar', ->
    this_wrap = $(@).closest('li')
    user_id = this_wrap.attr 'data-user-id'

    wrap = $(@).closest('.ordered-list-wrap')
    wrap_request = wrap.find('.ol-start-chat-wrap')

    request_list = wrap_request.find('.fo-chat-request-one-item')
#    console.log('request list', request_list.length)
    current_request = request_list.filter("[data-user-id='" + user_id + "']")
    if this_wrap.hasClass('uhcr-hidden')
      if current_request
        wrap_request.removeClass('hide')
        current_request.removeClass('hide')
        this_wrap.removeClass('uhcr-hidden')
        $('section.ordered-list').addClass('ud-fo-has-chat-request')
      else
#        console.log('dosnt')
#    console.log('current request :', current_request)
#    alert 'user id : '+ user_id

#=====================================================
# dismiss message on frendlie list
#=====================================================
  $('.ol-start-chart-footer a.dismiss').click ->
    wrapper = $(this).closest('.ordered-list-wrap')

    frends_list = wrapper.find('section.ordered-list')
    chat_req_wrap = $(@).closest('.ol-start-chat-wrap')
    chat_req = wrapper.find('.fo-chat-request-one-item')

    count_requests = +wrapper.find('.fo-chat-request-one-item').length

    user_id = $(@).closest('.fo-chat-request-one-item').attr 'data-user-id'

    users_list = wrapper.find('li')
    current_user = users_list.filter("[data-user-id='" + user_id + "']")

    $(@).closest('.fo-chat-request-one-item').remove()
    current_user.removeClass('uhcr-hidden')
    current_user.removeClass('ud-has-chat-request')


    if frends_list.hasClass('ud-fo-has-chat-request')
      frends_list.removeClass('ud-fo-has-chat-request')
    if count_requests <= 1

      chat_req_wrap.remove()
    else
      chat_req.each ->
        if !$(@).hasClass('hide')
          chat_req_wrap.addClass('hide')



#    $frendContainer = $wrapper.find('.one-item')
#    $thisContainer = $wrapper.find('.ol-start-chat-wrap')
#    $thisContainer.toggleClass('hide')
#    $frendContainer.toggleClass('hide')

#=====================================================
# dismiss messagefrom not friends
#=====================================================
  $('.ud-chat-request-others-wrap a.dismiss').click ->
    $(@).closest('.ud-chat-request-others').remove()

#  $('#SocialRegistration').foundation('reveal', 'open')

#==================================
#  upload file when reporting user
#==================================
  $('input#ud-report-user-browse').change ->
    wrap = $(@).closest('.ud-report-user-wrap')
    attach_wrap = wrap.find('.ud-attach-for-report-user')

    filename = wrap.find('input[type=file]').val().replace(/C:\\fakepath\\/i, '')

    attached_file = filename+'<div class="ud-ru-remove-file"></div>'
    attach_wrap.append(attached_file)
#  clear value file upload
  $('.ud-attach-for-report-user').on 'click', '.ud-ru-remove-file', ->
    wrap = $(@).closest('.ud-report-user-wrap')

    $(@).closest('.ud-attach-for-report-user').text('')
    $(@).closest('.ud-attach-for-report-user').children().remove()

    wrap.find('input[type=file]').attr value: ''   #clear input


#================================
#  adding video to profile
#================================
  $('.ud-browse-video-input input').change ->
    wrap = $(@).closest('.p-video-wrap')
    browse_video = wrap.find('.ud-browse-video-input')
    view_video = wrap.find('.p-video-input-wrap')
    if !browse_video.hasClass('hide')
      browse_video.addClass('hide')
      view_video.removeClass('hide')

#================================
#  deleting video from profile
#================================
  $('.p-video-wrap .p-delete-video').click ->
    wrap = $(@).closest('.p-video-wrap')
    browse_video = wrap.find('.ud-browse-video-input')
    view_video = wrap.find('.p-video-input-wrap')
    if browse_video.hasClass('hide')
      browse_video.removeClass('hide')
      view_video.addClass('hide')
#================================
#  detect ration
#================================

  if(window.location.href.indexOf("live_chat") > -1)
    dpr     = window.devicePixelRatio
    $('body').addClass('live-chat-body')
    if dpr == 2
      $('body').addClass('live-chat-body')
    if dpr == 2 || dpr == 1
      $('body').addClass('hide-header')
      $('main.main-block-wrap').addClass('retina-livechat-page-wrap')

#   init binder upload file
  $('.ud-file-uploader-wrap input[type=file]').change ->
    $(@).closest('.ud-file-uploader-wrap').find('.ud-uploaded-file-wrap').text($(@).val())

#=========================================================
#  init close foundation reveal after add
#=========================================================
#  $('#AddAPictures .image-popup-one-item a').click ->
#    $this = $(this)
#    locked = $this.data('locked')
#
#    if !locked
#      $this.data('locked', true)
#      setTimeout(()->
#        $this.data('locked', false)
#      , 300)
#      # do something
#      conv_id = $('#AddAPictures').data('conv-id')
#      folder = $('#AddAPictures').data('folder')
#      fid = $(this).data('attachment-fid')
#      $.post '/sites/all/themes/ud/ajax/get_attachment_html.php', {
#        attachment_id: fid
#        conversation_id: conv_id
#        reply_folder: folder
#      }, (data) ->
#        $('div#' + folder + '-conv-id-' + conv_id + ' .ud-e-attachment-wrap').append data
#        $('.ud-e-attachment-wrap .message-attachment-item').removeClass 'end'
#        $('.ud-e-attachment-wrap .message-attachment-item:last').addClass 'end'
#        $('div#' + folder + '-conv-id-' + conv_id + ' form#conv-' + conv_id + ' textarea').trigger 'keyup'
#        return
#      return
#      $('#AddAPictures').foundation 'reveal', 'close'

#============================================
#  add attachment to current conversation
#============================================

  this_for_mesaage = ''

  $('.ud-attach-file-into-message .browse-file').click ->
    this_for_mesaage = $(@)

  $('#AddAPictures .image-popup-one-item a').click ->
    console.log("my_habdler_for_attachment")
    $this = $(this)
    locked = $this.data('locked')
    if !locked
      $this.data('locked', true)

      wrap = this_for_mesaage.closest('.ud-attach-file-into-message')
      attach_wrap = wrap.find('.ud-e-attachment-wrap')

      $image_object = $this.parent().html()

#      fields to comment before commit
      attachment_one_item = '<div class="columns large-2 medium-2 small-4 end"><div class="pg-one-item">
              <div class="pg-action-button pga-remove">
                <a data-file-id="123" data-folder="inbox" data-conv-id="65">
                  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="64px" height="64px" viewBox="0 0 64 64" enable-background="new 0 0 64 64" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve">
                  <polygon fill="#2E3E51" points="64,6.464 57.536,0 32,25.536 6.464,0 0,6.464 25.536,32 0,57.536 6.464,64 32,38.464 57.536,64
                      64,57.536 38.464,32 "></polygon>
                  </svg>
                  </a>
              </div>'+$image_object+'
            </div></div>'
      attach_wrap.append(attachment_one_item)
#      fields to comment end

      setTimeout(()->
        $this.data('locked', false)
      , 300)
      # do something
      if wrap.hasClass('ud-message-one-block-wrap')
        $('#AddAPictures').foundation 'reveal', 'close'
      else if wrap.hasClass('ud-intro-edit-mail')
        $('.notification-container').hide()
        $('#YourIntroductionLetterEdit').foundation 'reveal', 'open'
      else if wrap.hasClass('ud-intro-send-mail')
        $('.notification-container').hide()
        $('#SendEmail').foundation 'reveal', 'open'
      else if wrap.hasClass('text-chat-input-container')

        current_wrap = this_for_mesaage.closest('.text-chat-column')
        current_wrap.find('.text-chat-view-container').addClass('ud-chat-has-attached-file')
        wrap.addClass('ud-chat-has-attached-file')

        $('.notification-container').hide()
        $('#AddAPictures').foundation 'reveal', 'close'
      else if wrap.hasClass('ud-attach-file-is-mailing')
        $('#AddAPictures').foundation 'reveal', 'close'


#=========================================================
#  init multiple select
#=========================================================
  multiSelect = undefined

  multiSelect = $('select.ud-multiple').SumoSelect
    outerHtml: false
#    okCancelInMulti: true

  $('select.sort-by, select.view-mode').SumoSelect
    captionHtml: '<p class=\'CaptionCont SlectBox\'><label></label></p>'
    wrapperHtml: '<div class="SumoSelect GraySelect">'
    outerHtml: '<div class="SumoSelectOuter GraySelectOuter">'
    selectFirstIfBlank: true

#clear form
  $('a.clear-form').click ->
    $current_form = $(@).closest('form')
    resetForm($current_form)

    $formWrap = $(this).closest('form')
    $items = $formWrap.find('ul.options li')
    $items.removeClass('selected')
    $captionSelect = $formWrap.find('p.CaptionCont span')
    $captionSelect.text('')

#=========================================================
# binder for clear form if click on clear form button
#=========================================================

  $('p.ud-s-clear a').on 'click', ->
#   for sumoselect
#    obj = []
#    $('option:selected').each ->
#      obj.push $(this).index()
#      return
#    i = 0
#    while i < obj.length
#      $('select.ud-multiple')[0].sumo.unSelectItem obj[i]
#      i++
#    return

    $('select.ud-multiple')[0].sumo.unSelectAll()
    $('select.ud-multiple')[1].sumo.unSelectAll()

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

#===========================================================
#  countect for enter characters
#===========================================================
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

#=======================================================================
# mailbox text input
#=======================================================================
#  $('.ud-message-wrap .image-popup-one-item a').click ->
#    $get_user_mb_id = $(@).closest('.reveal-modal').attr('data-user-id')
#    $wrap = $("#{$get_user_mb_id}")
#    $attach_wrap = $wrap.find('.ud-e-attachment-wrap')
#    $image_object = $(@).parent().html()
#    $attach_wrap.append($image_object)
#
#    $('#AddAPictures').foundation 'reveal', 'close'

  $('.ud-message-wrap .image-popup-one-item a').click ->
    $this = $(this)
    locked = $this.data('locked')

    if !locked
      $this.data('locked', true)
      readyt(()->
        $this.data('locked', false)
      , 300)
      # do something
      $get_user_mb_id = $(@).closest('.reveal-modal').attr('data-user-id')
      $wrap = $("#{$get_user_mb_id}")
      $attach_wrap = $wrap.find('.ud-e-attachment-wrap')
      $image_object = $(@).parent().html()
      $attach_wrap.append($image_object)

      $('#AddAPictures').foundation 'reveal', 'close'

#===========================================================
# test version
#===========================================================
  $('a.button').click ->
    ud_count = $('ul.ud-testing li:last-child').text()
    ud_count++
    list_ul = $('ul.ud-testing')

    $this = $(this)
    locked = $this.data('locked')
    if !locked
      $this.data('locked', true)
      setTimeout(()->
        $this.data('locked', false)
      , 300)
      # do something
      list_ul.append('<li>'+ud_count+'</li>')


#===========================================================
# tripadvisor finding girl
#===========================================================
  $('.ud-ladies-that-confirmed .trf-choose-girl').click ->

    current_girl = $(@).closest('.trf-one-girl')
    $('.trf-one-girl').removeClass('ud_selected_girl')
    current_girl.addClass('ud_selected_girl')
#    $girls = $wrap.find('.trf-one-girl-wrap')
#    $currentGirlWrap = $(@).closest('.trf-one-girl-wrap')

#    $nextStep = $wrap.find('.t-button-step-wrap')
#
#    $girls.hide()
#    $currentGirlWrap.show()
#    $currentGirlWrap.addClass('selected-girl')
#    $nextStep.show()

#===========================================================
# tripadvisor
#===========================================================
  $('.tbag-thumbs-wrap .image').click (e)->
    e.preventDefault()

    $wrapper = $(@).closest('.tba-one-item')
    $previewWrap = $wrapper.find('.tbag-image')
    $hrefData = $(@).parent().attr('data-href')

    all_current_thumbs = $wrapper.find('a')

    $thisStyle = $(this).attr("style")
    $previewWrap.attr style: $thisStyle
    $previewWrap.parent().attr href: $hrefData

#    $('.tbag-thumbs-wrap a').removeClass('active')
    all_current_thumbs.removeClass('active')
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

#      second version after changes
  $('.trf-one-girl .trf-choose-girl, .trf-one-girl .trf-selected-girl').click ->
    $wrap = $(@).closest('.ud-tabs-wrap')
    $tabHeader = $wrap.find('.ud-tab-link')
    $tabs = $wrap.find('.ud-tab')

    $('.tripadvisor-page-wrap .ud-tab-link').removeClass('active')
    $tabs.hide()

    $tabHeader.eq(1).addClass(' active')
    $tabs.eq(1).show()

#    slect apartment
  $('select.ud-select-apartment').change ->

    wrap = $(@).closest('.t-book-tab-wrap')
    appartmen_gallery_list = wrap.find('.tba-one-item')
    appartmen_gallery_list.hide()
    if $(@).val() == 'VIP'
      wrap.find('.tba-vip').show()

    else if $(@).val() == 'Econom'
      wrap.find('.tba-economy').show()

    else if $(@).val() == 'Standart'
      wrap.find('.tba-standard').show()

#===========================================================
# datepicker
#===========================================================
  $('.datepicker').datepicker
    showOn: 'button'
    buttonImage: 'assets/UAD-calendar.png'
    buttonImageOnly: true
    changeMonth: true
    changeYear: true
    yearRange: "-95:-18"
    buttonText: 'Select date'
#    dateFormat: 'yy-dd-mm'
  $('.datepicker.hasDatepicker').on 'click', ()->
    $(this).next().trigger('click')

  $('.trip-datepicker').datepicker
    showOn: 'button'
    buttonImage: 'assets/UAD-calendar.png'
    buttonImageOnly: true
    changeMonth: true
    changeYear: true
    yearRange: "-0:+1"
    buttonText: 'Select date'
  $('.trip-datepicker.hasDatepicker').on 'click', ()->
    $(this).next().trigger('click')
# init tabs
#  $('.ud-tab').hide()
#  $('.ud-tab').first().show()
#  $('.ud-tab-link').first().addClass('active')
#
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

#=========================================================
# edit changes informations  if form has class ud-p-profile-editing-true
#=========================================================
  if $('form.ud-form-about-me').hasClass('ud-p-profile-editing-true')
    $('form.ud-form-about-me').addClass('p-editing-form')
    $('.p-input-preview').hide()
    $('.p-input-edit').show()
    $('form.ud-form-about-me').find('.p-edit-iam').addClass('hide')
    $('form.ud-form-about-me').find('.special-text-shadow.p-save-iam').removeClass('hide')

#=========================================================
# edit changes informations
#=========================================================
  $('.p-edit-iam').click (e)->
    e.preventDefault()
    $wrap = $(@).closest('form.ud-form-about-me')
    if $wrap.hasClass('ud-bf')
    else
      if $wrap.hasClass('p-editing-form')
        $wrap.removeClass('p-editing-form')
      else
        $wrap.addClass('p-editing-form')
      $('.p-input-preview').hide()
      $('.p-input-edit').show()
      $wrap.find('.p-edit-iam').addClass('hide')
      $saveButton = $wrap.find('.special-text-shadow.p-save-iam')
      $saveButton.removeClass('hide')


#=========================================================
# save changes informations
#=========================================================
  $('.p-save-iam').click (e)->
    e.preventDefault()

    $wrap = $(@).closest('form.ud-form-about-me')
    if $wrap.hasClass('p-editing-form')
      $wrap.removeClass('p-editing-form')
    else
      $wrap.addClass('p-editing-form')
    $('.p-input-preview').show()
    $('.p-input-edit').hide()
    $wrap.find('.p-save-iam').addClass('hide')
    $editButton = $wrap.find('.p-edit-iam')
    $editButton.removeClass('hide')


    $form = $(this).closest('form')
    $form.find('.pii-wrap').each ()->
      $wrap = $(this)
      $dst = $wrap.find(".p-input-preview .p-input p")
      $src = $wrap.find(".p-input-edit").find("input, select option:selected, textarea")
      str = ''

      $src.each (index)->
        if index
          str += '- '
        if $(@).is('option')
          str += $(this).text()
        if $(@).is('textarea')
          str +=$(@).val().replace(/</g, '&lt;').replace(/>/g,'&gt;').replace(/\n/g, '<br/>')
        else
          str += $(this).val()
      $dst.html(str)

#=========================================================
#  image gallery
#=========================================================
  $("a.fancy_gallery").fancybox
    beforeShow : ->
      @.title = (@.title ? '' + @.title + '' : '') + ' ' + (@.index + 1) + '/' + @.group.length
      return

#=========================================================
#  profile edit and save field
#=========================================================
  $('.p-input-preview div').click ->

    form = $(@).closest('form')
    $wrap = $(@).closest('.p-input-wrap')
    $editField = $wrap.find('.p-input-edit')
    $previewField = $wrap.find('.p-input-preview')

    if form.hasClass('ud-bf')
#      console.log('disable')
    else
      $('.p-input-edit').hide()
      $('.p-input-preview').show()
      $previewField.hide()
      $editField.show()



  $('.p-input-edit .pi-apply-button').click ->
    $wrap = $(@).closest('.p-input-wrap')

    $editField = $wrap.find('.p-input-edit')
    $previewField = $wrap.find('.p-input-preview')

    $previewFieldInput = $wrap.find('p')
    current_input = $wrap.find('.p-input')
    if current_input.find('input').length
      $editFieldInput = $wrap.find('input').val()
      $previewFieldInput.text($editFieldInput)

    else if current_input.find('select').length

#      window.$select = $wrap.find('select').SumoSelect()
      $src = $wrap.find('select option:selected')

      str = ''
      $src.each (index)->
        if index
          str += '/'
        str += $(this).text()
      $previewFieldInput.text(str)


#      str_from_select = $select.sumo.getSelStr()
#      $previewFieldInput.text(str_from_select)


    $previewField.show()
    $editField.hide()

#    alert 'test'+ str_from_select
#    alert 'value: '+$editFieldInput


#===========================================================
#  observe mouse
#===========================================================
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

#===========================================================
#  range slide initialize
#===========================================================
  if typeof $.fn.slider == 'function'
    $ ->
      range_age = $("#ud-range-age-slide")
      min_val = +range_age.attr('data-min-val')
      max_val = +range_age.attr('data-max-val')

      range_age.slider

        range: true
        min: min_val
        max: max_val
        values: [
          min_val
          max_val
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

    $ ->
      range_age = $("#ud-range-height-slide")
      min_val = +range_age.attr('data-min-val')
      max_val = +range_age.attr('data-max-val')

      range_age.slider

        range: true
        min: min_val
        max: max_val
        values: [
          min_val
          max_val
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
      range_age = $("#ud-range-weight-slide")
      min_val = +range_age.attr('data-min-val')
      max_val = +range_age.attr('data-max-val')

      range_age.slider

        range: true
        min: min_val
        max: max_val
        values: [
          min_val
          max_val
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

#      for age slider
  $('#lsf-age-min').keyup ->
    range_age = $("#ud-range-age-slide")
    range_age.slider("values", 0, @value)
  $('#lsf-age-max').keyup ->
    range_age = $("#ud-range-age-slide")
    range_age.slider("values", 1, @value)

#      for weight slider
  $('#lsf-weight-min').keyup ->
    range_weight = $("#ud-range-weight-slide")
    range_weight.slider("values", 0, @value)
  $('#lsf-weight-max').keyup ->
    range_weight = $("#ud-range-weight-slide")
    range_weight.slider("values", 1, @value)

#      for height slider
  $('#lsf-height-min').keyup ->
    range_height = $("#ud-range-height-slide")
    range_height.slider("values", 0, @value)

  $('#lsf-height-max').keyup ->
    range_height = $("#ud-range-height-slide")
    range_height.slider("values", 1, @value)


#  landing banner registration form
  $('.ud-gender-input input:radio').change ->
    $wrap = $(@).closest('form')
    $input_for_female = $wrap.find('.lbf-for-fame-only')

    if $(@).val() == 'male'
      $input_for_female.addClass('hide')
    else if $(@).val() == 'female'
      $input_for_female.removeClass('hide')


#===========================================================
# lading banner form
#===========================================================
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

#  landing search form
  $('.l-search-form-wrap form').submit (e) ->
    e.preventDefault()
    $('.l-search-result-wrap').show()
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
#  $('.ud-inbox-page-wrap .ud-inbox-tab').click ->
#    alert 'this'
#    current_position = $(this).index()
#    $head_tabs = $(this)
#    $wrap = $(this).closest('.ud-inbox-page-wrap')
#    $('.ud-inbox-page-wrap .ud-inbox-tab').removeClass('active')
#    $(this).addClass('active')
#
#    $body_tabs = $wrap.find('.ud-inbox-one-tab-wrap')
#    $body_tabs.addClass('hide')
#    $body_tabs.eq(current_position).removeClass('hide')


# mailbox message checkbox action handler
  $('.ud-inbox-wrap').on 'change', '.ud-inbox-checkbox input', ->
    el = $(@).closest('.ud-inbox-page-wrap').find('.ui-all-messages')
    if $(@).is(':checked')
      if !el.hasClass('ud-inbox-is-checked-message') && $(@).closest('.ud-inbox-page-wrap').find('input:checked').length > 0
        el.addClass('ud-inbox-is-checked-message')
    else if !$(@).closest('.ud-inbox-page-wrap').find('input:checked').length
      el.removeClass('ud-inbox-is-checked-message')



#  mailbox show browse file
  $('.ud-has-attached-file .ua-tumbler').click ->
    $wrap = $(this).closest('.ud-has-attached-file')
    $block = $wrap.find('.ud-attached-wrap')
    $block.show()

##======================================================================
##  mailbox  reply
##======================================================================
#  $('ul.ud-mb-actions li.ud-reply a').on "click", (event) ->
#    $wrapper = $(this).closest('.ud-message-one-block-wrap')
#    $editMessage = $wrapper.find('.ud-inbox-sent-message')
#    $subMesssageWrapper = $wrapper.find('.ud-inbox-message-sub-block-wrap')
#
#    if !$wrapper.hasClass('ud-nc-b') and !$wrapper.hasClass('ud-membership-plan-message')
#      $('.ud-inbox-sent-message, .ud-inbox-message-sub-block-wrap').addClass('hide')
#      $('.ud-message-one-block-wrap').removeClass('ud-opened-message-block')
#      $wrapper.addClass('ud-opened-message-block')
#
#      $subMesssageWrapper.removeClass('hide')
#      $editMessage.removeClass('hide')

#======================================================================
#  mailbox  reply
#======================================================================
  $('.ud-inbox-message-wrap').on 'click', '.ui-message-main-wrap .ud-mpm-window p, .ui-message-main-wrap p.ud-text-message, p.ud-inbox-draft, ul.ud-mb-actions li.ud-reply a', (event) ->

    console.log('first inbox message handler')

    $wrapper = $(this).closest('.ud-message-one-block-wrap')
    $editMessage = $wrapper.find('.ud-inbox-sent-message')
    $subMesssageWrapper = $wrapper.find('.ud-inbox-message-sub-block-wrap')

#    $wrapper.find('p.ud-text-message, .ud-has-attached-file, .ui-read-more').show()

    if !$wrapper.hasClass('ud-nc-b')
      $('.ud-inbox-sent-message, .ud-inbox-message-sub-block-wrap').addClass('hide')
      $('.ud-message-one-block-wrap').removeClass('ud-opened-message-block')
      $wrapper.addClass('ud-opened-message-block')

      $subMesssageWrapper.removeClass('hide')
      $editMessage.removeClass('hide')

      $wrapper.find('.ud-text-message-newer').hide()
      $("div.notification-container").hide()

      $editMessage.focus()

#======================================================================
#  mailbox  expand message
#======================================================================
  $('.ud-inbox-message-wrap').on 'click', '.ud-inbox-message-block-wrap .ud-message-option', (event) ->
    $this = $(@)
    wrap = $this.closest('.ud-inbox-message-block-wrap')

    $('.ud-inbox-message-block-wrap').css 'zIndex', 0
#    wrap.css 'zIndex', 1111111
    wrap.css 'zIndex', 11

#======================================================================
#  mailbox  expand message
#======================================================================
  $('.ud-inbox-message-wrap').on 'click', '.ui-read-more', (event) ->
#    $(@).closest('.ud-inbox-message-block-wrap').removeClass('ud-inbox-unread-message')
    wrap = $(@).closest('.ud-text-message-wrap')
    if !wrap.hasClass('ui-om-expand')
      wrap.addClass('ui-om-expand')
    else
      wrap.removeClass('ui-om-expand')
#======================================================================
#  mailbox  expand new message
#======================================================================
  $('.ud-inbox-message-wrap').on 'click', '.ui-message-main-wrap .ud-mpm-window p, .ui-message-main-wrap b, .ud-message-one-block-wrap .ud-text-message-newer p, .ui-inbox-reply-message', (event) ->

    console.log('second inbox message handler')

    $wrapper = $(this).closest('.ud-message-one-block-wrap')
    $editMessage = $wrapper.find('.ud-inbox-sent-message')
    $subMesssageWrapper = $wrapper.find('.ud-inbox-message-sub-block-wrap')
    current_message = $wrapper.find('.uic-current')

#    $(@).parent().hide()
#    $wrapper.find('p.ud-text-message, .ud-has-attached-file, .ui-read-more').show()

    if !$wrapper.hasClass('ud-opened-message-block')
      if !$wrapper.hasClass('ud-nc-b')
        $('.ud-inbox-sent-message, .ud-inbox-message-sub-block-wrap').addClass('hide')
        $('.ud-message-one-block-wrap').removeClass('ud-opened-message-block')
        $wrapper.addClass('ud-opened-message-block')

        $subMesssageWrapper.removeClass('hide')
        $editMessage.removeClass('hide')

        $("div.notification-container").hide()
        $wrapper.find('.ud-text-message-newer').hide()
#        current_message.focus() - було раніше для фокусу на нове повідомлення
        $wrapper.find('.ud-input-message-wrap textarea').focus()



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
#  $('.gift-tab').click ->
#    current_position = $(this).index()
#    $head_tabs = $(this)
#    $wrap = $(this).closest('.gifts-page-wrap')
#    $('.gifts-header-wrap .gift-tab').removeClass('active')
#    $(this).addClass('active')
#
#    $body_tabs = $wrap.find('.gift-one-page')
#    $body_tabs.addClass('hide')
#    $body_tabs.eq(current_position).removeClass('hide')

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

#=====================================================
# binder for frends list minimizate - maximizate
#=====================================================
  $('.ordered-list-wrap img.diamond-logo').click ->
    if($(window).width() < 1445)
      $wrapper = $(this).closest('.ordered-list-wrap')
      if $wrapper.hasClass('maxinmizate')
        $wrapper.removeClass('maxinmizate')
      else
        $wrapper.addClass('maxinmizate')
#      alert '< large'
    else
      $wrapper = $(this).closest('.ordered-list-wrap')
      if $wrapper.hasClass('minimizate')
        $wrapper.removeClass('minimizate')
      else
        $wrapper.addClass('minimizate')
#      alert 'large'
  $('li.ordered-list-button').click ->
    order_list_sidebar = $('.ordered-list-wrap')

    if order_list_sidebar.hasClass('maxinmizate')
      order_list_sidebar.removeClass('maxinmizate')
    else
      order_list_sidebar.addClass('maxinmizate')

#=====================================================
#  init index page tabs wooman
#=====================================================
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

#===========================================================
#  search header form
#===========================================================
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

#===========================================================
# disable scroll when mouse over an absolute div
#===========================================================
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

#===========================================================
#  main-menu binder
#===========================================================
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



#===========================================================
# click event to scroll to top
#===========================================================
  $(".scrollToTop").click ->
    $("html, body").animate
    $("html, body").animate
      scrollTop: 0
    , 800
    false

# ivan code
  $('#pBrowseAvatar').on 'change', ->
    $('#ud-upload-user-picture-form #edit-upload').trigger 'mousedown'
    count = $('#profile-photos-count').html()
    $('#profile-photos-count').html parseInt(count) + 1
    $.post '/sites/all/themes/ud/ajax/get_avatars_count.php', {}, (data) ->
      if parseInt(data) == 8
        $('#upload-user-picture').hide()

      alert 1
      $('#FillProfile').foundation 'reveal', 'open'
      alert 2

#===========================================================
#notification popup
#===========================================================
  $('body').on 'click', '.notification-link', (event)->
    $wrap = $(this).closest('.notification-wrap')
    $container = $wrap.find('.notification-container').filter(":not(:visible)")
    $container.fadeIn 300

  $notification_containers = $("div.notification-container")
#  $notification_containers.on "mouseUpOut", ()->
#    $containers = $(this)
#    console.log("hello")
#    $containers.fadeOut duration: 300
  $('body').on "mouseUpOut", '.notification-container', ()->
    $containers = $(this)
#    console.log("hello")
    $containers.fadeOut duration: 300
  $notification_containers.observeMouseOut()


#===========================================================
# email templates
#===========================================================
  $('ul.ud-navigation li a').click (e)->
    e.preventDefault()
#    alert 'ttt'
    current_position = $(this).parent().index()

    $wrapper = $(this).closest('.email-templates-wrap')

    tabWrapper = $(@).closest('.ud-navigation')
    $tabHeader = tabWrapper.find('li')


    $tabHeader.children().removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrapper.find('li.ud-et')

    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')



#  ====================================================================
$(window).resize ->
  if $(window).width() >= 1445
    if $(".button-menu a.mobile").hasClass('open')
      $(".button-menu a.mobile").removeClass('open')


  if $(window).height() <= 768
    $('body').addClass('live-chat-body')
  else
    $('body').removeClass('live-chat-body')


  friends_online()

  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('.l-footer-wrap').offset().top
  fh = $('.l-footer-wrap').height()

  action = ot - wh
  if st >= action
    $('.ordered-list-wrap').addClass('fixed-to-footer')
    $('.ordered-list-wrap').css 'bottom', $('footer').height()
  else
    $('.ordered-list-wrap').removeClass('fixed-to-footer')
    $('.ordered-list-wrap').css 'bottom', '0'

lastScrollTop = 0
$(window).scroll (event) ->
  friends_online()


  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('.l-footer-wrap').offset().top
  dpr     = window.devicePixelRatio
  if(window.location.href.indexOf("live_chat") > -1) && dpr == 2
  else
#    action = st + wh
#    diff = ot <= action
#    if diff
#      $('.ordered-list-wrap').addClass('fixed-to-footer')
#    else
#      $('.ordered-list-wrap').removeClass('fixed-to-footer')

    if st > lastScrollTop
      # downscroll code
      $('body').addClass 'hide-header'
    else
      # upscroll code
      $('body').removeClass 'hide-header'
    lastScrollTop = st


