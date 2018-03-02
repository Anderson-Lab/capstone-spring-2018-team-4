<% if @errors %>
$("#targetErrors").append("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
id = $('.popover').prop('id')
$("[aria-describedby='#{id}'").text("<%= @value %>")
$("[aria-describedby='#{id}'").focus()
$("[aria-describedby='#{id}'").attr('data-content', '<%= j render "targets/forms/#{@attribute}_form", target: @target %>')
$("[aria-describedby='#{id}'").popover('hide')
<% end %>
