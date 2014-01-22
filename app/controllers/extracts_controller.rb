class ExtractsController < ApplicationController
  layout 'home'

  def new
    @extract = Extract.new
  end

  def index
    extract = Extract.new params[:extract]
    @movimentations = Movimentation.by_period extract.start_date, extract.end_date,
      current_user.account
    respond_with @movimentations, location: extracts_path
  end
end