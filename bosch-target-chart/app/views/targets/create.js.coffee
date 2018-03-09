<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#modalContainer').modal('hide')
$('#targetsContainer').replaceWith("<%= j render 'targets/table', department: @department %>")
<% end %>
