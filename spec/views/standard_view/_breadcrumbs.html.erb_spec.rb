# frozen_string_literal: true

require "rails_helper"

RSpec.describe "standard_view/_breadcrumbs.html.erb", type: :view do
  include_context "with example materials"

  before do
    render partial: "standard_view/breadcrumbs", locals: { material: material }
  end

  it "needs specs"
end
