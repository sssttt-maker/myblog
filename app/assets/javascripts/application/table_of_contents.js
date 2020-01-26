$(function() {

  // 目次の出力に使用する変数
  var toc = '<p>目次</p><ol>';
  // 目次の階層の判断に使用する変数
  var hierarchy;
  // h2・h3の判断に使用する変数
  var element = 0;
  // 目次の項目数をカウントする変数
  var count = 0;

  $('.post-text h2, .post-text h3').each(function() {
    // 目次の項目数のカウントを増加
    count++;
    // h2・h3タグにIDの属性値を指定
    this.id = 'chapter-' + count;

    // 現在のループで扱う要素を判断する条件分岐
    if (this.nodeName == 'H2') {
      element = 0;
    } else {
      element = 1;
    }

    // 現在の状態を判断する条件分岐
    if (hierarchy === element) { // h2またはh3がそれぞれ連続する場合
      toc += '</li>';
    } else if (hierarchy < element) { // h2の次がh3となる場合
      toc += '<ol>';
      hierarchy = 1;
    } else if (hierarchy > element) { // h3の次がh2となる場合
      toc += '</li></ol></li>';
      hierarchy = 0;
    } else if (count == 1) { // 最初の項目の場合
      hierarchy = 0;
    }

    // 目次の項目を作成。※次のループで<li>の直下に<ol>タグを出力する場合ががあるので、ここでは<li>タグを閉じていません。
    toc += '<li><a href="#' + this.id + '">' + $(this).html() + '</a>';
  });

  // 目次の最後の項目をどの要素から作成したかにより、タグの閉じ方を変更
  if (element == 0) {
    toc += '</li></ol>';
  } else if (element == 1) {
    toc += '</li></ol></li></ol>';
  }

  // ページ内のh2・h3タグが3つ以上の場合に目次を出力
  if (count < 3) {
    $('.toc').remove();
  } else {
    $('.toc').html(toc);
  }
})
