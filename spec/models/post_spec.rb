require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '投稿機能のテスト' do
    context '投稿できる場合' do
      it '必要な情報を適切に入力して「投稿する」ボタンを押すと、情報がデータベースに保存されること。' do
        expect(@post).to be_valid
      end
      it '参考資料がなくても、情報がデータベースに保存されること。' do
        @post.reference = ''
        expect(@post).to be_valid
      end
      it '参考画像がなくても、情報がデータベースに保存されること。' do
        @post.image = ''
        expect(@post).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'ジャンルが必須であること。' do
        @post.genre = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("ジャンル を選択してください")
      end
      it 'タイトルが必須であること。' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'テキストが必須であること。' do
        @post.text = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("テキストを入力してください")
      end
      it 'userが紐付いていなければ投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
