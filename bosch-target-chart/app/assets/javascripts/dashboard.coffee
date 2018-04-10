$ ->
  setSidebarHeight()

  # Toggle tooltips
  $('[data-toggle=tooltip]').tooltip()

  $(document).on 'click', '#openTargetsSidebarButton', ->
    showSidebar()

  $(document).on 'click', '#closeTargetsSidebarButton', ->
    hideSidebar()

(exports ? this).setSidebarHeight = () ->
  # Calculate the height of the Targets sidebar
  banner_height = $('.banner').height() || 0
  footer_height = $('.footer').height() || 0
  $('#targetsSidebar').css('height', "calc(100% - #{banner_height + footer_height}px")

(exports ? this).showSidebar = () ->
  $('#openTargetsSidebarButton').fadeOut 'fast', ->
    $('#targetsSidebarPanel').animate {right: '0%'}, 250

(exports ? this).hideSidebar = () ->
  $('#targetsSidebarPanel').animate {right: '100%'}, 250, ->
    $('#openTargetsSidebarButton').fadeIn 'fast'
