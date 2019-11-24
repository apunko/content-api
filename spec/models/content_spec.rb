# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content, type: :model do
  it 'validates title and plot presence' do
    content = Content.new
    expect(content.valid?).to be false
    expect(%i[title plot]).to eq(content.errors.keys)
  end

  it 'validates uniqueness of title and number when number is nil' do
    content_params = { title: 'title', plot: 'plot' }
    Content.create(content_params)
    expect(Content.new(content_params).valid?).to be false
  end
end
