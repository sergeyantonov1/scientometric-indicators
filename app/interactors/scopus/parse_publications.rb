module Scopus
  class ParsePublications
    include Interactor

    delegate :profile, :publications_info, to: :context

    before do
      context.publications_info = {}
    end

    def call
      parse_publications
    end

    private

    def parse_publications
      response = ScopusClient.publications(profile.profile_id)

      while response do
        return if empty_response(response)

        parse_response(response)

        response = next_response(response)
      end
    end

    def parse_response(response)
      response["search-results"]["entry"].each do |entry|
        year = entry["prism:coverDate"].to_date.year
        publications_info[year] = { citations: 0, publications: 0 } unless publications_info.key?(year)

        publications_info[year][:citations] += entry["citedby-count"].to_i
        publications_info[year][:publications] += 1
      end
    end

    def next_response(response)
      response["search-results"]["link"].each do |link|
        return HTTParty.get(link["@href"]) if link["@ref"] == "next"
      end

      nil
    end

    def empty_response(response)
      response["search-results"]["entry"].first["error"]
    end
  end
end
