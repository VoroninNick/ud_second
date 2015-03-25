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
  ot = $('footer').offset().top

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
  flag = false
  $('.notification-link').click ->
    $('.notification-container').hide()
    $wrap = $(this).closest('.notification-wrap')
    $container = $wrap.find('.notification-container')
    if flag = !flag
      $container.fadeToggle 300
    false

  #Document Click
  $(document).click ->
    $('.notification-container').hide()
    return

  #Popup Click
  $('.notification-container').click ->
    false
  return

  $('.notification-link-sub').click ->
#    $('.notification-container-sub').hide()
#    $wrap = $(this).closest('.notification-wrap-sub')
#    $container = $wrap.find('.notification-container-sub')
#    $container.fadeToggle 300
#    false

  #Document Click
  $(document).click ->
    $('.notification-container-sub').hide()
    return

  #Popup Click
  $('.notification-container-sub').click ->
    false
  return