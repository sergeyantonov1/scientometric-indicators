class DashboardController < ApplicationController
  def index
    if dashboard_params
      @result = Chart::FetchDatasets.call(
        author_ids: dashboard_params[:profile_ids].split(", "),
        start_date: dashboard_params[:start_date],
        end_date: dashboard_params[:end_date]
      )
    end
  end

  private

  def dashboard_params
    params[:dashboard]
  end
end
