# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def index
        @movies = Movie.ordered_by_creation.includes(:purchase_options).page(params[:page])
      end
    end
  end
end
