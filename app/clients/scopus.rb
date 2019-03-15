class Scopus
  include HTTParty

  base_uri "api.elsevier.com"

  DEFAULT_SORT = "-document-count".freeze

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def authors
    self.class.get(
      "/content/search/author/",
      query: {
        sort: params[:sort] || DEFAULT_SORT,
        query: "AF-ID(#{params[:organization]})SUBJAREA(MATH OR ENGI OR COMP OR MULT)",
        start: params[:start] || 0,
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end
end
