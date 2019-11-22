# frozen_string_literal: true

require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get movies_path
    assert_response :success
  end
end
