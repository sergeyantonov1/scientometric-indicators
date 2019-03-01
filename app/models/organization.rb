class Organization < ApplicationRecord
  validates :name, presence: true

  has_many :authors
  has_many :profiles, class_name: "OrganizationProfile"
end
