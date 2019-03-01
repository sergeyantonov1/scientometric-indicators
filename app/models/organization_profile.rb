class OrganizationProfile < ApplicationRecord
  validates :profile_type, :profile_id, :organization, presence: true
  validates :profile_type, inclusion: { in: Enumeration::CITATIONS_DATABASES }

  belongs_to :organization
end
