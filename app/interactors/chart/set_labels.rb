# app/interactors/chart/set_labels.rb

module Chart
  class SetLabels
    include Interactor

    # delegate :start_date, :end_date, to: :context

    def call
      # context.fail! if start_date > end_date

      context.labels = labels
    end

    private

    def labels
      ((current_year - 9)..current_year).to_a
    end

    def current_year
      Date.current.year
    end
  end
end

