$("#modalContainer").html("<%= j render 'targets/new_target_form', target: @target %>")
$('#modalContainer').modal('show')
