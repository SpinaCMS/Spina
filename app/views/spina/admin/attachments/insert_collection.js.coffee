hidden_input = $("input[name='<%= j params[:page_part_id] %>[attachment_tokens]']")
attachment_collection = $("<%= j render partial: 'attachment_collection', locals: {attachments: @attachments} %>")

hidden_input.parents('.media_picker').find('.attachment').remove()
hidden_input.parents('.media_picker').append(attachment_collection)
hidden_input.val("<%= @attachments.map(&:id).join(',') %>")
$.hideModal()
