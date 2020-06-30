$(function(){
  function buildMessages(message){ 
    let html = `<div class="MessageBox">
                  <div class="MessageInfo">
                    <div class="MessageInfo__userName">
                      ${userJSN}
                    </div>
                    <div class="MessageInfo__date">
                      ${timeJSN}
                    </div>
                  </div>
                  <div class="Message">
                    <p class="Message__content">
                      ${contentJSN}
                    </p>
                  </div>
                  ${imageJSN}
                </div>`
    return html
    // hamlで書くのは不可???
    // let html = `.MessageBox
    //               .MessageInfo
    //                 .MessageInfo__userName
    //                   ${message.user.name}
    //                 .MessageInfo__date
    //                   ${message.created_at}
    //               .Message
    //                 - if message.content.present?
    //                   %p.Message__content
    //                     ${message.content}`
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
      //console.log(post)
      let html = buildMessages(message)
      //console.log(html)
      $('.MessageField').append(html)
      $('.Content__inputContent').val('')
      //console.log("success!!!")
    })
    .fail(function(){
      alert("エラーです")
    })
  })



});