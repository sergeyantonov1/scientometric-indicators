class DashboardController < ApplicationController
  def index
    @presenter = DashboardPresenter.new(
      author_ids: params[:author_ids],
      profile_types: params[:profile_types],
      start_date: params[:start_date],
      end_date: params[:end_date]
    )

    respond_with @presenter
  end
end


# Выбираю аккаунты, откуда собирать инфу (скопус или вос), диапазон дат
# от каждого автора нужно: количество цитат, публикаций за определенный год
