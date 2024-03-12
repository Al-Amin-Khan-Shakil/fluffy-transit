class Api::V1::ServicesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @services = Service.all
    render json: Api::V1::ServicesRepresenter.new(@services).as_json
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      render json: { data: 'Service was added successfully', status: 'success' }, status: :created
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def service_params
    params.require(:post).permit(:name, :description, :min_cost, :image)
  end
end
