<% if @errors %>
$("#targetErrors").html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
id    = $('.popover').prop('id')
$link = $("[aria-describedby='#{id}'")
<% if @attribute == 'unit' %>
$link.html('<%= raw("#{@value}<br>(#{@target.unit_type})") %>')
<% @target.indicators.each do |indicator| %>
$("#indicator<%= indicator.id %>").attr('data-content', '<%= j render "indicators/forms/indicator_form", indicator: indicator %>')
<% end %>
<% elsif @attribute == 'compare_to_value' %>
$link.html('<%= "#{@target.rule} #{@value}" %>')
<% else %>
$link.text("<%= @value %>")
<% end %>
$link.attr('data-content', '<%= j render "targets/forms/#{@attribute}_form", target: @target %>')
$link.focus()
$link.popover('hide')
<% end %>
