$ ->
  $("[data-toggle='popover']").popover()
    
  $(document).on 'focus', "[data-toggle='popover']", ->
    $("[data-toggle='popover']").not(this).popover('hide')
    $(this).popover('toggle')

  $(document).on 'click focus', 'html', (e) ->
    if !$("[data-toggle='popover']").is(e.target) and $('.popover').has(e.target).length == 0
      $("[data-toggle='popover']").popover('hide')
