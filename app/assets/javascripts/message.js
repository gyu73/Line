$(window).on('load', function() {
  last_scroll = $('.content').find(":last").offset().top
  $('.content').scrollTop(last_scroll);
})

$(function() {
  function build_current_user_HTML(new_message) {
    var html =
    '<div class= message data-message-id=' +
      new_message.message_id + '>' +
      '<div class= message_current_user>' +
          '<div class= message_content_cuurent_user>' +
            new_message.message +
          '</div>' +
          '<div class= message_time_cuurent_user>' +
            new_message.created_at +
          '</div>' +
        '</div>' +
        '</div>';
    return html;
  }

  function build_not_current_user_HTML(new_message) {
    var html =
    '<div class= message data-message-id=' +
      new_message.message_id + '>' +
      '<div class= message_not_current_user>' +
          '<div class= message_content_not_cuurent_user>' +
            new_message.message +
          '</div>' +
          '<div class= message_time_not_cuurent_user>' +
            new_message.created_at +
          '</div>' +
        '</div>' +
        '</div>';
    return html;
  }

// イベント
  $('.submit_button').on('click', function(e) {
    e.preventDefault();
    SendAjax();
    last_scroll = $('.content').find(":last").offset().top
    $('.content').scrollTop(last_scroll);
    console.log(last_scroll);
  })

  function SendAjax() {
    var message = $('.message_form')[0][2].value
    var group_id = $('.message_form')[0][3].value
    $.ajax({
      type: 'POST',
      url: location.href + "/messages",
      data: {
        message: {
          message: message,
          group_id: group_id
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      if (data.user_info === "current_user") {
        var current_user_html = build_current_user_HTML(data);
        return $('.content').append(current_user_html);
      }
      else {
        var not_current_user_html = build_not_current_user_HTML(data)
        return $('.content').scrollTop(last_scroll);
      }
    })
    .fail(function() {
      alert('メッセージを入力してください');
    })
  }
  // 自動更新のためのメソッド
  function getNewMessages() {
    var group_id = $('.message_form')[0][3].value
    if(location.pathname == '/groups/'+ group_id) {
      var LastMessageId = $(".message:last-child").data("message-id");
      $.ajax({
        type: 'GET',
        url: location.href,
        data: {
          LastMessageId: LastMessageId
        },
        dataType: 'json'
      })
      .done(function(data) {
        if(data.length != 0) {
          var html = '';
          $.each(data, function(index, new_message) {
            if (new_message.user_info === "current_user") {
            html += build_current_user_HTML(new_message);
          }
            else {
              html += build_not_current_user_HTML(new_message);
              debugger;
            }
          });
          return $('.content').append(html);
        };
      })
      .fail(function() {
        alert('メッセージを自動更新できませんでした。');
      })
    }
  }
  //自動更新のための記述
  var group_id = $('.message_form')[0][3].value
  if(location.pathname == '/groups/' + group_id ) {
    var timer = setInterval(getNewMessages, 10000);
  }
  else {
    clearInterval(timer);
  }
});
