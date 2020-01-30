$(function() {
  $('[data-provider="summernote"]').each(function() {
    $(this).summernote({
      lang: "ja-JP",

      height: 600,
      callbacks: {
        onImageUpload: function(files, editor, welEditable) {
          sendFile(files[0], editor, welEditable);
        }
      }
    })
  })

  function sendFile(file, editor, welEditable) {
    data = new FormData()
    data.append("file", file)
    $.ajax ({
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
