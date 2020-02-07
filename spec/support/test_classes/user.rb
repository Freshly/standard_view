# frozen_string_literal: true

class User
  def name
    @name ||= SecureRandom.hex
  end

  def orders
    @orders ||= [ Order.new(self) ]
  end
end
