require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    context 'commentを保存できる場合' do
      it 'commentがあれば保存できること' do
        expect(build(:comment, image: nil)).to be_valid
      end

      it 'imageがあれば保存できること' do
        expect(build(:comment, comment: nil)).to be_valid
      end

      it 'comment と imageがあれば保存できること' do
        expect(build(:comment)).to be_valid
      end
    end

    context 'commentを保存できない場合' do
      it ' comment と imageが両方空だと保存できないこと' do
        comment = build(:comment, comment: nil, image: nil)
        comment.valid?
        expect(comment.errors[:comment]).to include("を入力してください")
      end

      it 'group_idが無いと保存できないこと' do
        comment = build(:comment, group_id: nil)
        comment.valid?
        expect(comment.errors[:group]).to include("を入力してください")
      end

      it ' user_idが無いと保存できないこと' do
        comment = build(:comment, user_id: nil)
        comment.valid?
        expect(comment.errors[:user]).to include("を入力してください")
      end
    end
  end
end