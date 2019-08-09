# frozen_string_literal: true

require "rails_helper"

RSpec.describe "standard_view/_index.html.erb", type: :view do
  shared_examples_for "the expected name is rendered" do
    it "contains name" do
      render partial: "standard_view/index", locals: { name: assigned_name }
      expect(rendered).to include("Hello, #{expected_name}")
    end
  end

  context "with no name" do
    it_behaves_like "the expected name is rendered" do
      let(:assigned_name) { nil }
      let(:expected_name) { "World" }
    end
  end

  context "with name" do
    it_behaves_like "the expected name is rendered" do
      let(:assigned_name) { SecureRandom.hex }
      let(:expected_name) { assigned_name }

      before { assign(:name, assigned_name) }
    end
  end
end
