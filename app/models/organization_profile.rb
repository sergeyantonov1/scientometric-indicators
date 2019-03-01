class OrganizationProfile < ApplicationRecord
  PROFILE_TYPES = %w(scopus wos elibrary).freeze

  validates :profile_type, :profile_id, :organization, presence: true
  validates :profile_type, inclusion: { in: PROFILE_TYPES }

  belongs_to :organization
end
