# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be created' do
    expect(create(:user).id).to be > 0
  end

  it 'validates email presence' do
    expect(build(:user, email: nil).valid?).to be false
  end

  it 'validates email format' do
    expect(build(:user, email: 'user@gmail').valid?).to be false
  end

  it 'validates email uniqueness' do
    email = Faker::Internet.email
    create(:user, email: email)
    user = build(:user, email: email)
    user.validate

    expect(user.errors.details[:email].first[:error]).to eq :taken
  end
end
