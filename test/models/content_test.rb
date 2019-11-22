# frozen_string_literal: true

require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  test 'validates title and plot presence' do
    content = Content.new
    assert_not content.valid?
    assert_equal %i[title plot], content.errors.keys
  end

  test 'validates uniqueness of title and number when number is nil' do
    content_params = { title: 'title', plot: 'plot' }
    Content.create(content_params)
    assert_not Content.new(content_params).valid?
  end
end
