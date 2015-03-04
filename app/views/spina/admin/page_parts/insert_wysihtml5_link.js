var editor = $(".wysihtml5-container[data-object-id=<%= params[:object_id] %>]").data('wysihtml5');
editor.focus();
editor.composer.commands.exec("createLink", { href: "<%= params[:link] %>", target: "_self" });
editor.focus();
$.hideModal();
