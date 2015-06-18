$(document).ready ->
  featherEditor = new Aviary.Feather
    apiKey: $('body').attr('aviary_api_key'),
    theme: 'dark',
    language: $('body').attr('aviary_language'),
    tools: 'crop,enhance,contrast,sharpness,text,whiten,effects,warmth,orientation,brightness,saturation,redeye,blemish',
    onSave: (imageID, newURL) ->
      img = $('#' + imageID)
      img.attr('src', newURL)
      $.post(img.attr('data-posturl'), { new_image: newURL })
    ,
    onError: (errorObj) ->
      alert(errorObj.message)

  launchEditor = (id, src) ->
    featherEditor.launch
      image: id,
      url: ($('body').attr('ngrok_address') + src)
    return false

  $(document).on 'click', '[data-aviary]', (e) ->
    e.preventDefault()
    image = $(this).parents('.item').find('img')
    return launchEditor(image.attr('id'), image.attr('data-image'))
