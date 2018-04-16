$ ->
  setSidebarHeight()

  # Toggle tooltips
  $('[data-toggle=tooltip]').tooltip()

  $(window).scroll ->
    if $(window).scrollTop() > $('.banner').height()
      $('#openTargetsSidebarButton').css('top', 0)
      $('#targetsSidebar').css('top', 0)
    else if $(window).scrollTop() < $('.banner').height()
      $('#openTargetsSidebarButton').css('top', '')
      $('#targetsSidebar').css('top', '')
    setSidebarHeight()

  $(document).on 'click', '#openTargetsSidebarButton', ->
    showSidebar()

  $(document).on 'click', '#closeTargetsSidebarButton', ->
    hideSidebar()

  $(document).on 'click', '.remove-chart-target', ->
    target_id = $(this).data('target-id')
    chart_id  = $(this).data('chart-id')

    swal {
      title: I18n.charts.targets.delete_header
      text: I18n.charts.targets.delete_confirm
      type: 'warning'
      showCancelButton: true
      closeOnConfirm: true
    }, ->
      # Have to use POST on a DELETE request for older browsers (including for Specs)
      # See https://github.com/teampoltergeist/poltergeist/issues/532
      $.ajax
        type: "POST"
        url: "/chart_target.js"
        data:
          _method: "DELETE"
          target_id: target_id
          chart_id: chart_id

(exports ? this).setSidebarHeight = () ->
  # Calculate the height of the Targets sidebar
  if $(window).scrollTop() > $('.banner').height()
    $('#targetsSidebar').css('height', "100%")
  else if $(window).scrollTop < $('.banner').height()
    banner_height = $('.banner').height() || 0
    $('#targetsSidebar').css('height', "calc(100% - #{banner_height}px")

showSidebar = () ->
  $('#openTargetsSidebarButton').tooltip('hide')
  $('#openTargetsSidebarButton').fadeOut 'fast', ->
    $('#targetsSidebar').show()
    $('#targetsSidebarPanel').animate {right: '0%'}, 250

hideSidebar = () ->
  $('#closeTargetsSidebarButton').tooltip('hide')
  $('#targetsSidebarPanel').animate {right: '100%'}, 250, ->
    $('#targetsSidebar').hide()
    $('#openTargetsSidebarButton').fadeIn 'fast'

###################
### DRAG EVENTS ###
###################

# We cant use dataTransfer because it is not accessible to dragover events.
target_id = null
department_id = null

(exports ? this).dragTargetToChart = (e) ->
  target_id     = $(e.target).data('target-id')
  department_id = $(e.target).data('department-id')

  hideSidebar()

(exports ? this).endDragTargetToChart = (e) ->
  $('.droppable').removeClass('droppable')

  showSidebar()

(exports ? this).highlightCategoryForDrop = (e) ->
  e.preventDefault()

  $('.droppable').removeClass('droppable')

  $chart                  = $(e.target).parents('.chart')
  target_already_present  = $chart.has(".target-#{target_id}").length
  valid_chart_for_target  = $chart.data('department-id') == -1 || $chart.data('department-id') == department_id
  
  if !target_already_present && valid_chart_for_target
    $chart.addClass('droppable')

(exports ? this).unhighlightCategoryForDrop = (e) ->
  e.preventDefault()

  $('.droppable').removeClass('droppable')

(exports ? this).dropTargetOnChart = (e) ->
  e.preventDefault()

  if $(e.target).is('.chart')
    chart_id = $(e.target).data('chart-id')
  else
    chart_id = $(e.target).parents('.chart').data('chart-id')

  $.ajax
    method: "POST"
    url: "/chart_target.js"
    data:
      chart_id: chart_id
      target_id: target_id
