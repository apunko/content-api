# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Episode, type: :model do
  it 'should be created' do
    expect(create(:episode).id).to_not be nil
  end

  it 'is not valid without season' do
    expect(build(:episode, season: nil).valid?).to be false
  end

  it 'is not valid without title' do
    expect(build(:episode, title: nil).valid?).to be false
  end

  it 'is not valid without plot' do
    expect(build(:episode, plot: nil).valid?).to be false
  end

  it 'is not valid without number' do
    expect(build(:episode, number: nil).valid?).to be false
  end
end
