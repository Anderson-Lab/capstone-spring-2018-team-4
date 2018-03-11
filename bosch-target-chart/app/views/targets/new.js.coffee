$("#modalContainer").html("<%= j render 'targets/new_target_form', target: @target, year: @year %>")
$('#modalContainer').modal('show')
