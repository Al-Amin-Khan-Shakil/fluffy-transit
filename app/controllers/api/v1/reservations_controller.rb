class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:service)
    render json: Api::V1::ReservationsRepresenter.new(@reservations).as_json
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      render json: { data: 'Reservation is added successfully', status: 'success' }, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @reservation = Reservation.find(params[:id])

    if current_user = @reservation.user || current_user.admin?
      if @reservation.update(reservation_params)
        render json: { data: 'Reservation is updated successfully', status: 'success'}, status: :ok
      else
        render json: {errors: @reservation.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to update this reservation' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    if current_user = @reservation.user || current_user.admin?
      if @reservation.destroy
        render json: { data: 'Reservation is deleted successfully', status: 'success' }, status: :ok
      else
        render json: { errors: @reservation.errors.full_messages }
      end
    else
      render json: { error: 'You are not authorized to delete this reservation' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  private

  def reservation_params
    params.require(:reservation).permit(:pickup_address, :drop_address, :description, :contact, :pickup_date, :client_name, :pet_amount, :warning_message, :service_id)
  end
end
