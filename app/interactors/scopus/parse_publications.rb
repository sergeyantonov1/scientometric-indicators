module Scopus
  class ParsePublications
    include Interactor

    delegate :profile, :profile_publications, to: :context

    before do
      context.profile_publications = {}
    end

    def call
      parse_profile_publications
    end

    private

    def parse_profile_publications
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
        profile_publications[year] = { citations: 0, publications: 0 } unless profile_publications.key?(year)

        profile_publications[year][:citations] += entry["citedby-count"].to_i
        profile_publications[year][:publications] += 1
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
