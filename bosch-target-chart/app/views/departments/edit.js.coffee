$("#modalContainer").html("<%= j render 'departments/edit_department_form',
                           department: @department,
                           year: @year %>")
$('#modalContainer').modal('show')