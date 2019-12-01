# frozen_string_literal: true

module Api
  module V1
    class PurchasesController < ApplicationController
      before_action :authenticate!

      def index
        @purchases = @current_user.purchases.page(params[:page])
      end

      private

      def authenticate!
        @current_user = User.find(params[:user_id]) if params[:user_id]
        head :unauthorized unless @current_user
      end
    end
  end
end
