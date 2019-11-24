# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class MoviesControllerTest < ActionDispatch::IntegrationTest
      test 'should get index' do
        get api_v1_movies_path(format: :json)
        assert_response :success
      end

      test 'returns :not_acceptable for not json format' do
        get api_v1_movies_path
        assert_response :not_acceptable
      end

      test 'handles page param' do
        get api_v1_movies_path(page: Faker::Number.digit, format: :json)
        assert_response :success
      end
    end
  end
end
