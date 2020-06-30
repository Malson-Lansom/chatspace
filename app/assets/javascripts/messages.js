$(function(){
  function buildMessages(message){
    
    var attachedImage = ""
    if (message.imageJSN !== null) {
      attachedImage = `<div class="MessageBox>
                        ${message.imageJSN}
                      </div>`
    }
    
    function getToday() {
      var t = new Date();
      var year = t.getFullYear();
      var mth = t.getMonth() + 1;
      var date = t.getDate();
      var hour = t.getHours();
      var mins = t.getMinutes();
      return year + "年" + mth + "月" + date + "日 " + hour + "時" + mins + "分";
    }

    let html = `<div class="MessageBox">
                  <div class="MessageInfo">
                    <div class="MessageInfo__userName">
                      ${message.userJSN}
                    </div>
                    <div class="MessageInfo__date">
                      ${getToday()}
                    </div>
                  </div>
                  <div class="Message">
                    <p class="Message__content">
                      ${message.contentJSN}
                    </p>
                  </div>
                  ${attachedImage}
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