$ ->
  # Calculate the height of the Targets sidebar
  banner_height = $('.banner').height() || 0
  footer_height = $('.footer').height() || 0
  $('#targetsSidebar').css('height', "calc(100% - #{banner_height + footer_height}px")

  # Toggle tooltips
  $('[data-toggle=tooltip]').tooltip()

  $(document).on 'click', '#openTargetsSidebarButton', ->
    showSidebar()

  $(document).on 'click', '#closeTargetsSidebarButton', ->
    hideSidebar()

showSidebar = () ->
  $('#openTargetsSidebarButton').fadeOut 'fast', ->
    $('#targetsSidebarPanel').animate {right: '0%'}, 250

hideSidebar = () ->
  $('#targetsSidebarPanel').animate {right: '100%'}, 250, ->
    $('#openTargetsSidebarButton').fadeIn 'fast'

###################
### DRAG EVENTS ###
###################

(exports ? this).dragTargetToChart = (e) ->
  target_id     = $(e.target).data('target-id')
  department_id = $(e.target).data('department-id')

  e.dataTransfer.dropEffect = 'copy'
  e.dataTransfer.setData('text/json',
    "{
      \"target-id\" : #{target_id},
      \"department-id\" : #{department_id}
    }"
  )

  hideSidebar()

(exports ? this).endDragTargetToChart = (e) ->
  $('.droppable').removeClass('droppable')

  showSidebar()

(exports ? this).highlightCategoryForDrop = (e) ->
  e.preventDefault()

  data          = JSON.parse(e.dataTransfer.getData('text/json'))
  target_id     = data['target-id']
  department_id = data['department-id']

  $('.droppable').removeClass('droppable')

  $chart                  = $(e.target).parents('.chart')
  target_already_present  = !$chart.has(".target-#{target_id}").length
  valid_chart_for_target  = $chart.data('department-id') == -1 || $chart.data('department-id') == department_id
  
  if target_already_present && valid_chart_for_target
    $chart.addClass('droppable')

(exports ? this).unhighlightCategoryForDrop = (e) ->
  e.preventDefault()

  $(e.target).removeClass('droppable')

(exports ? this).dropTargetOnChart = (e) ->
  e.preventDefault()

  chart_id = $(e.target).parents('.chart').data('chart-id')
  target_id = JSON.parse(e.dataTransfer.getData('text/json'))['target-id']

  $.ajax
    method: "POST"
    url: "/chart_targets"
    data:
      chart_id: chart_id
      target_id: target_id
