$("#modalContainer").html("<%= j render 'categories/new_category_form', category: @category%>")
$('#modalContainer').modal('show')