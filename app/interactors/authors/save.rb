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
      author.profiles.each do |profile|
        publications_info_attributes = publications_info_attributes(profile)

        next unless publications_info_attributes.present?

        profile.publications.build(publications_info_attributes)
      end
    end

    def publications_info_attributes(profile)
      publications_info_attributes = []

      publications_info[profile.profile_type].each do |year, counts|
        publications_info_attributes << {
          year: year,
          publications_count: counts[:publications],
          citations_count: counts[:citations]
        }
      end

      publications_info_attributes
    end
  end
end
