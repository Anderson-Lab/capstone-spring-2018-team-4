<% if @errors %>
$("#targetErrors").append("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
id    = $('.popover').prop('id')
$link = $("[aria-describedby='#{id}'")
$link.text("<%= @value %>")
$link.attr('data-content', '<%= j render "targets/forms/#{@attribute}_form", target: @target %>')
$link.focus()
$link.popover('hide')
<% end %>
