require 'rails_helper'

describe CommentsController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'ログインしている場合' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it '@commentに期待した値が入っていること' do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it '@groupに期待した値が入っていること' do
        expect(assigns(:group)).to eq group
      end

      it 'index.html.erb に遷移すること' do
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'ログイン画面にリダイレクトすること' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, comment: attributes_for(:comment) } }

    context 'ログインしている場合' do
      before do
        login user
      end

      context '保存に成功した場合' do
        subject{
          post :create,
          params: params
        }

        it 'commentを保存すること' do
          expect{(subject).to change(Comment, :count).by(1)}
        end

        it 'group_comments_pathへリダイレクトすること' do
          subject
          expect{(response).to redirect_to(group_comments_path(group))}
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, comment: attributes_for(:comment, content: nil, image: nil) } }

        subject{
          post :create,
          params: invalid_params
        }

        it 'commentを保存しないこと' do
          expect{(subject).not_to change(Comment, :count)}
        end

        it 'index.html.hamlに遷移すること' do
          subject
          expect{(response).to render_template :index}
        end
      end
    end

    context 'ログインしていない場合' do

      it 'new_user_session_pathにリダイレクトすること' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end