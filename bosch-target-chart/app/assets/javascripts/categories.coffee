$ ->

  $(document).on 'change', '#category_color', ->
    selected_hex_color = $('option:selected', this).val()
    if selected_hex_color
      $(this).css('background-color', selected_hex_color)
      $(this).css('color', 'white')
    else
      $(this).css('background-color', '')
      $(this).css('color', '')

  $(document).on 'change', '#iconInput', (e) ->
    # Thanks to TimKaechele at StackOverflow for part of this solution
    # https://stackoverflow.com/questions/25474329/how-to-preview-uploaded-image-instantly-with-paperclip-in-ruby-on-rails
    image = e.target.files[0]
    reader = new FileReader

    reader.onload = (file) ->
      $('#iconPreview').attr('src', file.target.result)

    reader.readAsDataURL image
