class Author < ApplicationRecord
  has_many :profiles, class_name: "AuthorProfile", dependent: :destroy

  belongs_to :organization

  accepts_nested_attributes_for :profiles

  validates :first_name, :second_name, :organization, presence: true

  def full_name
    "#{second_name} #{first_name}"
  end
end
