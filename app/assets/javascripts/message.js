$(window).on('load', function() {
  last_scroll = $('.content').find(":last").offset().top
  $('.content').scrollTop(last_scroll);
})

$(function() {
  function build_current_user_HTML(new_message) {
    var html =
    '<div class= message data-message_id=' +
      new_message.message_id + '>' +
      '<div class= message_current_user>' +
          '<div class= message_content_cuurent_user>' +
            new_message.message +
          '</div>' +
          '<div class= message_time_cuurent_user>' +
            new_message.created_at +
          '</div>' +
        '</div>';
    return html;
  }

  function build_not_current_user_HTML(new_message) {
    var html =
    '<div class= message data-message_id=' +
      new_message.message_id + '>' +
      '<div class= message_not_current_user data-message_id=' +
      new_message.message_id + '>' +
          '<div class= message_content_not_cuurent_user>' +
            new_message.message +
          '</div>' +
          '<div class= message_time_not_cuurent_user>' +
            new_message.created_at +
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
      debugger;
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
})
