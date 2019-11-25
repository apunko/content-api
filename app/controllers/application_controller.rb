# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :only_respond_to_json

  private

  def only_respond_to_json
    head :not_acceptable unless params[:format] == :json
  end
end
