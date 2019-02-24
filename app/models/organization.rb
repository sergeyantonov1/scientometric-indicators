class Organization < ApplicationRecord
  validates :name, :scopus_id, presence: true
  validates :name, :scopus_id, uniqueness: true
end