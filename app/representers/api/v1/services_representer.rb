module Api
  module V1
    class ServicesRepresenter
      def initialize(services)
        @services = services
      end

      def as_json
        @services.map do |service|
          {
            id: service.id,
            name: service.name,
            description: service.description,
            min_cost: service.min_cost,
            image: service.image_url
          }
        end
      end

      private

      attr_reader :services
    end
  end
end
