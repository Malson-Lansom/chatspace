class MessagesController < ApplicationController

  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    # メッセージを新しく作って指定カラムに格納する条件式を考える
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージを投稿しました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください'
      render :index
    end
  end

  private
  def message_params
    # contentをuser_idに紐付けて渡す
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    # 現状のグループのインスタンス
    @group = Group.find(params[:group_id])
  end
end
