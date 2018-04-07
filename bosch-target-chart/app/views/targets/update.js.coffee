<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
<% if @attribute == 'unit' %>
$("#target<%= @target.id %>CompareToValue").replaceWith('<%= j render "targets/table/compare_to_value", target: @target %>')
<% end %>

<% if @attribute == 'unit' || @attribute == 'compare_to_value' %>
$(".chart").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
$("#target<%= @target.id %>Indicators").replaceWith("<%= j render 'targets/table/indicators', target: @target %>")
<% end %>

$("#target<%= @target.id %><%= @attribute.camelize %>").replaceWith('<%= j render "targets/table/#{@attribute}", target: @target %>')
initializePopovers()
$("#target<%= @target.id %><%= @attribute.camelize %> a").focus()
$('.popover').popover('hide')
<% end %>
