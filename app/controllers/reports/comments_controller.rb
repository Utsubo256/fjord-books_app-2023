# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  private

  def set_commentable
    @commentable = @report = Report.find(params[:report_id])
  end

  def commentable_show
    'reports/show'
  end
end
