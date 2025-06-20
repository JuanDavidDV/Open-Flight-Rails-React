module Api
  module V1
    class ReviewsController < ApplicationController
      protect_from_forgery with: :null_session # Added to test POST action using Postman

      def create
        @review = Review.new(review_params)

        if review.save
          render json: ReviewSerializer.new(@review).as_json
        else
          render json: { error: review.errors.messages }, status: 404
        end
      end

      def destroy
        @review = Review.find(params[:id])

        if review.destroy
          head :no_content
        else
          render json: { error: review.errors.messages }, status: 404
        end
      end

      private

      def review_params
        params.require(:review).permit(:title, :description, :score, :airline_id)
      end
    end
  end
end
