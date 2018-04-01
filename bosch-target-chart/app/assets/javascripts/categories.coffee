$ ->

  $(document).on 'change', '#category_color', ->
    selected_hex_color = $('option:selected', this).val()
    if selected_hex_color
      $(this).css('background-color', selected_hex_color)
      $(this).css('color', 'white')
    else
      $(this).css('background-color', '')
      $(this).css('color', '')
