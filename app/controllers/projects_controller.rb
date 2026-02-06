class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects/1
  def show
    @status = params[:status].presence

    scope = @project.tasks

    if @status && Task.statuses.key?(@status)
      scope = scope.where(status: Task.statuses[@status])
    end

    @tasks = scope
      .order(Arel.sql("CASE WHEN due_date IS NULL THEN 1 ELSE 0 END ASC"))
      .order(due_date: :asc)
      .order(created_at: :desc)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
