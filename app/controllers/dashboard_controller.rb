class DashboardController < ApplicationController
  def index
    @result = Chart::FetchDatasets.call(
      author_ids: params[:author_ids],
      start_date: params[:start_date],
      end_date: params[:end_date]
    )
  end
end
