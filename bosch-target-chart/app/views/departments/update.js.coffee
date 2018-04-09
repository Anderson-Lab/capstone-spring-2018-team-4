<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('#chartContainer').replaceWith("<%= j render 'charts/chart',
                                  header: I18n.t('charts.department_chart.header', department: @department.abbreviation || @department.name, chart_name: @chart.name, year: @year),
                                  chart: @chart, year: @year,
                                  header_for: 'show_department',
                                  department: @department %>")
$('#modalContainer').modal('hide')
<% end %>