$("#modalContainer").html("<%= j render 'departments/new_department_form',
                           department: @department,
                           year: @year,
                           chart: @chart %>")
$('#modalContainer').modal('show')