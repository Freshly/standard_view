# frozen_string_literal: true

class OrderMaterial < Material::Base
  define_parent { user }
end
