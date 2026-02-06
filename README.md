# Simple Project Management App

## 概要
User・Project・Task の3モデルを持つ、シンプルなタスク管理アプリです。  
業務アプリを想定し、担当者（User）→案件（Project）→タスク（Task）という構造で管理できるように設計しています。

アプリ起動時にはダッシュボードを表示し、全体状況を一目で把握できる構成としています。

---

## 使用技術
- Ruby on Rails 8.x
- Ruby 3.x
- SQLite3
- ERB（Rails標準ビュー）

---

## 機能一覧
- User / Project / Task のCRUD機能
- User → Project → Task の階層構造
- Taskのステータス管理（todo / doing / done）
- Taskの期限（due_date）管理
- ステータスによる絞り込み
- 期限順での並び替え
- ダッシュボード表示
- 最近作成された案件一覧
- 期限が近いタスク一覧
- 期限未設定の未完了タスク一覧
- 期限切れタスクの強調表示（赤表示・ラベル）

---

## データ構成
User
- name（必須）
  - has_many :projects

Project
- name（必須）
  - belongs_to :user
  - has_many :tasks

Task
- title（必須）
  - status（todo / doing / done）
  - due_date（任意）
  - belongs_to :project

## セットアップ手順

```bash
git clone https://github.com/uetachikara/simple_pm.git
cd simple_pm
bundle install
bin/rails db:create db:migrate db:seed
bin/rails s

