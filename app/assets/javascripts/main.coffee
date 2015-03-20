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


#  $('.header-navigation section li').click (e) ->
#    e.stopPropagation()
#    if $(this).hasClass('close')
#      $(this).removeClass('close')
#    else
#      $(this).addClass('close')

# click event to scroll to top
  $(".scrollToTop").click ->
    $("html, body").animate
      scrollTop: 0
    , 800
    false

  $('.notification-link').click ->
    $('.notification-container').hide()
    $wrap = $(this).closest('.notification-wrap')
    $container = $wrap.find('.notification-container')
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
