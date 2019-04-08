class ScopusClient
  def self.authors(oid)
    HTTParty.get(
      "https://api.elsevier.com/content/search/author/",
      query: {
        query: "AF-ID(#{oid})SUBJAREA(MATH OR ENGI OR COMP OR MULT)",
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end

  def self.publications(auid, start_date = nil, end_date = nil)
    query = {
      query: "AU-ID(#{auid})",
      apiKey: ENV["SCOPUS_KEY"],
      sort: "+coverDate"
    }

    query.merge!(date: "#{start_date}-#{end_date}") if start_date && end_date

    HTTParty.get("https://api.elsevier.com/content/search/scopus/", query: query)
  end

  def self.author(pid)
    HTTParty.get(
      "https://api.elsevier.com/content/author",
      query: {
        author_id: pid,
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end

  def self.author_metrics(pid)
    HTTParty.get(
      "https://api.elsevier.com/content/author/author_id/#{pid}",
      query: {
        view: "metrics",
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end
end
