$("#modalContainer").html("<%= j render 'categories/edit_category_form', category: @category %>")
$('#modalContainer').modal('show')