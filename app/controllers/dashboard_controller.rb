class DashboardController < ApplicationController
  def index
    # profile_type
    # profile_ids
    # profiles 
    # start_date
    # end_date

    # generate presenter
    #@presenter = DashboardPresenter.new(
     # profile_type: dashboard_params[:profile_type],
      #profile_ids: dashboard_params[:profile_ids],
      #profiles: dashboard_params[:profiles],
      #start_date: dashboard_params[:start_date],
      #end_date: dashboard_params[:end_date]
    #)

    #respond_with @presenter
  end

  private

  def dashboard_params
    params[:dashboard]
  end
end


# Выбираю аккаунты, откуда собирать инфу (скопус или вос), диапазон дат
# от каждого автора нужно: количество цитат, публикаций за определенный год
