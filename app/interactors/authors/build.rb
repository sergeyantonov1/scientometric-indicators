module Authors
  class Build
    include Interactor

    delegate :author_params, :author, to: :context

    def call
      context.author = Author.new(author_params)

      context.fail! if author.invalid?
    end
  end
end
