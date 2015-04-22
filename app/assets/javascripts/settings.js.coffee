#
# Created by: pasha
#



$(document).on 'ready', ()->

  $window = $(window)
  $document = $(document)
  $body = $('body')
  $document.on 'click', 'div.settings-left-menu a', (event)->
    #console.log('hello')
    #alert('hello')
    event.preventDefault()
    $anchor = $(this)
    $li = $anchor.closest('li')
    $ul = $li.parent()
    if !$li.hasClass('active')
      $active_item = $ul.children().filter('.active')
      $active_item.removeClass('active')
      $li.addClass('active')
      content_key = $li.attr('data-tab-selector')
      $('div.settings-content.active').removeClass('active')
      $('div.settings-content[data-key='+content_key+']' ).addClass('active')
    else if Modernizr.mq('(max-width: 640px)')
      $menu_container = $ul.parent()
      $menu_container.addClass('open-dropdown')


  $('.settings-nav-wrap').on "click", "li", (event)->
    event.preventDefault()
    $item = $(this)
    if !$item.hasClass('active')
      $parent = $item.parent()
      $items = $parent.children()
      $active_item = $items.filter('.active')
      $active_item.removeClass('active')
      $item.addClass('active')
      section_name = $item.attr('data-section')
      $tab_item_wrap = $('.tab-item-wrap')
      $items_with_section = $tab_item_wrap.find('[data-belongs-to-section]')
      $items_from_active_section = $items_with_section.filter("[data-belongs-to-section=#{section_name}]")
      $items_from_inactive_section = $items_with_section.filter("[data-belongs-to-section!=#{section_name}]")
      $items_from_inactive_section.removeClass('visible')
      $items_from_active_section.addClass('visible')
#  $('body').on 'change', '.popup-settings-content input#turn-popup-message[type=checkbox]', ()->
#    $input = $(this);
#    checked = $input.filter(':checked').length == 1
#
#    $('.popup-settings-content .email-settings-section.options').toggleClass('disabled')

  $('body').on 'change', '[data-enable]', ()->
    $input = $(this);
    checked = $input.filter(':checked').length == 1
    selector = $input.attr('data-enable')
    if checked
      $(selector).removeClass('disabled')
    else
      $(selector).addClass('disabled')

#  $settings_dropdown_menu = $('.settings-left-menu')
#  $settings_dropdown_menu.on 'click', 'li', ()->
#    $item = $(this)
#    if $item

  $('body').on "mouseover mouseout", "#account-settings-membership-plan .plan-item:not(.hover-unavailable)", (event)->
    $item = $(this)
    item_index = $item.index()
    $items = $("#account-settings-membership-plan .plan-item:eq(#{item_index}), #account-settings-membership-plan .plan:nth-child(#{item_index + 1})")
    $button = $(" #account-settings-membership-plan .buttons .button-container:eq(#{item_index}) a.ud-button")


    if event.type == 'mouseover'
      $items.addClass('hover')
      $button.removeClass("hide")
    else if event.type == 'mouseout'
      $items.removeClass('hover')
      $button.addClass('hide')

  $('body').on "mouseover mouseout", "#account-settings-membership-plan .plans .plan:not(.hover-unavailable)", (event)->
    $item = $(this)
    item_index = $item.index()
    $items = $("#account-settings-membership-plan .plan-item:eq(#{item_index}), #account-settings-membership-plan .plan:nth-child(#{item_index + 1})")
    $button = $(" #account-settings-membership-plan .buttons .button-container:eq(#{item_index}) a.ud-button")


    if event.type == 'mouseover'
      $items.addClass('hover')
      $button.removeClass("hide")
    else if event.type == 'mouseout'
      $items.removeClass('hover')
      $button.addClass('hide')

  $('body').on "mouseover mouseout", "#account-settings-membership-plan .button-container:not(.hover-unavailable)", (event)->
    $item = $(this)
    item_index = $item.index()
    $items = $("#account-settings-membership-plan .plan-item:eq(#{item_index}):not(.hover-unavailable), #account-settings-membership-plan .plan:nth-child(#{item_index + 1}):not(.hover-unavailable)")
    $button = $(" #account-settings-membership-plan .buttons .button-container:eq(#{item_index}) a.ud-button")


    if event.type == 'mouseover'
      $items.addClass('hover')
      $button.removeClass("hide")
    else if event.type == 'mouseout'
      $items.removeClass('hover')
      $button.addClass('hide')

  $('body').on "click", ".settings-left-menu li a", (event)->
    if Modernizr.mq("(max-width: 64em)")
      $anchor = $(this)
      $ul = $anchor.closest('ul')
      $menu_container = $anchor.closest('.settings-left-menu')
      if $menu_container.hasClass('opened')
        $menu_container.removeClass('opened')
      else
        $menu_container.addClass('opened')

  $('.settings-left-menu ul').on "mouseUpOut", ()->
    $menu_ul = $(this)
    $menu_container = $('.settings-left-menu')
    $menu_container.removeClass('opened').addClass('closed')

  $('.settings-left-menu ul').observeMouseOut()

  $('body').on "click", "#account-settings__membership-data .tabs .tab", (event)->
    $tab = $(this)
    active_tab_class = 'active-mobile-tab'
    if !$tab.hasClass(active_tab_class)
      $tab_content = $('.plans .plan').eq($tab.index())
      $active_tab = $(".tab.#{active_tab_class}")
      $active_tab_content = $(".plan.#{active_tab_class}")

      $active_tab.removeClass(active_tab_class)
      $active_tab_content.removeClass(active_tab_class)

      $tab.addClass(active_tab_class)
      $tab_content.addClass(active_tab_class)
