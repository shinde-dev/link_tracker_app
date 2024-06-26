# frozen_string_literal: true

class Api::V1::StoreUrlsController < Api::V1Controller
  def create
    @store_url = StoreUrl::Create.call(create_params[:url], create_params[:client_id])
    if @store_url.valid?
      render :show, status: :created
    else
      render json: { errors: @store_url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @store_url = StoreUrl.find_by(tracking_code: params[:tracking_code])
    if @store_url
      render :show, status: :ok
    else
      render json: { errors: 'Tracking code not found' }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:store_url).permit(:url, :client_id)
  end
end
