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
end
