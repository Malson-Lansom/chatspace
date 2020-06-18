# README
# ChatSpaceデータベースh1

## usersテーブルh2
|Column|Type|Option|Validation|
|------|----|------|----------|
|id|integer|null: false, unique: true||
|user_name|string|null: false|length { minimum: 8 }|
|email|string|null: false, unique: true|email, {presence: true, format: { with: VALID_EMAIL_REGEX }|
|password|string|null: false|length: { minimum: 8 }|
### Association
- has_many :groups, through: :users_groups
- has_many :chat_comments
#### 課題 email: emailであるかどうか、フォーマットが英字数字のみか、一意性があるか、
#### 課題 indexの設定　ChatSpaceでの検索機能必要か？　グループ機能でuser_nameのindex化必要か（コメント欄、グループ編集欄でユーザー名が検索・表示される）

## groupsテーブルh2
|Column|Type|Option|Validation|
|------|----|------|----------|
|id|integer|null: false, unique: true||
|group_name|string|null: false|length: { minimum: XX }|
### Association
- has_many :users, through: :users_groups
- has_many :chat_comments
#### 課題 group_nameのバリデーション設定（禁止文字、文字数制限）

## users_groupsの中間テーブルh2
|Column|Type|Option|Validation|
|------|----|------|----------|
|id|integer|null: false, unique: true||
|user_id|integer|foreign_key||
|group_id|integer|foreign_key||
### Association
- belongs_to :users
- belongs_to :groups

## messageテーブルh2
|Column|Type|Option|Validation|
|------|----|------|----------|
|id|integer|null: false, unique: true||
|body|text||length: { minimum: 100 }|
|image|string||url, format: URI::regexp(%w(http https))|
|user_id|integer|foreign_key: true| dependent: delete|
|group_id|integer|foreign_key: true| dependent: delete|
### Association
- belongs_to :users
- belongs_to :groups
#### 課題 imageの変数タイプ　機能としてはURLではなく、画像そのものを格納する挙動になっている。タイプを検索したところphpはresourceタイプ、rubyに関しては不明、同じ？
とりあえずURLを貼り付ける場合の対応を記述



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

