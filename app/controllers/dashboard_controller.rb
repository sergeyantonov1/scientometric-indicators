class DashboardController < ApplicationController
  expose :selectable_authors, :fetch_selectable_authors

  def index
    @result = Chart::FetchDatasets.call(
      start_date: params[:start_date],
      end_date: params[:end_date] || "2010",
      author_ids: params[:author_ids] || "2019"
    )
  end

  private

  def fetch_selectable_authors
    Author.all.map { |a| [a.full_name, a.id] }
  end
end
