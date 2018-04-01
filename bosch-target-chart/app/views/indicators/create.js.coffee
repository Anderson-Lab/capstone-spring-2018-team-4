<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$("#target<%= @target.id %>Indicators").replaceWith("<%= j render 'targets/table/indicators', target: @target %>")
initializePopovers()
$("#indicator<%= @indicator.id %> a").focus()
$('.popover').popover('hide')
<% end %>
