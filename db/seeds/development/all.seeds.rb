# FactoryGirl.create(:user, email: "user@example.com")

UNIVERITIES = [
  {
    name: "Высшая школа информационных технологий и интеллектуальных систем",
    profiles: [
      {
        profile_type: "scopus",
        profile_id: "60070941"
      }
    ],
    authors: [
      {
        first_name: "Денис",
        second_name: "Зуев",
        middle_name: "Сергеевич",
        orcid: "0000-0001-9651-6156",
        profiles: [
          {
            profile_type: "scopus",
            profile_id: "56145074600",
            h_index: 3,
            publications_infos: [
              {
                publications_count: 1,
                citations_count: 0,
                year: "2012"
              },
              {
                publications_count: 1,
                citations_count: 0,
                year: "2013"
              },
              {
                publications_count: 3,
                citations_count: 4,
                year: "2014"
              },
              {
                publications_count: 2,
                citations_count: 10,
                year: "2017"
              },
              {
                publications_count: 2,
                citations_count: 2,
                year: "2018"
              },
              {
                publications_count: 1,
                citations_count: 1,
                year: "2019"
              }
            ]
          },
          {
            profile_type: "wos",
            profile_id: "E-4348-2017",
            h_index: 3,
            publications_infos: [
              {
                publications_count: 2,
                citations_count: 1,
                year: "2014"
              }
            ]
          }
        ]
      },
      {
        first_name: "Михаил",
        second_name: "Абрамский",
        middle_name: "Михайлович",
        orcid: "0000-0003-3063-8948",
        profiles: [
          {
            profile_type: "scopus",
            profile_id: "57194198144",
            h_index: 2,
            publications_infos: [
              {
                publications_count: 1,
                citations_count: 0,
                year: "2017"
              },
              {
                publications_count: 1,
                citations_count: 4,
                year: "2018"
              },
              {
                publications_count: 0,
                citations_count: 2,
                year: "2019"
              }
            ]
          },
          {
            profile_type: "wos",
            profile_id: "B-1109-2016",
            h_index: 0,
            publications_infos: []
          }
        ]
      },
      {
        first_name: "Айрат",
        second_name: "Хасьянов",
        middle_name: "Фаридович",
        orcid: "0000-0002-1819-593X",
        profiles: [
          {
            profile_type: "scopus",
            profile_id: "57195319433",
            h_index: 0,
            publications_infos: [
              {
                publications_count: 1,
                citations_count: 0,
                year: "2016"
              }
            ]
          },
          {
            profile_type: "wos",
            profile_id: "K-8491-2017",
            h_index: 0,
            publications_infos: []
          }
        ]
      }
    ]
  }
].freeze

UNIVERITIES.each do |university|
  organization = FactoryGirl.create(:organization, name: university[:name])

  university[:profiles].each do |profile_attrs|
    FactoryGirl.create(
      :organization_profile,
      profile_attrs.merge(organization: organization)
    )
  end

  university[:authors].each do |author_attrs|
    author = FactoryGirl.create(
      :author,
      author_attrs.merge(organization: organization).except(:profiles)
    )

    author_attrs[:profiles].each do |profile_attrs|
      profile = FactoryGirl.create(
        :author_profile,
        profile_attrs.merge(author: author).except(:publications_infos)
      )

      profile_attrs[:publications_infos].each do |pub_info|
        FactoryGirl.create(
          :publications_info,
          pub_info.merge(author_profile: profile)
        )
      end
    end
  end
end



# UNIVERITIES.each do |university|
#   organization = SeedLogging.call("Creating organization with #{university[:name]} name...") do
#     FactoryGirl.create(:organization, name: university[:name])
#   end

#   university[:profiles].each do |k, v|
#     SeedLogging.call("Creating #{k} profile for #{organization.name}...") do
#       FactoryGirl.create(
#         :organization_profile,
#         organization: organization,
#         profile_type: k,
#         profile_id: v
#       )
#     end
#   end

#   @scopus_authors_response = Scopus.authors(60070941)

#   while @scopus_authors_response.present? do
#     puts "---------------------------------------------------------------------"
#     puts "LINKS #{@scopus_authors_response["search-results"]["link"]}"
#     puts "---------------------------------------------------------------------"

#     scopus_pagination = @scopus_authors_response["search-results"]["link"]
#     scopus_authors = @scopus_authors_response["search-results"]["entry"]

#     scopus_authors.each do |entry|
#       scopus_helper = ScopusHelper.new(
#         preferred_name: entry["preferred-name"],
#         name_variant: entry["name-variant"]
#       )

#       name, surname = scopus_helper.parse_name

#       SeedLogging.call("Creating #{name} #{surname} author in #{organization.name} organization...") do
#         author = Author.new.tap do |a|
#           a.first_name = name
#           a.second_name = surname
#           a.organization = organization
#           a.orcid = entry["orcid"]

#           a.save!
#         end

#         AuthorProfile.new.tap do |ap|
#           ap.profile_type = "scopus"
#           ap.profile_id = entry["dc:identifier"].remove("AUTHOR_ID:")
#           ap.author = author

#           ap.save!
#         end
#       end
#     end

#     scopus_pagination.each do |pag|
#       if pag["@ref"] == "next"
#         @scopus_authors_response = HTTParty.get(pag["@href"])

#         break
#       else
#         @scopus_authors_response = nil
#       end
#     end
#   end
# end
