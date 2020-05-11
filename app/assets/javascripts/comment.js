$(function(){
  function buildHTML(comment){
    if ( comment.image ) {
      var html =
        `<div class="comment-list">
          <div class="comment-info">
            <div class="comment-info__name">
              ${comment.user_name}
            </div>
            <div class="comment-info__date">
              ${comment.created_at}
            </div>
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
        `<div class="comment-list">
          <div class="comment-info">
            <div class="comment-info__name">
              ${comment.user_name}
            </div>
            <div class="comment-info__date">
              ${comment.created_at}
            </div>
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

});