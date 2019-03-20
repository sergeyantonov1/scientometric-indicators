class ScopusHelper
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def next_page
    response["search-results"]["link"].each do |link|
      return link["@href"] if link["@ref"] == "next"
    end

    nil
  end
end
