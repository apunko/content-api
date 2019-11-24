# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  describe '#index' do
    it ':success on json' do
      get :index, as: :json
      expect(response).to have_http_status(:success)
    end

    it ':not_acceptable on not json' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'handles page param' do
      get :index, params: { page: Faker::Number.digit }, as: :json
      assert_response :success
    end

    context 'with view rendering' do
      render_views

      it 'returns content per page' do
        create_list(:movie, Movie.default_per_page + 1)
        get :index, params: { page: 1 }, as: :json
        assert_equal Movie.default_per_page, JSON.parse(response.body).dig('data').count
      end
    end
  end
end
