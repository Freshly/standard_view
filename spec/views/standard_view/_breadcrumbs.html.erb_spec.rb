# frozen_string_literal: true

require "rails_helper"

RSpec.describe "standard_view/_breadcrumbs.html.erb", type: :view do
  include_context "with example materials"

  before do
    render partial: "standard_view/breadcrumbs", locals: { material: material }
  end

  context "with parent" do
    let(:material) { order_material }

    it "renders parent" do
      expect(rendered).to include("HAS PARENT")
    end
  end

  context "without parent" do
    let(:material) { user_material }

    it "renders child" do
      expect(rendered).to include("IS ORPHAN")
    end
  end
end
