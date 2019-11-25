# frozen_string_literal: true

module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        @seasons = Season.ordered_by_creation.page(params[:page])
      end
    end
  end
end
