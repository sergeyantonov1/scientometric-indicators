module ScopusClient1
  class ParsePublications
    include Interactor

    delegate :author_ids, :start_date, :end_date, :labels, :auid, to: :context

    def call
      context.raw_datasets = raw_datasets
    end

    private

    def scopus_author_ids
      AuthorProfile
        .where(author: author_ids, profile_type: "scopus")
        .pluck(:profile_id)
    end

    def raw_datasets
      raw_datasets = []

      scopus_author_ids.each do |auid|
        context.auid = auid
        context.response = ScopusClient.publications(auid, start_date, end_date)

        raw_datasets << init_dataset && next if empty_result_error

        raw_datasets << raw_dataset
      end

      raw_datasets
    end

    def raw_dataset
      raw_dataset = init_dataset

      while context.response do
        raw_dataset = add_response_data(raw_dataset)

        context.response = next_link ? HTTParty.get(next_link) : nil
      end

      raw_dataset
    end

    def add_response_data(raw_dataset)
      context.response["search-results"]["entry"].each do |entry|

        year = entry["prism:coverDate"].to_date.year

        raw_dataset[year][:citations] += entry["citedby-count"].to_i
        raw_dataset[year][:publications] += 1
      end

      raw_dataset
    end

    def author_full_name
      AuthorProfile
        .find_by(profile_id: auid)
        .author
        .full_name
    end

    def init_dataset
      init_dataset = { full_name: author_full_name }

      labels.each do |label|
        init_dataset[label] = { citations: 0, publications: 0 }
      end

      init_dataset
    end

    def next_link
      context.response["search-results"]["link"].each do |link|
        return link["@href"] if link["@ref"] == "next"
      end

      nil
    end

    def empty_result_error
      context.response["search-results"]["entry"].first["error"]
    end
  end
end
