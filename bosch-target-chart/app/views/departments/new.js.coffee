$("#modalContainer").html("<%= j render 'departments/new_department_form', department: @department%>")
$('#modalContainer').modal('show')