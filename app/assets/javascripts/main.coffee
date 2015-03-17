# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $menuWrap = $('.main-menu-wrap')
  if $(window).width() <= 1024
    $menuWrap.addClass('mobile-menu')

  $(".button-menu a").click ->
    if $menuWrap.hasClass('open-menu')
      $menuWrap.removeClass('open-menu')
    else
      $menuWrap.addClass('open-menu')
    $(this).toggleClass("open")

  $(".button-menu a.mobile").click ->
    $menuWrap.addClass('open-for-medium-and-mobile')

  $('.ordered-list-button a').click ->
    $('.ordered-list-wrap').toggle().show()

  $('select.view-mode').change ->
    $wrapper = $(this).closest('.ordered-list-wrap')
    if $(this).val() == 'minimize'
      $wrapper.addClass('minimizate')

    else if $(this).val() == 'fullscreen'
      $wrapper.removeClass('minimizate')



  $('.items-menu a').click (e) ->
    e.stopPropagation()
    $wrap = $(this).closest('.items-menu')
    $menu = $wrap.find('.menu-wrap')
    if $menu.hasClass('close-menu')
      $menu.removeClass('close-menu')
    else
      $menu.addClass('close-menu')

#  $('html').click ->
#    $('.menu-wrap').addClass('close-menu')
#    $('.header-navigation section li.profile-avatar').addClass('close')
#
#  $('li.profile-avatar').click (e) ->
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
