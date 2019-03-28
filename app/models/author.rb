class Author < ApplicationRecord
  validates :first_name, :second_name, :organization, presence: true

  has_many :profiles, class_name: "AuthorProfile", dependent: :destroy
  has_many :author_publications_infos, dependent: :destroy

  belongs_to :organization

  accepts_nested_attributes_for :profiles

  def full_name
    "#{first_name} #{second_name}"
  end
end
