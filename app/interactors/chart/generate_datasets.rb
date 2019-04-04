module Chart
  class GenerateDatasets
    include Interactor

    delegate :datasets, :labels, :profile_type, to: :context

    def call
      authors = Author.where(id: author_ids)
      datasets = []

      authors.each do |author|
        pr = author.profiles.where(profile_type: profile_type)&.first
        byebug
        generate_datasets(pr) if pr
      end
    end

    private

    def author_ids
      @author_ids ||= context.author_ids.delete("")
    end

    def generate_datasets(profile)
      datas = generate_data(profile)

      %i[publications citations].each do |type|
        datasets << generate_dataset(profile.author.full_name, datas[type], type)
      end
    end

    def generate_dataset(author:, data:, type:)
      {
        label: "#{profile.author.full_name} #{type}",
        data: data,
        type: type == :citations ? "line" : "bar",
        borderColor: color
      }
    end

    def generate_data(profile)
      publications = profile.publications.where(year: labels)
      publications_count = []
      citations_count = []

      labels.each do |label|
        pub = publications.find_by(year: label)

        publications_count << pub&.publications_count || 0
        citations_count << pub&.citations_count || 0
      end

      { publications: publications_count, citations: citations_count }
    end

    def random_color
      "#%06x" % (rand * 0xffffff)
    end
  end
end
