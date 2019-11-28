# frozen_string_literal: true

module Api
  module V1
    class ContentsController < ApplicationController
      def index
        @contents = Content.ordered_by_creation.includes(:episodes).page(params[:page])
      end
    end
  end
end
