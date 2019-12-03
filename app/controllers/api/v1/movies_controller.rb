# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def index
        @movies = Movie.ordered_by_creation.includes(:purchase_options).page(params[:page])
        json = Rails.cache.fetch("movies_page_#{params[:page]}_#{@movies.cache_key}", expires_in: 1.hour) do
          render_to_string template: 'api/v1/movies/index'
        end

        render json: json
      end
    end
  end
end
