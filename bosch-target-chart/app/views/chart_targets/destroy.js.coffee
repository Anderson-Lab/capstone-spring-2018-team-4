$("#chart<%= @chart.id %>").replaceWith("<%= j render 'charts/chart_body', chart: @chart %>")
