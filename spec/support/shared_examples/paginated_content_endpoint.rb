# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'paginated_content_endpoint' do |base_model|
  let(:base_model_factory) { base_model.name.downcase.to_sym }
  let(:default_per_page) { base_model.default_per_page }
  let(:path_helper_method_name) { "api_v1_#{base_model.name.pluralize.downcase}_path" }

  it ':success on default' do
    get send(path_helper_method_name)
    expect(response).to have_http_status(:success)
  end

  it ':success on explicit json format' do
    get send(path_helper_method_name, format: :json)
    expect(response).to have_http_status(:success)
  end

  it ':not_acceptable on not json format' do
    get send(path_helper_method_name, format: :html)
    expect(response).to have_http_status(:not_acceptable)
  end

  it 'handles page param' do
    get send(path_helper_method_name, params: { page: Faker::Number.digit })
    expect(response).to have_http_status(:success)
  end

  describe 'purchase_options attribute' do
    it 'returns purchase_options' do
      purchase_options_count = Faker::Number.digit
      create(base_model_factory, purchase_options_count: purchase_options_count)
      get send(path_helper_method_name)

      purchase_options = JSON.parse(response.body).dig('data').first.dig('purchase_options')
      expect(purchase_options.count).to eq purchase_options_count
    end

    it 'a purchase option contains id, quality, price attributes' do
      create(base_model_factory, purchase_options_count: 1)
      get send(path_helper_method_name)

      purchase_option = JSON.parse(response.body).dig('data').first.dig('purchase_options').first
      expect(purchase_option.keys.sort).to eq %w[id quality price].sort
    end

    it 'purchase option price is converted from cents' do
      created_purchase_option = create(base_model_factory, purchase_options_count: 1).purchase_options.first
      get send(path_helper_method_name)

      purchase_option = JSON.parse(response.body).dig('data').first.dig('purchase_options').first
      expect(purchase_option['price']).to eq created_purchase_option.price.to_f / 100
    end
  end

  describe 'paginator' do
    before { create_list(base_model_factory, default_per_page + 1) }

    it 'returns content per page' do
      get send(path_helper_method_name, params: { page: 1 })
      expect(JSON.parse(response.body).dig('data').count).to eq default_per_page
    end

    it 'could returns reduced page size for last page' do
      get send(path_helper_method_name, params: { page: 2 })
      expect(JSON.parse(response.body).dig('data').count).to eq 1
    end

    it 'returns empty result set for page after last' do
      get send(path_helper_method_name, params: { page: 3 })
      expect(JSON.parse(response.body).dig('data').count).to eq 0
    end
  end

  describe 'default order' do
    let!(:entities) { create_list(base_model_factory, default_per_page) }

    it 'returns ordered by creation(desc) result set' do
      get send(path_helper_method_name, params: { page: 1 })

      entities = JSON.parse(response.body).dig('data')
      expect(entities.first['created_at']).to be > entities.last['created_at']
    end

    it 'the first on the first page is just added entity' do
      entity = create(base_model_factory)
      get send(path_helper_method_name, params: { page: 1 })

      entities = JSON.parse(response.body).dig('data')
      expect(entities.first['id']).to be entity.id
    end
  end
end
