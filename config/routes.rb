Rails.application.routes.draw do

  devise_for :users
  root 'groups#index'
  resources :users, only: [:edit, :update, :index]
  
  # グループとメッセージの関係性から、合わせて呼び出す作りにする
  # メッセージを呼び出すのはグループの中だけなので
  # 分けておいて、メッセージを呼び出すという作りにする意味がない
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
  
  #rootはgroupsに設定する、それぞれのデータを呼び出すように:indexを追加する

end
