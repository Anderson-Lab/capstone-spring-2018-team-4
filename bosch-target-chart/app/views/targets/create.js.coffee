<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#targetsContainer').replaceWith("<%= j render 'targets/table', department: @department, year: @year %>")
$('#targetsSidebar').replaceWith("<%= j render 'layouts/targets_sidebar', year: @year %>")
initializePopovers()
$('#modalContainer').modal('hide')
<% end %>
