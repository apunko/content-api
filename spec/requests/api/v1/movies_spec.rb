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
      expect(response).to have_http_status(:success)
    end

    describe 'paginator' do
      let!(:movies) { create_list(:movie, Movie.default_per_page + 1) }

      it 'returns content per page' do
        get api_v1_movies_path, params: { page: 1 }
        expect(JSON.parse(response.body).dig('data').count).to eq Movie.default_per_page
      end

      it 'could returns reduced page size for last page' do
        get api_v1_movies_path, params: { page: 2 }
        expect(JSON.parse(response.body).dig('data').count).to eq 1
      end

      it 'returns empty result set for page after last' do
        get api_v1_movies_path, params: { page: 3 }
        expect(JSON.parse(response.body).dig('data').count).to eq 0
      end
    end

    describe 'default order' do
      let!(:movies) { create_list(:movie, Movie.default_per_page) }

      it 'returns ordered by creation result set' do
        get api_v1_movies_path, params: { page: 1 }

        movies = JSON.parse(response.body).dig('data')
        expect(movies.first['created_at']).to be > movies.last['created_at']
      end

      it 'the first on the first page is just added movie' do
        movie = create(:movie)
        get api_v1_movies_path, params: { page: 1 }

        movies = JSON.parse(response.body).dig('data')
        expect(movies.first['id']).to be movie.id
      end
    end
  end
end
