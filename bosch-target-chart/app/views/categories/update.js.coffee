<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#categoriesContainer').replaceWith("<%= j render 'categories/categories' %>")
$('#modalContainer').modal('hide')
<% end %>
