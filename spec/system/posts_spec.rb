require 'rails_helper'

RSpec.describe '投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
    sleep(0.1)
  end
  context '投稿ができるとき'do
  it 'ログインしたユーザーは新規投稿できる' do
    # ログインする
    sign_in(@user)
    # 新規投稿ページへのボタンがあることを確認する
    expect(page).to have_content('投稿する')
    # 投稿ページに移動する
    visit new_post_path
    # フォームに情報を入力する
    select 'IT用語', from: 'post[genre_id]'
    fill_in 'post_title', with: @post
    fill_in 'post_text', with: @post
    # 送信するとPostモデルのカウントが1上がることを確認する
    expect do
      click_button "投稿する"
    end.to change(Post, :count).by(1)
    # トップページに遷移する
    visit root_path
    # トップページには先ほど投稿した内容のツイートが存在することを確認する
    expect(page).to have_content(@post_title)
  end
end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # ログインしていないとトップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
    sleep(0.1)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # 投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_post_path(@post1)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する)
      expect(
        find('#post_title').value
      ).to eq(@post1.title)
      # 投稿内容を編集する
      fill_in 'post_title', with: "#{@post1.title}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect do
        click_button "編集する"
      end.to change(Post, :count).by(0)
      # トップページに遷移する
      visit root_path
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post1)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
  end
end
RSpec.describe 'ツイート削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
    sleep(0.1)
  end
  context 'ツイート削除ができるとき' do
    context 'ツイート削除ができるとき' do
      it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
        # ツイート1を投稿したユーザーでログインする
        visit new_user_session_path
        fill_in 'メールアドレス', with: @post1.user.email
        fill_in 'パスワード', with: @post1.user.password
        find('input[name="commit"]').click
        expect(current_path).to eq(root_path)
        # ツイート1に「削除」へのリンクがあることを確認する
        expect(page).to have_link '削除', href: post_path(@post1)
        # 投稿を削除するとレコードの数が1減ることを確認する
        expect{
          page.accept_confirm do
            click_link('投稿の削除')
          end
          expect(page).to have_content('トップページ')
        }.to change { Post.count }.by(-1)
        # トップページに遷移する
        visit root_path
        # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
        expect(page).to have_no_content("#{@post1.title}")
      end
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post1)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
  end
end

