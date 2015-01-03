class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all
  end
  def create
    auction = Auction.new(auction_params)
    if auction.save
      render json: {status: "saved"}, status: 201
    else
      render json: { errors: auction.errors.full_messages }, status: 422
    end
  end
  def destroy
    begin
      auction = Auction.find(params[:id])
      auction.delete
      flash[:success] = "Auction deleted!"
    rescue
      flash[:danger] = "Couldn't delete auction with id #{params[:id]}!"
    end
    redirect_to auctions_path
  end

  private

  def auction_params
    params.require(:auction).permit(:name, :url)
  end
end
