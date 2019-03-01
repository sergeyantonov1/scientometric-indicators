class Author < ApplicationRecord
  validates :first_name, :second_name, :organization, presence: true

  has_many :profiles, class_name: "AuthorProfile"

  belongs_to :organization
end
