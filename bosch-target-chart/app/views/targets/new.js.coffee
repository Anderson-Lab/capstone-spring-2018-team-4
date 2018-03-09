$("#modalContainer").html("<%= j render 'targets/new_target_form' ,target: @target, departments: @departments, categories: @categories%>")
$('#modalContainer').modal('show')