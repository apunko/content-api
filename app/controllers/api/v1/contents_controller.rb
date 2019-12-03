# frozen_string_literal: true

module Api
  module V1
    class ContentsController < ApplicationController
      def index
        @contents = Content.ordered_by_creation.includes(:episodes, :purchase_options).page(params[:page])
        json = Rails.cache.fetch("contents_page_#{params[:page]}_#{@contents.cache_key}", expires_in: 1.hour) do
          render_to_string template: 'api/v1/contents/index'
        end

        render json: json
      end
    end
  end
end
