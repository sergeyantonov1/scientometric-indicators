class Organization < ApplicationRecord
  validates :name, presence: true

  has_many :profiles, class_name: "OrganizationProfile"
end
