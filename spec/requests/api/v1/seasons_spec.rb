# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SeasonsController, type: :request do
  describe '#index' do
    it_behaves_like 'paginated_endpoint', Season
  end
end
