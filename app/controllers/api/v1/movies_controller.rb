# frozen_string_literal: true

module Api
  module V1
    class MoviesController < ApplicationController
      def index
        @movies = Movie.page(params[:page])
      end
    end
  end
end
