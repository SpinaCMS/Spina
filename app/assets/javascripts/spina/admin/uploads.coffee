 # Upload photo
$.fn.uploadPhoto = ->
  $(this).fileupload
    dataType: "script"
    singleFileUploads: true
    dropZone: $(this).find('.photo-field')
    # maxNumberOfFiles: 1
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        $(this).find('.customfile').addClass('loading')
        data.submit()
      else
        alert("#{file.name} is not gif-, jpeg- or png- file")
    done: (e, data) ->
      $(this).find('.customfile').removeClass('loading')

# Upload document
$.fn.uploadDocument = ->
  $(this).fileupload
    dataType: "script"
    singleFileUploads: true
    dropZone: $(this).find('.attachment-field')
    maxNumberOfFiles: 1
    add: (e, data) ->
      types = /(\.|\/)(pdf|docx?|rtf|txt)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        $(this).find('.customfile').addClass('loading')
        data.submit()
      else
        alert("#{file.name} is not pdf-, word-, txt- or rtf- file")
    done: (e, data) ->
      $(this).find('.customfile').removeClass('loading')
