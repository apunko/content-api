# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SeasonsController, type: :request do
  describe '#index' do
    it_behaves_like 'paginated_endpoint', Season

    it 'returns success on seasons with episodes' do
      create(:season_with_episodes)
      create(:season)
      get api_v1_seasons_path
      expect(response).to have_http_status(:success)
    end

    it 'a season contains id, title, plot, number, created_at, episodes attributes' do
      create(:season)
      get api_v1_seasons_path

      season = JSON.parse(response.body).dig('data').first
      expect(season.keys.sort).to eq %w[id title plot number created_at episodes].sort
    end

    it 'returns empty collection for season without episodes' do
      create(:season)
      get api_v1_seasons_path

      season = JSON.parse(response.body).dig('data').first
      expect(season.dig('episodes').count).to be 0
    end

    it 'returns season with episodes' do
      season = create(:season_with_episodes)
      get api_v1_seasons_path

      season_from_response = JSON.parse(response.body).dig('data').first
      expect(season_from_response.dig('episodes').count).to be season.episodes.count
    end

    it 'returns season with episodes ordered by number' do
      create(:season_with_episodes, episodes_count: 10)
      get api_v1_seasons_path

      episodes = JSON.parse(response.body).dig('data').first.dig('episodes')
      expect(episodes.first.dig('number')).to be < episodes.last.dig('number')
    end

    it 'an episode contains id, title, plot, number, created_at attributes' do
      create(:season_with_episodes, episodes_count: 1)
      get api_v1_seasons_path

      episode = JSON.parse(response.body).dig('data').first.dig('episodes').first
      expect(episode.keys.sort).to eq %w[id title plot number created_at].sort
    end
  end
end
