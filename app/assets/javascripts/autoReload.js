$(function() {



  function buildMessages(message){
    if ( message.image ) {
      let html =
        `<div class="MessageBox" data-message-id=${message.id}>
          <div class="MessageInfo">
            <div class="MessageInfo__userName">
              ${message.user_name}
            </div>
            <div class="MessageInfo__date">
              ${message.created_at}
            </div>
          </div>
          <div class="Message">
            <p class="Message__content">
              ${message.content}
            </p>
            <img class="Message__image" src="${message.image}">
          </div>
        </div>`
      return html;
    } else {
      let html =
      `<div class="MessageBox" data-message-id=${message.id}>
        <div class="MessageInfo">
          <div class="MessageInfo__userName">
            ${message.user_name}
          </div>
          <div class="MessageInfo__date">
            ${message.created_at}
          </div>
        </div>
        <div class="Message">
          <p class="Message__content">
            ${message.content}
          </p>
        </div>
      </div>`
      return html;
    }
  }

  let reloadMessages = function() {
    let last_message_id = $('.MessageBox:last').data("message-id");
    $.ajax({
      //リクエストしたいのは/groups/id番号/api/messages
      url: "api/messages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        let insertMessagesHTML = '';
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(messages, function(i, message) {
          insertMessagesHTML += buildMessages(message)
        });
        //メッセージが入ったHTMLに、入れ物ごと追加
        $('.MessageField').append(insertMessagesHTML);
        $('.MessageField').animate({scrollTop: $('.MessageField')[0].scrollHeight});
      }
    })
    .fail(function() {
      alert('error');
    });
  };

  setInterval(reloadMessages, 7000);
});