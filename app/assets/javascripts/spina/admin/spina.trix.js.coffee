window.Spina = {}

Trix.config.blockAttributes = $.extend Trix.config.blockAttributes, {
  h1:
    tagName: 'h1'
    nestable: false
  h2:
    tagName: 'h2'
    nestable: false
  h3:
    tagName: 'h3'
    nestable: false
  h4:
    tagName: 'h4'
    nestable: false
  h5:
    tagName: 'h5'
    nestable: false
  h6:
    tagName: 'h6'
    nestable: false
}

class Spina.TrixAttachment

  @upload: (attachment) ->
    file = attachment.file

    form = new FormData
    form.append('Content-Type', file.type)
    form.append('photo[file]', file)

    $.ajax
      url: '/admin/photos'
      data: form
      dataType: 'json'
      method: 'post'
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      mimetype: 'multipart/form-data',
      processData: false # tell jQuery not to process the data
      contentType: false # tell jQuery not to set contentType
      xhr: ->
        myXhr = $.ajaxSettings.xhr()
        if myXhr.upload
          myXhr.upload.addEventListener 'progress', (e) ->
            progress = e.loaded / e.total * 100
            attachment.setUploadProgress(progress)
        myXhr
      success: (data) ->
        console.log data
        url = data.file_url
        attachment.setAttributes
          url: url
          href: url

  @photoSelect: (e) ->
    editor_id = $(this).closest('trix-toolbar').data('editor-id')
    $.get("/admin/photos/wysihtml5_select/#{editor_id}")

  @photoInsert: (e, url) ->
    this.editor.insertHTML "<img src='#{ url }' />"

document.addEventListener 'trix-attachment-add', (e) ->
  Spina.TrixAttachment.upload(e.attachment) if e.attachment.file

$(document).on 'click', 'trix-toolbar .photo', Spina.TrixAttachment.photoSelect

$(document).on 'photo-insert', 'trix-editor', Spina.TrixAttachment.photoInsert
