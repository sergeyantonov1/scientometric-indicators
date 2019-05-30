# app/interactors/chart/fetch_datasets.rb

module Chart
  class FetchDatasets
    include Interactor::Organizer

    organize Chart::SetLabels, Chart::GenerateDatasets
  end
end

