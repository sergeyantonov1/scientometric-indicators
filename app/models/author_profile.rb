class AuthorProfile < ApplicationRecord
  has_many :publications, dependent: :destroy, class_name: "PublicationsInfo"

  validates :profile_type, :profile_id, presence: true

  validates :profile_type, inclusion: { in: Enumeration::CITATIONS_DATABASES }

  belongs_to :author
end
