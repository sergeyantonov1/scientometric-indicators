# app/jobs/sync_authors.rb

require "sidekiq-scheduler"

class SyncAuthors
  include Sidekiq::Worker

  def perform
    not_synced_authors.each do |author|
      Authors::Sync.call(author: author)
    end
  end

  private

  def not_synced_authors
    Author.where("synced_at <= ?", Time.now - 31.days)
  end
end

