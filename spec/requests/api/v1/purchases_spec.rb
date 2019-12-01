# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PurchasesController, type: :request do
  describe '#index' do
    let!(:user) { create(:user) }

    it 'returns :unauthorized for not authorized users' do
      get api_v1_purchases_path

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns :success for authorized users' do
      get api_v1_purchases_path(user_id: user.id)

      expect(response).to have_http_status(:success)
    end

    it ':success on explicit json format' do
      get api_v1_purchases_path(user_id: user.id, format: :json)
      expect(response).to have_http_status(:success)
    end

    it ':not_acceptable on not json format' do
      get api_v1_purchases_path(format: :html)
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'handles page param' do
      get api_v1_purchases_path, params: { user_id: user.id, page: Faker::Number.digit }
      expect(response).to have_http_status(:success)
    end

    describe 'paginator' do
      let!(:user) { create(:user_with_purchases, purchases_count: Purchase.default_per_page + 1) }

      it 'returns purchases per page' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
        expect(JSON.parse(response.body).dig('data').count).to eq Purchase.default_per_page
      end

      it 'could returns reduced page size for last page' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 2 }
        expect(JSON.parse(response.body).dig('data').count).to eq 1
      end

      it 'returns empty result set for page after last' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 3 }
        expect(JSON.parse(response.body).dig('data').count).to eq 0
      end
    end

    describe 'order' do
      let!(:user) { create(:user_with_purchases, purchases_count: Purchase.default_per_page) }

      it 'returns purchases ordered by creation(asc)' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }

        purchases = JSON.parse(response.body).dig('data')
        expect(purchases.first['created_at']).to be < purchases.last['created_at']
      end
    end

    describe 'watch time restriction' do
      let!(:user) { create(:user_with_purchases, purchases_count: 1) }

      it 'returns only active purchases' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
        expect(JSON.parse(response.body).dig('data').count).to eq 1

        travel Purchase::WATCH_TIME + 1.second do
          get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
          expect(JSON.parse(response.body).dig('data').count).to eq 0
        end
      end
    end

    it 'returns content with a purchase' do
      user = create(:user_with_purchases, purchases_count: 1)

      get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
      content = JSON.parse(response.body).dig('data').first['content']
      expect(content['id']).to be > 0
    end
  end
end
