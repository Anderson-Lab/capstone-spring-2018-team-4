$ ->
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
    if !$("[data-toggle='popover']").is(e.target) and $("[data-toggle='popover']").has(e.target).length == 0 and $('.popover').has(e.target).length == 0
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
        type: 'DELETE'
        url: "/targets/#{target_id}.js"

(exports ? this).initializePopovers = () ->
  # Target attribute popovers
  $("[data-toggle='popover']:not(.indicator)").popover(
    template: "<div class='popover' role='tooltip'>
                <div class='arrow'></div>
                <h3 class='popover-header'></h3>
                <div class='popover-body'></div>
                <div class='popover-footer'>
                  <input class='btn btn-sm btn-primary pull-right' value='#{I18n.actions.submit}' type='submit' form='updateForm' />
                  <div class='clearfix'></div>
                </div>
              </div>"
  )

  # Existing Indicator popovers
  $("[data-toggle='popover'].indicator:not(.new-indicator)").popover(
    template: "<div class='popover' role='tooltip'>
                <div class='arrow'></div>
                <h3 class='popover-header'></h3>
                <div class='popover-body'></div>
                <div class='popover-footer'>
                  <input class='btn btn-sm btn-primary pull-right' value='#{I18n.actions.submit}' type='submit' form='updateForm' />
                  <button class='btn btn-sm btn-danger pull-left delete-indicator-button'>
                    <i class='fa fa-trash'></i>
                  </button>
                  <div class='clearfix'></div>
                </div>
              </div>"
  )

  # New Indicator popovers
  $("[data-toggle='popover'].new-indicator").popover(
    template: "<div class='popover' role='tooltip'>
                <div class='arrow'></div>
                <h3 class='popover-header'></h3>
                <div class='popover-body'></div>
                <div class='popover-footer'>
                  <input class='btn btn-sm btn-success pull-right' value='#{I18n.actions.create}' type='submit' form='createForm' />
                  <div class='clearfix'></div>
                </div>
              </div>"
  )
