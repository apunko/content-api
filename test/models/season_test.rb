# frozen_string_literal: true

require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  test 'validates title, plot and number presence' do
    season = Season.new
    assert_not season.valid?
    assert_equal %i[title plot number], season.errors.keys
  end
end
