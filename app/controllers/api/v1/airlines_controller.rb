module Api
  module V1
    class AirlinesController < ApplicationController
      def index
        @airlines = Airline.all

        render json: AirlineSerializer.new(@airlines, options).as_json
      end

      def show
        @airline = Airline.find_by(slug: params[:slug])

        render json: AirlineSerializer.new(@airline, options).as_json
      end

      def create
        @airline = Airline.new(airline_params)

        if @airline.save
          render json: AirlineSerializer.new(@airline).as_json
        else
          render json: { error: @airline.errors.messages }, status: 404
        end
      end

      def update
        @airline = Airline.find_by(slug: params[:slug])

        if @airline.update(airline_params)
          render json: AirlineSerializer.new(@airline, options).as_json
        else
          render json: { error: @airline.errors.messages }, statsu: 404
        end
      end

      def destroy
        @airline = Airline.find_by(slug: params[:slug])

        if @airline.destroy!
          head :no_content
        else
          render json: { error: @airline.errors.messages }, status: 404
        end
      end

      private

      def airline_params
        params.expect(airline: [ :name, :image_url ])
      end

      def options
        @options ||= { include: %i[reviews] }
      end
    end
  end
end
