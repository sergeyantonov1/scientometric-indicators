module Authors
  class Save
    include Interactor

    delegate :author, :publications_info, to: :context

    def call
      build_publications_infos
      author.save!
    end

    private

    def build_publications_infos
      return unless publications_infos_attributes.present?

      author.author_publications_infos.build(publications_infos_attributes)
    end

    def publications_infos_attributes
      publications_infos_attributes = {}

      publications_info.each do |profile_type, data|
        next unless data.present?

        data.each do |year, counts|
          publications_infos_attributes.merge!({
            year: year,
            profile_type: profile_type,
            publications_count: counts[:publications],
            citations_count: counts[:citations]
          })
        end
      end

      publications_infos_attributes
    end
  end
end
