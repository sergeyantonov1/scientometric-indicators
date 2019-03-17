class DashboardPresenter

  attr_reader :author_ids, :profile_types, :start_date, :end_date

  def initialize(params)
    @profile_type = params[:profile_type]
    @profile_ids = params[:profile_ids]
    @profiles = params[:profiles]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
  end

  def date_range
    (@start_date..@end_date).to_a
  end

  def clean_dataset
    @dataset ||= []

    add_publications
    add_citations
  end

  private

  def generate_dataset
    GenerateDataset.call(
      profile_type: profile_type,
      profile_ids: profile_ids,
      profiles: profiles,
      start_date: start_date,
      end_date: end_date
    )
  end

  def random_color
    "#" + SecureRandom.hex(3)
  end
end

authors.each do |author|
  @object << author.publications # request to scopus

  [{
      label: 'Zuev Denis',
      data: [10, 20, 30, 40],
      type: 'line',
    }, {
      label: 'Mish',
      data: [35, 40, 20, 10],
      type: 'line'
    }, {
      label: 'Antonov',
      data: [35, 40, 20, 10],
      type: 'line'
    }
  ]

  date_range

  # generate object
  # [
  #   {
  #     author: "author_id",
  #     publications: {
  #       2014: {
  #         citedby: 10,
  #         count: 10
  #       },
  #       2015: {
  #         citedby: 10,
  #         count: 10
  #       },
  #     }
  #   }
  # ]


end

class HZ
  attr_reader :result

  def initialize(json)
    @result = json["search-results"]
  end


end



{"search-results"=>
  {"opensearch:totalResults"=>"9",
   "opensearch:startIndex"=>"0",
   "opensearch:itemsPerPage"=>"9",
   "opensearch:Query"=>{"@role"=>"request", "@searchTerms"=>"AU-ID(56145074600)", "@startPage"=>"0"},
   "link"=>
    [{"@_fa"=>"true",
      "@ref"=>"self",
      "@href"=>"https://api.elsevier.com/content/search/scopus?start=0&count=25&query=AU-ID%2856145074600%29&apiKey=c73a937acb5fac097389ebbe35948d51",
      "@type"=>"application/json"},
     {"@_fa"=>"true",
      "@ref"=>"first",
      "@href"=>"https://api.elsevier.com/content/search/scopus?start=0&count=25&query=AU-ID%2856145074600%29&apiKey=c73a937acb5fac097389ebbe35948d51",
      "@type"=>"application/json"}],
   "entry"=>
    [{"@_fa"=>"true",
      "link"=>
       [{"@_fa"=>"true", "@ref"=>"self", "@href"=>"https://api.elsevier.com/content/abstract/scopus_id/85058176774"},
        {"@_fa"=>"true", "@ref"=>"author-affiliation", "@href"=>"https://api.elsevier.com/content/abstract/scopus_id/85058176774?field=author,affiliation"},
        {"@_fa"=>"true", "@ref"=>"scopus", "@href"=>"https://www.scopus.com/inward/record.uri?partnerID=HzOxMe3b&scp=85058176774&origin=inward"},
        {"@_fa"=>"true", "@ref"=>"scopus-citedby", "@href"=>"https://www.scopus.com/inward/citedby.uri?partnerID=HzOxMe3b&scp=85058176774&origin=inward"}],
      "prism:url"=>"https://api.elsevier.com/content/abstract/scopus_id/85058176774",
      "dc:identifier"=>"SCOPUS_ID:85058176774",
      "eid"=>"2-s2.0-85058176774",
      "dc:title"=>"Services for formation of digital documents metadata in the formats of international science-based databases",
      "dc:creator"=>"Elizarov A.",
      "prism:publicationName"=>"CEUR Workshop Proceedings",
      "prism:issn"=>"16130073",
      "prism:volume"=>"2260",
      "prism:pageRange"=>"175-185",
      "prism:coverDate"=>"2018-01-01",
      "prism:coverDisplayDate"=>"2018",
      "citedby-count"=>"0",
      "affiliation"=>
       [{"@_fa"=>"true", "affilname"=>"Kazan Federal University", "affiliation-city"=>"Kazan", "affiliation-country"=>"Russian Federation"},
        {"@_fa"=>"true", "affilname"=>"Kazan Federal University", "affiliation-city"=>"Kazan", "affiliation-country"=>"Russian Federation"}],
      "prism:aggregationType"=>"Conference Proceeding",
      "subtype"=>"cp",
      "subtypeDescription"=>"Conference Paper",
      "source-id"=>"21100218356",
      "openaccess"=>"0",
      "openaccessFlag"=>false},
     {"@_fa"=>"true",
      "link"=>
       [{"@_fa"=>"true", "@ref"=>"self", "@href"=>"https://api.elsevier.com/content/abstract/scopus_id/85058175648"},
        {"@_fa"=>"true", "@ref"=>"author-affiliation", "@href"=>"https://api.elsevier.com/content/abstract/scopus_id/85058175648?field=author,affiliation"},
        {"@_fa"=>"true", "@ref"=>"scopus", "@href"=>"https://www.scopus.com/inward/record.uri?partnerID=HzOxMe3b&scp=85058175648&origin=inward"},
