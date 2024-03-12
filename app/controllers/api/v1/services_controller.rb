class Api::V1::ServicesController < ApplicationController
  def index
    @services = Service.all
    render json: Api::V1::ServicesRepresenter.new(@services).as_json
  end

  private

  def service_params
    params.require(:post).permit(:name, :description, :min_cost, :image)
  end
end
