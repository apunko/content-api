# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  describe '#index' do
    it_behaves_like 'paginated_content_endpoint', Movie

    it 'a movie contains id, title, plot, number, created_at attributes' do
      create(:movie)
      get api_v1_movies_path

      movie = JSON.parse(response.body).dig('data').first
      expect(movie.keys.sort).to eq %w[id title plot number created_at purchase_options].sort
    end
  end
end
