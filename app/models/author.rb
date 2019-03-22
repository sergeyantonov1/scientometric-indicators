class Author < ApplicationRecord
  validates :first_name, :second_name, :organization, presence: true

  has_many :profiles, class_name: "AuthorProfile"

  belongs_to :organization

  accepts_nested_attributes_for :profiles

  def full_name
    "#{first_name} #{second_name}"
  end
end
