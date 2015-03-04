featherEditor = new Aviary.Feather
  apiKey: 'e7a5e1c28334eb7a',
  apiVersion: 3,
  theme: 'light',
  language: 'nl',
  minimumStyling: true,
  tools: 'crop,enhance,contrast,sharpness,text,whiten,effects,warmth,orientation,brightness,saturation,redeye,blemish',
  appendTo: '',
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
    url: src
  return false

$(document).on 'click', '[data-aviary]', (e) ->
  e.preventDefault()
  image = $(this).parents('.item').find('img')
  return launchEditor(image.attr('id'), image.attr('data-image'))
