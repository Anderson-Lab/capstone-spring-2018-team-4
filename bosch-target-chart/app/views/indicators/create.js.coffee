<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$(".chart").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
$("#target<%= @target.id %>Indicators").replaceWith("<%= j render 'targets/table/indicators', target: @target %>")
$('#targetsSidebar').replaceWith("<%= j render 'layouts/targets_sidebar', year: @target.year %>")
initializePopovers()
$("#indicator<%= @indicator.id %> a").focus()
$('.popover').popover('hide')
<% end %>
