# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :request do
  describe '#index' do
    it_behaves_like 'paginated_content_endpoint', Content

    it 'returns movies and seasons' do
      create(:movie)
      create(:season_with_episodes)
      get api_v1_contents_path

      contents = JSON.parse(response.body).dig('data')
      expect(contents.map { |c| c['type'] }.sort).to eq %w[Movie Season]
    end

    it 'returns movies without number' do
      create(:movie)
      get api_v1_contents_path

      movie = JSON.parse(response.body).dig('data').first
      expect(movie.key?('number')).to be false
    end

    it 'returns movies without episodes' do
      create(:movie)
      get api_v1_contents_path

      movie = JSON.parse(response.body).dig('data').first
      expect(movie.key?('episodes')).to be false
    end

    it 'returns seasons with number' do
      season = create(:season_with_episodes)
      get api_v1_contents_path

      season_from_response = JSON.parse(response.body).dig('data').first
      expect(season_from_response['number']).to eq season.number
    end

    it 'returns seasons with episodes' do
      season = create(:season_with_episodes)
      get api_v1_contents_path

      season_from_response = JSON.parse(response.body).dig('data').first
      expect(season_from_response['episodes'].count).to eq season.episodes.count
    end
  end
end
