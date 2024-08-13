class BusinessesController < ApplicationController
  def index
    @businesses = []
    begin
      @businesses = MyBusinessService.new(current_user).list_businesses
    rescue StandardError => e
      Rails.logger.error "Error fetching businesses: #{e.message}"
    end
  end

  def show
    @business_name = params[:id]
    @reviews = []
    begin
      @reviews = MyBusinessService.new(current_user).get_reviews("accounts/#{@business_name}")
    rescue StandardError => e
      Rails.logger.error "Error fetching reviews for #{@business_name}: #{e.message}"
    end
  end
end
