$("#modalContainer").html("<%= j render 'departments/edit_department_form', department: @department%>")
$('#modalContainer').modal('show')