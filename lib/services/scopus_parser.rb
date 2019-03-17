class ScopusParser
  attr_reader :result

  def initialize(json)
    @result = json["search-results"]
  end

  def sync_authors
  end

  def next_page
    result["links"].each do |link|
      return link["@href"] if link["@ref"] == "next"
    end
  end
end
