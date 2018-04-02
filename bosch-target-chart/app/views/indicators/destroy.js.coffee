$("#target<%= @target.id %>Indicators").replaceWith("<%= j render 'targets/table/indicators', target: @target %>")
initializePopovers()
