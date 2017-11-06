$(document).on('turbolinks:load', function() {

// インクリメンタルサーチのメソッド
  function buildHtmluser(user){
    var user_name = user.name;
    var user_id = user.id;
    var html =  '<li class = "chat-group-form__result">' +
                      user_name +
                      '<a id ="add_button" type = "button" data-user-name="' + user_name + '"data-user-id=' + user_id +'>' + '追加' +
                      '</a>' +
                      '</li>';
    $('.form').append(html);
  }

// 追加したユーザーを表示するメソッド
  function addHtmluser(name, id){
    var html =   '<p class = "chat-group-add-user__name">' +
                       name +
                      '<input name = "chat_group[user_ids][]" type = "hidden", value =' + id + ' >' +
                      '<a class = "chat-group-form__delete-btn" data-user-id ='+ id +'>' + '削除' +
                      '</a>' +
                      '</p>';
    $('.chat-group-user').append(html);
  }

  function ajaxSearch() {
    var word = $('.search_form')[0][2].value
    if (word.length !== 0) {
      console.log("aaa");
      $.ajax({
        type: 'GET',
        url: "/users",
        data:
          {
            friend_name: {
            keyword: word
              }
          },
        dataType: 'json'
        })
        .done(function(json) {
          if (json) {
         // jsonの中身は配列として帰ってくる
          $.each(json, function(i, user){
            buildHtmluser(user);
          });
        }
        })
        .fail(function() {
          alert('メッセージを入力しろ。');
        });
    }
    else{
    $(".chat-group-form__result").remove();
    }
  };

  $('.search_form').on('keyup', function() {
    ajaxSearch();
  });

  $(document).on('click', '#add_button', function() {
    var user_name = $(this).data('user-name');
    var user_id = $(this).data('user-id');
    addHtmluser(user_name, user_id);
    $(this).parent().remove();
  });

  $(document).on('click', '.chat-group-form__delete-btn', function() {
    $(this).parent().remove();
  });
});
