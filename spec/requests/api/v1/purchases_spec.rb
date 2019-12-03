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

      it 'returns purchases ordered by remaining time to watch' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }

        purchases = JSON.parse(response.body).dig('data')
        expect(purchases.first['created_at']).to be <= purchases.last['created_at']
      end
    end

    describe 'expired restriction' do
      let!(:user) { create(:user_with_purchases, purchases_count: 5) }

      it 'returns only not expired purchases' do
        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
        expect(JSON.parse(response.body).dig('data').count).to eq 5

        user.purchases.update(expired: true)

        get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
        expect(JSON.parse(response.body).dig('data').count).to eq 0
      end
    end

    it 'returns content with a purchase' do
      user = create(:user_with_purchases, purchases_count: 1)

      get api_v1_purchases_path, params: { user_id: user.id, page: 1 }
      content = JSON.parse(response.body).dig('data').first['content']
      expect(content['id']).to be > 0
    end
  end

  describe '#create' do
    let!(:user) { create(:user) }

    it 'returns :unauthorized for not authorized users' do
      post api_v1_purchases_path, params: { purchase: { purchase_option_id: 1 } }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns :conflict when purchase option does not exist' do
      post api_v1_purchases_path, params: { user_id: user.id, purchase: { purchase_option_id: 1 } }

      expect(response).to have_http_status(:conflict)
    end

    it 'returns errors when purchase_option_invalid' do
      post api_v1_purchases_path, params: { user_id: user.id, purchase: { purchase_option_id: 1 } }
      errors = JSON.parse(response.body).dig('errors')

      expect(errors.count).to be > 0
    end

    it 'returns errors for invalid params' do
      post api_v1_purchases_path, params: { user_id: user.id, purchase2: { purchase_option_id: 1 } }
      errors = JSON.parse(response.body).dig('errors')

      expect(errors.count).to be > 0
    end

    it 'returns :created on successful creation' do
      purchase_option = create(:purchase_option)
      post api_v1_purchases_path, params: { user_id: user.id, purchase: { purchase_option_id: purchase_option.id } }

      expect(response).to have_http_status(:created)
    end

    it 'returns purchase attrs on successful creation' do
      purchase_option = create(:purchase_option)
      post api_v1_purchases_path, params: { user_id: user.id, purchase: { purchase_option_id: purchase_option.id } }
      data = JSON.parse(response.body).dig('data')

      expect(data['id']).to be > 0
      expect(data['purchase_option_id']).to eq purchase_option.id
      expect(data['user_id']).to eq user.id
    end

    it 'returns errors when same not expired purchase exists' do
      purchase = create(:purchase, user: user, expired: false)
      post api_v1_purchases_path, params: {
        user_id: user.id,
        purchase: { purchase_option_id: purchase.purchase_option_id }
      }
      errors = JSON.parse(response.body).dig('errors')

      expect(errors.count).to eq 1
    end

    it 'creates purchase after Purchase Expiration worker execution' do
      purchase = create(:purchase, user: user, expired: false)
      Sidekiq::Worker.drain_all

      purchase.reload
      expect(purchase.expired).to be true

      post api_v1_purchases_path, params: {
        user_id: user.id,
        purchase: { purchase_option_id: purchase.purchase_option_id }
      }
      data = JSON.parse(response.body).dig('data')

      expect(data['id']).to be > 0
    end
  end
end
