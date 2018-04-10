$(".chart").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
$('#targetsContainer').replaceWith("<%= j render 'targets/table', department: @department, year: @year %>")
initializePopovers()
