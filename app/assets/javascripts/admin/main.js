$(function() {

  $('.img-upload').change(function(e) {
    var files = e.target.files;
    console.log(e.target.files)

    $.each(files, function(i) {
      var reader = new FileReader();
      var file = files[i];

      if(file.type.indexOf('image') < 0) {
        alert('画像ファイルを指定してください');
        return false;
      }

      reader.onload = (function(file) {
        return function(e) {
          var src = e.target.result;
          var img = '<img src="' + src + '" class="img-preview">';
          $('.preview').append(img);
        }
      })(file)
      reader.readAsDataURL(file);
    })
  })

});
