class Author < ApplicationRecord
  validates :organization, presence: true

  has_many :profiles, class_name: "AuthorProfile"

  belongs_to :organization
end
