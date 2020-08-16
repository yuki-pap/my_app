# ぬり絵勉強部屋
https://www.obenkyo.work
ぬり絵勉強法で学習を記録し、ソーシャル機能で友達とも繋がれるWebアプリケーションです。
ぬり絵勉強法とは？
方眼紙と学習する教科ごとにカラフルなペンを用意し、15分勉強したらその教科の色で1マス方眼紙を塗りつぶすという勉強法です。（＊モチベーションを維持しやすい！）
サンプルユーザーでのログインも用意させていただいています、ご気軽にどうぞ！！
<img width="1081" alt="スクリーンショット 2020-08-16 6 34 08" src="https://user-images.githubusercontent.com/65793528/90324035-abe89b00-dfa4-11ea-8e5f-cf2f41b5e66e.png">　　


# アプリ作成に当たって意識したこと
ぬり絵勉強部屋を開発するにあたり私が一番意識したことは、このアプリを通じてのユーザー体験をより良いものにしたいということです。
自分自身が「　こんなアプリが欲しい！　」と思い開発に取り掛かったということもあり、便利かつ使っていて楽しいアプリケーションを目指して開発しました。

## 特に実現できたと思う機能

### タイマー機能
ぬり絵勉強法のデメリットとして、’時間を図るのが面倒’ という問題がありました。
そこでタイマー機能を実装しその問題を解決しました。
#### 方法　
Vue.jsは開発の中盤から導入したので,SPAではなくRailsのテンプレートを基盤にVueを動かすという形で導入しました。
そのためRailsでのページ遷移の際に、ブラウザをシャットダウンした際にタイマーがリセットされてしまうという問題が発生しましたが、Rails側にタイマー開始時刻、タイマー一時停止時刻　などの情報を一時的に保存しそれらの情報からタイマーの状態を計算すると言った手法で状態を維持するタイマーの作成を実現しました。

### 方眼紙を画像化
ぬり絵勉強法は、 「　方眼紙が自分だけのオリジナルの模様になる　」　というのがモチベーションの一つです。
ですので、この「　自分だけの方眼紙をコレクション　」　したいユーザーもいると考えました。
よってWebアプリから過去全ての方眼紙のデータを見れるようにしたかったのですが、
そうすると無限にストレージが必要となり現実的ではないと考え、
方眼紙を取り換える際に画像に変換して保存し、アプリ上には直近数枚の画像のみ残し、コレクションしたいユーザーには画像をダウンロードしてもらうという方針をとることにしました。
#### 方法
方眼紙の取り替えの際に、html2canvas.jsでスクリーンショットを撮りDataURI型に変換したものを画像アップローダー（Shrineを使用） しAmazonS3に保存。
方眼紙のデータは削除。
### To-do-list
私は学習をする際にタスクを細分化して管理する、ということはとても大切だと考えているのでタスク管理機能を実装しました。
この機能の実装にあたりユーザーが感覚的にまるでメモ帳を使い捨てるように簡単に使えるようにすることを目標に定めました。

# クラウドアーキテクチャー
![cloud](https://user-images.githubusercontent.com/65793528/90324031-a25f3300-dfa4-11ea-85c5-e31363f374e8.png)
# 機能一覧
▼ソーシャル機能

	ユーザー登録　　
	ログイン、ログアウト　　
	メール認証によるパスワードリセット　　
	ユーザー検索　　
	ランキング　　
	他ユーザーのフォロー　　
	他ユーザーの学習時間、日記のタイムライン　　
▼学習機能

	マーカー登録機能　　
	タイマーによる学習時間記述　　
	方眼紙による学習時間記述
	今月、今年の学習時間のグラフ
	今までのぬり絵シート表示　　
	ぬり絵シートダウンロード　　
	学習分野別の勉強時間表示　　
	過去の学習履歴表示　　
	日記を書く機能　　
	To-doリスト機能
	...etc　
