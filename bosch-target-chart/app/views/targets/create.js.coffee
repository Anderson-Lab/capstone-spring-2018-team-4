<% if @errors %>
$('#form-errors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
window.location = '/'
<% end %>
