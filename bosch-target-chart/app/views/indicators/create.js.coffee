<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('.new-indicator-container').first().replaceWith("<%= j render 'indicators/indicator', indicator: @indicator %>")
initializePopovers()
$("#indicator<%= @indicator.id %> a").focus()
$('.popover').popover('hide')
<% end %>
