$(function(){

  function buildHTML(comment){
    if ( comment.image ) {
      var html =
        `<div class="comment-list" data-comment-id = ${comment.id}>
          <div class="comment-info">
            <a class="comment-info__name">
              ${comment.user_username}
            </a>
            <a class="comment-info__date">
              ${comment.created_at}
            </a>
          </div>
          <div class="comment">
            <p class="comment__info">
              ${comment.comment}
            </p>
            <img src=${comment.image} class="lower-comment__image">
          </div>
        </div>`
      return html;
    } else {
      var html =
        `<div class="comment-list" data-comment-id = ${comment.id}>
          <div class="comment-info">
            <a class="comment-info__name">
              ${comment.user_username}
            </a>
            <a class="comment-info__date">
              ${comment.created_at}
            </a>
          </div>
          <div class="comment">
            <p class="comment__info">
              ${comment.comment}
            </p>
          </div>
        </div>`
      return html;
    };
  }

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.Chat-main__comment-list').append(html);
      $('.Chat-main__comment-list').animate({ scrollTop: $('.Chat-main__comment-list')[0].scrollHeight});
      $('form')[0].reset();
    })
    .always(() => {
      $(".comment-form__submit").removeAttr("disabled");
      })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    })
  });

  var reloadComments = function() {
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    var last_comment_id = $('.comment-list:last').data("comment-id");

    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/commentsとなるよう文字列を書く
      url: "api/comments",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'GET',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {id: last_comment_id}
    })
    .done(function(comments) {
      if (comments.length !== 0) {
        //追加するHTMLの入れ物を作る
        var html = '';
        //配列commentsの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(comments, function(i, comment) {
          html += buildHTML(comment)
        
        //メッセージが入ったHTMLに、入れ物ごと追加
        $('.Chat-main__comment-list').append(html);
        $('.Chat-main__comment-list').animate({ scrollTop: $('.Chat-main__comment-list')[0].scrollHeight});
        });
      }
    })
    .fail(function() {
      alert('error');
    });
    
  }

  if (document.location.href.match(/\/groups\/\d+\/comments/)) {
    setInterval(reloadComments, 7000);
  }
  
});