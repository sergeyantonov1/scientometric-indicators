class Scopus
  include HTTParty

  def organization_authors(org_id)
    HTTParty.get("https://api.elsevier.com/content/search/author")
  end
end
