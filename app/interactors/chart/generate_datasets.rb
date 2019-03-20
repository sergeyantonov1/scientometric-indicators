module Chart
  class GenerateDatasets
    include Interactor

    delegate :raw_datasets, :labels, to: :context

    def call
      context.datasets = handle_datasets
    end

    private

    def handle_datasets
      datasets = []

      raw_datasets.each do |r_d|
        datasets << generate_dataset(raw_dataset: r_d, type: :citations)
        datasets << generate_dataset(raw_dataset: r_d, type: :publications)
      end

      datasets
    end

    def generate_dataset(raw_dataset:, type:)
      data = []

      labels.each do |label|
        data << raw_dataset[label][type]
      end

      {
        label: "#{raw_dataset[:full_name]} #{type}",
        data: data,
        type: type == :citations ? "line" : "bar"
      }
    end
  end
end
