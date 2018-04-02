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
      difference = roundDifference(val, compare_to_val)

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

  $(document).on 'click', '.delete-indicator-button', ->
    indicator_id = $('#indicator_id').val()

    swal {
      title: I18n.indicators.delete_header
      text: I18n.indicators.delete_confirm
      type: 'warning'
      showCancelButton: true
      closeOnConfirm: true
    }, ->
      $.ajax
        type: 'delete'
        url: "/indicators/#{indicator_id}.js"

# Because of the way that JavaScript handles floating point numbers, we have to
# use some fancy math to convert the numbers into a format that prevents
# weird decimals like 5.00000000001 from displaying.
#
# We must calculate the largest number of decimals so that we can multiply both
# values into whole numbers. We can then divide the sum by the same multiplier
# to get an accurate floating point number.
#
# Sources:
# https://stackoverflow.com/a/5037927
# https://stackoverflow.com/a/44949594
roundDifference = (val, compare_to_val) ->
  val_decimals            = getDecimalPlaces(val)
  compare_to_val_decimals = getDecimalPlaces(compare_to_val)
  num_decimals            = Math.max(val_decimals, compare_to_val_decimals)
  multiplier              = Math.pow(10, num_decimals)

  return ((compare_to_val * multiplier) - (val * multiplier)) / multiplier

# Source: https://stackoverflow.com/a/17369384
getDecimalPlaces = (num) ->
  if (num % 1) != 0
    return num.toString().split(".")[1].length
  return 0
