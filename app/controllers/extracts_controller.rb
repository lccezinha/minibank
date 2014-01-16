require 'ostruct'
class ExtractsController < ApplicationController
  layout 'home'

  def index
    @extract = OpenStruct.new
    # @start_date = params[:start_date]
    # @end_date = params[:end_date]


  end

end