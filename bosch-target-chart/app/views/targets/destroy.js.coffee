$(".chart").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
$('#targetsContainer').replaceWith("<%= j render 'targets/table', department: @department, year: @year %>")
$('#targetsSidebar').replaceWith("<%= j render 'layouts/targets_sidebar', year: @year %>")
initializePopovers()
