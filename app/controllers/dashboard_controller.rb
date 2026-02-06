class DashboardController < ApplicationController
  def index
    # ユーザー一覧（数だけでもOKだが、入口で選べるように）
    @users = User.order(created_at: :desc)

    # 直近の案件
    @recent_projects = Project.includes(:user).order(created_at: :desc).limit(10)

    # 期限が近い/超過タスク（業務っぽいポイント）
    @upcoming_tasks = Task.includes(project: :user)
      .where.not(due_date: nil)
      .where.not(status: Task.statuses[:done])
      .where("due_date <= ?", Date.current + 7.days)
      .order(due_date: :asc)
      .limit(20)

    # 未期限の未完タスク（後回しになりがちなので見せる）
    @no_due_tasks = Task.includes(project: :user)
      .where(due_date: nil)
      .where.not(status: Task.statuses[:done])
      .order(created_at: :desc)
      .limit(20)
  end
end
