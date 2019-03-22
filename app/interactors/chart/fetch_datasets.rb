module Chart
  class FetchDatasets
    include Interactor::Organizer

    organize Chart::SetLabels, ScopusClient::ParsePublications, Chart::GenerateDatasets
  end
end
