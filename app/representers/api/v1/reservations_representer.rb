module Api
  module V1
    class ReservationsRepresenter
      def initialize(reservations)
        @reservations = reservations
      end

      def as_json
        @reservations.map do |reservation|
          {
            id: reservation.id,
            pickup_address: reservation.pickup_address,
            drop_address: reservation.drop_address,
            description: reservation.description,
            contact: reservation.contact,
            pickup_date: reservation.pickup_date,
            client_name: reservation.client_name,
            pet_amount: reservation.pet_amount,
            warning_message: reservation.warning_message,
            pending: reservation.pending,
            on_way: reservation.on_way,
            fulfilled: reservation.fulfilled,
            total_cost: reservation.total_cost,
            service_image: reservation.service.image_url,
            service_name: reservation.service.name
          }
        end
      end
    end
  end
end