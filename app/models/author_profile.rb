class AuthorProfile < ApplicationRecord
  validates :profile_type, :profile_id, :h_index, :citations_count,
    :publications_count, presence: true

  validates :profile_type, inclusion: { in: Enumeration::CITATIONS_DATABASES }

  belongs_to :author
end
