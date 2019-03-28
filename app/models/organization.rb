class Organization < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :authors, dependent: :destroy
  has_many :profiles, class_name: "OrganizationProfile", dependent: :destroy

  accepts_nested_attributes_for :profiles
end
