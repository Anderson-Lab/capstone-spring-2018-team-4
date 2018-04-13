<% if @errors %>
$('#formErrors').html("<%= j render 'shared/form_errors', errors: @errors %>")
<% else %>
$('.chart-container').last().after("<%= j render 'charts/chart',
                                        header: I18n.t('charts.department_chart.header', department: @department.abbreviation || @department.name, chart_name: @chart.name, year: @year),
                                        chart: @chart,
                                        year: @year,
                                        header_for: '',
                                        department: @department %>")
$('#targetsSidebar').replaceWith("<%= j render 'layouts/targets_sidebar', year: @year %>")
setSidebarHeight()
$('#modalContainer').modal('hide')
<% end %>