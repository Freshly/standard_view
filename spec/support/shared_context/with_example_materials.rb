# frozen_string_literal: true

RSpec.shared_context "with example materials" do
  let(:user) { User.new }
  let(:order) { user.orders.first }

  let(:user_material) { Material::Base.for(user) }
  let(:order_material) { Material::Base.for(order) }
end
