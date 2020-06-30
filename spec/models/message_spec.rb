require 'rails_helper'

RSpec.describe Message, type: :model do
  #messageモデルに保存できる場合とできない場合の条件
  #messageコントローラーのcreateアクションは、コンテントとイメージの２つのうちどちらかか両方の引数を持つパラムスを渡す
  #引数エラーにならないのは、最初からnilが代入されていて、該当箇所だけ挿し変わるのでインスタンスの引数の総数は常に一定
  describe '#create' do
    context 'can be saved' do 
      it 'is valid with content & image' do 
        expect(build(:message)).to be_valid
      end

      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end

      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
      end
    end

    context 'cannot be saved' do

      it 'is invalid without content & image' do
        message = build(:message, image: nil, content: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      it 'is invalid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end