class GroupsController < ApplicationController
  
  def index
  end

  def new
    # からのインスタンスを作成する
    @group = Group.new
    # まず作った段階でログインしているユーザーがグループに入っている状態にする用意
    @group.users << current_user
  end

  def create
    # ストロングパラメータを持ったインスタンスを作成する
    @group = Group.new(group_params)
    # グループを保存する条件式でルートを設定する
    if @group.save
      # 保存時はflashと共に、メイン画面へ 
      redirect_to root_path, notice: 'グループを作成しました'
    else
      # 情報が不足して保存できない時はnew.html.hamlへ返す
      render :new
    end
  end

  def edit
    # から、該当IDを持つグループを探しインスタンスとする
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Gropu.find(params[:id])
    # 条件式でストロングパラメータを上書きする分岐を設定
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    # 配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに[]と記述するルール
    params.require(:group).permit(:name, user_ids: [])
  end
end
