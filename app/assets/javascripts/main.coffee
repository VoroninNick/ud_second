# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).resize ->
  if $(window).width() >= 1445
    if $(".button-menu a.mobile").hasClass('open')
      $(".button-menu a.mobile").removeClass('open')
  st = $(this).scrollTop()
  wh = $(window).height()
  ot = $('footer').offset().top
  fh = $('footer').height()

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



$(document).ready ->
  $ ->
    $('#ud-range-slide').slider

      range: true
      min: 18
      max: 65
      values: [
        18
        65
      ]
      slide: (event, ui) ->
        #Поле минимального значения
        $('#lsf-age-min').val ui.values[0]
        #Поле максимального значения
        $('#lsf-age-max').val ui.values[1]
        return
    #Записываем значения ползунков в момент загрузки страницы
    #То есть значения по умолчанию
    $('#lsf-age-min').val $('#ud-range-slide').slider('values', 0)
    $('#lsf-age-max').val $('#ud-range-slide').slider('values', 1)
    return

  $('#lsf-age-min').change ->
    $minValue = $(this).val
    alert 'min'+ $minValue

#  landing banner registration form
  $('.lbf-registration-form .ud-gender-input label').click ->
    alert 'test'

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
  $('ul#index-banner').bxSlider()
#    auto: true
#    pause: 6000

# landing couple stories
  $('#l-couple-stories ul').bxSlider()
#    controls: false
#    auto: true
#    pause: 6000
#    speed: 1000
#    touchEnabled:false
#    pagerCustom: 'ul#pagers-index-banner'

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


#  $('#AddAPictures').foundation('reveal', 'open')

#  init index page tabs wooman
  $('.favorites-nav li').click ->
    current_position = $(this).index()
#    alert ''+current_position
    $head_tabs = $(this)
    $wrap = $(this).closest('.favorites-woman-wrap')
    $('.favorites-nav li').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.tab-item-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#  init index page tabs man
  $('.favorites-nav li').click ->
    current_position = $(this).index()
#    alert ''+current_position
    $head_tabs = $(this)
    $wrap = $(this).closest('.favorites-man-wrap')
    $('.favorites-nav li').removeClass('active')
    $(this).addClass('active')

    $body_tabs = $wrap.find('.tab-item-wrap')
    $body_tabs.addClass('hide')
    $body_tabs.eq(current_position).removeClass('hide')

#    init multiple select
  $('select.ud-multiple').SumoSelect()

#clear form
  $('a.clear-form').click ->
    $formWrap = $(this).closest('form')
    $items = $formWrap.find('ul.options li')
    $items.removeClass('selected')#
    $captionSelect = $formWrap.find('p.CaptionCont span')
    $captionSelect.text('')

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
    $container = $wrap.find('.notification-container')

    if !$container.hasClass('visible')
      $container.fadeIn 300
      $container.addClass('visible')
    else
      $container.removeClass('visible')

$(document).on 'mouseup', (event)->
  $containers = $("div.notification-container")
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
  console.log("mouseup: in: #{in_container}; out: #{out_of_container}")
  if out_of_container
    $containers.fadeOut duration: 300

