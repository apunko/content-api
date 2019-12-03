# frozen_string_literal: true

module Api
  module V1
    class SeasonsController < ApplicationController
      def index
        @seasons = Season.ordered_by_creation.includes(:episodes, :purchase_options).page(params[:page])
        json = Rails.cache.fetch("seasons_page_#{params[:page]}_#{@seasons.cache_key}", expires_in: 1.hour) do
          render_to_string template: 'api/v1/seasons/index'
        end

        render json: json
      end
    end
  end
end
