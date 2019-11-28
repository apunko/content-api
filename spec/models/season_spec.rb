# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Season, type: :model do
  it 'should be created' do
    expect(create(:season).id).to be > 0
  end

  it 'validates title, plot and number presence' do
    season = Season.new
    expect(season.valid?).to be false
    expect(%i[title plot number]).to eq(season.errors.keys)
  end
end
