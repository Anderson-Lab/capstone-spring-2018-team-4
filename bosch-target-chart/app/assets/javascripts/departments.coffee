$ ->
  $("[data-toggle='popover']").popover()
  
  # Credit to https://stackoverflow.com/a/9440580
  # for binding events to allow clicks / focuses correctly
  $(document).on 'mousedown', "[data-toggle='popover']", ->
    $(this).data('focused', true)
    $("[data-toggle='popover']").not(this).popover('hide')
    $(this).popover('toggle')

  $(document).on 'mouseup', "[data-toggle='popover']", ->
    $(this).removeData('focused')

  $(document).on 'focus', "[data-toggle='popover']", ->
    if !$(this).data('focused')
      $("[data-toggle='popover']").not(this).popover('hide')
      $(this).popover('toggle')

  $(document).on 'click focus', 'html', (e) ->
    if !$("[data-toggle='popover']").is(e.target) and $('.popover').has(e.target).length == 0
      $("[data-toggle='popover']").popover('hide')

  $(document).on 'click', '.delete-target-button', ->
    target_id = $(this).data('target-id')

    swal {
      title: I18n.targets.delete_header
      text: I18n.targets.delete_confirm
      type: 'warning'
      showCancelButton: true
      closeOnConfirm: true
    }, ->
      $.ajax
        type: 'delete'
        url: "/targets/#{target_id}.js"
