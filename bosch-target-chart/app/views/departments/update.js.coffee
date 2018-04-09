<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#chartContainer').replaceWith("<%= j render 'charts/chart' %>")
$('#modalContainer').modal('hide')
<% end %>