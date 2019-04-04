class DashboardController < ApplicationController
  expose :selectable_authors, :fetch_selectable_authors

  def index
    if dataset_params?
      @result = Chart::FetchDatasets.call(
        start_date: dashboard_params[:start_date],
        end_date: dashboard_params[:end_date],
        author_ids: dashboard_params[:author_ids],
        profile_type: dashboard_params[:profile_type]
      )
    end
  end

  private

  def dashboard_params
    params[:dashboard]
  end

  def fetch_selectable_authors
    Author.all.map { |a| [a.full_name, a.id] }
  end

  def dataset_params?
    dashboard_params[:start_date] && dashboard_params[:end_date] && dashboard_params[:author_ids] && dashboard_params[:profile_type]
  end
end
