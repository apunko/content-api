# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'should be created' do
    expect(create(:movie).id).to be > 0
  end
end
