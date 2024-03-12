class Api::V1::ServicesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @services = Service.all
    render json: Api::V1::ServicesRepresenter.new(@services).as_json
  end

  def show
    @service = Service.find(params[:id])
    render json: Api::V1::ServicesRepresenter.new(@service).as_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Service not found' }, status: :not_found
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      render json: { data: 'Service was added successfully', status: 'success' }, status: :created
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @service = current_user.services.find(params[:id])

    if @service.update(service_params)
      render json: { data: 'Service was updated successfully', status: 'success' }, status: :ok
    else
      render json: { errors: @service.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Service not found' }, status: :not_found
  end

  private

  def service_params
    params.require(:post).permit(:name, :description, :min_cost, :image)
  end
end
