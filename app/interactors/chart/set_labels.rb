module Chart
  class SetLabels
    include Interactor

    delegate :start_date, :end_date, to: :context

    def call
      context.labels = labels
    end

    private

    def labels
      (start_date.to_i..end_date.to_i).to_a
    end
  end
end
