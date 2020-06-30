$(function(){
  function buildMessages(message){ 
    let html = `<div class="MessageBox">
                  <div class="MessageInfo">
                    <div class="MessageInfo__userName">
                      ${message.userJSN}
                    </div>
                    <div class="MessageInfo__date">
                      ${message.timeJSN}
                    </div>
                  </div>
                  <div class="Message">
                    <p class="Message__content">
                      ${message.contentJSN}
                    </p>
                  </div>
                  ${message.imageJSN}
                </div>`
    return html
  }

  $('.Content').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this)
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      let html = buildMessages(message)
      $('.MessageField').append(html)
      $('.Content__inputContent').val('')
    })
    .fail(function(){
      alert("エラーです")
    })
  })



});