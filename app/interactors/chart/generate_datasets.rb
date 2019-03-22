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
        color = random_color

        datasets << generate_dataset(raw_dataset: r_d, type: :citations, color: color)
        datasets << generate_dataset(raw_dataset: r_d, type: :publications, color: color)
      end

      datasets
    end

    def generate_dataset(raw_dataset:, type:, color:)
      data = []

      labels.each do |label|
        data << raw_dataset[label][type]
      end

      {
        label: "#{raw_dataset[:full_name]} #{type}",
        data: data,
        type: type == :citations ? "line" : "bar",
        borderColor: color,
        backgroundColor: "rgba(0, 0, 0, 0)"
      }
    end

    def random_color
      "#%06x" % (rand * 0xffffff)
    end
  end
end
