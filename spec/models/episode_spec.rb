# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Episode, type: :model do
  it 'should be created' do
    expect(create(:episode).id).to be > 0
  end

  it 'validates season presence' do
    expect(build(:episode, season: nil).valid?).to be false
  end

  it 'validates title presence' do
    expect(build(:episode, title: nil).valid?).to be false
  end

  it 'validates plot presence' do
    expect(build(:episode, plot: nil).valid?).to be false
  end

  it 'validates number presence' do
    expect(build(:episode, number: nil).valid?).to be false
  end

  it 'on update season updated_at is also updated' do
    episode = create(:episode)
    season = episode.season
    season_updated_at = season.updated_at
    episode.update(title: 'new')

    expect(season_updated_at).to be < season.reload.updated_at
  end

  it 'on create season updated_at is also updated' do
    season = create(:season)
    season_updated_at = season.updated_at
    create(:episode, season: season)

    expect(season_updated_at).to be < season.reload.updated_at
  end
end
