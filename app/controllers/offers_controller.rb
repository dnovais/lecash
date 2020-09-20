class OffersController < ApplicationController
  before_action :set_offer, only: :show

  def index
    @offers = Offer.enabled.ordered_premium
  end

  def show; end

  private
  
  def set_offer
    @offer = Offer.find(params[:id])
  end
end
