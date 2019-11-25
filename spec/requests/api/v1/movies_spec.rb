# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  describe '#index' do
    it ':success on default' do
      get api_v1_movies_path
      expect(response).to have_http_status(:success)
    end

    it ':success on explicit json format' do
      get api_v1_movies_path(format: :json)
      expect(response).to have_http_status(:success)
    end

    it ':not_acceptable on not jso format' do
      get api_v1_movies_path(format: :html)
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'handles page param' do
      get api_v1_movies_path, params: { page: Faker::Number.digit }
      assert_response :success
    end

    it 'returns content per page' do
      create_list(:movie, Movie.default_per_page + 1)
      get api_v1_movies_path, params: { page: 1 }
      assert_equal Movie.default_per_page, JSON.parse(response.body).dig('data').count
    end
  end
end
