class Scopus
  def self.authors(oid)
    HTTParty.get(
      "https://api.elsevier.com/content/search/author/",
      query: {
        query: "AF-ID(#{oid})SUBJAREA(MATH OR ENGI OR COMP OR MULT)",
        apiKey: ENV["SCOPUS_KEY"]
      }
    )
  end

  def self.publications(auid, start_date, end_date)
    HTTParty.get(
      "https://api.elsevier.com/content/search/scopus/",
      query: {
        query: "AU-ID(#{auid})",
        apiKey: ENV["SCOPUS_KEY"],
        sort: "+coverDate",
        date: "#{start_date}-#{end_date}"
      }
    )
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
end
