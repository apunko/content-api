# frozen_string_literal: true

module Api
  module V1
    class PurchasesController < ApplicationController
      before_action :authenticate!

      def index
        @purchases = Purchase.for_user_library(@current_user.id).page(params[:page])
      end

      private

      def authenticate!
        @current_user = User.find(params[:user_id]) if params[:user_id]
        head :unauthorized unless @current_user
      end
    end
  end
end
