module Api
  module V1
    class LocationsController < ApiController

      def index
        @user = current_user
        @locations = Location.find_in_radius(current_user.location)
        respond_with @locations
      end

      def show
        @location = Location.find_by(id: params[:id])
        respond_with @location
      end

      def create
        @location = Location.new(location_params)
        if @location.save
          current_user.location = @location
          render json: { success: true }, status: :ok
        else
          render json: {success: false}, status: :unprocessable_entity
        end
      end

      private
      def location_params
        params
          .require(:location)
          .permit(:lat, :lon)
      end

    end
  end
end
