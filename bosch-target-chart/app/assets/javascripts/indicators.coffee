$ ->
  $(document).on 'keyup', '#indicator_name', ->
    $('#indicatorDifferenceLabel').text("#{I18n.indicators.fields.versus} #{$(this).val()}:")

  $(document).on 'keyup', '#indicator_value:not(.color-select)', ->
    val             = parseFloat($(this).val()) || 0
    compare_to_val  = parseFloat($('#compare_to_value').val())

    if Number.isInteger(val)
      val = val.toFixed(1)

    if Number.isInteger(compare_to_val)
      compare_to_val = compare_to_val.toFixed(1)
  
    if !isNaN(val) && !isNaN(compare_to_val)
      difference = compare_to_val - val

      if Number.isInteger(difference)
        difference = difference.toFixed(1)
      
      $('#indicatorDifference').text(difference)

      if difference > 0
        $('#indicatorDifference').removeClass('text-success').addClass('text-danger')
        $('#indicatorIcon').removeClass('text-success').addClass('text-danger')
        $('#indicatorIcon i').removeClass('fa-check-circle').addClass('fa-times-circle')
      else
        $('#indicatorDifference').removeClass('text-danger').addClass('text-success')
        $('#indicatorIcon').removeClass('text-danger').addClass('text-success')
        $('#indicatorIcon i').removeClass('fa-times-circle').addClass('fa-check-circle')

  $(document).on 'change', '#indicator_color', ->
    color = $(this).find('option:selected').text()

    if color == I18n.indicators.fields.color.green
      $(this).removeClass('bg-warning bg-danger').addClass('bg-success text-white')
    else if color == I18n.indicators.fields.color.yellow
      $(this).removeClass('bg-success bg-danger').addClass('bg-warning text-white')
    else if color == I18n.indicators.fields.color.red
      $(this).removeClass('bg-success bg-warning').addClass('bg-danger text-white')
    else
      $(this).removeClass('bg-success bg-warning bg-danger text-white')
