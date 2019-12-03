# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'should be created' do
    expect(create(:purchase).id).to be > 0
  end

  it 'triggers expiration worker when expired false' do
    expect { create(:purchase, expired: false) }.to change(PurchaseExpirationWorker.jobs, :size).by(1)
  end

  it 'does not trigger expiration worker when expired true' do
    expect { create(:purchase, expired: true) }.not_to change(PurchaseExpirationWorker.jobs, :size)
  end
end
