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

---

### 設計で意識した点

- 業務で一般的な「担当者 → 案件 → タスク」の関係が直感的に理解できるよう、User・Project・Task の3モデル構成を採用しました。
- Taskの状態管理には enum を使用し、状態遷移を明確にしています。
- 一覧画面ではN+1問題を避けるため、必要に応じて includes を利用しています。
- Rails 8 の enum 定義方式（enum :status, values）に対応した実装としています。

---

## 業務アプリとして考慮した点
- アプリの入口としてダッシュボード画面を用意し、全体状況を即座に把握できるようにしました。
- 期限切れタスクは業務上の優先度が高いため、赤表示と「期限超過」ラベルで視覚的に強調しています。
- タスクは期限順に並び替え、対応が必要なものが自然と上に表示されるようにしています。
- ステータス入力は select ボックスを使用し、入力ミスを防止しています。

---

## 悩んだ点
- Rails 8 における enum の定義方法が従来と異なっており、エラーを確認しながら正しい書き方に修正しました。
- ダッシュボードに表示する情報量について、見やすさとのバランスで悩みました。

---

## 改善したい点
- 認証機能を追加し、ユーザーごとに閲覧・操作可能なデータを制御したいです。
- タスク数が増えた場合に備え、ページネーションや検索機能を追加したいです。
- RSpecによるテストを拡充し、品質を担保できる構成にしたいです。
- API化し、React や Next.js などのフロントエンドと分離した構成にも対応したいです。

---

## セットアップ手順

```bash
git clone https://github.com/uetachikara/simple_pm.git
cd simple_pm
bundle install
bin/rails db:create db:migrate db:seed
bin/rails s

