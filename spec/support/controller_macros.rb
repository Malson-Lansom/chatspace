# devise を RSpec で使用できるようにする
# ログインメソッドを定義する

module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end