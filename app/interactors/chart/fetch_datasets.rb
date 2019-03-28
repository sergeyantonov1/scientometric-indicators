module Chart
  class FetchDatasets
    include Interactor::Organizer

    organize Chart::SetLabels, ScopusClient1::ParsePublications, Chart::GenerateDatasets
  end
end
