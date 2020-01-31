$(function() {

  // summernote
  var InsertCode = function() {
    var ui = $.summernote.ui;
    var node = $('<code class="hljs"></code>')
    // create button
    var button = ui.button({
      contents: '<code class="hljs">',
      tooltip: 'code',
      click: function() {
        // invoke insertText method with 'hello' on editor module.
        $('[data-provider="summernote"]').summernote('editor.insertNode', node[0]);
      }
    });

    return button.render(); // return button as jquery object
  }

  $('[data-provider="summernote"]').each(function() {
    $(this).summernote({
      lang: "ja-JP",
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'underline', 'clear']],
        ['fontname', ['fontname']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['table', ['table']],
        ['insert', ['link', 'picture', 'video']],
        ['view', ['fullscreen', 'codeview', 'help']],
        ['mybutton', ['code']]
      ],
      cleaner: {
        action: 'both', // both|button|paste 'button' only cleans via toolbar button, 'paste' only clean when pasting content, both does both options.
        newline: '<br>', // Summernote's default is to use '<p><br></p>'
        notStyle: 'position:absolute;top:0;left:0;right:0', // Position of Notification
        icon: '<i class="note-icon">[Your Button]</i>',
        keepHtml: false, // Remove all Html formats
        keepOnlyTags: ['<p>', '<br>', '<ul>', '<li>', '<b>', '<strong>', '<i>', '<a>'], // If keepHtml is true, remove all tags except these
        keepClasses: false, // Remove Classes
        badTags: ['style', 'script', 'applet', 'embed', 'noframes', 'noscript', 'html'], // Remove full tags with contents
        badAttributes: ['style', 'start'], // Remove attributes from remaining tags
        limitChars: false, // 0/false|# 0/false disables option
        limitDisplay: 'both', // text|html|both
        limitStop: false // true/false
      },
      buttons: {
        code: InsertCode
      },
      height: 600,
      callbacks: {
        onImageUpload: function(files, editor, welEditable) {
          sendFile(files[0], editor, welEditable);
        }
      }
    })
  })

     // s3へ画像をアップロードして表示
  function sendFile(file, editor, welEditable) {
    data = new FormData()
    data.append("file", file)
    $.ajax({
      url: '/admin/posts/upload_image',
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST',
      success: function(data) {
        $('[data-provider="summernote"]').summernote('insertImage', data.url);
      },
      error: function() {
        alert('画像のアップロードに失敗しました')
      }
    });
  }
})
