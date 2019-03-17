class ScopusDataset
  include Interactor

  delegate :profile_type, :profile_ids, :profiles, :start_date, :end_date, to: :context

  def call
    
  end

  private

  def 
    [{
      label: 'Zuev Denis',
      data: [10, 20, 30, 40],
      type: 'line',
    }, {
      label: 'Mish',
      data: [35, 40, 20, 10],
      type: 'line'
    }, {
      label: 'Antonov',
      data: [35, 40, 20, 10],
      type: 'line'
    }
  ]
  end
end