| ヘッダ 1 | ヘッダ 2 |
| ------------- | ------------- |
| アプリケーション名 | Reminder37191 |
|アプリケーション概要 | 備忘録用のアプリケーション。投稿した内容を検索したりいいねをすることができる。|
| URL | http://reminder37191.herokuapp.com/ |
| テスト用アカウント |メールアドレス taro@test パスワード aaa111 BASIC認証 admin PASS 2222 |
| 利用方法 | ヘッダーからユーザー新規登録を行い、投稿するボタンから「ジャンル、タイトル、説明」を入力して投稿を行う。トップページから投稿の詳細を選ぶといいねすることができてマイページにいいねした投稿が表示される。サイドバーから「投稿者名、タイトル、説明、ジャンル」による検索が可能。 |
| アプリケーションを作成した背景 | 自分の学習用に作成した自分ノート。プログラミングの学習は紙のノートに記述するよりも実際に打ち込んで身体で覚えた方が身につくと考えたため作成。検索機能を充実させたことで探したい投稿をすぐに探すことができる。紙媒体と違い編集することも容易である。さらに特に覚えたいことはいいね機能でマイページに残すことができる。 |
| 洗い出した要件 | https://docs.google.com/spreadsheets/d/1q2bLDS3xwHWsVT67hn3N0b4kvUJQhESpDSkViHvkcMU/edit#gid=982722306 |
| 実装した機能についての画像やGIFおよびその説明 |トップページ https://gyazo.com/4040f9b214e7adf226dd573766bf25f1 |
|実装予定の機能 |新規登録の際のユーザー情報を更新する予定である。得意なジャンルや学習歴をユーザー情報として登録できるようにしたい。|
|データベース設計 | /Users/sasakiayaka/projects/reminder37191/ER.dio
|画面遷移図| /Users/sasakiayaka/projects/reminder37191/std.dio |
|開発環境 | ・フロントエンド :HTML,CSS ・バックエンド :Ruby / Ruby on Rails ・インフラ :MySQL ・テスト :RSpec ・テキストエディタ :Visual Studio Code
|ローカルでの動作方法 | 以下コマンドを順に実行してください % git clone https://github.com/kurigaki/reminder37191 % cd reminder37191 % bundle install % yarn install