module Chart
  class GenerateDatasets
    include Interactor

    delegate :datasets, :labels, :author_ids, :profile_type, to: :context

    before do
      context.datasets = []
    end

    def call
      authors.each do |author|
        context.datasets = Chart::GenerateDataset.call(
          author: author,
          labels: labels,
          datasets: datasets,
          profile_type: profile_type
        ).datasets
      end
    end

    private

    def authors
      Author.where(id: author_ids)
    end
  end
end


