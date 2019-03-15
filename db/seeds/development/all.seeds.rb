FactoryGirl.create(:user, email: "user@example.com")

UNIVERITIES = [
  {
    name: "Kazan Federal University",
    profiles: {
      scopus: "60070941"
    }
  }
].freeze

UNIVERITIES.each do |university|
  organization = SeedLogging.call("Creating organization with #{university[:name]} name...") do
    FactoryGirl.create(:organization, name: university[:name])
  end

  university[:profiles].each do |k, v|
    SeedLogging.call("Creating #{k} profile for #{organization.name}...") do
      FactoryGirl.create(
        :organization_profile,
        organization: organization,
        profile_type: k,
        profile_id: v
      )
    end
  end

  @scopus_authors_response = Scopus.new(organization: "60070941").authors

  while @scopus_authors_response.present? do
    puts "---------------------------------------------------------------------"
    puts "LINKS #{@scopus_authors_response["search-results"]["link"]}"
    puts "---------------------------------------------------------------------"

    scopus_pagination = @scopus_authors_response["search-results"]["link"]
    scopus_authors = @scopus_authors_response["search-results"]["entry"]

    scopus_authors.each do |entry|
      scopus_helper = ScopusHelper.new(
        preferred_name: entry["preferred-name"],
        name_variant: entry["name-variant"]
      )

      name, surname = scopus_helper.parse_name

      SeedLogging.call("Creating #{name} #{surname} author in #{organization.name} organization...") do
        author = Author.new.tap do |a|
          a.first_name = name
          a.second_name = surname
          a.organization = organization
          a.orcid = entry["orcid"]

          a.save!
        end

        AuthorProfile.new.tap do |ap|
          ap.profile_type = "scopus"
          ap.profile_id = entry["dc:identifier"].remove("AUTHOR_ID:")
          ap.author = author

          ap.save!
        end
      end
    end

    scopus_pagination.each do |pag|
      if pag["@ref"] == "next"
        @scopus_authors_response = HTTParty.get(pag["@href"])

        break
      else
        @scopus_authors_response = nil
      end
    end
  end
end
