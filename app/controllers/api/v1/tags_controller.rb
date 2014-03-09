module Api
  module V1
    class TagsController < ApiController
      skip_before_filter :api_authorize, only: [:index, :show]

      def index
        respond_with Tag.all
      end

      def show
        @tag = Tag.find_by(id: params[:id])
        respond_with @tag
      end

    end
  end

end
