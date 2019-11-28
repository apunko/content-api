# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'should be created' do
    expect(create(:purchase).id).to be > 0
  end
end
