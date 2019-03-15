class ScopusPublicationEntry
  attr_reader :author_id, :pub_count, :publications

  def initialize(author_id, pub_count)
    @author_id = author_id
    @pub_count = pub_count
    @publications = {}
  end

  def add_publication(year, cited_by)
    publications[year] = { cited_by: 0, count: 0 } unless publications.key?(year)

    publications[year][:cited_by] += cited_by
    publications[year][:count] += 1
  end
end
