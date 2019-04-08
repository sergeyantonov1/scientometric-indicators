module Chart
  class GenerateDataset
    include Interactor

    delegate :author, :labels, :profile_type, :datasets, to: :context

    def call
      profile = author.profiles.find_by(profile_type: profile_type)
      datas = generate_datas

      datasets << publications_dataset(datas[:publications])
      datasets << citations_dataset(datas[:citations])
    end

    private

    def publications_dataset(data)
      {
        label: "#{author.full_name}'s publications",
        data: data,
        type: "bar",
        borderColor: random_border_color,
        backgroundColor: random_background_color,
        borderWidth: 1
      }
    end

    def citations_dataset(data)
      {
        label: "#{author.full_name}'s citations",
        data: data,
        type: "line",
        borderColor: random_border_color,
        backgroundColor: "rgba(255,255,255,0.5)",
        borderWidth: 1
      }
    end

    def generate_datas
      return [] unless profile = author.profiles.find_by(profile_type: profile_type)

      datas = publications_as_hash(profile)

      publications_count = []
      citations_count = []

      labels.each do |label|
        label = label.to_s

        if datas.key?(label)
          publications_count << datas[label][:publications_count]
          citations_count << datas[label][:citations_count]
        else
          publications_count << 0
          citations_count << 0
        end
      end

      { publications: publications_count, citations: publications_count }
    end

    def publications_as_hash(profile)
      publications_as_hash = {}

      profile.publications.each do |publ|
        publications_as_hash[publ.year] = {
          publications_count: publ.publications_count,
          citations_count: publ.citations_count
        }
      end

      publications_as_hash
    end

    def random_border_color
      "##{SecureRandom.hex(3)}"
    end

    def random_background_color
      r, g, b = rand(255), rand(255), rand(255)

      "rgba(#{r}, #{g}, #{b}, 0.2)"
    end
  end
end
