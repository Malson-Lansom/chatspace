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
@ -15,33 +15,33 @@
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

## chat_commentsテーブルh2
|Column|Type|Validation|
|------|----|----------|
|id|integer|null: false, unique: true|
|comment|text|length: { minimum: 100 }|
|image|text|url, format: URI::regexp(%w(http https))|
|user_id|integer|foreign_key: true, dependent: delete|
|group_id|integer|foreign_key: true, dependent: delete|

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
@ -72,4 +72,4 @@ Things you may want to cover:
* Deployment instructions

* ...
