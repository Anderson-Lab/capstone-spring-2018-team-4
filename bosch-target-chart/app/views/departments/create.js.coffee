<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#departmentsContainer').replaceWith("<%= j render 'departments/departments' %>")
$('#modalContainer').modal('hide')
<% end %>