# frozen_string_literal: true

module Api
  module V1
    class PurchasesController < ApplicationController
      before_action :authenticate!

      def index
        @purchases = Purchase.for_user_library(@current_user.id).page(params[:page])
        json = Rails.cache.fetch("purchases_user_#{@current_user.id}_page_#{params[:page]}", expires_in: 1.hour) do
          render_to_string template: 'api/v1/purchases/index'
        end

        render json: json
      end

      def create
        @purchase = @current_user.purchases.build(create_params)
        @purchase.content = @purchase.purchase_option.content if @purchase.purchase_option

        if @purchase.save
          render @purchase, status: :created
        else
          @errors = @purchase.errors.full_messages
          render :errors, status: :conflict
        end
      rescue ActiveRecord::RecordNotUnique
        @errors = ['An unexpired purchase exists']
        render :errors, status: :conflict
      end

      private

      def authenticate!
        @current_user = User.find(params[:user_id]) if params[:user_id]
        head :unauthorized unless @current_user
      end

      def create_params
        params.fetch(:purchase, {}).permit(:purchase_option_id)
      end
    end
  end
end
