class Admin::OffersController < Admin::ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :switch_state, :destroy]

  def index
    @offers = Offer.all
    @offers = @offers.order(:id).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to admin_offers_url, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end
  
  def edit; end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to admin_offers_url, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def switch_state
    @offer.enabled? ? @offer.disable_offer! : @offer.enable_offer!
  
    respond_to do |format|
      format.html { redirect_to admin_offers_url, notice: "Offer was successfully #{@offer.state}" }
      format.json { head :no_content }
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to admin_offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:advertiser_name, :url, :role, :description, :starts_at, :ends_at, :premium, :state)
  end
end
