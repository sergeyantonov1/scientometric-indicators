class Scopus
  def self.authors(params)
    HTTParty.get(
      "https://api.elsevier.com/content/search/author/",
      query: {
        query: "AF-ID(#{params[:organization_id]})SUBJAREA(MATH OR ENGI OR COMP OR MULT)",
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end

  def self.publications(params)
    HTTParty.get(
      "https://api.elsevier.com/content/search/scopus/",
      query: {
        query: "AU-ID(#{params[:author_id]})",
        apiKey: ENV["SCOPUS_KEY"],
        sort: "+coverDate"
      }
    )
  end
end
