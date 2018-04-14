$("#modalContainer").html("<%= j render 'departments/edit_department_form',
                           department: @department,
                           year: @year,
                           chart: @chart %>")
$('#modalContainer').modal('show')