<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
<% if @attribute == 'unit' %>
$("#target<%= @target.id %>CompareToValue").replaceWith('<%= j render "targets/table/compare_to_value", target: @target %>')
<% end %>

<% if @attribute == 'unit' || @attribute == 'compare_to_value' %>
$("#target<%= @target.id %>Indicators").replaceWith("<%= j render 'targets/table/indicators', target: @target %>")
<% end %>

$(".chart").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
$('#targetsSidebar').replaceWith("<%= j render 'layouts/targets_sidebar', year: @target.year %>")
$("#target<%= @target.id %><%= @attribute.camelize %>").replaceWith('<%= j render "targets/table/#{@attribute}", target: @target %>')
initializePopovers()
$("#target<%= @target.id %><%= @attribute.camelize %> a").focus()
$('.popover').popover('hide')
<% end %>
