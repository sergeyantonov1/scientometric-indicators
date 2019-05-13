class DashboardController < ApplicationController
  expose :selectable_authors, :fetch_selectable_authors
  expose :datasets, :fetch_datasets

  def index
    if fetch_datasets&.success?
      @datasets = fetch_datasets
    end
  end

  private

  def dashboard_params
    params[:dashboard]
  end

  def fetch_selectable_authors
    Author
      .order(:second_name, :first_name)
      .map { |author| [author.full_name, author.id] }
      .append(["Select authors", ""])
  end

  def dataset_params_exists?
    dashboard_params &&
      dashboard_params[:author_ids] &&
      dashboard_params[:profile_type]
  end

  def fetch_datasets
    return unless dataset_params_exists?

    @fetch_datasets ||= Chart::FetchDatasets.call(
      author_ids: dashboard_params[:author_ids],
      profile_type: dashboard_params[:profile_type]
    )
  end
end
