# README

### LINEのようなアプリケーションの実装

## DB設計

https://gyazo.com/59aacc3f5374c40a04640224558c3af5

## エンドポイント

```
root GET    /                                    groups#index
        new_user_session GET    /users/sign_in(.:format)             devise/sessions#new
            user_session POST   /users/sign_in(.:format)             devise/sessions#create
    destroy_user_session DELETE /users/sign_out(.:format)            devise/sessions#destroy
       new_user_password GET    /users/password/new(.:format)        devise/passwords#new
      edit_user_password GET    /users/password/edit(.:format)       devise/passwords#edit
           user_password PATCH  /users/password(.:format)            devise/passwords#update
                         PUT    /users/password(.:format)            devise/passwords#update
                         POST   /users/password(.:format)            devise/passwords#create
cancel_user_registration GET    /users/cancel(.:format)              devise/registrations#cancel
   new_user_registration GET    /users/sign_up(.:format)             devise/registrations#new
  edit_user_registration GET    /users/edit(.:format)                devise/registrations#edit
       user_registration PATCH  /users(.:format)                     devise/registrations#update
                         PUT    /users(.:format)                     devise/registrations#update
                         DELETE /users(.:format)                     devise/registrations#destroy
                         POST   /users(.:format)                     devise/registrations#create
                   users GET    /users(.:format)                     users#index
          search_friends GET    /friends/search(.:format)            friends#search
                 friends GET    /friends(.:format)                   friends#index
                         POST   /friends(.:format)                   friends#create
          group_messages POST   /groups/:group_id/messages(.:format) messages#create
                  groups GET    /groups(.:format)                    groups#index
                         POST   /groups(.:format)                    groups#create
                   group GET    /groups/:id(.:format)                groups#show
```

### 問題点

heroku上でJQueryが動作しなかったので修正する必要あり
