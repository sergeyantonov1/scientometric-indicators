class ParsePublications
  include Interactor

  delegate :author_id, to: :context

  def call
  end

  def make_request
    publication_entry ||= ScopusPublicationEntry.new(author, total_search)
    response = Scopus.publications(author_id: author)

    total_search = response["search-results"]["opensearch:totalResults"]

    response["search-results"]["entry"].each do |entry|
      publication_entry.add_publication(entry["prism:coverDisplayDate"], entry["citedby-count"])
    end
  end

  def next_page
  end
end


ParsePublications.call(author_id: author_profile.profile_id)

# сделать запрос на первую страницу
# добавить инфу куда-то

ScopusEntry.new(
  author_id: id,
  publications_count: total_search
)
