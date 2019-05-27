# app/clients/scopus_client.rb

class ScopusClient
  def self.publications(auid, start_date = nil, end_date = nil)
    query = {
      query: "AU-ID(#{auid})",
      apiKey: ENV["SCOPUS_KEY"],
      sort: "+coverDate"
    }

    query.merge!(date: "#{start_date}-#{end_date}") if start_date && end_date

    HTTParty.get(
      "https://api.elsevier.com/content/search/scopus/",
      query: query
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

