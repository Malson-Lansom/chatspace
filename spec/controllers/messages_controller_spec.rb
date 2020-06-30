require 'rails_helper'
describe MessagesController do
  #initialize method
  #容れ物を定義するだけなので、遅延評価（＝メソッド実行時に評価される）のletを使って
  #factoriesのgroupとuserのインスタンス化される
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
  
  # describe '#index' do
  #   context 'log in' do
  #     before do
  #       #ログインしている場合、ユーザーと所属しているgroup_idのデータが存在している
  #       #ログインユーザーはコントローラマクロで定義したloginメソッドを呼び出し、let(:user)のデータを引数として渡す
  #       login user
  #       #コントローラーのindexアクションを擬似的に呼び出す
  #       #変数のハッシュはグループidをキーに <= messagesのルーティングはgroupsにネスト
  #       get :index, params: { group_id: group.id }
  #     end
  #       #変数を代入したインスタンスが、loginメソッドのインスタンスと同じか確認する？
  #       #対象が等しく、未保存のレコードか確認 => be_a_new()
  #     it 'assigns @message' do
  #       expect(assigns(:message)).to be_a_new(Message)
  #     end

  #     it 'assigns @group' do
  #       expect(assigns(:group)).to eq group
  #     end

  #     it 'renders index' do
  #       expect(response).to render_template :index
  #     end
  #   end

  #   context 'not log in' do
  #     before do
  #       #ログインしていない場合、ユーザー情報は無い
  #       get :index, params: { group_id: group.id }
  #     end

  #     it 'redirects to new_user_session_path' do
  #       expect(response).to redirect_to(new_user_session_path)
  #     end
  #   end
  # end

  describe '#create' do
    context 'log in' do
      before do
        #ログインユーザーはコントローラマクロで定義したloginメソッドを呼び出し、let(:user)のデータを引数として渡す
        login user
      end
      
      context 'can be saved' do
        subject {
          post :create,
          params: params
        }
        
        it 'count up message' do
          # Messageモデルのレコードが一つ増えたかを確認する?
          expect { subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))          
        end
      end

      context 'cannot be saved' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }
        subject {
          post :create, 
          params: invalid_params
        }

        it 'does not count up' do
          expect {subject}.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end
end