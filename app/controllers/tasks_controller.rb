class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks
  def index
    @status = params[:status].presence

    scope = Task.includes(:project)

    # 絞り込み（status=todo/doing/done のみ許可）
    if @status && Task.statuses.key?(@status)
      scope = scope.where(status: Task.statuses[@status])
    end

    # 並び順：期限ありを先に、due_date昇順 → 同日なら新しい順
    # due_dateがnilは最後に回す（DB差異があるのでRuby側で安全に）
    @tasks = scope
      .order(Arel.sql("CASE WHEN due_date IS NULL THEN 1 ELSE 0 END ASC"))
      .order(due_date: :asc)
      .order(created_at: :desc)
  end

  def new
  @task = Task.new(project_id: params[:project_id])
end


  private

  def set_task
    @task = Task.find(params[:id])
  end
end
